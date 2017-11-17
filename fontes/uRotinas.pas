unit uRotinas;

interface

uses
 Configuracoes, Lm_bkpdfe,  Winapi.Windows, Winapi.Messages,
 System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
 Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
 Vcl.Buttons, Vcl.ExtCtrls, System.IniFiles,
 Data.SqlExpr, FireDAC.Comp.Client,Vcl.ComCtrls, System.ZLib,uDMnfebkp,
 Xml.XMLDoc,Xml.XMLIntf, uMetodosUteis,Data.DB,System.Zip,System.DateUtils,
 Usuarios, ShellAPI, TlHelp32, Comobj,System.StrUtils,
 uProgressThread, MSXML;

 type TOperArquivos = (oaReplace, oaAdd, oaDescarta);
 type TExecuteMetodo = (emLoadXMLNFe, emExportaLoteXML, emExportaPDF, emSelecionaRows);

 type TRotinas = class(TProgressThread)
  private
    FMaximo : Int64;
    FResult : Int64;
    FResultMax : Int64;
    FLista : TStringList;
    FInitialDir : String;
    FRefazAutorizacao : Boolean;
    FExecuteMetodo : TExecuteMetodo;

  public
    property Result: Int64                 read FResult;
    property Maximo: Int64                 read FMaximo write FMaximo;
    property Lista: TStringList            write FLista;
    property InitialDir: String            write FInitialDir;
    property RefazAutorizacao: Boolean     read FRefazAutorizacao write FRefazAutorizacao;
    property ExecuteMetodo: TExecuteMetodo read FExecuteMetodo write FExecuteMetodo;

    procedure Execute; override; //Demo

    procedure pProgress(pText : string; pNumber: cardinal);
    procedure pLeituradaNFE;
    function fGetIdf_DocPelaChave(pChave: string):Integer;
    function fGetCNPJPelaChave(pChave: string):string;
    //Métodos para importar e exportar arquivos XML
    function fExportaLoteXML(pLista: TStringList):Int64;
    function fDeleteObjetoXML(pLista: TStringList; pCNPJ: string = '*'):Boolean;
    function fLoadXMLNFe(pObjConfig : TConfiguracoes; pTiposXML: TTipoXML; pParametro: boolean = false; pChave: string = ''; pEmail : string = ''): Int64;
    function fLoadXMLNFeLista(pLista : TStringList): Boolean;

    function fMaster(pObjUsuario: TUsuarios): boolean;

    function fDirectoryTreeFileCount(PInitialDir: String): Cardinal;

    function fExportaPDF(pLista: TStringList): Integer;
    //Métodos de Compressão
    function fCompactar(pPath: string): TFileStream;
    function fDescompacartar(pPath: string): boolean;
    //Métodos de Compactação de arquivos
    function fZipFile(pZipFile, AFileName: string; pArqDuplicado : boolean = false): Boolean;
    function fZipFileExtrair(FZipFile, APath: string): Boolean;
    //Metodos da IS
    function fNumProcessThreads: Integer;
    function fIsValidDispatch(const v: OleVariant): Boolean;
    procedure pCompress(const ASrc: string; var vDest: TStream; aEHStringStream: Boolean);
    procedure pDecompress(var vXML: TStream; ADest: string); overload;
    procedure pShellZip(pZipfile, pSourceFolder: OleVariant; pFilter: String);
    //Metodos de compressão em lote
    procedure pCompressFiles(Files: TStrings; const Filename: String);
    procedure pDecompressFiles(const Filename, DestDirectory : String);
    procedure pEnumFiles(szPath, szAllowedExt: String; iAttributes: Integer;
      Buffer: TStrings; bClear, bIncludePath: Boolean); StdCall;


  end;


const
  SHCONTCH_NOPROGRESSBOX = 4;
  SHCONTCH_AUTORENAME = 8;
  SHCONTCH_RESPONDYESTOALL = 16;
  SHCONTF_INCLUDEHIDDEN = 128;
  SHCONTF_FOLDERS = 32;
  SHCONTF_NONFOLDERS = 64;

  cEnv_ = 'Env_NFe*.xml';
  cCan_ = 'Can_*.xml';
  cInut_= 'Inut_.xml';
  cRetsai_ = 'Retsai_*.xml';
  cRetEven = 'RetEven_*.xml';

  cAguardando = 1;
  cCancAguard = 4;

var
 wRotinas : TRotinas;

implementation

uses
  uFoPrincipal, Base;

var
 wChaveErro : TStringList;

procedure TRotinas.pDecompressFiles(const Filename, DestDirectory : String);
var
  dest,s : String;
  decompr : TDecompressionStream;
  infile, outfile : TFilestream;
  i,l,c : Integer;
begin
  // IncludeTrailingPathDelimiter (D6/D7 only)
  dest := IncludeTrailingPathDelimiter(DestDirectory);

  ForceDirectories(Dest);

  infile := TFileStream.Create(Filename,fmOpenRead);
  try
    { number of files }
    infile.Read(c,SizeOf(c));
    for i := 1 to c do
    begin
      { read filename }
      infile.Read(l,SizeOf(l));
      SetLength(s,l);
      infile.Read(s[1],l);
      { read filesize }
      infile.Read(l,SizeOf(l));
      { decompress the files and store it }
      s := dest+s; //include the path
      outfile := TFileStream.Create(s,fmCreate);
      decompr := TDecompressionStream.Create(infile);
      try
        outfile.CopyFrom(decompr,l);
      finally
        outfile.Free;
        decompr.Free;
      end;
    end;
  finally
    infile.Free;
  end;
end;


procedure TRotinas.pEnumFiles(szPath, szAllowedExt: String; iAttributes: Integer;
  Buffer: TStrings; bClear, bIncludePath: Boolean); StdCall;
var
  res: TSearchRec;
  szBuff: String;
begin
  if (bClear) then Buffer.Clear;
  szPath := IncludeTrailingBackslash(szPath);
  if (FindFirst(szPath + szAllowedExt, iAttributes, res) = 0) then
  begin
    repeat
      szBuff := res.Name;
      if ((szBuff <> '.') and (szBuff <> '..')) then
      if (bIncludePath) then
      Buffer.Add(szPath + szBuff) else
      Buffer.Add(szBuff);
    until FindNext(res) <> 0;
    FindClose(res);
  end;
end;

function TRotinas.fMaster(pObjUsuario: TUsuarios): boolean;
begin
  Result := ((Trim(LowerCase(pObjUsuario.Usuario)) = 'master') and (pObjUsuario.Senha = fSenhaAtual('')));
end;

procedure TRotinas.pCompress(const ASrc: string; var vDest: TStream; aEHStringStream: Boolean);
var
  FileIni: TFileStream;
  Zip:     TCompressionStream;
  tString: TStringStream;
begin
  tString := nil;
  FileIni := nil;

  if aEHStringStream then //Se for no momento do envio, pega da string (memória) e não do arquivo físico.
    tString := TStringStream.Create(ASrc)
  else
    FileIni := TFileStream.Create(ASrc, fmOpenRead and fmShareExclusive);

  Zip := TCompressionStream.Create(vDest); //clMax,
  try
    try
      if aEHStringStream then
        Zip.CopyFrom(tString, tString.Size)
      else
        Zip.CopyFrom(FileIni, FileIni.Size);
    except
      Raise Exception.Create('Não foi possível compactar o arquivo');
      abort;
    end;
  finally
    FreeAndNil(tString);
    FreeAndNil(Zip);
    FreeAndNil(FileIni);
  end;
end;

function TRotinas.fNumProcessThreads: Integer;
var
  HSnapShot: THandle;
  Te32: TThreadEntry32;
  Proch: DWORD;
  ProcThreads: Integer;
begin
  ProcThreads := 0;
  Proch       := GetCurrentProcessID;
  HSnapShot   := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
  Te32.dwSize := SizeOf(TTHREADENTRY32);
  if Thread32First(HSnapShot, Te32) then
  begin
    if Te32.th32OwnerProcessID = Proch then
      Inc(ProcThreads);

    while Thread32Next(hSnapShot, Te32) do
    begin
      if Te32.th32OwnerProcessID = Proch then
        Inc(ProcThreads);
    end;
  end;
  CloseHandle (HSnapShot);
  Result := ProcThreads;
end;

function TRotinas.fIsValidDispatch(const v: OleVariant): Boolean;
begin
  result := (VarType(v) = varDispatch) and Assigned(TVarData(v).VDispatch);
end;

procedure TRotinas.pShellZip(pZipfile, pSourceFolder: OleVariant; pFilter: String);
const //A tipagem dos diretórios(parâmetros) deve ser OleVariant para funcionar o get 'shellobj.NameSpace'.
  emptyzip: array[0..23] of byte  = (80,75,5,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
var
  ms:             TMemoryStream;
  wSrcfldr:        Variant;
  wDestfldr:       Variant;
  wShellfldrItems: Variant;
  wShellObj:       Variant;
  wNumT: Integer;
begin
  if not FileExists(pZipfile) then
  begin
    //Criando um novo arquivo ZIP vazio.
    ms := TMemoryStream.Create;
    ms.WriteBuffer(emptyzip, sizeof(emptyzip));
    ms.SaveToFile(pZipfile);
    ms.Free;
  end;

  wNumT     := fNumProcessThreads;
  wShellObj := CreateOleObject('Shell.Application');

  wSrcfldr := wShellObj.NameSpace(pSourceFolder);
  if not fIsValidDispatch(wSrcfldr) then
    raise EInvalidOperation.CreateFmt('<%s> Caminho Inválido!', [pSourceFolder]);

  wDestfldr := wShellObj.NameSpace(pZipfile);
  if not fIsValidDispatch(wDestfldr) then
    raise EInvalidOperation.CreateFmt('<%s> Arquivo ZIP Inválido!', [pZipfile]);

  wShellfldrItems := wSrcfldr.Items;

  if pFilter <> '' then
  begin
    wShellfldrItems.pFilter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS, pFilter);
    wDestfldr.copyhere(wShellfldrItems, 0);
  end
  else
  begin
    wShellfldrItems.pFilter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS, '');
    wDestfldr.copyhere(wShellfldrItems, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  end;

  while fNumProcessThreads <> wNumT do
   Sleep(100);
end;

procedure TRotinas.pCompressFiles(Files: TStrings; const Filename: String);
var
  infile, outfile, tmpFile : TFileStream;
  compr : TCompressionStream;
  i,l : Integer;
  s : String;
begin
  if Files.Count > 0 then
  begin
    outFile := TFileStream.Create(Filename,fmCreate);
    try
      { the number of files }
      l := Files.Count;
      outfile.Write(l,SizeOf(l));
      for i := 0 to Files.Count-1 do
      begin
        infile := TFileStream.Create(Files[i],fmOpenRead);
        try
          { the original filename }
          s := ExtractFilename(Files[i]);
          l := Length(s);
          outfile.Write(l,SizeOf(l));
          outfile.Write(s[1],l);
          { the original filesize }
          l := infile.Size;
          outfile.Write(l,SizeOf(l));
          { compress and store the file temporary}
          tmpFile := TFileStream.Create('tmp',fmCreate);
          compr := TCompressionStream.Create(clMax,tmpfile);
          try
            compr.CopyFrom(infile,l);
          finally
            compr.Free;
            tmpFile.Free;
          end;
          { append the compressed file to the destination file }
          tmpFile := TFileStream.Create('tmp',fmOpenRead);
          try
            outfile.CopyFrom(tmpFile,0);
          finally
            tmpFile.Free;
          end;
        finally
          infile.Free;
        end;
      end;
    finally
      outfile.Free;
    end;
    DeleteFile('tmp');
  end;
end;

procedure TRotinas.pDecompress(var vXML: TStream; ADest: string);
var
  FileOut: TFileStream;
  DeZip: TDecompressionStream;
  i: Integer;
  Buf: array[0..1023] of Byte;
begin
  FileOut := TFileStream.Create(ADest, fmCreate or fmShareExclusive);
  DeZip   := TDecompressionStream.Create(vXML);
  DeZip.Position := 0;
  try
    try
      repeat
        i := DeZip.Read(Buf, SizeOf(Buf));
        if i <> 0 then
          FileOut.Write(Buf, i);
      until i <= 0;
    except
      raise Exception.Create('Não foi possível descompactar o arquivo');
      abort;
    end;
  finally
    DeZip.Free;
    FileOut.Free;
  end;
end;

function TRotinas.fExportaLoteXML(pLista: TStringList): Int64;
var
  I : Integer;
  wStream : TStream;
  wSLFiles: TStringList;
  wDir, wDirTemp, wPathZIP, wXMLFilename, wZipFilename : string;
begin
  Result := 0;
  wStream := TMemoryStream.Create;
  try
    wDirTemp := ExtractFileDir(GetCurrentDir);
    with foPrincipal.dlgSaveXML do
    begin
      Filter := 'ZIP | *.zip';
      FilterIndex := FilterIndex+1;
      FileName := 'LoteXML.zip';
      if Execute then
      begin
        wDirTemp := ExpandFileName(ExtractFileDir(FileName) +'\Notas_Temp'); //ExtractFileDir(FileName)
        if not DirectoryExists(wDirTemp) then
          if not CreateDir(wDirTemp) then
            if not ForceDirectories(wDirTemp) then
            begin
              ShowMessage('Não Foi possivel criar um diretório TEMP aqui');
              exit;
            end;

        wPathZIP := FileName;
        if not Assigned(ObjetoXML) then
          ObjetoXML := TLm_bkpdfe.Create;

        FMaximo := pLista.Count;
        FResultMax := pLista.Count;
        for I := 0 to pLista.Count - 1 do
        begin
          ObjetoXML:= TLm_bkpdfe.Create;
          ObjetoXML.Chave := pLista.Strings[i];

          if DaoObjetoXML.fConsultaObjXML(ObjetoXML, ['chave']) then
          begin
            if (ObjetoXML.Protocolocanc <> '') and (ObjetoXML.Protocoloaut <> '') then
            begin
              wStream := objetoXML.Xmlextendcanc;
              if wStream.Size > 0 then
              begin
                wXMLFilename := ObjetoXML.Chave;
                pSalveName('xmlextendcanc','xml', wXMLFilename);
                wStream := objetoXML.Xmlextendcanc;
                pDecompress(wStream, wDirTemp+'\'+wXMLFilename);
                if fZipFile(wPathZIP, wDirTemp+'\'+wXMLFilename) then
                  DeleteFile(wDirTemp+'\'+wXMLFilename);
              end;

              wStream := objetoXML.Xmlextend;
              if wStream.Size > 0 then
              begin
                wXMLFilename := ObjetoXML.Chave;
                pSalveName('xmlextend','xml', wXMLFilename );
                pDecompress(wStream, wDirTemp+'\'+wXMLFilename);
                if fZipFile(wPathZIP, wDirTemp+'\'+wXMLFilename) then
                  DeleteFile(wDirTemp+'\'+wXMLFilename);
              end;
            end
            else
            begin
              wStream := objetoXML.Xmlextend;
              if wStream.Size > 0 then
              begin
                wXMLFilename := ObjetoXML.Chave;
                pSalveName('xmlextend','xml',wXMLFilename);
                pDecompress(wStream, wDirTemp+'\'+wXMLFilename);
                if fZipFile(wPathZIP, wDirTemp+'\'+wXMLFilename) then
                  DeleteFile(wDirTemp+'\'+wXMLFilename);
              end;
            end;

            pProgress('Exportando: '+pLista.Strings[i], I);
            Inc(Result,1);
          end;
        end;
        RemoveDir(wDirTemp);
      end;
    end;
  finally
    FreeAndNil(wStream);
  end;
end;


function TRotinas.fZipFileExtrair(FZipFile, APath: string): Boolean;
var
  Zip: TZipFile;
begin
  result := false;
  Zip := TZipFile.Create;
  try
    try
    if fileExists(FZipFile) then
      Zip.Open(FZipFile, zmReadWrite)
    else
      raise exception.Create('Não encontrei: ' + FZipFile);
    Zip.ExtractAll(APath);
    Zip.Close;
    result := true;
    except on E: Exception do

    end;
  finally
    FreeAndNil(Zip);
  end;
end;

function TRotinas.fZipFile(pZipFile, AFileName: string; pArqDuplicado : boolean = false): Boolean;
var
  Zip: TZipFile;
  i : Integer;
begin
  result := false;
  Zip := TZipFile.Create;
  try
    try
      if fileExists(pZipFile) then
        Zip.Open(pZipFile, zmReadWrite)
      else
        Zip.Open(pZipFile, zmWrite);

      i := Zip.IndexOf(extractFileName(AFileName));
      if (i >= 0) and (pArqDuplicado) or (i < 0) then
        Zip.Add(AFileName, extractFileName(AFileName));

      Zip.Close;
      result := true;
    except on E: Exception do

    end;
  finally
    FreeAndNil(Zip);
  end;
end;

function TRotinas.fDescompacartar(pPath: string): boolean;
var
  FileIni, FileOut: TFileStream;
  DeZip: TDecompressionStream;
  i : Integer;
  Buf: array[0..1023]of Byte;
begin
  try
    FileIni:=TFileStream.Create(pPath, fmOpenRead and fmShareExclusive); //fmShareExclusive);
    FileOut:=TFileStream.Create(pPath, fmCreate and fmShareExclusive);   //fmShareExclusive);
    DeZip:=TDecompressionStream.Create(FileIni);
    repeat
     i:=DeZip.Read(Buf, SizeOf(Buf));

    if i <> 0 then
      FileOut.Write(Buf, i);

    until i <= 0;
  finally
    DeZip.Free;
    FileOut.Free;
    FileIni.free;
  end;
end;

function TRotinas.fLoadXMLNFe(pObjConfig : TConfiguracoes; pTiposXML: TTipoXML; pParametro: boolean = false; pChave: string = ''; pEmail : string = ''): Int64;
var
  wDataSet   : TDataSet;
  wDaoXML    : TDaoBkpdfe;
  ObjetoXML, ObjXMLAux : TLm_bkpdfe;
  wStream    : TStream;
  wFileStream : TFileStream;
  wFRec      : TSearchRec;
  wErro, j: integer;
  XMLArq     : TXMLDocument;
  wArrayObjXML : array of TLm_bkpdfe;
  wNodeXML, wNodeInfNFe, wNodeNfeProc, wNodeDest, wNodeEmit: IXMLNode;
  wFileSource, wFileDest: string;
  wXmlName, wZipName,wChaveAux,wPathFile, wCNPJAux: string;
  wXMLEnvio, wXMLProcessado,wOK, wYesAll: boolean;

 function fGetChaveFilename(pFileName : string): string;
  var wPos :Integer;
  begin
    Result := '';
    if (pFileName = '') then
     Exit;

    Result := ExtractFileName(pFileName);

    wPos := Pos('Env_NFe',Result);
    if wPos > 0 then
    begin
      Result := Copy(Result,8,44);
      exit;
    end;

    wPos := Pos('Can_',Result);
    if wPos > 0 then
    begin
      Result := Copy(Result,5,44);
      exit;
    end;

    wPos := Pos('Inut_',Result);
    if wPos > 0 then
    begin
      Result := Copy(Result,6,44);
      Exit;
    end;

    wPos := Pos('retsai_NFe',Result);
    if wPos > 0 then
    begin
      Result := Copy(Result,11,44);
      Exit;
    end;

  end;

  function funcvarXML(xmlNTag : IXMLNode): WideString;
  begin
    if Not (xmlNTag.ChildNodes.First = Nil) Then
      Result := xmlNTag.ChildNodes.First.Text;
  end;

  function fXMLChave: Int64;
  begin
    J := 0;
    if not pParametro then
    begin
      wOK := True;
      wFileSource := pChave;
    end
    else
    begin
      wErro := FindFirst(wPathFile+'\'+ cEnv_, faAnyFile, wFRec);
      wOK := wErro = 0;
      wFileSource := wPathFile+'\'+wFRec.Name;
    end;

    with ObjetoXML do
    if Pos('Env_NFe',wFileSource) > 0 then
    begin

      while wOK do
      begin
        ObjetoXML := TLm_bkpdfe.Create;
        wXmlName := ExtractFileName(wFileSource);
        wCNPJAux :=  fGetCNPJPelaChave(wXmlName);
        wChaveAux := fGetChaveFilename(wXmlName);

        Tipo := '1';
        Inc(J,1);
        SetLength(wArrayObjXML, J);
        wXMLProcessado := False;
        wStream := TMemoryStream.Create;

        if pParametro then
          pProgress('Importando '+wXmlName, J);

        if wChaveErro.IndexOf(wChaveAux) >= 0 then
        begin
          pCopyFiles(wFileSource, tabConfiguracoes.NFePathRejeitado,false);
          FileClose(FindWindow( 0,pWideChar(wFileSource)));
          if DeleteFile(wFileSource) then
            AddLog('LOGMAXXML',GetCurrentDir,'ErroXML: ['+ wXmlName+']', true);

          wErro := FindNext(wFRec);
          wFileSource := wPathFile+'\'+wFRec.Name;
          wOK := (wErro = 0);
          Continue;
        end;
        wFileStream := TFileStream.Create(wFileSource,0);
        XMLArq.LoadFromStream(wFileStream,xetUTF_8);

        wNodeXML := XMLArq.documentElement;
        //Nesse momento verifica se o xml é autorizado (nfeProc = Autorizado) (NFe = XML de Envio)
        if Assigned(wNodeXML) and (wNodeXML.NodeName = 'nfeProc') or (wNodeXML.NodeName = 'NFe') then
        begin
          if (wNodeXML.NodeName = 'nfeProc') then
          begin
            wXMLProcessado := true;
            wNodeNfeProc := wNodeXML;
            wNodeXML := wNodeXML.ChildNodes.First;
          end;

          if (wNodeXML.NodeName = 'NFe') then
          begin
            wNodeXML := wNodeXML.ChildNodes.First;

            if Assigned(wNodeXML) and (wNodeXML.NodeName = 'infNFe') then
            begin
              Chave := wNodeXML.AttributeNodes.FindNode('Id').text;
              Chave := Copy(Chave,4,44);
              wNodeXML := wNodeXML.ChildNodes.First;
              if Assigned(wNodeXML) and (wNodeXML.NodeName = 'ide') then
              begin
                Idf_documento := StrToInt64Def(funcvarXML(wNodeXML.ChildNodes['nNF']),0);
                Dataemissao := DateXMLToDate(funcvarXML(wNodeXML.ChildNodes['dhEmi']));
                Tipoambiente :=  funcvarXML(wNodeXML.ChildNodes['tpAmb']); // Tipo de Ambiente da Nota Fiscal(Produção/Homologação)
                if Tipoambiente = '1' then
                  Tipoambiente := 'Produção'
                else
                  Tipoambiente := 'Homologação';
              end;

              wNodeDest := wNodeXML.NextSibling;
              if Assigned(wNodeDest) and (wNodeDest.NodeName = 'emit') then
              begin
                CNPJ := funcvarXML(wNodeDest.ChildNodes['CNPJ']);
                if wCNPJAux <> CNPJ then
                  ShowMessage('CNPJ da Chave difere da tag <CNPJ> do Desitinatário');
              end;

              Status := cAguardando;
            end;

            if (wXMLProcessado) and (Assigned(wNodeNfeProc)) then
            begin

              wNodeNfeProc := wNodeNfeProc.ChildNodes.First.NextSibling;
              if Assigned(wNodeNfeProc) and (wNodeNfeProc.NodeName = 'protNFe') or (wNodeNfeProc.NodeName = 'infProt') then
              begin
                if (wNodeNfeProc.NodeName = 'protNFe') then
                  wNodeNfeProc := wNodeNfeProc.ChildNodes.First;

                if (wNodeNfeProc.NodeName = 'infProt') then
                begin
                  Tipoambiente :=  funcvarXML(wNodeNfeProc.ChildNodes['tpAmb']); // Tipo de Ambiente da Nota Fiscal(Produção/Homologação)
                  if Tipoambiente = '1' then
                    Tipoambiente := 'Produção'
                  else
                  Tipoambiente := 'Homologação';

                  Chave := funcvarXML(wNodeNfeProc.ChildNodes['chNFe']);
                  if Chave <> wChaveAux then
                     exit;

                  Datarecto := DateXMLToDate(funcvarXML(wNodeNfeProc.ChildNodes['dhRecbto']));
                  Protocoloaut := funcvarXML(wNodeNfeProc.ChildNodes['nProt']);
                  Status :=  StrToIntDef(funcvarXML(wNodeNfeProc.ChildNodes['cStat']),-1);
                  Motivo :=  funcvarXML(wNodeNfeProc.ChildNodes['xMotivo']);
                  if Length(Motivo) > 20 then
                  Motivo := Copy(Motivo,1,20);
                end;
              end;
            end;
          end;
        end;

        FileClose(wFileStream.Handle);
        pCompress(wFileSource, wStream,false);
        Xmlenvio := wStream;
        if wXMLProcessado then
        begin
          Xmlextend := wStream;
        end;

        Dataalteracao := Today;
        wArrayObjXML[j-1] := ObjetoXML;

        if pParametro then
        begin
          wErro := FindNext(wFRec);
          wFileSource := wPathFile+'\'+wFRec.Name;
          wOK := (wErro = 0);
          Continue;
        end
        else
        begin
          wOK := False;
          exit;
        end;
      end;
    end;

    if pParametro then
    begin
      wErro := FindFirst(wPathFile+'\'+ cCan_, faAnyFile, wFRec);
      wOK := wErro = 0;
      wFileSource := wPathFile+'\'+wFRec.Name;
    end;

    with ObjetoXML do
    if Pos('Can_',wFileSource) > 0 then
    begin
      while wOK do
      begin
        Inc(J,1);
        SetLength(wArrayObjXML, J);
        wXmlName := ExtractFileName(wFileSource);
        ObjetoXML := TLm_bkpdfe.Create;
        wChaveAux := fGetChaveFilename(wXmlName);
        Idf_documento := fGetIdf_DocPelaChave(wChaveAux);
        Tipo := '1';
        wStream := TMemoryStream.Create;

        if pParametro then
          pProgress('Importando '+ wXmlName, J);

        if wChaveErro.IndexOf(wChaveAux) >= 0 then
        begin
          pCopyFiles(wFileSource, tabConfiguracoes.NFePathRejeitado,false);
          FileClose(FindWindow( 0,pWideChar(wFileSource)));
          if DeleteFile(wFileSource) then
            AddLog('LOGMAXXML', GetCurrentDir,'ErroXML: ['+ wXmlName+']');

          wErro := FindNext(wFRec);
          wFileSource := wPathFile+'\'+wFRec.Name;
          wOK := (wErro = 0);
          Continue;
        end;
        wFileStream := TFileStream.Create(wFileSource,0);
        XMLArq.LoadFromStream(wFileStream);
        wNodeXML := XMLArq.documentElement;

        if Assigned(wNodeXML) then
        begin  //CAN_ Envio

          if (wNodeXML.NodeName = 'cancNFe') then
          begin
            wNodeXML := wNodeXML.ChildNodes.First;
            if Assigned(wNodeXML) and (wNodeXML.NodeName = 'infCanc') then
            begin
              Tipoambiente := funcvarXML(wNodeXML.ChildNodes['tpAmb']);
              if Tipoambiente = '1' then
                Tipoambiente := 'Produção'
              else
                Tipoambiente := 'Homologação';
              chave := funcvarXML(wNodeXML.ChildNodes['chNFe']);
              CNPJ := fGetCNPJPelaChave(chave);

              Protocolocanc := funcvarXML(wNodeXML.ChildNodes['nProt']);
              Status := cCancAguard;;
              Motivocanc := funcvarXML(wNodeXML.ChildNodes['xJust']);
              if Length(Motivocanc)>20 then
                Motivocanc := copy(Motivocanc,1,20);

              if pEmail <> '' then
                Emailsnotificados := pEmail;

              Dataalteracao := Today;
              FileClose(wFileStream.Handle);
              pCompress(wFileSource,wStream,false);
              Xmlenviocanc := wStream;
            end;
          end
          else
          if (wNodeXML.NodeName = 'procEventoNFe') then
          begin   //CAN_ processado
            wNodeXML := wNodeXML.ChildNodes.First.NextSibling; //Pula da tag <Evento> para <retEvento>

            if Assigned(wNodeXML) and (wNodeXML.NodeName = 'retEvento') then
            begin
              wNodeXML := wNodeXML.ChildNodes.First;
              if Assigned(wNodeXML) and (wNodeXML.NodeName = 'infEvento') then
              begin
                Tipoambiente := funcvarXML(wNodeXML.ChildNodes['tpAmb']);
                if Tipoambiente = '1' then
                  Tipoambiente := 'Produção'
                else
                  Tipoambiente := 'Homologação';

                Status :=  StrToIntDef(funcvarXML(wNodeXML.ChildNodes['cStat']),-1);
                Motivocanc := funcvarXML(wNodeXML.ChildNodes['xMotivo']);
                if Length(Motivocanc)> 20 then
                  Motivocanc := copy(Motivocanc,1,20);

                Chave := funcvarXML(wNodeXML.ChildNodes['chNFe']);
                CNPJ := fGetCNPJPelaChave(Chave);
                if wChaveAux <> Chave then
                  exit;

                if pEmail <> '' then
                  Emailsnotificados := pEmail;

                Protocolocanc := funcvarXML(wNodeXML.ChildNodes['nProt']);
                Dataalteracao := Today;
                FileClose(wFileStream.Handle);
                pCompress(wFileSource,wStream,false);
                Xmlextendcanc := wStream;
              end;
            end;
          end;
        end;

        wArrayObjXML[j-1] := ObjetoXML;

        if pParametro then
        begin
          wErro := FindNext(wFRec);
          wFileSource := wPathFile+'\'+wFRec.Name;
          wOK := (wErro = 0);
          Continue;
        end
        else
        begin
          wOK := False;
          exit;
        end;
      end;
    end;

    if not pParametro then
    begin
      wOK := True;
      wFileSource := pChave;
    end
    else
    begin
      wErro := FindFirst(wPathFile+'\'+ cEnv_, faAnyFile, wFRec);
      wOK := wErro = 0;
      wFileSource := wPathFile+'\'+wFRec.Name;
    end;

    if Pos('retsai_NFe',wFileSource) > 0 then
    begin
      with ObjetoXML do
      while wOK do
      begin
        Inc(J,1);
        SetLength(wArrayObjXML, J);
        ObjetoXML := TLm_bkpdfe.Create;
        Tipo := '1';
        Status := cAguardando;
        CNPJ  := fGetCNPJPelaChave(Chave);
        wStream := TMemoryStream.Create;
        wFileStream := TFileStream.Create(wFileSource,0);
        wXmlName := ExtractFileName(wFileSource);
        Chave := fGetChaveFilename(wXmlName);
        XMLArq.LoadFromStream(wFileStream,xetUTF_8);
        wNodeXML := XMLArq.documentElement;

        if Assigned(wNodeXML) then
        begin
          if wNodeXML.NodeName = 'protNFe' then
             wNodeXML := wNodeXML.ChildNodes.First;

          if Assigned(wNodeXML) and (wNodeXML.NodeName = 'infProt') then
          begin
            Tipoambiente :=  funcvarXML(wNodeXML.ChildNodes['tpAmb']); // Tipo de Ambiente da Nota Fiscal(Produção/Homologação)
            if Tipoambiente = '1' then
              Tipoambiente := 'Produção'
            else
            Tipoambiente := 'Homologação';
            wChaveAux := funcvarXML(wNodeXML.ChildNodes['chNFe']);
            Datarecto := DateXMLToDate(funcvarXML(wNodeXML.ChildNodes['dhRecbto']));
            Protocoloaut := funcvarXML(wNodeXML.ChildNodes['nProt']);
            Status :=  StrToIntDef(funcvarXML(wNodeXML.ChildNodes['cStat']),-1);
            Motivo :=  funcvarXML(wNodeXML.ChildNodes['xMotivo']);
            if Length(Motivo) > 20 then
            Motivo := Copy(Motivo,1,20);
            Dataalteracao := Today;
          end;
        end;

        if pParametro then
          pProgress('Importando '+wXmlName, J);

        FileClose(wFileStream.Handle);
  //        pCompress(wFileSource, wStream,false);
  //        Xmlenvio:= wStream;

        wArrayObjXML[j-1] := ObjetoXML;

        if pParametro then
        begin
          wErro := FindNext(wFRec);
          wFileSource := wPathFile+'\'+wFRec.Name;
          wOK := (wErro = 0);
          Continue;
        end
        else
        begin
          wOK := False;
          exit;
        end;
      end;
    end;

    Result := Length(wArrayObjXML);
  end;

  function fCarregaPath:boolean;
  var
  wPathAux: string;
  wTiposXML : TTipoXML;
  begin
    wPathAux := '';
    Result := False;

    case pTiposXML of
      txNFE_Env, txNFE_EnvLote,txCan_, txCan_Lote:
      begin
        wPathAux := pObjConfig.NFePathEnvio;
      end;

      txNFe_EnvExt, txNFe_EnvExtLote, txCan_Ext, txCan_ExtLote:
      begin
        wPathAux := pObjConfig.NFePathProcessado;
      end;

      txTodos:
      begin
        wPathAux := pObjConfig.NFePathRetornoLido;
      end;
    end;

    Result :=  DirectoryExists(wPathAux);
    if Result then
      wPathFile := wPathAux;
  end;

 function fGravaXML: Boolean;
 var i: Integer;
 begin
   Result := False;
   try
     for I := Low(wArrayObjXML) to High(wArrayObjXML) do
     begin
       if Assigned(wArrayObjXML[I]) then
       begin
         if pParametro then
           pProgress('Processando a base dados '+wArrayObjXML[I].Chave, J);

         Inc(J,1);
         if wDaoXML.fCarregaXMLEnvio(wArrayObjXML[I]) then
           wArrayObjXML[i].Free;
       end
       else
         wArrayObjXML[i].Free;
     end;
   finally
     Result := True;
     FreeAndNil(wChaveErro);
   end;
 end;

begin
  if not Assigned(wChaveErro) then
     wChaveErro := TStringList.Create;

  if not Assigned(pObjConfig) then
    exit;

  XMLArq     := TXMLDocument.Create(Application);
  wDaoXML    := TDaoBkpdfe.Create;
  wDataSet   := TDataSet.Create(Application);

  if pParametro then
    fCarregaPath;
  try
    try
     fXMLChave;
     Result := J;
     FRefazAutorizacao := fGravaXML;
    except on E: Exception do
           begin
             FRefazAutorizacao := False;
             if pParametro then
               exit;

              if wChaveErro.IndexOf(wChaveAux) < 0 then
                 wChaveErro.Add(wChaveAux);

             if (not wYesAll) then
             begin
               wYesAll :=  MessageDlg('Erro na leitura do arquivo: '+ wChaveAux+ #10#13+
                                      'Deseja refazer o processo? '+#10#13+
                                      E.Message, mtError, [mbYes, mbYesToAll, mbNo],0) = mrYesToAll;

                fLoadXMLNFe(tabConfiguracoes,txNFe_EnvExt,true,'','');
             end;

             if wYesAll then
                 fLoadXMLNFe(tabConfiguracoes,txNFe_EnvExt,true,'','')
             else
               exit;
           end;

    end;
  finally
    foPrincipal.pAtualizaGrid;
    FreeAndNil(XMLArq);
    FreeAndNil(wDaoXML);
    FreeAndNil(wDataSet);
  end;

end;

function TRotinas.fLoadXMLNFeLista(pLista : TStringList): Boolean;
var
  wDaoXML    : TDaoBkpdfe;
  wObjConfig : TConfiguracoes;
  wDaoConfig : TDaoConfiguracoes;
  wObjetoXML : TLm_bkpdfe;
  wStream    : TStream;
  wFileStream : TFileStream;
  wFRec      : TSearchRec;
  wErro, wI, wJ: integer;
  XMLArq     : TXMLDocument;
  wArrayObjXML : array of TLm_bkpdfe;
  wNodeXML, wNodeInfNFe, wNodeNfeProc: IXMLNode;
  wFileSource, wFileDest: string;
  wXmlName, wZipName,wChaveAux,wPathFile: string;
  wXMLEnvio, wXMLProcessado,wOK: boolean;

 function fGetChaveFilename(pFileName : string): string;
  var wPos :Integer;
  begin
    Result := '';
    if (pFileName = '') then
     Exit;

    Result := ExtractFileName(pFileName);

    wPos := Pos('Env_NFe',Result);
    if wPos > 0 then
    begin
      Result := Copy(Result,8,44);
      exit;
    end;

    wPos := Pos('Can_',Result);
    if wPos > 0 then
    begin
      Result := Copy(Result,5,44);
      exit;
    end;

    wPos := Pos('Inut_',Result);
    if wPos > 0 then
    begin
      Result := Copy(Result,6,44);
      Exit;
    end;

    wPos := Pos('retsai_NFe',Result);
    if wPos > 0 then
    begin
      Result := Copy(Result,11,44);
      Exit;
    end;

  end;

  function funcvarXML(xmlNTag : IXMLNode): WideString;
  begin
    if Not (xmlNTag.ChildNodes.First = Nil) Then
      Result := xmlNTag.ChildNodes.First.Text;
  end;

  procedure pXMLChave(pChave : String);
  begin

    wErro := FindFirst(wObjConfig.NFePathProcessado+'\*'+ pChave+'*.xml', faAnyFile, wFRec);
    wOK := wErro = 0;
    wFileSource := wObjConfig.NFePathProcessado+'\'+wFRec.Name;

    with wObjetoXML do
    while wOK do
    begin
      if Pos('Env_NFe',wFileSource) > 0 then
      begin
        Status := cAguardando;
        wObjetoXML := TLm_bkpdfe.Create;
        wXmlName := ExtractFileName(wFileSource);
        wChaveAux := fGetChaveFilename(wXmlName);

        Tipo := '1';
        Inc(wJ,1);
        SetLength(wArrayObjXML, wJ);
        wXMLProcessado := False;
        wStream := TMemoryStream.Create;
        wFileStream := TFileStream.Create(wFileSource,0);

        XMLArq.LoadFromStream(wFileStream,xetUTF_8);
        wNodeXML := XMLArq.documentElement;
        //Nesse momento verifica se o xml é autorizado (nfeProc = Autorizado) (NFe = XML de Envio)
        if Assigned(wNodeXML) and (wNodeXML.NodeName = 'nfeProc') or (wNodeXML.NodeName = 'NFe') then
        begin
          if (wNodeXML.NodeName = 'nfeProc') then
          begin
            wXMLProcessado := true;
            wNodeNfeProc := wNodeXML;
            wNodeXML := wNodeXML.ChildNodes.First;
          end;

          if (wNodeXML.NodeName = 'NFe') then
          begin
            wNodeXML := wNodeXML.ChildNodes.First;

            if Assigned(wNodeXML) and (wNodeXML.NodeName = 'infNFe') then
            begin
              Chave := wNodeXML.AttributeNodes.FindNode('Id').text;
              Chave := Copy(Chave,4,44);
              wNodeXML := wNodeXML.ChildNodes.First;
              if Assigned(wNodeXML) and (wNodeXML.NodeName = 'ide') then
              begin
                Idf_documento := StrToInt64Def(funcvarXML(wNodeXML.ChildNodes['nNF']),0);
                Dataemissao := DateXMLToDate(funcvarXML(wNodeXML.ChildNodes['dhEmi']));
                Tipoambiente :=  funcvarXML(wNodeXML.ChildNodes['tpAmb']); // Tipo de Ambiente da Nota Fiscal(Produção/Homologação)
                if Tipoambiente = '1' then
                  Tipoambiente := 'Produção'
                else
                  Tipoambiente := 'Homologação';
              end;

            end;

            if (wXMLProcessado) and (Assigned(wNodeNfeProc)) then
            begin
              wNodeNfeProc := wNodeNfeProc.ChildNodes.First.NextSibling;
              if Assigned(wNodeNfeProc) and (wNodeNfeProc.NodeName = 'protNFe') or (wNodeNfeProc.NodeName = 'infProt') then
              begin
                if (wNodeNfeProc.NodeName = 'protNFe') then
                  wNodeNfeProc := wNodeNfeProc.ChildNodes.First;

                if (wNodeNfeProc.NodeName = 'infProt') then
                begin
                  Tipoambiente :=  funcvarXML(wNodeNfeProc.ChildNodes['tpAmb']); // Tipo de Ambiente da Nota Fiscal(Produção/Homologação)
                  if Tipoambiente = '1' then
                    Tipoambiente := 'Produção'
                  else
                  Tipoambiente := 'Homologação';

                  wChaveAux := funcvarXML(wNodeNfeProc.ChildNodes['chNFe']);
                  if Chave <> wChaveAux then
                     exit;

                  Datarecto := DateXMLToDate(funcvarXML(wNodeNfeProc.ChildNodes['dhRecbto']));
                  Protocoloaut := funcvarXML(wNodeNfeProc.ChildNodes['nProt']);
                  Status :=  StrToIntDef(funcvarXML(wNodeNfeProc.ChildNodes['cStat']),-1);
                  Motivo :=  funcvarXML(wNodeNfeProc.ChildNodes['xMotivo']);
                  if Length(Motivo) > 20 then
                  Motivo := Copy(Motivo,1,20);
                end;
              end;
            end;
          end;
        end;

        FileClose(wFileStream.Handle);
        pCompress(wFileSource, wStream,false);
        Xmlenvio := wStream;
        if wXMLProcessado then
          Xmlextend := wStream;

        Dataalteracao := Today;
        wArrayObjXML[wJ-1] := wObjetoXML;
      end;

      if Pos('Can_',wFileSource) > 0 then
      begin
        Inc(wJ,1);
        Status := cAguardando;
        SetLength(wArrayObjXML, wJ);
        wXmlName := ExtractFileName(wFileSource);
        wObjetoXML := TLm_bkpdfe.Create;
        Chave := fGetChaveFilename(wXmlName);
        Idf_documento := fGetIdf_DocPelaChave(Chave);
        Tipo := '1';
        wStream := TMemoryStream.Create;
        wFileStream := TFileStream.Create(wFileSource,0);
        XMLArq.LoadFromStream(wFileStream);
        wNodeXML := XMLArq.documentElement;

        if Assigned(wNodeXML) then
        begin  //CAN_ Envio
          if (wNodeXML.NodeName = 'cancNFe') then
          begin
            wNodeXML := wNodeXML.ChildNodes.First;

            if Assigned(wNodeXML) and (wNodeXML.NodeName = 'infCanc') then
            begin
              Tipoambiente := funcvarXML(wNodeXML.ChildNodes['tpAmb']);
              if Tipoambiente = '1' then
                Tipoambiente := 'Produção'
              else
                Tipoambiente := 'Homologação';
              wChaveAux := funcvarXML(wNodeXML.ChildNodes['chNFe']);
              Protocolocanc := funcvarXML(wNodeXML.ChildNodes['nProt']);
              Status := cCancAguard;
              Motivocanc := funcvarXML(wNodeXML.ChildNodes['xJust']);
              if Length(Motivocanc)>20 then
                Motivocanc := copy(Motivocanc,1,20);

//              if pEmail <> '' then
//                      Emailsnotificados := pEmail;
              Dataalteracao := Today;
              FileClose(wFileStream.Handle);
              pCompress(wFileSource,wStream,false);
              Xmlenviocanc := wStream;
            end;
          end
          else
          if (wNodeXML.NodeName = 'procEventoNFe') then
          begin   //CAN_ processado
            wNodeXML := wNodeXML.ChildNodes.First.NextSibling; //Pula da tag <Evento> para <retEvento>

            if Assigned(wNodeXML) and (wNodeXML.NodeName = 'retEvento') then
            begin
              wNodeXML := wNodeXML.ChildNodes.First;
              if Assigned(wNodeXML) and (wNodeXML.NodeName = 'infEvento') then
              begin
                Tipoambiente := funcvarXML(wNodeXML.ChildNodes['tpAmb']);
                if Tipoambiente = '1' then
                  Tipoambiente := 'Produção'
                else
                  Tipoambiente := 'Homologação';

                Status :=  StrToIntDef(funcvarXML(wNodeXML.ChildNodes['cStat']),-1);
                wChaveAux := funcvarXML(wNodeXML.ChildNodes['chNFe']);
                if wChaveAux <> Chave then
                  exit;

                Protocolocanc := funcvarXML(wNodeXML.ChildNodes['nProt']);
                Motivocanc := funcvarXML(wNodeXML.ChildNodes['xMotivo']);
                if Length(Motivocanc)> 20 then
                  Motivocanc := copy(Motivocanc,1,20);

                Dataalteracao := Today;
                FileClose(wFileStream.Handle);
                pCompress(wFileSource,wStream,false);
                Xmlextendcanc := wStream;
              end;
            end;
          end;
        end;

        wArrayObjXML[wJ-1] := wObjetoXML;
      end;

      wErro := FindNext(wFRec);
      wFileSource := wObjConfig.NFePathProcessado+'\'+wFRec.Name;
      wOK := (wErro = 0);
    end;
  end;

 function fCarregaObjConfig(pIDConfig : Integer): boolean;
  begin
    Result := false;
    if not Assigned(wObjConfig) then
      wObjConfig := TConfiguracoes.Create;

    wObjConfig.id := pIDConfig;
    Result := (wDaoConfig.fCarregaConfiguracoes(wObjConfig,['id']).RecordCount = 1);
  end;

 function fGravaXML: boolean;
 var i: Integer;
 begin
   Result := False;
   try
   for I := Low(wArrayObjXML) to High(wArrayObjXML) do
   begin
     if wDaoXML.fCarregaXMLEnvio(wArrayObjXML[I]) then
        wArrayObjXML[i].Free;
   end;
   finally
     Result := True;
   end;
 end;

begin
  Result := False;

  XMLArq     := TXMLDocument.Create(Application);
  wDaoXML    := TDaoBkpdfe.Create;
  wObjConfig := TConfiguracoes.Create;
  wDaoConfig := TDaoConfiguracoes.Create;

  try
    try
      if fCarregaObjConfig(tabUsuarios.Id) then
      begin
        wJ := 0;
        for wI := 0 to pLista.Count - 1 do
          pXMLChave(pLista.Strings[wi]);
      end
      else
      exit;

      Result := fGravaXML;
    except on E: Exception do
      ShowMessage('Método: fLoadXMLNFeLista' + #10#13+
                  'Arquivo: '+ wXmlName+#10#13+
                   E.Message);
    end;

  finally
    FreeAndNil(XMLArq);
    FreeAndNil(wDaoXML);
    FreeAndNil(wObjConfig);
    FreeAndNil(wDaoConfig);
  end;
end;

function TRotinas.fExportaPDF(pLista: TStringList): Integer;
var
  wOK : boolean;
  wDaoXML    : TDaoBkpdfe;
  wObjConfig : TConfiguracoes;
  wDaoConfig : TDaoConfiguracoes;
  wObjetoXML : TLm_bkpdfe;
  wFRec      : TSearchRec;
  wErro, wI,wJ, wTotSave  : integer;
  wFileSource,wPathSave, wPathArq, wFileName: string;

 function fCarregaObjConfig(pIDConfig : Integer): boolean;
  begin
    Result := false;
    if not Assigned(wObjConfig) then
      wObjConfig := TConfiguracoes.Create;

    wObjConfig.id := pIDConfig;
    Result := (wDaoConfig.fCarregaConfiguracoes(wObjConfig,['id']).RecordCount = 1);
  end;


  function fCarregaPAthPDF: String;
  var wPathMAX : string;
  begin
    wPathMAX := ExtractFileDir(ParamStr(0));
    wPathMAX := Copy(wPathMAX, 1, LastDelimiter('\', wPathMAX));
    if FileExists(wPathMAX+'Maxwin.exe') or (FileExists(wPathMAX+'Maxecv.exe')) then
      Result := wPathMAX + 'DFE\PDF';

    if not DirectoryExists(Result) then
    with foPrincipal.jopdDirDir do
    begin
      InitialDir := Copy(ExtractFileDir(ParamStr(0)),1, LastDelimiter('\',InitialDir));
      Title := 'Localize a pasta de arquivos PDFs salvos';
      if Execute then
      begin
        Result := Directory
      end;
    end;
  end;

begin
  wJ         := 0;
  Result     := 0;
  wDaoXML    := TDaoBkpdfe.Create;
  wObjConfig := TConfiguracoes.Create;
  wDaoConfig := TDaoConfiguracoes.Create;
  try
    wPathSave := fCarregaPAthPDF;
    try
      with foPrincipal.dlgSaveXML do
      begin
        InitialDir := GetCurrentDir;
        Filter := 'ZIP | *.zip';
        FilterIndex := FilterIndex+1;
        wJ := pLista.Count;
        FileName := 'LotePDF'+IntToStr(wJ)+'.zip';

        if Execute then
        begin
          wJ := 0;
          wTotSave := 0;
          for wI := 0 to pLista.Count - 1 do
          begin
            wErro := FindFirst(wPathSave+'\*'+ pLista.Strings[wi]+'*.pdf', faAnyFile, wFRec);
            wOK := wErro = 0;
            while wOK do
            begin
              wFileSource := wPathSave+'\'+wFRec.Name;
              if Pos(pLista.Strings[wi] ,wFileSource) > 0 then
                if fZipFile(FileName,wFileSource) then
                   Inc(wJ,1);

              pProgress('Exportando PDF'+QuotedStr('s')+': '+wFRec.Name, wI);
              wErro := FindNext(wFRec);
              wOK := (wErro = 0);
            end;
           end;

          Result := wJ;
        end;
      end;

    except on E: Exception do
      ShowMessage('Método: fExportaPDF' + #10#13+
                   E.Message);
    end;

  finally
    FreeAndNil(wDaoXML);
    FreeAndNil(wObjConfig);
    FreeAndNil(wDaoConfig);
  end;

end;


function TRotinas.fGetIdf_DocPelaChave(pChave: string):integer;
var wLen : Integer;
begin
  Result := 0;
  if pChave= '' then
    exit;
  wLen := Length(pChave);
  if (wLen = 44) then
  begin
    pChave := Copy(pChave, 26,9);
    Result := StrToIntDef(pChave,0);
    exit;
  end;

  if (wLen = 52) and (pos('Can_',pChave)>0 ) then
  begin
    pChave := Copy(pChave, 30,9);
    Result := StrToIntDef(pChave,0);
    exit;
  end;

  if (wLen = 53) and (pos('Inut_',pChave)>0 ) then
  begin
    pChave := Copy(pChave, 31,9);
    Result := StrToIntDef(pChave,0);
    exit;
  end;

  if (wLen = 55) and (pos('Env_NFe',pChave)>0 ) then
  begin
    pChave := Copy(pChave, 33,9);
    Result := StrToIntDef(pChave,0);
    exit;
  end;
end;

function TRotinas.fGetCNPJPelaChave(pChave: string):string;
var wLen: Integer;
begin
  Result := '';

  if pChave= '' then
    exit;
  wLen := Length(pChave);

  if (wLen = 44) then
  begin
    pChave := Copy(pChave, 08,14);
    if fValidaCNPJ(pChave) then
      Result := pChave;
    exit;
  end;

  if (wLen = 52) and (pos('Can_',pChave)>0 ) then
  begin
    pChave := Copy(pChave, 11,14);
    if fValidaCNPJ(pChave) then
      Result := pChave;
    exit;
  end;

  if (wLen = 53) and (pos('Inut_',pChave)>0 ) then
  begin
    pChave := Copy(pChave, 12,14);
    if fValidaCNPJ(pChave) then
      Result := pChave;
    exit;
  end;

  if (wLen = 55) and (pos('Env_NFe',pChave)>0 ) then
  begin
    pChave := Copy(pChave, 14,14);
    if fValidaCNPJ(pChave) then
      Result := pChave;
    exit;
  end;
end;

procedure TRotinas.pLeituradaNFE;
var
  xmlNCab, xmlNItm : IXMLNode;
  widstrRetorno    : WideString;
  xmldoc_nfe       : TXMLDocument;
  opndlg_nfe       : TOpenDialog;

  function funcvarXML(xmlNTag : IXMLNode): WideString;
  begin
    if Not (xmlNTag.ChildNodes.First = Nil) Then
      Result := xmlNTag.ChildNodes.First.Text;
  end;

begin
  xmldoc_nfe := TXMLDocument.Create(Application);
  opndlg_nfe := TOpenDialog.Create(Application);

  //  *** Importar Arquivo XML NFe...
  opndlg_nfe.InitialDir := Application.GetNamePath;
  opndlg_nfe.Filter := 'NFe|*.XML';
  opndlg_nfe.Title  := 'Selecione o arquivo a importar';
  opndlg_nfe.Execute;

  if Not (opndlg_nfe.FileName = '') Then
  Exit;
  // Lendo o arquivo pelas TAGs...
  xmldoc_nfe.LoadFromFile(opndlg_nfe.FileName);
  // Leitura Dados da Nota Fiscal...
  xmlNCab := xmldoc_nfe.DocumentElement.childNodes.First.ChildNodes.FindNode('ide');
  if Not (xmlNCab.ChildNodes.First = Nil) Then
  begin
    widstrRetorno := funcvarXML(xmlNCab.ChildNodes['cNF'    ]); // Código sequencial NFe
    widstrRetorno := funcvarXML(xmlNCab.ChildNodes['nNF'    ]); // Número da Nota Fiscal
    widstrRetorno := funcvarXML(xmlNCab.ChildNodes['dEmi'   ]); // Data Emissão Nota Fiscal
    widstrRetorno := funcvarXML(xmlNCab.ChildNodes['verProc']); // Descrição da Nota Fiscal
    widstrRetorno := funcvarXML(xmlNCab.ChildNodes['serie'  ]); // Série da Nota Fiscal
  end;
  // Leitura Dados do Fornecedor...
  xmlNCab := xmldoc_nfe.DocumentElement.childNodes.First.ChildNodes.FindNode('emit');
  if Not (xmlNCab.ChildNodes.First = Nil) Then
  begin
    widstrRetorno := funcvarXML(xmlNCab.ChildNodes['CNPJ'   ]); // CGC Fornecedor
    widstrRetorno := funcvarXML(xmlNCab.ChildNodes['CPF'    ]); // CPF Fornecedor
    widstrRetorno := funcvarXML(xmlNCab.ChildNodes['xNome'  ]); // Razão Social do Fornecedor
    widstrRetorno := funcvarXML(xmlNCab.ChildNodes['xFant'  ]); // Nome Fantasia
    widstrRetorno := funcvarXML(xmlNCab.ChildNodes['IE'     ]); // Inscrição Estadual
    // Leitura Dados Endereços do Fornecedor...
    xmlNItm := xmlNCab.ChildNodes['enderEmit'];
    if Not (xmlNItm.ChildNodes.First = Nil) Then
    begin
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['xLgr'   ]); // Logradouro
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['nro'    ]); // Número
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['xCpl'   ]); // Complemento
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['xBairro']); // Bairro
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['cMun'   ]); // Código Município IBGE
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['xMun'   ]); // Nome Município
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['UF'     ]); // Unidade Federação
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['CEP'    ]); // CEP
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['cPais'  ]); // Código Pais BACEN
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['xPais'  ]); // Nome Pais
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['fone'   ]); // Telefone
    end;
  end;
  // Leitura Dados Totais da Nota Fiscal...
  xmlNCab := xmldoc_nfe.DocumentElement.childNodes.First.ChildNodes.FindNode('total');
  if Not (xmlNCab.ChildNodes.First = Nil) Then
  begin
    xmlNItm := xmlNCab.ChildNodes['ICMSTot'];
    if Not (xmlNItm.ChildNodes.First = Nil) Then
    begin
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['vNF'    ]); // Valor total da Nota Fiscal(2dec,S/M)
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['vProd'  ]); // Valor total da Nota Fiscal(2dec,S/M)
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['vDesc'  ]); // Valor total dos descontos (2dec,S/M)
    end;
  end;
  // Leitura Dados Itens da Nota Fiscal...
  xmlNCab := xmldoc_nfe.DocumentElement.childNodes.First.ChildNodes.FindNode('det');
  While Not (xmlNCab = Nil) Do
  begin
    xmlNCab.ChildNodes.First.ChildNodes.FindNode('det');
    xmlNItm := xmlNCab.ChildNodes['prod'];
    if Not (xmlNItm.ChildNodes.First = Nil) Then
    begin
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['cProd'  ]); // Código do produto CFOP
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['xProd'  ]); // Nome do produto
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['uCom'   ]); // Sigla unidade da embalagem
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['qCom'   ]); // Quantidade do produto (4dec,S/M)
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['vUnCom' ]); // Valor unitário do produto (4dec,S/M)
      widstrRetorno := funcvarXML(xmlNItm.ChildNodes['vProd'  ]); // Valor total do produto (2dec,S/M)
    end;
    xmlNCab := xmlNCab.NextSibling;
  end;;

end;

procedure TRotinas.pProgress(pText: string; pNumber: cardinal);
begin
  Text := Trim(pText);
  Number := pNumber;
  DoProgress;
end;

{TRotinas}

function TRotinas.fDirectoryTreeFileCount(PInitialDir: String): Cardinal;
var
  SearchRecord: TSearchRec;
begin
  Result := 0;
  if (Copy(PInitialDir,length(PInitialDir),1) <> '\') then
    PInitialDir := PInitialDir + '\';

  if FindFirst(PInitialDir + '*.*', faAnyFile, SearchRecord) = 0 then
    try
      repeat
        if ((SearchRecord.Attr and faDirectory) = faDirectory) then
        begin
          if (SearchRecord.Name <> '.') and (SearchRecord.Name <> '..') then
            Inc(Result,fDirectoryTreeFileCount(PInitialDir + SearchRecord.Name + '\' + ExtractFileName(PInitialDir)));
        end
        else
          Inc(Result);
      until FindNext(SearchRecord) <> 0;
    finally
      FindClose(SearchRecord)
    end;
end;

procedure TRotinas.Execute;

  procedure pExecuteLoadXMLNFe;
  begin
    Max := 2 * fDirectoryTreeFileCount(FInitialDir);;
    DoMax;
    FResult := fLoadXMLNFe(tabConfiguracoes, txNFe_EnvExtLote, True);
  end;

  procedure pExecuteExportaLoteXML;
  begin
    Max := FLista.Count;
    DoMax;
    FResult := fExportaLoteXML(FLista);
  end;

  procedure pExecuteExportaPDF;
  begin
    Max := FLista.Count;
    DoMax;
    FResult := fExportaPDF(FLista);
  end;

  procedure pExecuteSelecionaLinhaGrid;
  begin
    Max := foPrincipal.dbgNfebkp.DataSource.DataSet.RecordCount;
    DoMax;
    FResult :=foPrincipal.fSelecionaLinhaGrid(sgFiltro);
  end;

begin

  inherited;
  CoInitializeEx(nil,0);
  try
    case FExecuteMetodo of
           emExportaPDF : pExecuteExportaPDF;
           emLoadXMLNFe : pExecuteLoadXMLNFe;
       emExportaLoteXML : pExecuteExportaLoteXML;
        emSelecionaRows : pExecuteSelecionaLinhaGrid


    end;
  finally
    CoInitializeEx(nil,0);
  end;
end;

function TRotinas.fDeleteObjetoXML(pLista: TStringList; pCNPJ: string): Boolean;
var i: integer;
    wObjtXML : TLm_bkpdfe;
    wDataSet : TDataSet;
begin
  Result := False;
    DM_NFEDFE.Dao.StartTransaction;
  try

    if pCNPJ = '*' then
    begin
      wDataSet := DM_NFEDFE.Dao.ConsultaSqlExecute('delete from lm_bkpdfe');
      Result := wDataSet.IsEmpty;
      Exit;
    end
    else
    if fValidaCNPJ(pCNPJ) then
    begin
      if Length(pCNPJ) >= 18  then
       pCNPJ := fTiraMascaraCNPJ(pCNPJ);

      wDataSet := DM_NFEDFE.Dao.ConsultaSqlExecute('delete from lm_bkpdfe where CNPJ = '+ QuotedStr(pCNPJ));
      Result := wDataSet.FieldCount = 0;
      Exit;
    end;

    for I := 0 to pLista.Count - 1 do
    begin
      wObjtXML := TLm_bkpdfe.create;
      wObjtXML := TLm_bkpdfe(pLista.Objects[I]);
      if wObjtXML.Chave = pLista.Strings[i] then
        if DaoObjetoXML.fConsDeleteObjXML(wObjtXML,['CHAVE']) then
        begin
          Result := (DaoObjetoXML.fExcluirObjXML(wObjtXML) > 0);
          ObjetoXML:= TLm_bkpdfe.Create;
        end;
    end;

   DM_NFEDFE.Dao.Commit;
  except
    DM_NFEDFE.Dao.RollBack;
    Result := False;
  end;
end;


function TRotinas.fCompactar(pPath: string): TFileStream;
var
FileIni, FileOut: TFileStream;
Zip: TCompressionStream;
begin
  try
    FileIni:=TFileStream.Create(pPath, fmOpenRead and fmShareExclusive);//fmOpenRead);
    FileOut:=TFileStream.Create(pPath, fmCreate and fmShareExclusive);   // fmShareExclusive);
    Zip:=TCompressionStream.Create(clMax, FileOut);
    Zip.CopyFrom(FileIni, FileIni.Size);

    Result := FileIni;
  finally
    Zip.Free;
    FileOut.Free;
    FileIni.Free;
  end;
end;


end.


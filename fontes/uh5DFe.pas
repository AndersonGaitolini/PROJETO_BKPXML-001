unit uh5DFe;

interface

uses
  Classes, SysUtils, Comobj, Variants, DB, uxbPublico, uxbClasses, uhbClientDataSet,
  uxsM3Publico, uM3DocumentosRefExtH0, uM3DocumentosRefExtH1, uM3DocumentosRefExtH2, uM3DocumentosRefExtH3, uM3DocumentosH0, uM3DocumentosH1, uM3DocumentosH2, uM3DocumentosH3, uh0DFe,
  Tlhelp32, windows;

type

  { Th5DFe }
  Th5DFe = class(Th0DFe, I20DFe)
  private
    function NumProcessThreads: Integer;
    function IsValidDispatch(const v:OleVariant):Boolean;
    procedure ExportarXMLs(aListaDoctos: String; DiretorioDestino: string);
    procedure RefazerAutorizacoesSelecionados(aListaDoctos: String);
    procedure RefazerAutorizacoesTodos;
    procedure ExportarPDFs(aListaDoctos: String; DiretorioDestino: string);
    //procedure ShellUnzip(zipfile, targetfolder: string; filter: string = '');
    procedure ShellZip(zipfile, sourcefolder:OleVariant; filter: String = '');

    procedure Compress(const ASrc: string; var vDest: TStream; aEHStringStream: Boolean);
    procedure Decompress(var vXML: TStream; ADest: string);
  protected
    procedure _INTERNO_Incluir_Alterar(aIDFDocto: Integer; aChave: string; aXMLEnvio: string; aXMLExtend: string; aDataEmi: TDateTime; aDataRecto: TDateTime; aMotivo: string; aProtocoloCancel: string; aProtocoloRecto: string;
                              aDataAlteracao: TDateTime; aEmailsNotificados: string; aProcesso: String; aTipoAmbiente: Integer; aNomeArquivo: String; aCaminhoArquivo: String; aXMLEnvioCanc: String; aXMLExtendCanc: String); override;
  public
    function ExecutarMetodo(aNomeMetodo: String; var aParametros: OleVariant; aThread: TThread = nil): OleVariant; override;

  end;

implementation

uses
  uxbCentral, uxbExpressao, VarUtils, Dialogs, Jpeg, Graphics, zlib;

const
  SHCONTCH_NOPROGRESSBOX = 4;  
  SHCONTCH_AUTORENAME = 8;  
  SHCONTCH_RESPONDYESTOALL = 16;  
  SHCONTF_INCLUDEHIDDEN = 128;  
  SHCONTF_FOLDERS = 32;  
  SHCONTF_NONFOLDERS = 64;    

{ Th5DFe }
{ Th5DFe }

//GFS - DFe.
//Obs.: Os XML's são guardados compactados e descompactados do banco usando o ZLIB do Delphi,
//porém, para compactar novamente e ser utilizável é necessário usar a API do Windows, o ZLIB só serve para backup (não pode ser lido posteriormente). 
//Caso necessário, o método ShellUnzip descompacta com a API do Windows, está comentado.

procedure Th5DFe.ExportarXMLs(aListaDoctos: String; DiretorioDestino: string);
const
  kAutorizada = '3';
  kCancelada  = '5';
var
  fCloneAux: ThbObjetoNegocio;
  sDirXMLTemp: String;
  sDirDestino: String;
  vXML:      TStream;
  vXMLCanc:  TStream;
  sArquivo:  String;
  ms: TMemoryStream;
begin
  fCloneAux := ThbObjetoNegocio(Aplicacao.Repositorio.Instanciar(Session, kDFe));
  try
    sDirXMLTemp := ExpandFileName(ExtractFileDir(ParamStr(0)))+ '\XML_Temp\';
    sArquivo    := ExpandFileName(ExtractFileDir(ParamStr(0)))+ '\ZIP\Notas.zip';
    sDirDestino := DiretorioDestino + '\Notas.zip';
    
    fCloneAux.Dados.Filtros.LimparTodos;

    with fCloneAux.Dados.Filtros.Adicionar('Flt').Condicoes.IncluirExpressao(kOpOu).Expressao do
    begin
      with IncluirExpressao2(kOpIgual) do
      begin
        IncluirVariavel2(kAtDocto_SituacaoNFe);
        IncluirConstante2(kAutorizada);
      end;

      with IncluirExpressao2(kOpIgual) do
      begin
        IncluirVariavel2(kAtDocto_SituacaoNFe);
        IncluirConstante2(kCancelada); 
      end;
    end;

    fCloneAux.Dados.ListaIN.Text := aListaDoctos;
    fCloneAux.Dados.ListaIN.Insert(0, kAtDFe_ID);
    if fCloneAux.Dados.AtivarDataSet(kVsDFe_BRW) then
    begin
      while not fCloneAux.Dados.CDS.Eof do
      begin
        vXML     := TMemoryStream.Create;
        vXMLCanc := TMemoryStream.Create;
        try
          TBlobField(fCloneAux.Dados.AtributoByName(kAtDFe_XMLExtend).FieldH).SaveToStream(vXML);
          Decompress(vXML, sDirXMLTemp + 'NFe'+ fCloneAux.Dados.FBAN[kAtDFe_Chave].AsString + '-procnfe.xml');

          if TBlobField(fCloneAux.Dados.AtributoByName(kAtDFe_XMLExtendCanc).FieldH).Value <> '' then
          begin
            TBlobField(fCloneAux.Dados.AtributoByName(kAtDFe_XMLExtendCanc).FieldH).SaveToStream(vXMLCanc);
            Decompress(vXMLCanc, sDirXMLTemp + 'NFe'+ fCloneAux.Dados.FBAN[kAtDFe_Chave].AsString + '-proccanc.xml');
          end;
        finally
          vXML.Free; //Precisa sempre criar um novo.
          vXMLCanc.Free;
        end;

        fCloneAux.Dados.CDS.Next;
      end;

      ShellZip(sArquivo, sDirXMLTemp, '');

      if FileExists(sArquivo) then
      begin
        ms := TMemoryStream.Create;
        ms.LoadFromFile(sArquivo);
        ms.SaveToFile(sDirDestino);
        ms.Free;
      end;
    end;
  finally
    Aplicacao.Repositorio.Destruir(fCloneAux);
  end;
end;

function Th5DFe.ExecutarMetodo(aNomeMetodo: String; var aParametros: OleVariant; aThread: TThread): OleVariant;
begin
  if aNomeMetodo = 'ExportarXMLs' then
    ExportarXMLs(aParametros[0], aParametros[1])
  else
    if aNomeMetodo = 'ExportarPDFs' then
      ExportarPDFs(aParametros[0], aParametros[1])
    else
      if aNomeMetodo = 'RefazerAutorizacoesSelecionados' then
        RefazerAutorizacoesSelecionados(aParametros[0])
      else
        if aNomeMetodo = 'RefazerAutorizacoesTodos' then
          RefazerAutorizacoesTodos;
end;

{procedure Th5DFe.ShellUnzip(zipfile, targetfolder, filter: string);
var
  srcfldr, destfldr: variant;
  shellfldritems: variant;
  shellobj: OleVariant;
begin
  shellobj := CreateOleObject('Shell.Application');
  
  srcfldr  := shellobj.NameSpace(zipfile);  
  destfldr := shellobj.NameSpace(targetfolder);  
  
  shellfldritems := srcfldr.Items;  
  if (filter <> '') then  
    shellfldritems.Filter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS,filter);  
  
  destfldr.CopyHere(shellfldritems, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);  
end;}

procedure Th5DFe.ShellZip(zipfile, sourcefolder: OleVariant; filter: String);
const //A tipagem dos diretórios(parâmetros) deve ser OleVariant para funcionar o get 'shellobj.NameSpace'.
  emptyzip: array[0..23] of byte  = (80,75,5,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
var
  ms:             TMemoryStream;
  srcfldr:        Variant;
  destfldr:       Variant;
  shellfldritems: Variant;
  shellobj:       Variant;
  NumT: Integer;
begin
  if not FileExists(zipfile) then
  begin
    //Criando um novo arquivo ZIP vazio.
    ms := TMemoryStream.Create;
    ms.WriteBuffer(emptyzip, sizeof(emptyzip));
    ms.SaveToFile(zipfile);
    ms.Free;
  end;

  NumT     := NumProcessThreads;
  shellobj := CreateOleObject('Shell.Application');

  srcfldr := shellobj.NameSpace(sourcefolder);
  if not IsValidDispatch(srcfldr) then
    raise EInvalidOperation.CreateFmt('<%s> Caminho Inválido!', [sourcefolder]);

  destfldr := shellobj.NameSpace(zipfile);   
  if not IsValidDispatch(destfldr) then
    raise EInvalidOperation.CreateFmt('<%s> Arquivo ZIP Inválido!', [Zipfile]);

  shellfldritems := srcfldr.Items;

  if filter <> '' then
  begin
    shellfldritems.Filter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS, Filter);
    destfldr.copyhere(shellfldritems, 0);
  end
  else
  begin
    shellfldritems.Filter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS, '');
    destfldr.copyhere(shellfldritems, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
  end;

  while NumProcessThreads <> NumT do
   Sleep(100);
end;

procedure Th5DFe._INTERNO_Incluir_Alterar(aIDFDocto: Integer; aChave, aXMLEnvio, aXMLExtend: string;
                                          aDataEmi, aDataRecto: TDateTime; aMotivo, aProtocoloCancel,
                                          aProtocoloRecto: string; aDataAlteracao: TDateTime;
                                          aEmailsNotificados: string; aProcesso: String; aTipoAmbiente: Integer;
                                          aNomeArquivo: String; aCaminhoArquivo: String; aXMLEnvioCanc: String; aXMLExtendCanc: String);
const
  kGerarNFe    = '1';
  kCancelarNFe = '2';
  kInutilizacao = '3';
var
  fObjAux:             ThbObjetoNegocio;
  iIDAux:              Integer;
  tBlobXMLEnvio:       TBlobField;
  tBlobXMLEnvioExtend: TBlobField;
  vDest:               TStream;
  FRec:                TSearchRec;
  sCaminhoXMLExtend:   String;
begin
  iIDAux  := 0;
  fObjAux := ThbObjetoNegocio(Aplicacao.Repositorio.Instanciar(Session, kDFe));
  vDest   := TmemoryStream.Create;
  try
    fObjAux.Dados.Filtros.LimparTodos;

    if aIDFDocto > 0 then
      fObjAux.Dados.Filtros['Flt'].Condicoes.IncluirConstante(kAtDFe_IDF_Documento, kopIgual, aIDFDocto)
    else
      fObjAux.Dados.Filtros['Flt'].Condicoes.IncluirConstante(kAtDFe_Chave, kopIgual, aChave); //Envio de cancelamento.

    if fObjAux.Dados.AtivarDataSet(kVsDFe_BRW) then
      iIDAux := fObjAux.Dados.FBAN[kAtDFe_ID].AsInteger;

    if aProcesso = kGerarNFe then
    begin
      if iIDAux > 0 then //Caso já exista evento de envio para a nota, edita e não cria um novo.
      begin
        Dados.Isolar(iIDAux, kVsDFe_BRW);
        EditarRegistro;

        if aXMLExtend <> '' then //Autorização, xml extendido com todas as informações.
        begin
          if (FindFirst(aCaminhoArquivo + '\Env_' + aChave + '*.XML', faAnyFile, FRec) = 0) then
          begin
            sCaminhoXMLExtend := aCaminhoArquivo + '\' + FRec.Name;
            Compress(sCaminhoXMLExtend, vDest, False);
            tBlobXMLEnvioExtend := TBlobField(Dados.AtributoByName(kAtDFe_XMLExtend).FieldH);
            tBlobXMLEnvioExtend.LoadFromStream(vDest);
          end;
        end;

        if aMotivo <> '' then
          Dados.FBAN[kAtDFe_Motivo].AsString := aMotivo;

        Dados.FieldByAtributoName(kAtDFe_ProtocoloAut).AsString := aProtocoloRecto;
        Dados.FieldByAtributoName(kAtDFe_DataRecto).AsDateTime  := aDataRecto;
      end
      else
      begin
        if not Dados.CDS.Active then
          Dados.Isolar(0, kVsDFe_BRW);

        IncluirRegistro;
        Dados.FieldByAtributoName(kAtDFe_IDF_Documento).AsInteger    := aIDFDocto;
        Dados.FieldByAtributoName(kAtDFe_Chave).AsString             := aChave;
        Dados.FieldByAtributoName(kAtDFe_DataEmissao).AsDateTime     := aDataEmi;
        Dados.FieldByAtributoName(kAtDFe_EmailsNotificados).AsString := aEmailsNotificados;
        Dados.FieldByAtributoName(kAtDFe_Tipo).AsString              := kGerarNFe;

        if aTipoAmbiente > 0 then
        begin
          if aTipoAmbiente = 1 then
            Dados.FieldByAtributoName(kAtDFe_TipoAmbiente).AsString := 'Produção'
          else
            if aTipoAmbiente = 2 then
              Dados.FieldByAtributoName(kAtDFe_TipoAmbiente).AsString := 'Homologação';
        end;
      end;

      if aXMLEnvio <> '' then
      begin
        Compress(aXMLEnvio, vDest, True);

        tBlobXMLEnvio := TBlobField(Dados.AtributoByName(kAtDFe_XMLEnvio).FieldH);
        tBlobXMLEnvio.LoadFromStream(vDest);
      end;

      Confirmar;
    end
    else
      if aProcesso = kCancelarNFe then
      begin
        if iIDAux > 0 then
        begin
          Dados.Isolar(iIDAux, kVsDFe_BRW);
          EditarRegistro;
          Dados.FieldByAtributoName(kAtDFe_EmailsNotificados).AsString := aEmailsNotificados;
          Dados.FieldByAtributoName(kAtDFe_ProtocoloCanc).AsString     := aProtocoloCancel;
          Dados.FieldByAtributoName(kAtDFe_MotivoCanc).AsString        := aMotivo;

          if aXMLEnvioCanc <> '' then
          begin
            Compress(aXMLEnvioCanc, vDest, True);

            tBlobXMLEnvioExtend := TBlobField(Dados.AtributoByName(kAtDFe_XMLEnvioCanc).FieldH);
            tBlobXMLEnvioExtend.LoadFromStream(vDest);
          end;

          if aXMLExtendCanc <> '' then
          begin
            if (FindFirst(aCaminhoArquivo + '\Can_' + aChave + '*.XML', faAnyFile, FRec) = 0) then
            begin
              sCaminhoXMLExtend := aCaminhoArquivo + '\' + FRec.Name;
              Compress(sCaminhoXMLExtend, vDest, False);
              tBlobXMLEnvioExtend := TBlobField(Dados.AtributoByName(kAtDFe_XMLExtendCanc).FieldH);
              tBlobXMLEnvioExtend.LoadFromStream(vDest);
            end;  
          end;

          Confirmar;
        end
      end;
  finally
    vDest.Free;
    Aplicacao.Repositorio.Destruir(fObjAux);
  end;
end;

procedure Th5DFe.Compress(const ASrc: string; var vDest: TStream; aEHStringStream: Boolean);
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

  Zip := TCompressionStream.Create(clMax, vDest);
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
    tString.Free;
    Zip.Free;
    FileIni.Free;
  end;
end;
                
procedure Th5DFe.Decompress(var vXML: TStream; ADest: string);
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

function Th5DFe.IsValidDispatch(const v: OleVariant): Boolean;
begin
  result := (VarType(v) = varDispatch) and Assigned(TVarData(v).VDispatch);
end;

procedure Th5DFe.ExportarPDFs(aListaDoctos, DiretorioDestino: string);
const
  kAutorizada = '3';
  kCancelada  = '5';
var
  fCloneAux:            ThbObjetoNegocio;
  sArquivo:             String;
  sFolder:              String;
  ms:                   TMemoryStream;
  sDirDestino:          String;
  F: TSearchRec;
begin
  fCloneAux := ThbObjetoNegocio(Aplicacao.Repositorio.Instanciar(Session, kDFe));
  try
    sArquivo    := ExpandFileName(ExtractFileDir(ParamStr(0)))+ '\ZIP\Notas_PDF.zip';
    sDirDestino := DiretorioDestino + 'Notas.zip';

    fCloneAux.Dados.Filtros.LimparTodos;
    fCloneAux.Dados.ListaIN.Text := aListaDoctos;
    fCloneAux.Dados.ListaIN.Insert(0, kAtDFe_ID);
    if fCloneAux.Dados.AtivarDataSet(kVsDFe_BRW) then
    begin
      sFolder := ExpandFileName(ExtractFileDir(ParamStr(0)) + '\..\DFe\PDF');
      
      while not fCloneAux.Dados.CDS.Eof do
      begin
        if FindFirst(sFolder + '\*' + fCloneAux.Dados.FBAN[kAtDFe_Chave].AsString +'*', faAnyFile, F) = 0 then
          copyfile(PAnsiChar(sFolder + '\' + F.name), PAnsiChar(ExpandFileName(ExtractFileDir(ParamStr(0)))+ '\PDFs_Selecionados\' + F.name), True);
        
        fCloneAux.Dados.CDS.Next;
      end;

      ShellZip(sArquivo, ExpandFileName(ExtractFileDir(ParamStr(0)))+ '\PDFs_Selecionados', '');
    end;

    if FileExists(sArquivo) then
    begin
      ms := TMemoryStream.Create;
      ms.LoadFromFile(sArquivo);
      ms.SaveToFile(sDirDestino);
      ms.Free;
    end;
  finally
    Aplicacao.Repositorio.Destruir(fCloneAux);
  end;
end;

function Th5DFe.NumProcessThreads: Integer;
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

procedure Th5DFe.RefazerAutorizacoesSelecionados(aListaDoctos: String);
const
  kAutorizada = '3';
  kCancelada  = '5';
var
  fCloneAux:    ThbObjetoNegocio;
  fParamNFe:    ThbObjetoNegocio;
  sCaminhoDFe:  String;
  sArquivoString: TStringList;
  FRec:         TSearchRec;
  tBlobXMLEnvioExtend: TBlobField;
  tBlobXMLCancExtend:  TBlobField;
  vDest:        TStream;
  iIDFilialAnt: Integer;
begin
  iIDFilialAnt := 0;
  fCloneAux    := ThbObjetoNegocio(Aplicacao.Repositorio.Instanciar(Session, kDFe));
  fParamNFe    := ThbObjetoNegocio(Aplicacao.Repositorio.Instanciar(Session, 'ParamNFE'));
  sArquivoString := TStringList.Create;
  try
    fCloneAux.Dados.Ordenacoes.Limpar;
    fCloneAux.Dados.Ordenacoes.Adicionar(kAtDocto_IDF_Filial);
    fCloneAux.Dados.Filtros.LimparTodos;
    fCloneAux.Dados.ListaIN.Text := aListaDoctos;
    fCloneAux.Dados.ListaIN.Insert(0, kAtDFe_ID);

    with fCloneAux.Dados.Filtros.Adicionar('Flt').Condicoes.IncluirExpressao(kOpOu).Expressao do
    begin
      with IncluirExpressao2(kOpIgual) do
      begin
        IncluirVariavel2(kAtDocto_SituacaoNFe);
        IncluirConstante2(kAutorizada);
      end;

      with IncluirExpressao2(kOpIgual) do
      begin
        IncluirVariavel2(kAtDocto_SituacaoNFe);
        IncluirConstante2(kCancelada);
      end;
    end;

    fCloneAux.Dados.AtivarDataSet(kVsDFe_BRW);
    while not fCloneAux.Dados.CDS.Eof do
    begin
      fCloneAux.EditarRegistro;

      if fCloneAux.Dados.FBAN[kAtDocto_IDF_Filial].AsInteger <> iIDFilialAnt then
      begin
        fParamNFe.Dados.Ordenacoes.Limpar;
        fParamNFe.Dados.Ordenacoes.Adicionar('ParamFil_DataInicial');
        fParamNFe.Dados.Ordenacoes.Adicionar('ParamFil_IDF_Filial');
        fParamNFe.Dados.Filtros.LimparTodos;
        fParamNFe.Dados.Filtros['Flt'].Condicoes.IncluirConstante('ParamFil_DataInicial', kOpMenorIgual, Date);
        fParamNFe.Dados.Filtros['Flt'].Condicoes.IncluirConstante('ParamFil_DataFinal',   kOpMaiorIgual, Date);
        fParamNFe.Dados.Filtros['Flt'].Condicoes.IncluirConstante('ParamFil_Situacao',    kOpDiferente,  '2'); //Diferente de inativo
        fParamNFe.Dados.Filtros['Flt'].Condicoes.IncluirConstante('ParamFil_IDF_Filial',  kOpIgual, fCloneAux.Dados.FBAN[kAtDocto_IDF_Filial].AsInteger);
        fParamNFe.Dados.AtivarDataSet('vsBRW');
        if not fParamNFe.Dados.CDS.IsEmpty then
          sCaminhoDFe := fParamNFe.Dados.FBAN['ParamNFe_CaminhoSaida'].AsString + '\Processado';
      end;

      if (FindFirst(sCaminhoDFe + '\Env_' + fCloneAux.Dados.FBAN[kAtDFe_Chave].AsString + '*.XML', faAnyFile, FRec) = 0) then
      begin
        vDest := TmemoryStream.Create;
        try
          sArquivoString.LoadFromFile(sCaminhoDFe + '\' + FRec.Name);
          Compress(sArquivoString.Text, vDest, True);
          tBlobXMLEnvioExtend := TBlobField(fCloneAux.Dados.AtributoByName(kAtDFe_XMLExtend).FieldH);
          tBlobXMLEnvioExtend.LoadFromStream(vDest);
          fCloneAux.ConfirmarRegistro;
        finally
          vDest.Free; //Precisa sempre criar um novo.
        end;
      end;

      if (FindFirst(sCaminhoDFe + '\Can_' + fCloneAux.Dados.FBAN[kAtDFe_Chave].AsString + '*.XML', faAnyFile, FRec) = 0) then
      begin
        vDest := TmemoryStream.Create;
        try
          if fCloneAux.Dados.CDS.State <> dsEdit then
            fCloneAux.EditarRegistro;

          sArquivoString.LoadFromFile(sCaminhoDFe + '\' + FRec.Name);
          Compress(sArquivoString.Text, vDest, True);
          tBlobXMLCancExtend := TBlobField(fCloneAux.Dados.AtributoByName(kAtDFe_XMLExtendCanc).FieldH);
          tBlobXMLCancExtend.LoadFromStream(vDest);
          fCloneAux.ConfirmarRegistro;
        finally
          vDest.Free; //Precisa sempre criar um novo.
        end;
      end;

      fCloneAux.Confirmar;
      iIDFilialAnt := fCloneAux.Dados.FBAN[kAtDocto_IDF_Filial].AsInteger;
      fCloneAux.Dados.CDS.Next;
    end;  
  finally
    FreeAndNil(sArquivoString);
    Aplicacao.Repositorio.Destruir(fCloneAux);
    Aplicacao.Repositorio.Destruir(fParamNFe);
  end;
end;

procedure Th5DFe.RefazerAutorizacoesTodos;
var
  fCloneAux:    ThbObjetoNegocio;
  fParamNFe:    ThbObjetoNegocio;
  sCaminhoDFe:  String;
  sArquivoString: TStringList;
  FRec:         TSearchRec;
  tBlobXMLEnvioExtend: TBlobField;
  vDest:        TStream;
  iIDFilialAnt: Integer;
begin
  iIDFilialAnt := 0;
  fCloneAux    := ThbObjetoNegocio(Aplicacao.Repositorio.Instanciar(Session, kDFe));
  fParamNFe    := ThbObjetoNegocio(Aplicacao.Repositorio.Instanciar(Session, 'ParamNFE'));
  sArquivoString := TStringList.Create;
  try
    fCloneAux.Dados.Ordenacoes.Limpar;
    fCloneAux.Dados.Ordenacoes.Adicionar(kAtDocto_IDF_Filial);
    fCloneAux.Dados.Filtros.LimparTodos;
    fCloneAux.Dados.Filtros['Flt'].Condicoes.IncluirConstante(kAtDFe_XMLExtend,     kOpTesteNulo, Null);
    fCloneAux.Dados.Filtros['Flt'].Condicoes.IncluirConstante(kAtDocto_SituacaoNFe, kOpIgual,     '3'); //Autorizada
    fCloneAux.Dados.AtivarDataSet(kVsDFe_BRW);
    while not fCloneAux.Dados.CDS.Eof do
    begin
      fCloneAux.EditarRegistro;

      if fCloneAux.Dados.FBAN[kAtDocto_IDF_Filial].AsInteger <> iIDFilialAnt then
      begin
        fParamNFe.Dados.Ordenacoes.Limpar;
        fParamNFe.Dados.Ordenacoes.Adicionar('ParamFil_DataInicial');
        fParamNFe.Dados.Ordenacoes.Adicionar('ParamFil_IDF_Filial');
        fParamNFe.Dados.Filtros.LimparTodos;
        fParamNFe.Dados.Filtros['Flt'].Condicoes.IncluirConstante('ParamFil_DataInicial', kOpMenorIgual, Date);
        fParamNFe.Dados.Filtros['Flt'].Condicoes.IncluirConstante('ParamFil_DataFinal',   kOpMaiorIgual, Date);
        fParamNFe.Dados.Filtros['Flt'].Condicoes.IncluirConstante('ParamFil_Situacao',    kOpDiferente,  '2'); //Diferente de inativo
        fParamNFe.Dados.Filtros['Flt'].Condicoes.IncluirConstante('ParamFil_IDF_Filial',  kOpIgual, fCloneAux.Dados.FBAN[kAtDocto_IDF_Filial].AsInteger);
        fParamNFe.Dados.AtivarDataSet('vsBRW');
        if not fParamNFe.Dados.CDS.IsEmpty then
          sCaminhoDFe := fParamNFe.Dados.FBAN['ParamNFe_CaminhoSaida'].AsString + '\Processado';
      end;

      if (FindFirst(sCaminhoDFe + '\Env_' + fCloneAux.Dados.FBAN[kAtDFe_Chave].AsString + '*.XML', faAnyFile, FRec) = 0) then
      begin
        vDest := TmemoryStream.Create;
        try
          sArquivoString.LoadFromFile(sCaminhoDFe + '\' + FRec.Name);
          Compress(sArquivoString.Text, vDest, True);
          tBlobXMLEnvioExtend := TBlobField(fCloneAux.Dados.AtributoByName(kAtDFe_XMLExtend).FieldH);
          tBlobXMLEnvioExtend.LoadFromStream(vDest);
          fCloneAux.ConfirmarRegistro;
          fCloneAux.Confirmar;
        finally
          vDest.Free; //Precisa sempre criar um novo.
        end;
      end;

      iIDFilialAnt := fCloneAux.Dados.FBAN[kAtDocto_IDF_Filial].AsInteger;
      fCloneAux.Dados.CDS.Next;
    end;  
  finally
    FreeAndNil(sArquivoString);
    Aplicacao.Repositorio.Destruir(fCloneAux);
    Aplicacao.Repositorio.Destruir(fParamNFe);
  end;
end;

initialization
  Aplicacao.RegistrarClasse(Th5DFe, kDFe);

end.

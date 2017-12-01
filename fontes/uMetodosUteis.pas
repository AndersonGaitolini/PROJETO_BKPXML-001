unit uMetodosUteis;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.IniFiles,
  Data.SqlExpr, FireDAC.Comp.Client,Vcl.ComCtrls,Generics.Collections,TypInfo,System.DateUtils,
  JvBaseDlg, JvSelectDirectory, FireDAC.Phys.FB,System.StrUtils,IdIcmpClient,System.MaskUtils, Winsock, WinSvc;


Const
  Threshold2000 : Integer = 2000;

  MinTime = 0;
  MaxTime = 86399;
  BadTime = $FFFFFFFF;

  SecondsInDay = 86400;
  SecondsInHour = 3600;
  SecondsInMinute = 60;
  HoursInDay = 24;
  MinutesInHour = 60;

 clProcessado = clBlack;
 clEnvAguard = clGreen;
 clCancAguard = clPurple;
 clCancProcessado = clRed;
 clDenegada = clSilver;
 clInutilizada = clFuchsia;
 clXmlDefeito = clBlue;
 clNaoIdent = clNavy;

  cnMaxServices = 4096;
  SERVICE_KERNEL_DRIVER       = $00000001;
  SERVICE_FILE_SYSTEM_DRIVER  = $00000002;
  SERVICE_ADAPTER             = $00000004;
  SERVICE_RECOGNIZER_DRIVER   = $00000008;

  SERVICE_DRIVER = (SERVICE_KERNEL_DRIVER or SERVICE_FILE_SYSTEM_DRIVER or SERVICE_RECOGNIZER_DRIVER);

  SERVICE_WIN32_OWN_PROCESS   = $00000010;
  SERVICE_WIN32_SHARE_PROCESS = $00000020;
  SERVICE_WIN32 = (SERVICE_WIN32_OWN_PROCESS or SERVICE_WIN32_SHARE_PROCESS);

  SERVICE_INTERACTIVE_PROCESS = $00000100;

  SERVICE_TYPE_ALL = (SERVICE_WIN32 or SERVICE_ADAPTER or SERVICE_DRIVER  or SERVICE_INTERACTIVE_PROCESS);

type
  TSvcA = array[0..cnMaxServices] of TEnumServiceStatus;
  PSvcA = ^TSvcA;

  type
    TOperacao = (opInserir, opAlterar, opExcluir, opOK, opNil);
    TTipoClass = (tiLabel, tiButton, tiBitBtn, tiEdit, tiPanel, tiComboBox, tiTodos);
    DayType = (Domingo, Segunda, Terca, Quarta, Quinta, Sexta, Sabado);
    TTipoDocumento = (tdCNPJ, tdCPF, tdPIS);

  Type
  TGenerico = 0..255;

   TConvert<T:Record> = class
     private
     public
       class procedure PopulateListEnum(AList: TStrings);
       class function StrConvertEnum(const AStr: string):T;
       class function EnumConvertStr(const eEnum:T):string;
     end;

  function fValidaCNPJ(var pCNPJ: string; pMascara: boolean=false): boolean;
  function fValidaCNPJ2(pCNPJDoc: string; pMascara: boolean=false): boolean;
  function fValidCPF(pCPF : string; pMascara: boolean=false): boolean;
  function fIsNumeric(pStr : String) : Boolean;
  procedure AddLog(pNameLog,pDirLog, aStr: string; pActiveAll: boolean = false);
  procedure setINI(pIniFilePath, prSessao, prSubSessao: string; prValor: string = '');
  function getINI(pIniFilePath, prSessao, prSubSessao: string; prValorDefault: string = ''): string;

  function fPingIP(pHost : String) :boolean;
//  function ConexaoBD(var prCon: TFDConnection; prDriver: TFDPhysFBDriverLink; pTryConexao: boolean = false):Boolean;
  function fArqIni: string;
  procedure pAtivaCamposForm(pForm: TForm; pEnable: boolean; pLista : array of TTipoClass);
  function fNomePC: string;
  function fLocalIP : string;
  function ExtractName(const Filename: String): String;
  function DateXMLToDate(pDateXML: String): TDate;
  function fOpenFileName(var prFileName:string;pTitle: string; pFilter: array of string; pFilterIndex : integer = 0): Boolean;
  function fOpenFile(pTitleName: string;var pFileName : String; pFilterName: array of string; pFilterIndex : integer = 0; pDefaultExt : string = '*.*' ): Boolean; overload;
  function fGetWindowsDrive: Char;

  function fOpenPath(var pInitialDir: string; pTitle : string = ''): Boolean;
  function fSaveFile(pInitialDir, pFileNAme, pTitle: String; pFilter: array of string): TSaveDialog;

  function fCloseFile(pSource: string): boolean;
  Procedure pZapFiles(pMasc:string);
  procedure pCopyFiles(pFileSource, pFileDest:String; pListErro:Boolean);
  procedure pSalveName(pFieldName, pExt: string; var wFileName: string);
  procedure pGetDirList(pDirectory: String; var pListaDir: TStringList; SubPastas: Boolean);


  function fMascaraCNPJ(pString: string): string;
  function fMascaraDoc(pSTR: string; pDoc : TTipoDocumento): string;
  function fTiraMascaraCNPJ(pString: string): string;
  function fSenhaAtual(pData: string):string;
  function fSEsp(Txt: string): string;
  function fSomaDigitos(pValor: LongInt):LongInt;
  function fBinToDec(pValorBin: string): LongInt;
  function fPotencia(pVal, pPot: LongInt): LongInt;
  function fDecToBin(ValorDec: LongInt): string;
  function fInverte(pValor: string; pTipo: Boolean; Pos: LongInt): string;
  function fConsideraPrimeiros(pValor, pNum: LongInt):string;
  function fColocaVerificador(pValor: string; pNum: LongInt):string;
//  function fDesCriptStr(pString : string) : string;
//  function fCripStr(pString : string) : string;

  function fServiceStop(sMachine,sService : string ) : boolean;
  function fServiceStart(sMachine, sService : string ) : boolean;
  function fServiceGetList(sMachine : string; dwServiceType, dwServiceState : DWord; var slServicesList : TStringList): Boolean;

  function ServiceRunning(sMachine, sService: PChar): Boolean;
  function ServiceGetStatus(sMachine, sService: PChar): DWORD;

  procedure pAppTerminate;
  function fSetAtribute(pPath: string; pAtribute: Cardinal): Boolean;

  var
   wOpe : TOperacao = opNil;
implementation

uses
  uDMnfebkp;

//  { Criptografa uma String }
//  function fCripStr(pString : string) : string;
//  var
//    i   : Integer;
//    ist : string;
//  begin
//     result := '';
//     if pString = '' then
//       Exit;
//
//     pString    := WideUpperCase(pString);
//     ist   :='';
//     for i :=1 to Length(pString) do
//       ist[i] :=  Chr(ord(pString[i])-30-i);
//
//     ist := pString;
//     result   := ist;
//  end;
//
//  { DesCriptografa uma String }
//  function fDesCriptStr(pString : string) : string;
//  var
//    i   : Integer;
//    ist : array of widechar;
//  begin
//     result := '';
//     if pString = '' then
//       Exit;
//     SetLength(ist, Length(pString));
//     pString  := UpperCase(pString);
//     for i:=1 to Length(pString) do
//       ist[i]:= Chr(ord(pString[i])+30+i);
//
//     ist[0] := pString[1];
//     result   := WideCharToString(ist);
//  end;


function fValidCPF(pCPF : string; pMascara: boolean=false): boolean;
var
  v: array[0..1] of Word;
  wCPF: array[0..10] of Byte;
  I: Byte;
  wRetorno: boolean;

  function fFormatCPF: string;
  begin
    Result := pCPF;
    Insert('.',Result,04);
    Insert('.',Result,08);
    Insert('-',Result,12);
  end;

begin
  if Length(pCPF) = 14 then
    if (Copy(pCPF,4,1) + Copy(pCPF,8,1) + Copy(pCPF,12,1) = '..-') then
    begin
      pCPF:=Copy(pCPF,1,3) + Copy(pCPF,4,3) + Copy(pCPF,8,3) + Copy(pCPF,12,4) + Copy(pCPF,17,2);
      wRetorno:=True;
    end;

  if Length(pCPF) = 11 then
    wRetorno:=True;

  if wRetorno then
  begin
    try
      for I := 1 to 11 do
        wCPF[i-1] := StrToInt(pCPF[i]);
      //Nota: Calcula o primeiro dígito de verificação.
      v[0] := 10*wCPF[0] + 9*wCPF[1] + 8*wCPF[2];
      v[0] := v[0] + 7*wCPF[3] + 6*wCPF[4] + 5*wCPF[5];
      v[0] := v[0] + 4*wCPF[6] + 3*wCPF[7] + 2*wCPF[8];
      v[0] := 11 - v[0] mod 11;
      if (v[0] >= 10) then
        v[0] := 0;
//      v[0] := IfThen(v[0] >= 10, 0, v[0]);
      //Nota: Calcula o segundo dígito de verificação.
      v[1] := 11*wCPF[0] + 10*wCPF[1] + 9*wCPF[2];
      v[1] := v[1] + 8*wCPF[3] +  7*wCPF[4] + 6*wCPF[5];
      v[1] := v[1] + 5*wCPF[6] +  4*wCPF[7] + 3*wCPF[8];
      v[1] := v[1] + 2*v[0];
      v[1] := 11 - v[1] mod 11;
      if (v[1] >= 10) then
        v[1] := 0;
//      v[1] := IfThen(v[1] >= 10, 0, v[1]);
      //Nota: Verdadeiro se os dígitos de verificação são os esperados.
      Result :=  ((v[0] = wCPF[9]) and (v[1] = wCPF[10]));

      if (Result) and (pMascara) then
        pCPF := fFormatCPF

    except on E: Exception do
      Result := False;
    end;
  end;
end;

function fValidaCNPJ(var pCNPJ: string; pMascara: boolean=false): boolean;
var
  wFormatCNPJ,
  wCNPJ: string;
  wDig1, wDig2: integer;
  x, total: integer;
  wRetorno: boolean;

  function fFormatCNPJ: string;
  begin
    Result := wCNPJ;
    Insert('.',Result,03);
    Insert('.',Result,07);
    Insert('/',Result,11);
    Insert('-',Result,16);
  end;

begin
  wRetorno:=False;
  wCNPJ:='';
//Analisa os formatos
  if Length(pCNPJ) = 18 then
    if (Copy(pCNPJ,3,1) + Copy(pCNPJ,7,1) + Copy(pCNPJ,11,1) + Copy(pCNPJ,16,1) = '../-') then
    begin
      wCNPJ:=Copy(pCNPJ,1,2) + Copy(pCNPJ,4,3) + Copy(pCNPJ,8,3) + Copy(pCNPJ,12,4) + Copy(pCNPJ,17,2);
      wRetorno:=True;
    end;

  if Length(pCNPJ) = 14 then
  begin
    wCNPJ:=pCNPJ;
    wRetorno:=True;
  end;
//Verifica
  if wRetorno then
  begin
    try
      //1° digito
      total:=0;
      for x:=1 to 12 do
          begin
          if x < 5 then
              Inc(total, StrToInt(Copy(wCNPJ, x, 1)) * (6 - x))
          else
              Inc(total, StrToInt(Copy(wCNPJ, x, 1)) * (14 - x));
          end;
      wDig1:=11 - (total mod 11);
      if wDig1 > 9 then
          wDig1:=0;
      //2° digito
      total:=0;
      for x:=1 to 13 do
          begin
          if x < 6 then
              Inc(total, StrToInt(Copy(wCNPJ, x, 1)) * (7 - x))
          else
              Inc(total, StrToInt(Copy(wCNPJ, x, 1)) * (15 - x));
          end;
      wDig2:=11 - (total mod 11);
      if wDig2 > 9 then
          wDig2:=0;
      //Validação final
      if (wDig1 = StrToInt(Copy(wCNPJ, 13, 1))) and (wDig2 = StrToInt(Copy(wCNPJ, 14, 1))) then
          wRetorno:=True
      else
          wRetorno:=False;
    except
      wRetorno:=False;
    end;
    //Inválidos
    case AnsiIndexStr(wCNPJ,['00000000000000','11111111111111','22222222222222','33333333333333','44444444444444',
                              '55555555555555','66666666666666','77777777777777','88888888888888','99999999999999']) of

    0..9: wRetorno:=False;

    end;
  end;

  Result := wRetorno;
  if (Result) and (pMascara) then
    pCNPJ := fFormatCNPJ
  else
  if Result then
    pCNPJ := wCNPJ
end;


function fValidaCNPJ2(pCNPJDoc: string; pMascara: boolean=false): boolean;
var wCNPJ: string;
begin
  wCNPJ := pCNPJDoc;
  Result:= fValidaCNPJ(wCNPJ, pMascara);
end;

function fIsNumeric(pStr: String) : Boolean;
begin
  Result := True;
  try
     StrToInt(pStr);
  Except
    Result := False;
  end;
end;

function fMascaraCNPJ(pString: string): string;
begin
 try
   if Length(pString) = 14 then
      Result := Copy(pString,1,2)+'.'+Copy(pString,3,3)+'.'+Copy(pString,6,3)+'/'+Copy(pString,9,4)+'-'+Copy(pString,13,2);

    if not fValidaCNPJ(result) then
      Result := pString;
 except
   Result := '00.000.000/0000-00';
 end;
end;

function fMascaraDoc(pSTR: string; pDoc : TTipoDocumento): string;
begin
  Result := pSTR;
  case pDoc of

    tdCNPJ: begin
              if Length(pSTR) = 14 then
                Result := FormatMaskText('00.000.000\0000-00', pSTR)
              else
               Exit;
            end;

    tdCPF: begin
              if Length(pSTR) = 11 then
                Result := FormatMaskText('000.000.000-00', pSTR)
              else
                Exit;
            end;

    tdPIS: begin
              if Length(pSTR) = 11 then
                Result := FormatMaskText('000.0000.000-0', pSTR)
              else
                Exit;
            end;
  end;
end;

function fTiraMascaraCNPJ(pString: string): string;
begin
  try
    Result := Copy(pString,1,2) + Copy(pString,4,3) + Copy(pString,8,3) + Copy(pString,12,4) + Copy(pString,17,2);
    if not fValidaCNPJ(result) then
       Result := pString;
  except
    Result := '00.000.000/0000-00';
  end;

end;



function fSenhaAtual(pData: string):string;
var
  pNum,
  Bin1,
  Bin2,
  DataStr,
  DataPos: string;
  Data1,
  Data2,
  Data3,
  Data4,
  Data5,
  Data6  : Char;
  x      : Integer;
  Temp,
  Dec1,
  Dec2,
  QuatU,
  DoisP  : LongInt;

begin
  if (fSEsp(pData) = '') or (fSEsp(pData) = '//') then
    DataStr := FormatDateTime('dd/mm/yyyy', now)
  else
  if StrToDate(pData) < now then
  begin
    fSenhaAtual := '0000000';
    Exit;
  end
  else
  DataStr := FormatDateTime('dd/mm/yyyy',StrToDate(pData));

  Data1   := DataStr[1];
  Data2   := DataStr[2];
  Data3   := DataStr[4];
  Data4   := DataStr[5];
  Data5   := DataStr[9];
  Data6   := DataStr[10];

  Val(Data2, Temp, X);

  case Temp of
    1: DataPos := Data3 + Data4 + Data6 + Data5 + Data2 + Data1;
    2: DataPos := Data1 + Data2 + Data6 + Data5 + Data3 + Data4;
    3: DataPos := Data4 + Data3 + Data5 + Data6 + Data1 + Data2;
    4: DataPos := Data3 + Data5 + Data2 + Data1 + Data6 + Data4;
    5: DataPos := Data1 + Data3 + Data5 + Data2 + Data4 + Data6;
    6: DataPos := Data6 + Data4 + Data3 + Data2 + Data5 + Data1;
    7: DataPos := Data2 + Data3 + Data6 + Data5 + Data4 + Data1;
    8: DataPos := Data5 + Data6 + Data2 + Data3 + Data1 + Data4;
    9: DataPos := Data2 + Data6 + Data4 + Data3 + Data1 + Data5;
    0: DataPos := Data5 + Data1 + Data3 + Data4 + Data6 + Data2;
  end;

  Val(Copy(DataPos,3,4), QuatU, X);
  Val(Copy(DataPos,1,2), DoisP, X);
  Val(DataPos, Temp, X);

  QuatU := QuatU + fSomaDigitos(Temp);
  DoisP := DoisP + fSomaDigitos(Temp);

  Dec1 := QuatU * DoisP;

  Bin1 := fDecToBin(Dec1);

  Bin2 := fInverte(Bin1, true, 0);
  Bin2 := fInverte(Bin2, False, 3);

  Dec2 := fBinToDec(Bin1) + fBinToDec(Bin2);

  Dec1 := fSomaDigitos(Dec2);

  Val(Data1 + Data2,Temp,x);
  Dec1 := Dec1 + Temp;

  pNum := fConsideraPrimeiros(Dec2,4) + fConsideraPrimeiros(Dec1,2);

  pNum := fColocaVerificador(pNum, 5);

  fSenhaAtual := pNum;
end;

function fSEsp(Txt: string): string;
var
  i: Integer;
  Aux: string;
begin
  Aux := '';
  for i := 1 to Length(Txt) do
    if Txt[i] <> ' ' then
      Aux := Aux + Txt[i];
  fSEsp := Aux;
end;

function fColocaVerificador(pValor: string; pNum: LongInt):string;
var
  i,
  a,
  x      : Integer;
  Num1,
  Num2,
  Num3,
  Num4,
  Num5,
  Num6,
  Soma,
  Resto  : LongInt;
  Temp,
  VlFinal: string;
begin
  Val(pValor[1],Num1,x);
  Val(pValor[2],Num2,x);
  Val(pValor[3],Num3,x);
  Val(pValor[4],Num4,x);
  Val(pValor[5],Num5,x);
  Val(pValor[6],Num6,x);

  Num1 := Num1 * 9;
  Num2 := Num2 * 8;
  Num3 := Num3 * 7;
  Num4 := Num4 * 6;
  Num5 := Num5 * 5;
  Num6 := Num6 * 4;
  Soma := Num1 + Num2 + Num3 + Num4 + Num5 + Num6;
  Resto:= Soma mod 11;
  Resto:= fSomaDigitos(Resto);

  VlFinal := '';
  a := 0;
  for i := 1 to 7 do
    if i <> pNum then
    begin
      a := a + 1;
      VlFinal := VlFinal + pValor[a];
    end
    else
    begin
      Str(Resto,Temp);
      VlFinal := VlFinal + Temp;
    end;

  fColocaVerificador := VlFinal;
end;


function fConsideraPrimeiros(pValor, pNum: LongInt):string;
var
  i: Integer;
  Numero,
  NumStr: string;
begin
   numero:='';
   Str(pValor,NumStr);

   if Length(NumStr) > pNum then
   begin
     for i := 1 to pNum do
       Numero := Numero + NumStr[i];
   end
   else
   if Length(NumStr) < pNum then
   begin
      Numero := NumStr;
      for i := Length(NumStr) to (pNum - 1) do
        Numero := Numero + '0';
   end
   else
     Str(pValor,Numero);

   fConsideraPrimeiros := Numero;
end;

function fSomaDigitos(pValor: LongInt):LongInt;
var
  ValorS: string;
  i,
  x     : Integer;
  Temp,
  ValorT: LongInt;
begin
  ValorT := 0;
  Str(pValor,ValorS);
  for i := 1 to Length(ValorS) do
  begin
    Val(ValorS[i],Temp,x);
    ValorT := ValorT + Temp;
  end;

  fSomaDigitos := valorT;
end;

function fInverte(pValor: string; pTipo: Boolean; Pos: LongInt): string;
var
  i,
  x      : Integer;
  Temp   : LongInt;
  ValorT : string;

begin
  ValorT := '';

  if pTipo then
    for i := Length(pValor) downto 1 do
      ValorT := ValorT + pValor[i]
  else
    for i := 1 to Length(pValor) do
      if (i + Pos) > Length(pValor) then
      begin
        Val(pValor[i],Temp,x);
        case Temp of
          0: ValorT := ValorT + '1';
          1: ValorT := ValorT + '0';
        end;
      end
      else
        ValorT := ValorT + pValor[i];

    fInverte := ValorT;
end;

function fPotencia(pVal, pPot: LongInt): LongInt;
var
  Nr,
  pValor: LongInt;
begin
  pValor := pVal;
  Nr := pPot;
  if Nr = 0 then
    fPotencia := 1
  else
  begin
    while Nr > 1 do
    begin
        pValor := pValor * pVal;
        Nr := Nr - 1;
    end;
  fPotencia := pValor;
  end;
end;

function fBinToDec(pValorBin: string): LongInt;
var
  ValorStr: string;
  i,
  x       : Integer;
  Temp,
  ValorDec: LongInt;
begin
  ValorStr := pValorBin;
  ValorDec := 0;
  for i := length(ValorStr) downto 1 do
  begin
    Val(ValorStr[i],Temp,x);
    ValorDec := ValorDec + Temp * (fPotencia(2,length(ValorStr)-i));
  end;

  fBinToDec := ValorDec;
end;

function fDecToBin(ValorDec: LongInt): string;
var
  ValorQc: LongInt;
  Resto,
  Temp   : string;
begin
  Resto  := '';
  ValorQc:= ValorDec;

  while ValorQc > 0 do
  begin
    Str(ValorQc mod 2,Temp);
    Resto   := resto + Temp;
    ValorQc := ValorQc div 2;
  end;

  fDecToBin := fInverte(Resto, True, 0);
end;

procedure pCopyFiles(pFileSource, pFileDest:String; pListErro:Boolean);
var wWCSource,wWCDest : array [0..255]  of WideChar;
begin
  StringToWideChar(pFileSource, wWCSource,length(pFileSource)+1);
  StringToWideChar(pFileDest, wWCDest,length(pFileDest)+1);
  CopyFile(wWCSource,wWCDest,pListErro);
end;

procedure pSalveName(pFieldName, pExt: string; var wFileName: string);
var wStr : String;
begin
  wStr := AnsiUpperCase(pFieldName);
  if (wStr = 'XMLENVIO')  or ( wStr = 'XMLEXTEND') then
   wFileName := 'Env_NFe'+ wFileName + '.'+pExt;

  if (wStr = 'XMLENVIOCANC') or (wStr = 'XMLEXTENDCANC' ) then
   wFileName := 'Can_'+ wFileName + '.'+pExt;

  if (wStr = 'ZIPENVIOCANC') or (wStr = 'ZIPEXTENDCANC' ) then
    wFileName := 'Can_'+ wFileName + '_XMLCancelado.'+pExt;

  if (wStr = 'ZIPENVIO')  or ( wStr = 'ZIPEXTEND') then
   wFileName := 'Env_NFe'+ wFileName + '_XMLAutorizado.'+pExt;
end;

procedure pGetDirList(pDirectory: String; var pListaDir: TStringList; SubPastas: Boolean);
var
wSearch : TSearchRec;

   procedure Recursive(Dir : String); { Sub Procedure, Recursiva }
   var wSearchAux : TSearchRec;
   begin
     if wSearchAux.Name = EmptyStr then
        FindFirst(pDirectory + '\' + Dir + '\*.*', faDirectory, wSearchAux);
     while FindNext(wSearchAux) = 0 do
        if wSearchAux.Name <> '..' then
           if DirectoryExists(pDirectory + '\' + Dir + '\' + wSearchAux.Name) then
           begin
              pListaDir.Add(pDirectory + '\' + Dir + '\' + wSearchAux.Name);
              Recursive(Dir + '\' + wSearchAux.Name);
           end;
   end;

begin
   FindFirst(pDirectory + '\*.*', faDirectory, wSearch);
   while FindNext(wSearch) = 0 do
   if wSearch.Name <> '..' then
   if DirectoryExists(pDirectory + '\' + wSearch.Name) then
   begin
      pListaDir.Add(pDirectory+'\'+wSearch.Name);

      if SubPastas then
         Recursive(wSearch.Name);
   end;

end;

Procedure pZapFiles(pMasc:String);
{Apaga arquivos usando mascaras tipo: c:\Temp\*.zip, c:\Temp\*.*
 Obs: Requer o Path dos arquivos a serem deletados}
var Dir : TsearchRec;
    Erro: Integer;
begin
   Erro := FindFirst(pMasc,faArchive,Dir);
   While Erro = 0 do
   begin
//      if not (deleteFile(ExtractFilePath(pMasc)+Dir.Name)) then
//        AddLog( 'LOGMAXXML',ExtractFileDir(Dir.Name),' - '+ ExtractFileName(Dir.Name));
      deleteFile(ExtractFilePath(pMasc)+Dir.Name);
      Erro := FindNext(Dir);
   end;
   FindClose(Dir);
end;

procedure AddLog(pNameLog,pDirLog, aStr: string; pActiveAll: boolean = false);
var
 wIndex: Integer;
 ArqLog: string;
 F :TStringList;
  begin
    if not pActiveAll then
      exit;

    F := TStringList.Create;
    try
      try
        ArqLog := pDirLog+'\'+pNameLog+FormatDateTime('-dd-mm-aaaa',now)+'.log';

        if FileExists(ArqLog) then
          f.LoadFromFile(ArqLog);

         f.Add(Format('[ %s ]: %s', [DateTimeToStr(Now), aStr]));

        f.SaveToFile(ArqLog);
      except on E: Exception do

      end;
    finally
      FreeAndNil(f);
    end;
  end;

function fOpenFileName(var prFileName:string;pTitle: string; pFilter: array of string; pFilterIndex : integer = 0): Boolean;
var
  dlgOpenDir : TOpenDialog;
  auxFilter, auxFilterName : string;
  i : Integer;
 begin

  dlgOpenDir := TOpenDialog.Create(Application);
  try
     dlgOpenDir.Filter :='';
     for I := Low(pFilter) to High(pFilter) do
     begin
       dlgOpenDir.Filter := pFilter[i] + '|' + pFilter[i]+'|';
     end;

     dlgOpenDir.FilterIndex := 0;
     dlgOpenDir.Title := pTitle;
     if prFileName <> '' then
       dlgOpenDir.FileName := prFileName;

     Result := dlgOpenDir.Execute;

     if Result then
       prFileName := dlgOpenDir.FileName
     else
       prFileName := '';
  finally
    dlgOpenDir.Free;
  end;
end;

function fOpenFile(pTitleName: string;var pFileName : String; pFilterName: array of string; pFilterIndex : integer = 0; pDefaultExt : string = '*.*' ): Boolean;
var
  dlgOpenDir : TOpenDialog;
  auxFilter, auxFilterName : string;
  i : Integer;
begin

  dlgOpenDir := TOpenDialog.Create(Application);
  try
     auxFilter := '';
     i := Length(pFilterName);

     if i > 0 then
     begin
       for auxFilter in pFilterName do
       begin
         dlgOpenDir.Filter :=  auxFilter+ ' |'
       end;
     end
     else
     begin
       dlgOpenDir.Filter := 'Todos | *.* |';
       dlgOpenDir.FilterIndex := 0;
     end;

     dlgOpenDir.InitialDir := GetCurrentDir;
     dlgOpenDir.FilterIndex := pFilterIndex;
     dlgOpenDir.Title := pTitleName;
     dlgOpenDir.DefaultExt := pDefaultExt;

     if pFileName <> '' then
       dlgOpenDir.FileName := pFileName;

     Result := dlgOpenDir.Execute;

     if Result then
       pFileName := dlgOpenDir.FileName
     else
       pFileName := '';
  finally
    dlgOpenDir.Free;
  end;
end;

function fGetWindowsDrive: Char;
var S: string;
begin
  SetLength(S, MAX_PATH);
  if GetWindowsDirectory(PChar(S), MAX_PATH) > 0 then
    Result := string(S)[1]
  else
    Result := #0;
end;

function fCloseFile(pSource: string): boolean;
var wHandle : THandle;
    wFileSize: Cardinal;
begin
  Result := false;
  try
    wHandle := FindWindow(0,pWideChar(pSource));
    wFileSize := GetFileSize(wHandle,nil);
    Result := UnlockFile(wHandle,0,0,wFileSize,0);
    FileClose(wHandle);
  except //on E: Exception do
  end;
end;

function fSaveFile(pInitialDir, pFileName, pTitle: String; pFilter: array of string): TSaveDialog;
var  wSaveXML : TSaveDialog;
     I : Integer;
     wMsg: string;

  procedure pMSG(pMsg : Integer);
  begin
    case pMsg of
      0: wMsg := 'Diretório do '+ ExtractFileName(pFileName) +': '+ ExtractFileDir(pFileNAme)+' não existe!';
      1: wMsg := 'Diretório: '+pInitialDir+' não existe!';
    end;

    ShowMessage(wMsg);
    exit;
  end;

begin
  wSaveXML := TSaveDialog.Create(Application);
  try
    for I := Low(pFilter) to High(pFilter) do
    begin
      if i = 0 then
        wSaveXML.Filter := pFilter[i]//'ZIP|*.zip';
      else
        wSaveXML.Filter := ' | '+ pFilter[i]
    end;

    wSaveXML.Name :='wSaveDLG';
    wSaveXML.Title :=  pTitle; //'Salve o arquivo ZIP ';
    wSaveXML.FilterIndex := 1;

    wSaveXML.Ctl3D := true;
    wSaveXML.Options := [ofHideReadOnly,ofEnableSizing];

    if  DirectoryExists(pInitialDir) then
      wSaveXML.InitialDir := pInitialDir
    else
     pMsg(1);

      pFileName := ExtractFileDir(pFileName);
      wSaveXML.FileName := pFileName;
//    else
//      pMSG(0);

    Result := wSaveXML;

  finally
    wSaveXML.Free;
  end;
end;

function fOpenPath(var pInitialDir: string; pTitle : string = ''): Boolean;
var jopdOpenDir : TJvSelectDirectory;
begin
  Result := false;
  jopdOpenDir := TJvSelectDirectory.Create(Application);
  jopdOpenDir.title := pTitle;

  if pInitialDir <> '' then
     if DirectoryExists(pInitialDir) then
        jopdOpenDir.InitialDir := pInitialDir;

  try
     Result := jopdOpenDir.Execute;
     if Result then
       pInitialDir := jopdOpenDir.Directory
     else
       pInitialDir := '';
  finally
    jopdOpenDir.Free;
  end;
end;

function DateXMLToDate(pDateXML: String): TDate;
begin
  Result := 0;
  if pDateXML = '' then
     exit;
            //'aaaa-mm-dd
  Result := StrToDate(Copy(pDateXML,9,2)+'/'+ Copy(pDateXML,6,2)+'/'+Copy(pDateXML,1,4));
end;

function ExtractName(const Filename: String): String;
{Retorna o nome do Arquivo sem extensão}
var
aExt : String;
aPos : Integer;
begin
  aExt := ExtractFileExt(Filename);
  Result := ExtractFileName(Filename);
   if aExt <> '' then
   begin
   aPos := Pos(aExt,Result);
   if aPos > 0 then
      begin
      Delete(Result,aPos,Length(aExt));
      end;
   end;

end;

function fLocalIP : string;
  type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
  var
  phe  : PHostEnt;
  pptr : PaPInAddr;
  Buffer : array [0..63] of ansichar;
  I : Integer;
  GInitData : TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName( Buffer, SizeOf(Buffer));
  phe :=GetHostByName(buffer);
  if phe = nil then
    Exit;

  pptr := PaPInAddr(Phe^.h_addr_list);
  I := 0;
  while pptr^[I] <> nil do
  begin
    result:=StrPas(inet_ntoa(pptr^[I]^));
    Inc(I);
  end;
  WSACleanup;
end;

function fNomePC: string;
var
buffer: array[0..255] of char;
size: dword;
begin
 size:=256;
 Result :='';

 if GetComputerName(buffer, size) then
   Result := string(buffer);

end;

procedure pAtivaCamposForm(pForm: TForm; pEnable: boolean; pLista : array of TTipoClass);
var i : integer;
begin
  if not Assigned(pForm) then
    exit;

  for i:= 0 to pForm.ComponentCount-1 do
  begin
    if pForm.Components[i] is TEdit then
      TEdit (pForm.Components[i]).Enabled := pEnable;

    if pForm.Components[i] is TBitBtn then
      TBitBtn(pForm.Components[i]).Enabled := pEnable;

    if pForm.Components[i] is TButton then
      TBitBtn(pForm.Components[i]).Enabled := pEnable;

    if pForm.Components[i] is TTabSheet then
      TTabSheet(pForm.Components[i]).Enabled := pEnable;
  end;
end;

function fPingIP(pHost : String) :boolean;
var
  IdICMPClient: TIdICMPClient;
begin
  Result := False;
  IdICMPClient := TIdICMPClient.Create(nil);
  try
    try

      IdICMPClient.Host := pHost;
      IdICMPClient.ReceiveTimeout := 500;
      IdICMPClient.Ping;
      Result := (IdICMPClient.ReplyStatus.BytesReceived > 0);
    except on E: Exception do

    end;
  finally
    IdICMPClient.Free;
  end
end;

//function ConexaoBD(var prCon: TFDConnection; prDriver: TFDPhysFBDriverLink; pTryConexao: boolean = false):Boolean;
//var
//wMSg : string;
//wDataBase: string;
//wHost: string;
//wLog :Boolean;
////wHandle : THandle;
//
////  procedure pIniArquivo(pSource: string);
////  begin
////    try
////      setINI(fArqIni, 'BD', 'ARQUIVO',wDataBase);
////    except
////      wHandle := FindWindow( 0,pWideChar(pSource));
////      FileClose(wHandle);
////      setINI(fArqIni, 'BD', 'ARQUIVO',wDataBase);
////    end;
////  end;
////
////  procedure pIniFbClient(pSource: string);
////  begin
////    try
////    setINI(fArqIni, 'BD', 'FBCLIENT',wFBClient);
////    except
////      wHandle := FindWindow( 0,pWideChar(pSource));
////      FileClose(wHandle);
////      setINI(fArqIni, 'BD', 'FBCLIENT',wFBClient);
////    end;
////  end;
//
// begin
//  wLog := false;
//  try
//    try
//      Result := False;
//      prCon.Connected := Result;
//      prCon.Close;
//
//      AddLog('LOGMAXXML',GetCurrentDir,'ConexaoBD - ParamStr(0) = ['+ ParamStr(0) + ']',wLog);
//      if (FileExists(ExtractFileName(ChangeFileExt(Application.ExeName, 'INI')))) then
//      begin
//        with prCon.Params do
//        begin
//          Values['ConfigName'] := getINI(fArqIni, 'MAXXML',   'ConfigName', '');
//          Values['Usuario'] := getINI(fArqIni, 'MAXXML',      'Usuario', '');
//          Values['Password'] := getINI(fArqIni, 'MAXXML',     'Password', '');
//          Values['Database'] := getINI(fArqIni, 'MAXXML',     'Database', '');
//          Values['SQLDialect'] := getINI(fArqIni, 'MAXXML',   'SQLDialect', '');
//          Values['VendorLib'] := getINI(fArqIni, 'MAXXML',    'VendorLib', '');
//          Values['VendorHome'] := getINI(fArqIni, 'MAXXML',   'VendorHome', '');
//          Values['DriverId'] := getINI(fArqIni, 'MAXXML',     'DriverId', '');
//          Values['Port'] := getINI(fArqIni, 'MAXXML',         'Port', '');
//
//          if (getINI(fArqIni, 'MAXXML', 'Conexao', '') = 'Remote') then
//          begin
//            wHost := getINI(fArqIni, 'MAXXML', 'Server', '');
//
//            if not fPingIP(wHost) then
//            begin
//               pAppTerminate;
//               ShowMessage('Sem Conexão de Rede');
//            end
//            else
//            begin
//              Values['Server'] := wHost;
//              Values['Protocol'] := getINI(fArqIni, 'MAXXML',     'Protocol', '');
//              Values['CharacterSet'] := getINI(fArqIni, 'MAXXML', 'CharacterSet', '');
//            end;
//          end;
//        end;
//      end
//      else
//      if (ParamCount = 0)then
//      begin
//        foConfiguracao := TfoConfiguracao.Create(Application);
//        try
//          foConfiguracao.ShowModal;
//        finally
//          FreeAndNil(foConfiguracao);
//        end;
//      end;
//
//      prCon.Open;
//      DM_NFEDFE.Conectado := prCon.Connected;
//      Result := prCon.Connected;
//
//    except
//      on E: Exception do
//         begin
//           AddLog('LOGMAXXML',GetCurrentDir,'except Conexão -  [VendorHome: ' +  prDriver.VendorHome +'] VendorLib: [' +  prDriver.VendorLib +'] wDataBase: ['+ wDataBase + ']: Erro:'+
//           #10#13+ E.Message,wLog);
//         end;
//    end;
//  finally
//
//    if not Result  then
//    begin
//      pAppTerminate;
//    end;
//  end;
//end;

function fSetAtribute(pPath: string; pAtribute: Cardinal):Boolean;
var
  Attributes: Word;
begin

    Attributes := FileGetAttr(pPath);
    result := FileSetAttr(pPath, pAtribute) > 0;

//   (Attributes and faReadOnly) = faReadOnly;
//   (Attributes and faArchive)  = faArchive;
//   (Attributes and faSysFile)  = faSysFile;
//   (Attributes and faHidden)   = faHidden;
//   NewAttributes := Attributes;
//      { start with original attributes }
//        NewAttributes := NewAttributes or faReadOnly;
//        NewAttributes := NewAttributes and not faReadOnly;
//        NewAttributes := NewAttributes or faArchive;
//        NewAttributes := NewAttributes and not faArchive;
//        NewAttributes := NewAttributes or faSysFile;
//        NewAttributes := NewAttributes and not faSysFile;
//        NewAttributes := NewAttributes or faHidden;
//        NewAttributes := NewAttributes and not faHidden;


         { ...write the new values }
end;

procedure setINI(pIniFilePath, prSessao, prSubSessao: string; prValor: string ='');
var
  wINI : TIniFile;
begin
  wINI := TIniFile.Create(pIniFilePath);
  try
    if FileExists(pIniFilePath) then
      fCloseFile(pIniFilePath);

    wINI.WriteString(prSessao, prSubSessao, prValor);
  finally
    wINI.Free;
  end;
end;

function getINI(pIniFilePath, prSessao, prSubSessao: string; prValorDefault: string = ''): string;
var
  wINI : TIniFile;
begin
  wINI := TIniFile.Create(pIniFilePath);
  try
    Result := wINI.ReadString(prSessao, prSubSessao, prValorDefault);
  finally
    wINI.Free;
  end;
end;

function fArqIni: string;
begin
  Result := ExtractFileDir(Application.ExeName) +'\'+ ExtractFileName(ChangeFileExt(Application.ExeName, '.INI'));;

//  if not FileExists(Result) then
//    setINI(Result,'',ExtractName(Result),'');
end;

{ TConvert }

class procedure TConvert<T>.PopulateListEnum(AList: TStrings);
  var
   i:integer;
   StrTexto:String;
   Enum:Integer;
 begin
   i:=0;
   try
     repeat
       StrTexto:=trim(GetEnumName(TypeInfo(T), i));
       Enum:=GetEnumValue(TypeInfo(T),StrTexto);
       AList.Add(StrTexto);
       inc(i);
     until Enum < 0 ;
       AList.Delete(pred(AList.Count));
   except;
     raise EConvertError.Create(
                'O Parâmetro passado não corresponde a um Tipo ENUM');
   end;
 end;

class function TConvert<T>.StrConvertEnum(const AStr: string):T;
 var
   P:^T;
   pNum:Integer;
 begin
   try
     pNum:=GetEnumValue(TypeInfo(T),Astr);
      if pNum = -1 then
        abort;
      P:=@pNum;
      result:=P^;
   except
     raise EConvertError.Create('O Parâmetro "'+Astr+'" passado não '+sLineBreak+
     ' corresponde a um Tipo Enumerado');
   end;
 end;

class function TConvert<T>.EnumConvertStr(const eEnum:T): String;
 var
   P:PInteger;
   pNum:integer;
 begin
   try
     P:=@eEnum;
     pNum:=integer(TGenerico((P^)));
     Result := GetEnumName(TypeInfo(T),pNum);
   except
    raise EConvertError.Create('O Parâmetro passado não corresponde a '+sLineBreak+
             'um inteiro Ou a um Tipo Enumerado');
   end;
 end;

 procedure pAppTerminate;
 begin
   Application.Terminate;
 end;

function fServiceGetList(sMachine : string; dwServiceType, dwServiceState : DWord; var slServicesList : TStringList): Boolean;
var
  j : integer;
  schm : SC_Handle;
  nBytesNeeded, nServices, nResumeHandle : DWord;
  ssa : PSvcA;
  wSL : TStringList;

  SCManHandle, Svchandle : SC_HANDLE;
  {Nome do computador onde esta localizado o serviço}
  sComputerNameEx : string;
  chrComputerName : array[0..255] of char;
  cSize           : Cardinal;
begin
  wSL := TStringList.Create;
  try
    Result := false;

    if (sMachine = '') then
    begin
      {Caso não tenha sido declarado captura o nome do computador local}
      FillChar(chrComputerName, SizeOf(chrComputerName), #0);
      GetComputerName(chrComputerName, cSize);
      sComputerNameEx:=chrComputerName;
    end
    else
      sComputerNameEx := sMachine;

    schm := OpenSCManager(PChar(sComputerNameEx), nil, SC_MANAGER_ENUMERATE_SERVICE); //SC_MANAGER_ALL_ACCESS);

    if(schm > 0)then
    begin
      nResumeHandle := 0;
      New(ssa);

      EnumServicesStatus(
        schm,
        dwServiceType,
        dwServiceState,
        ssa^[0],
        SizeOf(ssa^),
        nBytesNeeded,
        nServices,
        nResumeHandle );

      for j := 0 to nServices-1 do
        wSL.Add(StrPas(ssa^[j].lpDisplayName));

      Result := true;
      Dispose(ssa);
      slServicesList := wSL;
      CloseServiceHandle(schm);
    end;
  finally
//    FreeAndNil(wSL);
  end;
end;

function ServiceGetStatus(sMachine, sService: PChar): DWORD;
var
  SCManHandle, SvcHandle: SC_Handle;
  SS: TServiceStatus;
  dwStat: DWORD;
begin
  dwStat := 0;
  // Open service manager handle.
  SCManHandle := OpenSCManager(sMachine, nil, SC_MANAGER_CONNECT);
  if (SCManHandle > 0) then
  begin
    SvcHandle := OpenService(SCManHandle, sService, SERVICE_QUERY_STATUS);
    // if Service installed
    if (SvcHandle > 0) then
    begin
      // SS structure holds the service status (TServiceStatus);
      if (QueryServiceStatus(SvcHandle, SS) ) then
        dwStat := ss.dwCurrentState;
      CloseServiceHandle(SvcHandle);
    end;
    CloseServiceHandle(SCManHandle);
  end;
  Result := dwStat;
end;

function ServiceRunning(sMachine, sService: PChar): Boolean;
begin
  Result := SERVICE_RUNNING = ServiceGetStatus(sMachine, sService);
end;


function fServiceStart(sMachine, sService : string ) : boolean;
var
  schm,
  schs   : SC_Handle;
  ss     : TServiceStatus;
  psTemp : PChar;
  dwChkP : DWord;
begin
  ss.dwCurrentState := 0; //-1;
  schm := OpenSCManager(PChar(sMachine),Nil, SC_MANAGER_CONNECT);
  if(schm > 0)then
  begin
    schs := OpenService(schm, PChar(sService), SERVICE_START or SERVICE_QUERY_STATUS);
    if(schs > 0)then
    begin
      psTemp := Nil;
      if(StartService(schs, 0, psTemp))then
      begin
        if(QueryServiceStatus(schs, ss))then
        begin
          while(SERVICE_RUNNING <> ss.dwCurrentState)do
          begin
            dwChkP := ss.dwCheckPoint;
            Sleep(ss.dwWaitHint);
            if(not QueryServiceStatus(schs, ss))then
            begin
              break;
            end;
            if(ss.dwCheckPoint <  dwChkP)then
            begin
              break;
            end;
          end;
        end;
      end;
      CloseServiceHandle(schs);
   end;
    CloseServiceHandle(schm);
  end;
  Result := SERVICE_RUNNING = ss.dwCurrentState;
end;

function fServiceStop(sMachine,sService : string ) : boolean;
var
schm, schs   : SC_Handle;
ss : TServiceStatus;
dwChkP : DWord;
begin
  schm := OpenSCManager(PChar(sMachine),Nil, SC_MANAGER_CONNECT);
  if(schm > 0)then
  begin
    schs := OpenService(schm,PChar(sService), SERVICE_STOP or SERVICE_QUERY_STATUS);
    if(schs > 0)then
    begin
      if(ControlService(schs, SERVICE_CONTROL_STOP, ss))then
      begin
        if(QueryServiceStatus(schs,ss))then
        begin
          while(SERVICE_STOPPED <> ss.dwCurrentState)do
          begin
              dwChkP := ss.dwCheckPoint;
              Sleep(ss.dwWaitHint);
              if(not QueryServiceStatus(schs, ss))then
              begin
                break;
              end;

              if(ss.dwCheckPoint < dwChkP)then
              begin
                break;
              end;
          end;
        end;
      end;
      CloseServiceHandle(schs);
    end;
    CloseServiceHandle(schm);
  end;
  Result := SERVICE_STOPPED = ss.dwCurrentState;
end;
end.


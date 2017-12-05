unit uDMnfebkp;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXFirebird,
  Data.FMTBcd, Datasnap.Provider, Datasnap.DBClient, Data.DBXInterBase,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  Base, DaoFD, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet,FMX.Forms, FireDAC.Moni.Custom,
  FireDAC.Moni.FlatFile;

type
  TTipoConexao = (tcLocal, tcLocalEmbed, tcRemote);

  TConecxaoBD = class(TObject)
  private
    { private declarations }
    FConectado    : boolean;
    FPassword     : String;
    FUserName     : String;
    FDataBase     : String;
    FSQLDialect   : String;
    FDriverID     : String;
    FCharacterSet : String;
    FVendorLib    : String;
    FVendorHome   : String;
    FEmbedded     : boolean;
    FServer       : String;
    FProtocol     : String;
    FPort         : String;
    FIniFile      : String;
    FTipoCon      : TTipoConexao;
//    FConn         : TFDConnection;
//    FDriver       : TFDPhysFBDriverLink;
  protected
    { protected declarations }

  public
    { public declarations }
    property Conectado    : boolean      read  FConectado    write FConectado   ;
    property IniFile      : String       read  FIniFile      write FIniFile     ;
    property Password     : String       read  FPassword     write FPassword    ;
    property UserName     : String       read  FUserName     write FUserName    ;
    property DataBase     : String       read  FDataBase     write FDataBase    ;
    property SQLDialect   : String       read  FSQLDialect   write FSQLDialect  ;
    property DriverID     : String       read  FDriverID     write FDriverID    ;
    property CharacterSet : String       read  FCharacterSet write FCharacterSet;
    property VendorLib    : String       read  FVendorLib    write FVendorLib   ;
    property VendorHome   : String       read  FVendorHome   write FVendorHome  ;
    property Embedded     : boolean      read  FEmbedded     write FEmbedded    ;
    property Server       : String       read  FServer       write FServer      ;
    property Protocol     : String       read  FProtocol     write FProtocol    ;
    property Port         : String       read  FPort         write FPort        ;
    property TipoCon      : TTipoConexao read  FTipoCon      write FTipoCon;
//    property Conn         : TFDConnection read FConn write FConn;
//    property Driver       : TFDPhysFBDriverLink read FDriver write FDriver;

    function fConexaoBD: Boolean;
    procedure pIniPath;
    procedure pConecta;
    procedure pClearParams;
    procedure pReadParams;
    procedure pWriteParams;

    constructor Create; overload;
  end;

type
  TDM_NFEDFE = class(TDataModule)
    conConexaoFD: TFDConnection;
    fdtrTransacao: TFDTransaction;
    fdWaitCursor: TFDGUIxWaitCursor;
    fddrfbDriver: TFDPhysFBDriverLink;
    dsConfiguracoes: TDataSource;
    dsBkpdfe: TDataSource;
    cdsBkpdfe: TClientDataSet;
    provBkpdfe: TDataSetProvider;
    sqlBkpDfe: TFDQuery;
    dsUsuarios: TDataSource;
    cdsUsuarios: TClientDataSet;
    provUsuarios: TDataSetProvider;
    sqlUsuarios: TFDQuery;
    cdsConfiguracoes: TClientDataSet;
    provConfiguracoes: TDataSetProvider;
    cdsUsuariosID: TIntegerField;
    cdsUsuariosUSUARIO: TStringField;
    cdsUsuariosSENHA: TStringField;
    cdsBkpdfeID: TIntegerField;
    cdsBkpdfeCHAVE: TStringField;
    cdsBkpdfeDATAEMISSAO: TDateField;
    cdsBkpdfeDATARECTO: TDateField;
    cdsBkpdfeIDF_DOCUMENTO: TIntegerField;
    cdsBkpdfeMOTIVO: TStringField;
    cdsBkpdfePROTOCOLOCANC: TStringField;
    cdsBkpdfePROTOCOLORECTO: TStringField;
    cdsBkpdfeDATAALTERACAO: TDateField;
    cdsBkpdfeTIPO: TStringField;
    cdsBkpdfeEMAILSNOTIFICADOS: TStringField;
    cdsBkpdfeTIPOAMBIENTE: TStringField;
    cdsBkpdfeXMLENVIO: TBlobField;
    cdsBkpdfeXMLEXTEND: TBlobField;
    cdsBkpdfeMOTIVOCANC: TStringField;
    cdsBkpdfeXMLENVIOCANC: TBlobField;
    cdsBkpdfeXMLEXTENDCANC: TBlobField;
    cdsBkpdfePROTOCOLOAUT: TStringField;
    cdsBkpdfeCAMPOSTREAM: TMemoField;
    cdsBkpdfeCHECKBOX: TSmallintField;
    intgrfldConfiguracoesID: TIntegerField;
    intgrfldConfiguracoesIDUSUARIO: TIntegerField;
    strngfldConfiguracoesDESCRICONFIG: TStringField;
    strngfldConfiguracoesNAMEBD: TStringField;
    strngfldConfiguracoesPATHBD: TStringField;
    strngfldConfiguracoesSENHABD: TStringField;
    strngfldConfiguracoesUSUARIOBD: TStringField;
    strngfldConfiguracoesNFEPATHENVIO: TStringField;
    strngfldConfiguracoesNFEPATHPROCESSADO: TStringField;
    strngfldConfiguracoesNFEPATHREJEITADO: TStringField;
    strngfldConfiguracoesNFEPATHRETORNOLIDO: TStringField;
    strngfldConfiguracoesNFEPATHPDFSALVO: TStringField;
    strngfldConfiguracoesNFCEPATHENVIO: TStringField;
    strngfldConfiguracoesNFCEPATHPROCESSADO: TStringField;
    strngfldConfiguracoesNFCEPATHREJEITADO: TStringField;
    strngfldConfiguracoesNFCEPATHRETORNOLIDO: TStringField;
    strngfldConfiguracoesNFCEPATHPDFSALVO: TStringField;
    strngfldConfiguracoesNFSEPATHENVIO: TStringField;
    strngfldConfiguracoesNFSEPATHPROCESSADO: TStringField;
    strngfldConfiguracoesNFSEPATHREJEITADO: TStringField;
    strngfldConfiguracoesNFSEPATHRETORNOLIDO: TStringField;
    strngfldConfiguracoesNFSEPATHPDFSALVO: TStringField;
    cdsBkpdfeSTATUS: TSmallintField;
    cdsUsuariosCONFIGSALVA: TIntegerField;
    sqlConfiguracoes: TFDQuery;
    cdsBkpdfeCNPJ: TStringField;
    cdsBkpdfeXMLERRO: TMemoField;
    cdsBkpdfeCNPJDEST: TStringField;
    fdmoMonitor: TFDMoniFlatFileClientLink;

    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Dao   : TDaoFD;

  end;

var
  DM_NFEDFE: TDM_NFEDFE;
  ConecxaoBD : TConecxaoBD;

implementation

uses
  Usuarios, Lm_bkpdfe, uMetodosUteis, dialogs, uRotinas, Configuracoes, ConfigPadrao, uFoConexao;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM_NFEDFE.DataModuleCreate(Sender: TObject);
begin
  ConecxaoBD := TConecxaoBD.Create;
  Dao := TDaoFD.Create(conConexaoFD, fdtrTransacao);
  sqlBkpDfe.Connection := conConexaoFD;
  tabConfigpadrao := TConfigpadrao.create;
  daoConfigPadrao := TDaoConfigPadrao.Create;

  tabConfiguracoes := TConfiguracoes.Create;
  daoConfiguracoes := TDaoConfiguracoes.Create;

  tabUsuarios  := TUsuarios.Create;
  daoUsuarios := TDaoCadUsuario.create;

  ObjetoXML := TLm_bkpdfe.Create;
  DaoObjetoXML := TDaoBkpdfe.Create;

  CNPJDOC := TCNPJDOC.Create;
//  DaoObjetoXML.pAtualizaTabela;

end;

{ TConecxaoBD }

//constructor TConecxaoBD.Create(pConn: TFDConnection;
//  pDriver: TFDPhysFBDriverLink);
//begin
////  inherited;
//  FConn := pConn;
//  FDriver := pDriver;
//  pIniPath;
//end;


constructor TConecxaoBD.Create;
begin
  pIniPath;
end;

function TConecxaoBD.fConexaoBD: Boolean;
var
wMSg : string;
wDataBase: string;
wHost: string;
wLog :Boolean;

procedure pConLocal;
begin
  DM_NFEDFE.fddrfbDriver.VendorLib                     := FVendorLib;
  DM_NFEDFE.fddrfbDriver.VendorHome                    := FVendorHome;
  DM_NFEDFE.fddrfbDriver.Embedded                      := FEmbedded;
  DM_NFEDFE.fddrfbDriver.DriverID                      := FDriverID;
  DM_NFEDFE.conConexaoFD.Params.DriverID               := DM_NFEDFE.fddrfbDriver.DriverID;

  DM_NFEDFE.conConexaoFD.Params.Values['User_Name']    := FUserName;
  DM_NFEDFE.conConexaoFD.Params.Values['Password']     := FPassword;
  DM_NFEDFE.conConexaoFD.Params.Values['Database']     := FDataBase;
  DM_NFEDFE.conConexaoFD.Params.Values['SQLDialect']   := FSQLDialect;
//  DM_NFEDFE.conConexaoFD.Params.Values['DriverID']     := FDriverID;
  DM_NFEDFE.conConexaoFD.Params.Values['CharacterSet'] := FCharacterSet;
  DM_NFEDFE.conConexaoFD.Params.Values['Protocol']     := FProtocol;
  DM_NFEDFE.conConexaoFD.Params.Values['Protocol']     := 'ipLocal';
  DM_NFEDFE.conConexaoFD.Params.Values['Server']       := '';
  DM_NFEDFE.conConexaoFD.Params.Values['Port']                   := FPort;
end;

procedure pConLocalEmbedded;
begin
  DM_NFEDFE.fddrfbDriver.VendorLib                     := FVendorLib;
  DM_NFEDFE.fddrfbDriver.VendorHome                    := FVendorHome;
  DM_NFEDFE.fddrfbDriver.Embedded                      := FEmbedded;
  DM_NFEDFE.fddrfbDriver.DriverID                      := FDriverID;
  DM_NFEDFE.conConexaoFD.Params.DriverID               := DM_NFEDFE.fddrfbDriver.DriverID;

  DM_NFEDFE.conConexaoFD.Params.Values['User_Name']    := FUserName;
  DM_NFEDFE.conConexaoFD.Params.Values['Password']     := FPassword;
  DM_NFEDFE.conConexaoFD.Params.Values['Database']     := FDataBase;
  DM_NFEDFE.conConexaoFD.Params.Values['SQLDialect']   := FSQLDialect;
//  DM_NFEDFE.conConexaoFD.Params.Values['DriverID']     := FDriverID;
  DM_NFEDFE.conConexaoFD.Params.Values['CharacterSet'] := FCharacterSet;
  DM_NFEDFE.conConexaoFD.Params.Values['Protocol']     := FProtocol;
  DM_NFEDFE.conConexaoFD.Params.Values['Protocol']     := 'ipLocal';
  DM_NFEDFE.conConexaoFD.Params.Values['Server']       := '';
  DM_NFEDFE.conConexaoFD.Params.Values['Port']                   := FPort;

//    DM_NFEDFE.conConexaoFD.Params.UserName               := FUserName;
//    DM_NFEDFE.conConexaoFD.Params.Password               := FPassword;
//    DM_NFEDFE.conConexaoFD.Params.Database               := FDataBase;
//    DM_NFEDFE.conConexaoFD.ActualDriverID;
//    DM_NFEDFE.conConexaoFD.Params.Pooled                 := False;
//    DM_NFEDFE.conConexaoFD.Params.PoolCleanupTimeout     := 30000;
//    DM_NFEDFE.conConexaoFD.Params.PoolExpireTimeout      := 90000;
//    DM_NFEDFE.conConexaoFD.Params.PoolMaximumItems       := 50;
//
//    DM_NFEDFE.conConexaoFD.Params.Values['Protocol']     := 'ipLocal';
//    DM_NFEDFE.conConexaoFD.Params.Values['Port']         := '3050';
//    DM_NFEDFE.conConexaoFD.Params.Values['SQLDialect']   := FSQLDialect;
//    DM_NFEDFE.conConexaoFD.Params.Values['CharacterSet'] := 'WIN1252';
//    DM_NFEDFE.conConexaoFD.Params.Values['server']       := '';
end;

procedure pConRemote;
begin
  with DM_NFEDFE do
  begin
    conConexaoFD.Params.Values['User_Name']    := FUserName;
    conConexaoFD.Params.Values['Password']     := FPassword;
    conConexaoFD.Params.Values['Database']     := FDataBase;
    conConexaoFD.Params.Values['SQLDialect']   := FSQLDialect;
    conConexaoFD.Params.Values['DriverID']     := FDriverID;
    conConexaoFD.Params.Values['CharacterSet'] := FCharacterSet;
    conConexaoFD.Params.Values['Protocol']     := FProtocol;
    conConexaoFD.Params.Values['Server']       := FServer;
    fPingIP(FServer);
    conConexaoFD.Params.Values['Port']     := FPort;
    fddrfbDriver.VendorLib                   := FVendorLib;
  end;
end;

var I:Integer;
begin
  Result := False;
  FConectado := False;
  DM_NFEDFE.conConexaoFD.Connected := false;
  DM_NFEDFE.conConexaoFD.Close;
  try
//    pClearParams;
    case TipoCon of
      tcLocal: pConLocal;
      tcLocalEmbed: pConLocalEmbedded;
      tcRemote: pConRemote;
    else
      Exit;
    end;

   DM_NFEDFE.conConexaoFD.Open;

//   for I := 0 to ParamCount do
//     uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'[ParamCount ['+ inttoStr(ParamCount) +'] '+inttostr(I)+'-> CALL_PARAMETROS: '+ ParamStr(i),true);

    Result := DM_NFEDFE.conConexaoFD.Connected;
    FConectado := Result;
  except
    on E: Exception do
       begin
         if not FConectado then
         if not Assigned(foConexao) and (ParamCount > 0) and (StrToIntDef(Trim(ParamStr(1)),0) = 0) then
         begin
           foConexao := TfoConexao.Create(Application);
           try
            foConexao.ShowModal;
           finally
             if not FConectado then
               Application.Terminate;
           end;
         end;
       end;
  end;
end;

procedure TConecxaoBD.pIniPath;
begin
  FIniFile := fArqIni;
end;

procedure TConecxaoBD.pClearParams;
begin
  DM_NFEDFE.conConexaoFD.Params.Clear;
  DM_NFEDFE.fddrfbDriver.Embedded := False;
  DM_NFEDFE.fddrfbDriver.VendorHome := '';
  DM_NFEDFE.fddrfbDriver.VendorLib := '';
end;

procedure TConecxaoBD.pConecta;
begin
  Conectado := fConexaoBD;
end;


procedure TConecxaoBD.pReadParams;
var wSessao : string;
begin
  wSessao := fNomePC;
  FTipoCon      := TConvert<TTipoConexao>.StrConvertEnum(getINI(FIniFile, wSessao, 'TipoCon','tcLocal'));
  FUserName     := getINI(FIniFile, wSessao, 'User_Name');
  FPassword     := getINI(FIniFile, wSessao, 'Password');
  FDataBase     := getINI(FIniFile, wSessao, 'Database');
  FSQLDialect   := getINI(FIniFile, wSessao, 'SQLDialect');
  FDriverID     := getINI(FIniFile, wSessao, 'DriverID');
  FCharacterSet := getINI(FIniFile, wSessao, 'CharacterSet');
  FServer       := getINI(FIniFile, wSessao, 'Server');
  FProtocol     := getINI(FIniFile, wSessao, 'Protocol');
  FPort         := getINI(FIniFile, wSessao, 'Port');
  FVendorLib    := getINI(FIniFile, wSessao, 'VendorLib');
  FVendorHome   := getINI(FIniFile, wSessao, 'VendorHome');
  FEmbedded     := StrToBoolDef(getINI(FIniFile, wSessao, 'Embedded'),false);
end;

procedure TConecxaoBD.pWriteParams;
var wSessao : string;
begin
 wSessao := fNomePC;
 setINI(FIniFile, wSessao, 'TipoCon'       ,TConvert<TTipoConexao>.EnumConvertStr(FTipoCon));
 setINI(FIniFile, wSessao, 'User_Name'     ,FUserName     );
 setINI(FIniFile, wSessao, 'Password'      ,FPassword     );
 setINI(FIniFile, wSessao, 'Database'      ,FDataBase     );
 setINI(FIniFile, wSessao, 'SQLDialect'    ,FSQLDialect   );
 setINI(FIniFile, wSessao, 'DriverID'      ,FDriverID     );
 setINI(FIniFile, wSessao, 'CharacterSet'  ,FCharacterSet );
 setINI(FIniFile, wSessao, 'Server'        ,FServer       );
 setINI(FIniFile, wSessao, 'Protocol'      ,FProtocol     );
 setINI(FIniFile, wSessao, 'Port'          ,FPort         );
 setINI(FIniFile, wSessao, 'VendorLib'     ,FVendorLib    );
 setINI(FIniFile, wSessao, 'VendorHome'    ,FVendorHome   );
 setINI(FIniFile, wSessao, 'Embedded'      ,BoolToStr(FEmbedded));
end;

end.



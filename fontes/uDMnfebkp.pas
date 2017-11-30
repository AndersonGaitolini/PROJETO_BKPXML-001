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
  FireDAC.DApt, FireDAC.Comp.DataSet,FMX.Forms;

type
  TTipoConexao = (tcLocal, tcLocalEmbed, tcRemote);

  TConecxaoBD = class(TObject)
  private
    { private declarations }
    FConectado : boolean;
    FPassword   : String;
    FUserName   : String;
    FDataBase   : String;
    FSQLDialect : String;
    FDriverID   : String;
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
  Usuarios, Lm_bkpdfe, uMetodosUteis, dialogs, uRotinas, Configuracoes, ConfigPadrao;

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

//  if not Assigned(sqlBkpDfe.FindField('CNPJDEST')) then
//  begin
//    dao.StartTransaction;
//    try
////      Dao.ConsultaSqlExecute('ALTER TABLE LM_BKPDFE ADD CNPJDEST VARCHAR(14) CHARACTER SET WIN1252 COLLATE WIN1252');
//     Dao.ConsultaSqlExecute('ALTER TABLE LM_BKPDFE ADD CNPJDEST CNPJVARCHAR');
//      Dao.Commit;
//    except on E: Exception do
//       Dao.RollBack;
//    end;
//  end;

//  if not Assigned(sqlBkpDfe.FindField('XMLERRO')) then
//  begin
//    dao.StartTransaction;
//    try
//      Dao.ConsultaSqlExecute('CREATE DOMAIN XMLBLOB AS BLOB SUB_TYPE 0 SEGMENT SIZE 80');
//      Dao.Commit;
//    except on E: Exception do
//       Dao.RollBack;
//    end;
//  end;

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

end;

function TConecxaoBD.fConexaoBD: Boolean;
var
wMSg : string;
wDataBase: string;
wHost: string;
wLog :Boolean;


procedure pConLocal;
begin
  with DM_NFEDFE do
  begin
    conConexaoFD.Params.Values['User_Name']    := FUserName;
    conConexaoFD.Params.Values['Password']     := FPassword;
    conConexaoFD.Params.Values['Database']     := FDataBase;
    conConexaoFD.Params.Values['SQLDialect']   := FSQLDialect;
    conConexaoFD.Params.Values['DriverID']     := FDriverID;
    conConexaoFD.Params.Values['CharacterSet'] := FCharacterSet;
    fddrfbDriver.VendorLib                     := FVendorLib;
    fddrfbDriver.VendorHome                    := FVendorHome;
    fddrfbDriver.Embedded                      := FEmbedded;
  end;
end;

procedure pConLocalEmbedded;
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
    fddrfbDriver.VendorLib                   := FVendorLib;
    fddrfbDriver.VendorHome                  := FVendorHome;
    fddrfbDriver.Embedded                    := FEmbedded;
  end;
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
    conConexaoFD.Params.Values['Protocol']     := FProtocol;
    fddrfbDriver.VendorLib                   := FVendorLib;
  end;
end;

var I:Integer;
begin
  Result := False;
  FConectado := False;
  try
    pClearParams;
    case TipoCon of
      tcLocal: pConLocal;
      tcLocalEmbed: pConLocalEmbedded;
      tcRemote: pConRemote;
    else
      Exit;
    end;

//    for I := 0 to ConecxaoBD.Driver.ServicesCount-1 do
//      ShowMessage(InttoStr(I)+' - '+ConecxaoBD.Driver.Services[I].Name);

    if fCloseFile(FDataBase) then
     DM_NFEDFE.conConexaoFD.Open
    else
      Result := False;

    Result := DM_NFEDFE.conConexaoFD.Connected;
    FConectado := Result;
  except
    on E: Exception do
       begin
//         FConectado := False;
         ShowMessage(e.Message);
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
  DM_NFEDFE.conConexaoFD.Connected := false;
  DM_NFEDFE.conConexaoFD.Close;
  Conectado := fConexaoBD;
end;


procedure TConecxaoBD.pReadParams;
var wSessao : string;
begin
  wSessao := fNomePC;
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



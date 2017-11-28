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
    FConn         : TFDConnection;
    FDriver       : TFDPhysFBDriverLink;
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
    property Conn         : TFDConnection read FConn write FConn;
    property Driver       : TFDPhysFBDriverLink read FDriver write FDriver;

    function fConexaoBD: Boolean;
    procedure pConecta;
    procedure pClearParams;
    procedure pReadParams;
    procedure pReadDriver;

    constructor Create(pConn : TFDConnection; pDriver : TFDPhysFBDriverLink); overload;
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
  ConecxaoBD := TConecxaoBD.Create(conConexaoFD, fddrfbDriver);
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

constructor TConecxaoBD.Create(pConn: TFDConnection;
  pDriver: TFDPhysFBDriverLink);
begin
//  inherited;
  FConn := pConn;
  FDriver := pDriver;
end;

function TConecxaoBD.fConexaoBD: Boolean;
var
wMSg : string;
wDataBase: string;
wHost: string;
wLog :Boolean;


procedure pConLocal;
begin
  FConn.Params.Values['User_Name']    := FUserName;
  FConn.Params.Values['Password']     := FPassword;
  FConn.Params.Values['Database']     := FDataBase;
  FConn.Params.Values['SQLDialect']   := FSQLDialect;
  FConn.Params.Values['DriverID']     := FDriverID;
  FConn.Params.Values['CharacterSet'] := FCharacterSet;
end;

procedure pConLocalEmbedded;
begin
  FConn.Params.Values['User_Name']    := FUserName;
  FConn.Params.Values['Password']     := FPassword;
  FConn.Params.Values['Database']     := FDataBase;
  FConn.Params.Values['SQLDialect']   := FSQLDialect;
  FConn.Params.Values['DriverID']     := FDriverID;
  FConn.Params.Values['CharacterSet'] := FCharacterSet;
  FDriver.VendorLib                   := FVendorLib;
  FDriver.VendorHome                  := FVendorHome;
  FDriver.Embedded                    := FEmbedded;
end;

procedure pConRemote;
begin
  FConn.Params.Values['User_Name']    := FUserName;
  FConn.Params.Values['Password']     := FPassword;
  FConn.Params.Values['Database']     := FDataBase;
  FConn.Params.Values['SQLDialect']   := FSQLDialect;
  FConn.Params.Values['DriverID']     := FDriverID;
  FConn.Params.Values['CharacterSet'] := FCharacterSet;
  FConn.Params.Values['Server']       := FServer;
  FConn.Params.Values['Protocol']     := FProtocol;
  FConn.Params.Values['Port']         := FPort;
end;

 begin
  try
    pClearParams;
    case TipoCon of
      tcLocal: pConLocal;
      tcLocalEmbed: pConLocalEmbedded;
      tcRemote: pConRemote;
    else
      Exit;
    end;

    FConn.Open;
    Result := FConn.Connected;
  except
    on E: Exception do
       begin
         ShowMessage(e.Message);
       end;
  end;
end;

procedure TConecxaoBD.pClearParams;
begin
  FConn.Params.Clear;
end;

procedure TConecxaoBD.pConecta;
begin
  FConn.Connected := false;
  FConn.Close;
  Conectado := fConexaoBD;
end;


procedure TConecxaoBD.pReadDriver;
begin
  FVendorLib := FDriver.VendorLib;
  FVendorHome := FDriver.VendorHome;
  FEmbedded   := FDriver.Embedded;
end;

procedure TConecxaoBD.pReadParams;
begin
  FUserName     :=  Conn.Params.Values['User_Name'];
  FPassword     :=  Conn.Params.Values['Password'];
  FDataBase     :=  Conn.Params.Values['Database'];
  FSQLDialect   :=  Conn.Params.Values['SQLDialect'];
  FDriverID     :=  Conn.Params.Values['DriverID'];
  FCharacterSet :=  Conn.Params.Values['CharacterSet'];
  FServer       :=  Conn.Params.Values['Server'];
  FProtocol     :=  Conn.Params.Values['Protocol'];
  FPort         :=  Conn.Params.Values['Port'];
end;

end.

//:= getINI(fArqIni, 'MAXXML',     'Password', '');
//:= getINI(fArqIni, 'MAXXML',     'Database', '');
//:= getINI(fArqIni, 'MAXXML',     'User_Name', '');
//:= '3';
//:= getINI(fArqIni, 'MAXXML',     'DriverId', '');
//:= getINI(fArqIni, 'MAXXML', 'CharacterSet', '');
//:= getINI(fArqIni, 'MAXXML',    'VendorLib', '');
//:= getINI(fArqIni, 'MAXXML',   'VendorHome', '');
//:= getINI(fArqIni, 'MAXXML',   'Embedded', '');
//:= getINI(fArqIni,   'MAXXML', 'Server','');
//:= getINI(fArqIni, 'MAXXML', 'Protocol', '');
//:= getINI(fArqIni,     'MAXXML', 'Port', '');

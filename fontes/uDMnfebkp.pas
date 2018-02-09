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
  FireDAC.Moni.FlatFile,System.IniFiles;

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
    FSessaoAtual  : String;
    FListaSessao  : TStringList;
    FTipoCon      : TTipoConexao;
    FConn         : TFDConnection;
//    FDriver       : TFDPhysFBDriverLink;
  procedure pListaSessaoINI;

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
    property SessaoAtual  : String read FSessaoAtual write FSessaoAtual;
    property ListaSessao  : TStringList read FListaSessao write FListaSessao;
    property Conn         : TFDConnection read FConn write FConn;
//    property Driver       : TFDPhysFBDriverLink read FDriver write FDriver;


    function fConexaoBD: Boolean;
    procedure pIniPath;
    procedure pConecta;
    procedure pClearParams;
    procedure pReadParams(pSessao: String);
    procedure pWriteParams(pSessao: String);

    constructor Create(pConn : TFDConnection);
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
    cdsBkpdfeXMLINUTILIZACAO: TBlobField;
    cdsBkpdfeXMLCARTACORRECAO: TBlobField;
    dsTPEvento: TDataSource;
    cdsTPEvento: TClientDataSet;
    provTPEvento: TDataSetProvider;
    sqlTPEvento: TFDQuery;
    cdsTPEventoID: TIntegerField;
    cdsTPEventoCODEVENTO: TIntegerField;
    cdsTPEventoDESCRICAO: TStringField;
    cdsBkpdfeTPEVENTO: TIntegerField;

    procedure DataModuleCreate(Sender: TObject);
    procedure dsTPEventoDataChange(Sender: TObject; Field: TField);
  private
  public
    Dao: TDaoFD;
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
  Dao := TDaoFD.Create(conConexaoFD, fdtrTransacao);
  ConecxaoBD := TConecxaoBD.Create(conConexaoFD);
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
end;

procedure TDM_NFEDFE.dsTPEventoDataChange(Sender: TObject; Field: TField);
begin

end;

{ TConecxaoBD }

constructor TConecxaoBD.Create(pConn: TFDConnection);
begin
  FConn := pConn;
  pIniPath;
end;

function TConecxaoBD.fConexaoBD: Boolean;

procedure pConLocal;
begin
  DM_NFEDFE.fddrfbDriver.VendorLib                     := FVendorLib;
  DM_NFEDFE.fddrfbDriver.VendorHome                    := FVendorHome;
  DM_NFEDFE.fddrfbDriver.Embedded                      := FEmbedded;
  DM_NFEDFE.fddrfbDriver.DriverID                      := FDriverID;
  Conn.Params.DriverID               := DM_NFEDFE.fddrfbDriver.DriverID;

  Conn.Params.Values['User_Name']    := FUserName;
  Conn.Params.Values['Password']     := FPassword;
  Conn.Params.Values['Database']     := FDataBase;
  Conn.Params.Values['SQLDialect']   := FSQLDialect;
  Conn.Params.Values['CharacterSet'] := FCharacterSet;
  Conn.Params.Values['Protocol']     := FProtocol;
  Conn.Params.Values['Protocol']     := 'ipLocal';
  Conn.Params.Values['Server']       := '';
  Conn.Params.Values['Port']         := FPort;
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
  DM_NFEDFE.conConexaoFD.Params.Values['CharacterSet'] := FCharacterSet;
  DM_NFEDFE.conConexaoFD.Params.Values['Protocol']     := FProtocol;
  DM_NFEDFE.conConexaoFD.Params.Values['Protocol']     := 'ipLocal';
  DM_NFEDFE.conConexaoFD.Params.Values['Server']       := '';
  DM_NFEDFE.conConexaoFD.Params.Values['Port']         := FPort;
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

begin
  Result := False;
  FConectado := False;

  Conn.Connected := false;
  Conn.Close;
  try
    case TipoCon of
      tcLocal: pConLocal;
      tcLocalEmbed: pConLocalEmbedded;
      tcRemote: pConRemote;
    else
      Exit;
    end;

    Conn.Open;
    Result := Conn.Connected;
    if Result and (ParamStr(1)= '') then
      DaoObjetoXML.pAtualizaBD;

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

procedure TConecxaoBD.pListaSessaoINI;
begin
  try
    FListaSessao := fListaSessaoINIFile;
  finally
    fListaSessaoINIFile.Free;
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

procedure TConecxaoBD.pReadParams(pSessao: String);
begin
  FSessaoAtual := pSessao;
  pListaSessaoINI;
  FTipoCon      := TConvert<TTipoConexao>.StrConvertEnum(getINI(FIniFile, pSessao, 'TipoCon','tcLocal'));
  FUserName     := getINI(FIniFile, pSessao, 'User_Name');
  FPassword     := getINI(FIniFile, pSessao, 'Password');
  FDataBase     := getINI(FIniFile, pSessao, 'Database');
  FSQLDialect   := getINI(FIniFile, pSessao, 'SQLDialect');
  FDriverID     := getINI(FIniFile, pSessao, 'DriverID');
  FCharacterSet := getINI(FIniFile, pSessao, 'CharacterSet');
  FServer       := getINI(FIniFile, pSessao, 'Server');
  FProtocol     := getINI(FIniFile, pSessao, 'Protocol');
  FPort         := getINI(FIniFile, pSessao, 'Port');
  FVendorLib    := getINI(FIniFile, pSessao, 'VendorLib');
  FVendorHome   := getINI(FIniFile, pSessao, 'VendorHome');
  FEmbedded     := StrToBoolDef(getINI(FIniFile, pSessao, 'Embedded'),false);
end;

procedure TConecxaoBD.pWriteParams(pSessao: String);
begin
  setINI(FIniFile, pSessao, 'TipoCon'       ,TConvert<TTipoConexao>.EnumConvertStr(FTipoCon));
  setINI(FIniFile, pSessao, 'User_Name'     ,FUserName     );
  setINI(FIniFile, pSessao, 'Password'      ,FPassword     );
  setINI(FIniFile, pSessao, 'Database'      ,FDataBase     );
  setINI(FIniFile, pSessao, 'SQLDialect'    ,FSQLDialect   );
  setINI(FIniFile, pSessao, 'DriverID'      ,FDriverID     );
  setINI(FIniFile, pSessao, 'CharacterSet'  ,FCharacterSet );
  setINI(FIniFile, pSessao, 'Server'        ,FServer       );
  setINI(FIniFile, pSessao, 'Protocol'      ,FProtocol     );
  setINI(FIniFile, pSessao, 'Port'          ,FPort         );
  setINI(FIniFile, pSessao, 'VendorLib'     ,FVendorLib    );
  setINI(FIniFile, pSessao, 'VendorHome'    ,FVendorHome   );
  setINI(FIniFile, pSessao, 'Embedded'      ,BoolToStr(FEmbedded));
end;
end.




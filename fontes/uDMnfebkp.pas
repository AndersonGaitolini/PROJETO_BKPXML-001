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
    FConectado : boolean;

  public
    { Public declarations }
    Dao   : TDaoFD;

    function fConexaoBD:Boolean;
    property Conectado : boolean read FConectado write FConectado;
  end;

var
  DM_NFEDFE: TDM_NFEDFE;

implementation

uses
  ConfigPadrao, Configuracoes, Usuarios, Lm_bkpdfe, uMetodosUteis, dialogs, uRotinas;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDM_NFEDFE.fConexaoBD: Boolean;
var
wMSg : string;
wDataBase: string;
wHost: string;
wLog :Boolean;

 begin
   with conConexaoFD do
   begin
    wLog := false;
    try
      try
        Result := False;
        Connected := Result;
        Close;

        AddLog('LOGMAXXML',GetCurrentDir,'ConexaoBD - ParamStr(0) = ['+ ParamStr(0) + ']',wLog);
        with Params do
        begin
          Values['ConfigName'] := getINI(fArqIni, 'MAXXML',   'ConfigName', '');
          Values['Usuario'] := getINI(fArqIni, 'MAXXML',      'Usuario', '');
          Values['Password'] := getINI(fArqIni, 'MAXXML',     'Password', '');
          Values['Database'] := getINI(fArqIni, 'MAXXML',     'Database', '');
          Values['SQLDialect'] := getINI(fArqIni, 'MAXXML',   'SQLDialect', '');
          Values['VendorLib'] := getINI(fArqIni, 'MAXXML',    'VendorLib', '');
          Values['VendorHome'] := getINI(fArqIni, 'MAXXML',   'VendorHome', '');
          Values['DriverId'] := getINI(fArqIni, 'MAXXML',     'DriverId', '');
          Values['Port'] := getINI(fArqIni, 'MAXXML',         'Port', '');

          if (getINI(fArqIni, 'MAXXML', 'Conexao', '') = 'Remote') then
          begin
            wHost := getINI(fArqIni, 'MAXXML', 'Server', '');

            if not fPingIP(wHost) then
            begin
               pAppTerminate;
               ShowMessage('Sem Conexão de Rede');
            end
            else
            begin
              Values['Server'] := wHost;
              Values['Protocol'] := getINI(fArqIni, 'MAXXML',     'Protocol', '');
              Values['CharacterSet'] := getINI(fArqIni, 'MAXXML', 'CharacterSet', '');
            end;
          end;
        end;

        Open;
        FConectado := Connected;
        Result := Connected;

      except
        on E: Exception do
           begin
//             AddLog('LOGMAXXML',GetCurrentDir,'except Conexão -  [VendorHome: ' +  prDriver.VendorHome +'] VendorLib: [' +  prDriver.VendorLib +'] wDataBase: ['+ wDataBase + ']: Erro:'+
//             #10#13+ E.Message,wLog);
           end;
      end;
    finally

      if not Result  then
      begin
        pAppTerminate;
      end;
    end;
   end;
end;

procedure TDM_NFEDFE.DataModuleCreate(Sender: TObject);
begin
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

end.

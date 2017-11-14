unit uDMnfebkp;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXFirebird,
  Data.FMTBcd, Datasnap.Provider, Datasnap.DBClient, Data.DBXInterBase,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  //ORM
  Base, DaoFD, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

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

    procedure DataModuleCreate(Sender: TObject);
    procedure cdsBkpdfeAfterOpen(DataSet: TDataSet);
    procedure cdsUsuariosAfterOpen(DataSet: TDataSet);
    procedure cdsConfiguracoesAfterOpen(DataSet: TDataSet);
    procedure sqlBkpDfeAfterOpen(DataSet: TDataSet);
    procedure sqlUsuariosAfterOpen(DataSet: TDataSet);
    procedure sqlConfiguracoesAfterOpen(DataSet: TDataSet);
    procedure conConexaoFDAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Dao   : TDaoFD;
  end;

var
  DM_NFEDFE: TDM_NFEDFE;

implementation

uses
  ConfigPadrao, Configuracoes, Usuarios, Lm_bkpdfe, uMetodosUteis, dialogs, uRotinas;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM_NFEDFE.cdsBkpdfeAfterOpen(DataSet: TDataSet);
begin
  try

  except on E: Exception do
         begin
           AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'cdsBkpdfeAfterOpen : '+E.Message);
         end;
  end;

end;

procedure TDM_NFEDFE.cdsConfiguracoesAfterOpen(DataSet: TDataSet);
begin
  try

  except on E: Exception do
         begin
           AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'cdsConfiguracoesAfterOpen : '+E.Message);
         end;
  end;
end;

procedure TDM_NFEDFE.cdsUsuariosAfterOpen(DataSet: TDataSet);
begin
  try
  except on E: Exception do
         begin
           AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'cdsUsuariosAfterOpen : '+E.Message);
         end;
  end;
end;

procedure TDM_NFEDFE.conConexaoFDAfterConnect(Sender: TObject);
begin
  try
  except on E: Exception do
         begin
           AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'sqlBkpDfeAfterOpen : '+E.Message);
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
  wRotinas := TRotinas.Create;
end;

procedure TDM_NFEDFE.sqlBkpDfeAfterOpen(DataSet: TDataSet);
begin
  try
  except on E: Exception do
         begin
           AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'sqlBkpDfeAfterOpen : '+E.Message);
         end;
  end;
end;

procedure TDM_NFEDFE.sqlConfiguracoesAfterOpen(DataSet: TDataSet);
begin
  try
  except on E: Exception do
         begin
           AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'sqlConfiguracoesAfterOpen : '+E.Message);
         end;
  end;
end;

procedure TDM_NFEDFE.sqlUsuariosAfterOpen(DataSet: TDataSet);
begin
  try
  except on E: Exception do
         begin
           AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'sqlUsuariosAfterOpen : '+E.Message);
         end;
  end;
end;

end.

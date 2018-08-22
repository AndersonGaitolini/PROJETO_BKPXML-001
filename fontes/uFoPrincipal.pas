unit uFoPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,uDMnfebkp,
  Vcl.StdCtrls, Vcl.ToolWin, FireDAC.Comp.Client, Lm_bkpdfe, Datasnap.DBClient, usuarios,
  uMetodosUteis, uPadraoCons, GerarClasse, ufoGerarClasse,System.DateUtils,
  FireDAC.Phys.Intf, FireDAC.Stan.Option, FireDAC.Stan.Intf, JvComponentBase,
  JvTrayIcon, IPPeerClient, REST.Backend.PushTypes, System.JSON,
  System.PushNotification, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Backend.BindSource, REST.Backend.PushDevice,System.TypInfo, Vcl.Buttons,uRotinas,
  Vcl.DBCtrls, Vcl.AppEvnts, JvBaseDlg, JvSelectDirectory,System.MaskUtils,
  IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient,
  ProgressWheel, Vcl.Mask, uProgressWheel, JvExMask, JvToolEdit, JvMaskEdit,
  JvCheckedMaskEdit, JvDatePickerEdit, JvDBDatePickerEdit, System.Classes,Contnrs,
  System.Generics.Collections, SplitView,uFoAutoriza;

type
  TOrdena = (ordCodigo, ordData, ordChave);
  TSelectRowsGrid = (sgTodos, sgNenhum, sgVarios, sgFiltro);

//type
//  TDBGrid = class(Vcl.DBGrids.TDBGrid)
//  private
//    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
//  end;

  TfoPrincipal = class(TForm)
    tmrTempo: TTimer;
    pmExpSelecao: TMenuItem;
    ilButtons: TImageList;
    pnlMenu: TPanel;
    EvaAlertas: TFDEventAlerter;
    tiTryIcon: TJvTrayIcon;
    dlgSaveXML: TSaveDialog;
    pmExpTodos: TMenuItem;
    lbDataIni: TLabel;
    dtpDataFiltroINI: TDateTimePicker;
    lbDataFIm: TLabel;
    dtpDataFiltroFin: TDateTimePicker;
    pmSelecionar: TPopupMenu;
    mmSelTodos: TMenuItem;
    mmSelTodosExportar: TMenuItem;
    pmDeletarTodos: TMenuItem;
    pmDelTodosSelecionados: TMenuItem;
    pmDescmarcarSelTodos: TMenuItem;
    pnlControles: TPanel;
    btnEnvioArq: TButton;
    btnEnvioLote: TButton;
    btnEnvioExt: TButton;
    btnXMLEnvioExtLote: TButton;
    btnCanEnvioLote: TButton;
    btnCanEnvioArq: TButton;
    btnCanEnvioExt: TButton;
    btnCanExetendLote: TButton;
    btnSIMULACAO: TButton;
    TrayIconBkpNfe: TTrayIcon;
    appEventBKPNFE: TApplicationEvents;
    FDEventAlerter1: TFDEventAlerter;
    pnlLegenda: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape17: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Shape4: TShape;
    Label1: TLabel;
    pmAcoes: TMenuItem;
    pmExpXMLPDFSelecao: TMenuItem;
    pmRefazAutorizacaoSelecao: TMenuItem;
    pmRefazAutorizacaoTodos: TMenuItem;
    pmLinhaGrupoRefaz: TMenuItem;
    pmLinhaGrupoDel: TMenuItem;
    pmN3: TMenuItem;
    pmMarcarTodos: TMenuItem;
    pmExpPDFSelecao: TMenuItem;
    pmExpPDFTodos: TMenuItem;
    pmLinhaGrupoExpPDF: TMenuItem;
    pmExpXMLPDFTodos: TMenuItem;
    pmConfigurar: TMenuItem;
    pmConfigUsaurios: TMenuItem;
    pmDelRefazAutTodos: TMenuItem;
    pmExportar: TPopupMenu;
    pmN1: TMenuItem;
    pmTrocarUsuario: TMenuItem;
    pmN2: TMenuItem;
    pnl1: TPanel;

    dbgNfebkp: TDBGrid;
    statPrincipal: TStatusBar;
    pmFiltroData: TPopupMenu;
    pmDataEmissao: TMenuItem;
    pmDataAlteracao: TMenuItem;
    pmDataRecebimento: TMenuItem;
    dlgDir: TJvSelectDirectory;
    dlgOpenPrinc: TOpenDialog;
    pmHabiltaLogs: TMenuItem;
    ProgressBar1: TProgressBar;
    pmTamArquivos: TMenuItem;
    mmMaxxml: TMainMenu;
    mmFiltrosMenu: TMenuItem;
    mmFerramentas: TMenuItem;
    mmExpTodos: TMenuItem;
    mmAcoes: TMenuItem;
    mmDescmarcarSelTodos: TMenuItem;
    mmMarcarTodos: TMenuItem;
    mmN1: TMenuItem;
    mmTrocarUsuario: TMenuItem;
    mmN2: TMenuItem;
    mmConfigurar: TMenuItem;
    mmExpSelecao: TMenuItem;
    mmN3: TMenuItem;
    mmExpPDFTodos: TMenuItem;
    mmExpPDFSelecao: TMenuItem;
    mmN4: TMenuItem;
    mmExpXMLPDFTodos: TMenuItem;
    mmDeletarTodos: TMenuItem;
    mmDelTodosSelecionados: TMenuItem;
    mmConfgdiretrios1: TMenuItem;
    mmConfigUsaurios: TMenuItem;
    objectpmHabiltaLogsTMenuItem1: TMenuItem;
    mmTamArquivos: TMenuItem;
    mmN5: TMenuItem;
    mmRefazAutorizacaoSelecao: TMenuItem;
    mmRefazAutorizacaoTodos: TMenuItem;
    mmDelRefazAutTodos: TMenuItem;
    mmExpXMLPDFSelecao: TMenuItem;
    mmFetchAll: TMenuItem;
    mmDataEmissao: TMenuItem;
    mmDataAlteracao: TMenuItem;
    mmDataRecebimento: TMenuItem;
    pmFiltroColunas: TPopupMenu;
    pmRefazXML: TMenuItem;
    mmRefazXML: TMenuItem;
    pmFiltrodetalhado: TMenuItem;
    mmFiltroDetalhado: TMenuItem;
    mmGeraClasse: TMenuItem;
    mmConfigConn: TMenuItem;
    mmConfigconexo1: TMenuItem;
    mmAjuda: TMenuItem;
    mmCorrecoes: TMenuItem;
    pnlProgressWheel: TPanel;
    pbw1: TProgressWheel;
    Panel1: TPanel;
    btnFiltrar: TButton;
    cbbEmpCNPJ: TComboBox;
    cbbFIltroMes: TComboBox;
    cbbFiltroAno: TComboBox;
    pnlFiltroStatus: TPanel;
    shpNormal: TShape;
    lb1: TLabel;
    shpCancelada: TShape;
    lb2: TLabel;
    shpCancAguard: TShape;
    lb3: TLabel;
    lb4: TLabel;
    shp4: TShape;
    shp5: TShape;
    lb5: TLabel;
    lb6: TLabel;
    shpAguardando: TShape;
    lb7: TLabel;
    shpDenegado: TShape;
    Shape5: TShape;
    Label2: TLabel;
    lbConsultas: TLabel;
    edConsDocDest: TMaskEdit;
    cbbConsDocDest: TComboBox;
    opcLimparBase: TMenuItem;
    dlgvOpenXML: TFileOpenDialog;
    mmUseAnimation: TMenuItem;
    btnFiltroStatus: TButton;
    btnFIltroSQL: TButton;
    ilMenuMain: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure mniReconectarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgNfebkpDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure mmGeraclasseClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure dbgNfebkpTitleClick(Column: TColumn);
    procedure btnInserirClick(Sender: TObject);
    procedure btnProcRetornoClick(Sender: TObject);
    procedure dbgNfebkpDblClick(Sender: TObject);
    procedure pmExpTodosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgNfebkpKeyPress(Sender: TObject; var Key: Char);
    procedure dbgNfebkpKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mmSelTodosClick(Sender: TObject);
    procedure mmSelTodosExportarClick(Sender: TObject);
    procedure pmExpSelecaoClick(Sender: TObject);
    procedure pmDescmarcarSelTodosClick(Sender: TObject);
    procedure pmExportaPopup(Sender: TObject);
    procedure dbgNfebkpMouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure pmSelecionarPopup(Sender: TObject);
    procedure pmDelTodosSelecionadosClick(Sender: TObject);
    procedure pmDeletarTodosClick(Sender: TObject);
    procedure btnEnvioArqClick(Sender: TObject);
    procedure btnEnvioLoteClick(Sender: TObject);
    procedure btnEnvioExtClick(Sender: TObject);
    procedure btnXMLEnvioExtLoteClick(Sender: TObject);
    procedure btnCanEnvioArqClick(Sender: TObject);
    procedure btnCanEnvioLoteClick(Sender: TObject);
    procedure btnCanEnvioExtClick(Sender: TObject);
    procedure btnCanExetendLoteClick(Sender: TObject);
    procedure btnSIMULACAOClick(Sender: TObject);
    procedure appEventBKPNFEMinimize(Sender: TObject);
    procedure TrayIconBkpNfeDblClick(Sender: TObject);
    procedure FDEventAlerter1Alert(ASender: TFDCustomEventAlerter;
      const AEventName: string; const AArgument: Variant);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pmMarcarTodosClick(Sender: TObject);
    procedure pmRefazAutorizacaoTodosClick(Sender: TObject);
    procedure pmRefazAutorizacaoSelecaoClick(Sender: TObject);
    procedure pmTrocarUsuarioClick(Sender: TObject);
    procedure dtpDataFiltroINIExit(Sender: TObject);
    procedure dtpDataFiltroINIKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtpDataFiltroFinKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pmFiltroDataPopup(Sender: TObject);
    procedure pmDataEmissaoClick(Sender: TObject);
    procedure pmDataAlteracaoClick(Sender: TObject);
    procedure pmDataRecebimentoClick(Sender: TObject);
    procedure pmExpPDFSelecaoClick(Sender: TObject);
    procedure pmExpPDFTodosClick(Sender: TObject);
    procedure cbbEmpCNPJChange(Sender: TObject);
    procedure statPrincipalDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure pmTamArquivosClick(Sender: TObject);
    procedure mmFerramentasClick(Sender: TObject);
    procedure cbbEmpCNPJDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure mmFetchAllClick(Sender: TObject);
    procedure pmFiltroColunasPopup(Sender: TObject);
    procedure pmRefazXMLClick(Sender: TObject);
    procedure pmFiltrodetalhadoClick(Sender: TObject);
    procedure btnFIltroSQLClick(Sender: TObject);
    procedure edConsDocDestKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPauseClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure cbbConsDocDestChange(Sender: TObject);
    procedure edConsDocDestExit(Sender: TObject);
    procedure dbgNfebkpMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure edConsDocDestDblClick(Sender: TObject);
    procedure lb2MouseEnter(Sender: TObject);
    procedure lb2MouseLeave(Sender: TObject);
    procedure lb2DblClick(Sender: TObject);
    procedure mmConfigConnClick(Sender: TObject);
    procedure cbbFiltroAnoChange(Sender: TObject);
    procedure cbbFIltroMesChange(Sender: TObject);
    procedure btnFiltroStatusClick(Sender: TObject);
    procedure btnfILTROClick(Sender: TObject);
    procedure opcLimparBaseClick(Sender: TObject);
    procedure mmUseAnimationClick(Sender: TObject);
    procedure dbgNfebkpCellClick(Column: TColumn);

//  protected
//    procedure DoExecute; override;
//    procedure DoSetUp; override;
//    procedure DoTearDown; override;
  private
    { Private declarations }
    Split : TSplitView;
    FLastColunm : integer;
    FLastOrderBy: TOrdenaBy;
    wMesFiltro, wMesMin, wMesMax,
    wAnoFiltro, wAnoMin, wAnoMax: word;
    wValue: String;
    wStartTime: TTime;
    wVisible, bPrimeiraVez: boolean;
    wFiltroData ,wFiltroDetalhe, wFiltroOrdem : TFieldFiltros;
    wPathXML : string;
    wThreadAtual : cardinal;
    PilhaMes : TStack<string>;
    PilhaAno : TStack<string>;
    PilhaMesesAno : TStack<TAnoMeses>;
    PilhaAnoMes : TPilhaAnoMes;
    FFetchALL : Boolean;
    FUseAnim : Boolean;
    {Métodos da barra de progresso em threds}
    procedure DoMax(const PMax: Int64);
    procedure DoProgress (const PText: String; const PNumber: Cardinal);
    procedure pRotinasProgress(pNomeMetodo: TExecuteMetodo; pListaCNPJ : ArrayString = nil);
    procedure DoTerminate(PSender: TObject);
    procedure pMenuMaster(pAtiva : boolean);

    procedure pDesableControls(pEnable: boolean= true);
    procedure pInitSplitView;
    procedure pDataFiltro;
    procedure pFiltroEmissaoXML;
    procedure pUpdateCampoCNPJE;
    procedure pSalveName(pFieldName: string; var wFileName: string);
    procedure pSelecaoChave(var pLista: TStringList; pAddObjet : boolean = true);
    procedure pRemoveSelTodasLinhas;
    procedure pIniciaGrid;
    procedure pMenuFiltroData(pFieldFiltros : TFieldFiltros);
    procedure pCarregaMenuPrincipal;
    procedure pPosicionaDocDest;
    procedure pTrocaUsuario;

    procedure pCarregaListaAnoMes;
    procedure pCarregaListaMesesAno(pAno: word = 0);
  public
    { Public declarations }

    procedure pAtualizaGrid;
    function fSelecionaLinhaGrid(var pLista: TStringList; pSelecao : TSelectRowsGrid = sgTodos; pCNPJ : String = '*'): Int64;
    property FetchALL : Boolean read FFetchALL;
    property UseAnim: Boolean read FUseAnim;
    property LastColunm : integer read FLastColunm write FLastColunm;
    property LastOrderBy: TOrdenaBy read FLastOrderBy write FLastOrderBy;
  published
    function OpenTabela:boolean;
  end;

var
//  foAutoriza  : TfoAutoriza;
  foPrincipal : TfoPrincipal;
  AtualColunm,i  : Integer;
  wUpDown,
  wLoadXML : TLoadXML;
  SLXMLEnv :TStringList;
  wListaEmp, wListaSelecionados, wSlLoadLote : TStringList;
  clCorGrid00,
  clCorGrid01,
  clCorGrid02,
  clCorGrid03,
  clCorGrid04: integer;
  const
  cTodosCNPJ = '*';
  cMaster = 2;
  cAllEmp = 3;
  cOneEmp = 4;

implementation

uses
uFoConsConfiguracao, Configuracoes, uFoXMLSimulacao, ufoLogin, ufoTamanhoArquivos, uFoFiltroDetalhe,
uFoConexao, uFoProgressao;

{$R *.dfm}

procedure TfoPrincipal.pmTamArquivosClick(Sender: TObject);
begin
  foTamArquivos := TfoTamArquivos.Create(Application);
  try
    foTamArquivos.ShowModal;

  finally
    FreeAndNil(foTamArquivos);
  end;
end;

procedure TfoPrincipal.appEventBKPNFEMinimize(Sender: TObject);
begin
//  Self.Hide;
//  Self.WindowState := wsMinimized;
//  TrayIconBkpNfe.Visible := TRUE;
//  TrayIconBkpNfe.Animate := True;
end;

procedure TfoPrincipal.btnfILTROClick(Sender: TObject);
begin
 Split.MoveSplitView;
 if Split.SplitViewState = Expandido then
 begin
   btnFiltroStatus.ImageIndex := 0;
   btnFiltroStatus.HotImageIndex := 7;
   btnFiltroStatus.DisabledImageIndex := 1;
   btnFiltroStatus.SelectedImageIndex := 2;
 end
 else
 begin
   btnFiltroStatus.ImageIndex := 6;
   btnFiltroStatus.HotImageIndex := 1;
   btnFiltroStatus.DisabledImageIndex := 7;
   btnFiltroStatus.SelectedImageIndex := 8;
 end;

// cbbConsDocDest.ItemIndex := 0;
end;

procedure TfoPrincipal.btnCanEnvioArqClick(Sender: TObject);
var wFilename: string;
begin
  fOpenFile('Selecione o XML de Cancelamento', wFilename,['XML | *.*xml'],1);
  wRotinas.fLoadXMLNFe(tabConfiguracoes,txCan_,False, wFilename);
  btnFiltrarClick(Sender);
end;

procedure TfoPrincipal.btnCanEnvioExtClick(Sender: TObject);
var wFilename: string;
begin
  fOpenFile('Selecione o XML de Cancelamento processado', wFilename,['XML | *.*xml'],1);
  wRotinas.fLoadXMLNFe(tabConfiguracoes,txCan_Ext,False, wFilename);
  btnFiltrarClick(Sender);
end;

procedure TfoPrincipal.btnCanEnvioLoteClick(Sender: TObject);
begin
  wRotinas.fLoadXMLNFe(tabConfiguracoes,txCan_Lote, True);
  btnFiltrarClick(Sender);
end;

procedure TfoPrincipal.btnCanExetendLoteClick(Sender: TObject);
begin
  wRotinas.fLoadXMLNFe(tabConfiguracoes,txCan_ExtLote, True);
  btnFiltrarClick(Sender);
end;

procedure TfoPrincipal.btnEnvioArqClick(Sender: TObject);
var wFilename: string;
begin
  wFilename := 'Env_Nfe';
  fOpenFile('Selecione o XML de Envio', wFilename,['XML | *.*xml'],1);
  wRotinas.fLoadXMLNFe(tabConfiguracoes, txNFE_Env, false, wFilename);
  pDataFiltro;
//  DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,FLastOrderBy, CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
end;

procedure TfoPrincipal.btnEnvioExtClick(Sender: TObject);
var wFilename: string;
begin
  wFilename := 'Env_Nfe';
  fOpenFile('Selecione o XML de Envio processado', wFilename,['XML | *.*xml'],1);
  wRotinas.fLoadXMLNFe(tabConfiguracoes,txNFe_EnvExt, False, wFilename);
  pDataFiltro;
//  DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,FLastOrderBy,CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
end;

procedure TfoPrincipal.btnEnvioLoteClick(Sender: TObject);
begin
  wRotinas.fLoadXMLNFe(tabConfiguracoes,txNFE_EnvLote, True);
  pDataFiltro;
//  DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,FLastOrderBy, CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
end;

procedure TfoPrincipal.btnFiltrarClick(Sender: TObject);
begin
  pFiltroEmissaoXML;
end;

procedure TfoPrincipal.btnFIltroSQLClick(Sender: TObject);
begin
  if (edConsDocDest.CanFocus) then
  begin
   edConsDocDest.SetFocus;
   edConsDocDest.SelStart := Length(edConsDocDest.Text)+1;
  end;

  pDataFiltro;
  case cbbConsDocDest.ItemIndex of
   {MODELO}       0: wFiltroDetalhe := ffModelo;
   {CPF (DEST.)}  1,
   {CNPJ (DEST.)} 2: wFiltroDetalhe := ffCNPJDEST;
   {CNPJ(EMIT.)}  3: wFiltroDetalhe := ffCNPJ;
   {DOCUMENTO}    4: wFiltroDetalhe := ffIDF_DOCUMENTO;
   {PROT. AUT.}   5: wFiltroDetalhe := ffPROTOCOLOAUT;
   {PROT. CANC.}  6: wFiltroDetalhe := ffPROTOCOLOCANC;
   {CHAVE}        7: wFiltroDetalhe := ffCHAVE;
  else
   wFiltroDetalhe := ffDATAEMISSAO;
  end;

  wFiltroOrdem := wFiltroDetalhe;
  pDataFiltro;
  DaoObjetoXML.fFiltroOrdAnoMes(wMesFiltro,wAnoFiltro,wFiltroData,wFiltroDetalhe,wFiltroOrdem, FLastOrderBy ,CNPJDOC.Documento,Trim(edConsDocDest.Text),'', FetchALL);
end;

procedure TfoPrincipal.btnFiltroStatusClick(Sender: TObject);
begin
 Split.MoveSplitView;
 if Split.SplitViewState = Expandido then
 begin
   btnFiltroStatus.ImageIndex := 0;
   btnFiltroStatus.HotImageIndex := 7;
   btnFiltroStatus.DisabledImageIndex := 1;
   btnFiltroStatus.SelectedImageIndex := 2;
 end
 else
 begin
   btnFiltroStatus.ImageIndex := 6;
   btnFiltroStatus.HotImageIndex := 1;
   btnFiltroStatus.DisabledImageIndex := 7;
   btnFiltroStatus.SelectedImageIndex := 8;
 end;

// cbbConsDocDest.ItemIndex := 0;
end;

procedure TfoPrincipal.btnInserirClick(Sender: TObject);
begin
  if not Assigned(tabConfiguracoes) then
    tabConfiguracoes := TConfiguracoes.Create;
end;

procedure TfoPrincipal.btnPauseClick(Sender: TObject);
begin
  wRotinas.Pausar := not wRotinas.Pausar;
end;

procedure TfoPrincipal.btnProcRetornoClick(Sender: TObject);
begin
  if wRotinas.fLoadXMLNFe(tabConfiguracoes,txRet_Sai,True)> 0 then
  begin
    pDataFiltro;
//    DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,FLastOrderBy,CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
  end;
end;

procedure TfoPrincipal.btnSIMULACAOClick(Sender: TObject);
begin
  foXMLSimulcao := TfoXMLSimulcao.Create(Application);
  try
    foXMLSimulcao.ShowModal;
//    DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,FLastOrderBy,CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
    LastColunm := dbgNfebkp.SelectedIndex;
  finally
    foXMLSimulcao.Free;
  end;
end;

procedure TfoPrincipal.btnStopClick(Sender: TObject);
begin
  if MessageDlg('Deseja para o processo?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    wRotinas.Terminate;
  end;

end;

procedure TfoPrincipal.btnXMLEnvioExtLoteClick(Sender: TObject);
begin
  wRotinas.fLoadXMLNFe(tabConfiguracoes,txNFe_EnvExtLote, True);
//  DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,FLastOrderBy,CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
end;

procedure TfoPrincipal.cbbConsDocDestChange(Sender: TObject);
begin
  edConsDocDest.Clear;
  pPosicionaDocDest;

end;

procedure TfoPrincipal.cbbEmpCNPJChange(Sender: TObject);
begin
   if not Assigned(CNPJDOC) then
     CNPJDOC := TCNPJDOC.Create;

   if cbbEmpCNPJ.Items[cbbEmpCNPJ.ItemIndex] = 'Todos' then
     CNPJDOC.Documento := '*'
   else
     CNPJDOC.Documento := Copy(cbbEmpCNPJ.Items[cbbEmpCNPJ.ItemIndex],7,18);
end;

procedure TfoPrincipal.cbbEmpCNPJDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TComboBox do
  begin
    case Index of
      000: begin
             Canvas.Brush.Color := clWhite; //clCorGrid00;
           end;

      001: begin
             Canvas.Brush.Color := clCorGrid01;
           end;

      002: begin
             Canvas.Brush.Color := clCorGrid02;
           end;

      003: begin
             Canvas.Brush.Color := clCorGrid03;
           end;

      004: begin
             Canvas.Brush.Color := clCorGrid04;
           end;

      005: begin
             Canvas.Brush.Color := clPurple;
           end;

      006: begin
            Canvas.Brush.Color := clAqua;
           end;

      007: begin
             Canvas.Brush.Color := clOlive;
           end;
    end;
    //pintar a barra
//    Canvas.Brush.Color := TColor(Colors[Index]) ;
    //pintar a fonte
//    Canvas.Font.Color := TColor(Colors[Index]);
    Canvas.FillRect(Rect) ;
    Canvas.TextOut(Rect.Left,Rect.Top,cbbEmpCNPJ.Items[Index]);
  end;
end;

procedure TfoPrincipal.cbbFiltroAnoChange(Sender: TObject);
begin
  pCarregaListaMesesAno(StrToIntDef(cbbFiltroAno.Items[cbbFiltroAno.ItemIndex],0));
  pUpdateCampoCNPJE;
end;

procedure TfoPrincipal.cbbFIltroMesChange(Sender: TObject);
begin
  pUpdateCampoCNPJE;
end;

procedure TfoPrincipal.pAtualizaGrid;
begin
  pCarregaListaMesesAno(StrToIntDef(cbbFiltroAno.Items[cbbFiltroAno.ItemIndex],0));
//  cbbFIltroMes.ItemIndex := cbbFIltroMes.Items.Count-1;
//  cbbFiltroAno.ItemIndex := cbbFiltroAno.Items.Count-1;
  pDataFiltro;
  pUpdateCampoCNPJE;
  pDataFiltro;
  wFiltroDetalhe := ffDATAEMISSAO;
  wFiltroOrdem   := ffDATAEMISSAO;
  dbgNfebkp.DataSource.DataSet.Close;
  dbgNfebkp.DataSource.DataSet.Open;
  DaoObjetoXML.fFiltroOrdAnoMes(wMesFiltro,wAnoFiltro,wFiltroData,wFiltroDetalhe,wFiltroOrdem, FLastOrderBy ,CNPJDOC.Documento,'','', FetchALL);
  dbgNfebkp.Refresh;
  dbgNfebkp.DataSource.DataSet.First;
end;

procedure TfoPrincipal.pCarregaListaAnoMes;
var I: byte;
begin
  PilhaAnoMes := TPilhaAnoMes.Create;
  try

    with PilhaAnoMes do
    begin
       CarregaMesesAno;
      if PreencheAnoMes then
      begin
        PilhaMes := MesStack;
        PilhaAno := AnoStack;

      end;

      cbbFIltroMes.Clear;
      if PilhaMes.Count > 0 then
      for I := 0 to PilhaMes.Count-1 do
        cbbFIltroMes.Items.Add(PilhaMes.Pop);

      cbbFiltroAno.Clear;
      if PilhaAno.Count > 0 then
      for I := 0 to PilhaAno.Count-1 do
        cbbFiltroAno.Items.Add(PilhaAno.Pop);

      cbbFiltroMes.ItemIndex := 0;
      cbbFiltroAno.ItemIndex := 0;
    end;
  finally
    PilhaAnoMes.Destroy;
  end;
end;

procedure TfoPrincipal.pCarregaListaMesesAno(pAno: word);
var I,J:Integer;
    AuxAno : TAnoMeses;

begin
 PilhaAnoMes := TPilhaAnoMes.Create;
  try
    with PilhaAnoMes do
    begin
      if CarregaMesesAno then //and PreencheAnoMes then
      begin
        PilhaMesesAno := MesesAnoStack;
//        PilhaMes := MesStack;
        PilhaAno := AnoStack;
      end;

      cbbFiltroAno.Clear;
      if PilhaAno.Count > 0 then
      for I := 0 to PilhaAno.Count-1 do
        cbbFiltroAno.Items.Add(PilhaAno.Pop);

      if (pAno = 0) then
        pAno := StrToIntDef(cbbFiltroAno.Items[pAno],0);
        if (pAno = 0)then
        begin
          cbbFiltroAno.Items.Add('Sem registros');
          cbbFiltroAno.ItemIndex := cbbFiltroAno.Items.IndexOf('Sem registros');
          cbbFIltroMes.Items.Add('Sem registros');
          cbbFIltroMes.ItemIndex := cbbFIltroMes.Items.IndexOf('Sem registros');
          exit;
        end;

      cbbFIltroMes.Clear;
      if PilhaMesesAno.Count > 0 then
      for I := 0 to PilhaMesesAno.Count-1 do
      begin
        AuxAno := PilhaMesesAno.Pop;
        if AuxAno.Ano = pAno then
        if PreencheMes(pAno)then
        begin
          for J := 1 to MesLista.Count do
          begin
            cbbFIltroMes.Items.Add(MesLista.Strings[J-1]);
          end;
        end;
      end;

      cbbFiltroMes.ItemIndex := 0;
      for I := 0 to cbbFiltroAno.Items.Count-1 do
      begin
        if cbbFiltroAno.Items[I] = IntToStr(pAno)then
          cbbFiltroAno.ItemIndex := I;
      end;
    end;
  finally
    PilhaAnoMes.Destroy;
  end;
end;

procedure TfoPrincipal.pCarregaMenuPrincipal;
begin
  FFetchALL := mmFetchAll.Checked;
  FUseAnim := mmUseAnimation.checked;
end;

procedure TfoPrincipal.pDataFiltro;
begin
  wMesFiltro := StrMesToInt(cbbFIltroMes.Items[cbbFIltroMes.ItemIndex]);
  wAnoFiltro := StrToIntDef(cbbFiltroAno.Items[cbbFiltroAno.ItemIndex],0);

  wMesMin := StrMesToInt(cbbFIltroMes.Items[0]);
  wMesMax := StrMesToInt(cbbFIltroMes.Items[cbbFIltroMes.Items.Count-1]);
  wAnoMin := StrToIntDef(cbbFiltroAno.Items[0],wAnoFiltro);
  wAnoMax := StrToIntDef(cbbFiltroAno.Items[cbbFiltroAno.Items.Count-1],wAnoFiltro);
end;

procedure TfoPrincipal.pDesableControls(pEnable: boolean= true);
begin
  cbbEmpCNPJ.Enabled := pEnable;

end;

procedure TfoPrincipal.pRotinasProgress(pNomeMetodo: TExecuteMetodo; pListaCNPJ : ArrayString = nil);
begin
  wRotinas := TRotinas.Create;
  wThreadAtual := wRotinas.ThreadID;
  with wRotinas do
  begin

    ExecuteMetodo := pNomeMetodo;
    statPrincipal.Panels[1].Text := '0.00%';
    case pNomeMetodo of
           emLoadXMLNFe: InitialDir := wPathXML;
       emLoadLoteXMLNFe: Lista := wSlLoadLote;
       emExportaLoteXML,
           emExportaPDF,
        emDeleteSelecao,

        emDeleteMultSelecao: begin
                              Lista := wListaSelecionados;
                              ListaCNPJ := pListaCNPJ;
                             end;

        emSelecionaRows: begin
                           if not Assigned(CNPJDOC) then
                             CNPJDOC := TCNPJDOC.Create;

                           Documento := CNPJDOC.Documento;
                         end;
    end;

    OnMax := DoMax;
    OnProgress := DoProgress;
    OnTerminate := DoTerminate;
    wStartTime := Now;
    //Inicia e suspende a  thread go go go...
    start;
//    foPrincipal.pAtualizaGrid;
  end;
end;

procedure TfoPrincipal.pIniciaGrid;
begin
  with dbgNfebkp do
  begin
    Columns[i].Title.Color := 15391680; //clInfoBk;
    Columns[i].Title.Font.Color := clBlack;
    Columns[i].Title.Font.Name := 'Arial';
    Columns[i].Title.Font.Size  := 9;
    Columns[i].Title.Font.Style := [];
  end;
end;

procedure TfoPrincipal.pInitSplitView;
begin
  if not (Assigned(Split)) then
    Split := TSplitView.Create(pnlFiltroStatus);

 with Split do
 begin
   Placement := svLeft;
   UseAnimation := UseAnim;
   CloseStyle := svColapse; //svCompact;
   SplitViewState := Expandido; //Colapsado;
   btnFiltroStatus.ImageIndex := 6;
   btnFiltroStatus.HotImageIndex := 1;
   btnFiltroStatus.DisabledImageIndex := 7;
   btnFiltroStatus.SelectedImageIndex := 8;
   Split.MoveSplitView;
 end;
end;

procedure TfoPrincipal.pMenuFiltroData(pFieldFiltros: TFieldFiltros);

 procedure pCheck(pEmissao, pAlterecao, pReceb, pFiltroDetalhado: boolean);
 begin
  mmDataEmissao.Checked     := pEmissao;
  mmDataAlteracao.Checked   := pAlterecao;
  mmDataRecebimento.Checked := pReceb;
  mmFiltroDetalhado.Checked := pFiltroDetalhado;

  pmDataEmissao.Checked     := pEmissao;
  pmDataAlteracao.Checked   := pAlterecao;
  pmDataRecebimento.Checked := pReceb;
  pmFiltrodetalhado.Checked := pFiltroDetalhado;
 end;
begin

  wFiltroData := pFieldFiltros;
  case pFieldFiltros of

       ffDATARECTO   : pCheck(false, false, True, false);
     ffDATAEMISSAO   : pCheck(true, false, false, false);
   ffDATAALTERACAO   : pCheck(false, true, false, false);
   ffFILTRODETALHADO : pCheck(false, false, false, true);
  end;
end;

procedure TfoPrincipal.pMenuMaster(pAtiva: boolean);
var i, j, k: integer;
begin

  with mmMaxxml do
  begin
    for I := 0 to mmMaxxml.Items.Count-1 do
    begin
      if Items[I].Name = 'mmFerramentas' then
      for K:= 0 to mmMaxxml.Items[I].Count-1 do
      begin
        if mmMaxxml.Items[I].Items[K].Name = 'mmAcoes' then
        begin
          for J := 0 to mmMaxxml.Items[I].Items[K].Count -1 do
          begin
             if mmMaxxml.Items[I].Items[K].Items[J].Tag = cMaster then
             begin
               mmMaxxml.Items[I].Items[K].Items[J].Enabled := pAtiva;
               mmMaxxml.Items[I].Items[K].Items[J].Visible := pAtiva;
             end;

             if (mmMaxxml.Items[I].Items[K].Items[J].Tag = cOneEmp)  and
                (cbbEmpCNPJ.Items[cbbEmpCNPJ.ItemIndex] = 'Todos') then
             begin
               mmMaxxml.Items[I].Items[K].Items[J].Enabled := pAtiva;
               mmMaxxml.Items[I].Items[K].Items[J].Visible := pAtiva;
             end;
          end;
        end;

        if (mmMaxxml.Items[I].Items[K].Name = 'mmConfigurar') and
           (mmMaxxml.Items[I].Items[K].Tag = cMaster) then
        begin
          mmMaxxml.Items[I].Items[K].Enabled := pAtiva;
          mmMaxxml.Items[I].Items[K].Visible := pAtiva;
          exit;
        end;
      end;
    end;
  end;
end;

procedure TfoPrincipal.pmExportaPopup(Sender: TObject);
var wHabilita : boolean;

const
 cMaster = 2;
 cAllEmp = 3;
 cOneEmp = 4;

  procedure pPopupMenuMaster(pAtiva : boolean);
  var i, j, k: integer;
  begin

      with TPopupMenu(Sender) do
      begin
        for I := 0 to Items.Count-1 do
        begin
          if Items[i].Name = 'pmAcoes' then
          begin
            for j := 0 to TPopupMenu(sender).Items[i].Count -1 do
            begin
               if TPopupMenu(Sender).Items[i].Items[j].Tag = cMaster then
               begin
                 TPopupMenu(Sender).Items[i].Items[j].Enabled := pAtiva;
                 TPopupMenu(Sender).Items[i].Items[j].Visible := pAtiva;
               end;

               if (TPopupMenu(Sender).Items[i].Items[j].Tag = cOneEmp)  and
                  (cbbEmpCNPJ.Items[cbbEmpCNPJ.ItemIndex] = 'Todos') then
               begin
                 TPopupMenu(Sender).Items[i].Items[j].Enabled := pAtiva;
                 TPopupMenu(Sender).Items[i].Items[j].Visible := pAtiva;
               end;
            end;
          end;

          if Items[i].Name = 'pmConfigurar' then
          begin
            Items[I].Enabled := pAtiva;
            Items[I].Visible := pAtiva;

            exit;
          end;
        end;
      end;
  end;

begin
//  pSelecaoChave(wListaSelecionados);
  wVisible := wRotinas.fMaster(tabUsuarios);
  pPopupMenuMaster(wVisible);
end;

procedure TfoPrincipal.pmFiltroColunasPopup(Sender: TObject);

  procedure pCriaPopupMenuColunas;
  begin
    for I := 0 to dbgNfebkp.Columns.Count-1 do
    begin
      with pmFiltroColunas do
      begin



      end;

    end;

  end;

begin
  pCriaPopupMenuColunas;


end;

procedure TfoPrincipal.pmFiltroDataPopup(Sender: TObject);
var i, j, k: integer;
begin

end;

procedure TfoPrincipal.pmFiltrodetalhadoClick(Sender: TObject);
var wDocDest: string;
begin
  pMenuFiltroData(ffFILTRODETALHADO);
  try
    foFiltroDetalahado := TfoFiltroDetalahado.Create(Application);
    with wFiltroDetalhado do
    begin
      if cbbEmpCNPJ.Items[cbbEmpCNPJ.ItemIndex] = 'Todos' then
        CnpjEmi := 'Todos'
      else
        CnpjEmi := Copy(cbbEmpCNPJ.Items[cbbEmpCNPJ.ItemIndex],7,18);

      DataIni := dtpDataFiltroINI.Date;
      DataFin := dtpDataFiltroFin.Date;
      wDocDest := dbgNfebkp.DataSource.DataSet.FieldByName('cnpjdest').AsString;
      if fValidaCNPJ(wDocDest, true) or fValidaCPF(wDocDest, true) then
        CnpjDest := wDocDest
      else
        CnpjDest := 'Todos';
    end;
    foFiltroDetalahado.ShowModal;


  finally
    FreeAndNil(foFiltroDetalahado);
  end;

end;

procedure TfoPrincipal.pmSelecionarPopup(Sender: TObject);
//  var wI,wJ : Integer;
//      wSTR1,wSTR2 : String;
begin
//  wI := dbgNfebkp.SelectedRows.Count;
//  wJ := dbgNfebkp.DataSource.DataSet.RecordCount;
//  wSTR1 := IntToStr(wI);
//  wSTR2 := IntToStr(wJ);
//
//  if wI < 0 then
//  begin
//    mmSelTodos.Caption := 'Selecionar &todos ('+wSTR2+')';
//    mmSelTodosExportar.Caption := 'Selecionar todos e &exportar ('+wSTR2+')';
//  end;
end;

procedure TfoPrincipal.mmConfigConnClick(Sender: TObject);
begin
    foConexao := TfoConexao.Create(Application);
  try
    foConexao.ShowModal;
    if not ConecxaoBD.Conectado then
      pTrocaUsuario;

  finally
    FreeAndNil(foConexao);
  end;
end;

procedure TfoPrincipal.pmDataAlteracaoClick(Sender: TObject);
begin
  pMenuFiltroData(ffDATAALTERACAO);
end;

procedure TfoPrincipal.pmDataEmissaoClick(Sender: TObject);
begin
  pMenuFiltroData(ffDATAEMISSAO);
end;

procedure TfoPrincipal.pmDataRecebimentoClick(Sender: TObject);
begin
  pMenuFiltroData(ffDATARECTO);
end;

procedure TfoPrincipal.mmFerramentasClick(Sender: TObject);
begin
  pMenuMaster(wVisible);
end;

procedure TfoPrincipal.mmFetchAllClick(Sender: TObject);
begin
  mmFetchAll.Checked := not mmFetchAll.Checked;
  FFetchALL := mmFetchAll.Checked;
end;

procedure TfoPrincipal.pmDeletarTodosClick(Sender: TObject);
var I,J : Integer;
    ShowResult : byte;
    wMsg, wCNPJEmit : string;
    ListaCNPJ : ArrayString;
    TipoSel : TExecuteMetodo;
begin
  cbbEmpCNPJChange(Sender);
  wCNPJEmit := CNPJDOC.Documento;
  begin
    if wCNPJEmit = '*' then
    begin
      wMsg := 'Você está prestes a deletar todos os arquivos.';
      J := 0;
      for I := 0 to cbbEmpCNPJ.Items.Count-1 do
      begin
        if cbbEmpCNPJ.Items[I] <> '*' then
        begin
          Inc(J);
          SetLength(ListaCNPJ,J);
          ListaCNPJ[I] := cbbEmpCNPJ.Items[I];
        end;
      end;
    end
    else
    if fValidaCNPJ(wCNPJEmit, true)then
    begin
      wMsg := 'Você está prestes a deletar todos os arquivos do CNPJ '+ wCNPJEmit+'.';
      SetLength(ListaCNPJ,1);
      ListaCNPJ[0] := wCNPJEmit;
    end;

    try
      if MessageDlg(wMsg, mtConfirmation, [mbNo, mbYes],0 )= mrYes then
      begin
        Application.CreateForm(TfoAutoriza, foAutoriza);
        ShowResult := foAutoriza.ShowModal;
        if ShowResult = mrOk then
        begin
          fSelecionaLinhaGrid(wListaSelecionados,sgTodos);
          pRotinasProgress(emDeleteSelecao,ListaCNPJ);
        end;
      end;
    finally
      FreeAndNil(foAutoriza);
    end;
  end;
end;

procedure TfoPrincipal.pmDelTodosSelecionadosClick(Sender: TObject);
var TotSelecao: Integer; sMSG : string;
begin
   TotSelecao := dbgNfebkp.SelectedRows.Count;
   if (TotSelecao = 0) then
   begin
     ShowMessage('Selecione uma ou mais linhas antes');
     exit;
   end
   else
   if (TotSelecao = 1) then
     sMSG := Format('Deseja deletar %d arquivos selecionados?',[dbgNfebkp.SelectedRows.Count])
   else
     sMSG := 'Deseja deletar o arquivos selecionado?';

  if MessageDlg(sMSG, mtConfirmation, [mbNo, mbYes],0 ) = mrYes then
  begin
    fSelecionaLinhaGrid(wListaSelecionados, sgFiltro);
    pRotinasProgress(emDeleteMultSelecao);
  end;
end;

procedure TfoPrincipal.pmExpTodosClick(Sender: TObject);
begin
  fSelecionaLinhaGrid(wListaSelecionados, sgTodos);
  if dbgNfebkp.SelectedRows.Count = wListaSelecionados.Count then
  begin
    pRotinasProgress(emExportaLoteXML);
  end;

end;

procedure TfoPrincipal.pmExpPDFSelecaoClick(Sender: TObject);
var wTotSalvos: integer;
begin
//  pSelecaoChave(wListaSelecionados);
  fSelecionaLinhaGrid(wListaSelecionados, sgFiltro);
  pRotinasProgress(emExportaPDF);
end;

procedure TfoPrincipal.pmExpPDFTodosClick(Sender: TObject);
var wTotSalvos: integer;
begin
//  pSelecaoChave(wListaSelecionados);
  fSelecionaLinhaGrid(wListaSelecionados,sgTodos);
  pRotinasProgress(emExportaPDF);
end;

procedure TfoPrincipal.pmExpSelecaoClick(Sender: TObject);
begin
//    pSelecaoChave(wListaSelecionados);
  fSelecionaLinhaGrid(wListaSelecionados, sgFiltro);
  if dbgNfebkp.SelectedRows.Count > 0  then
    pRotinasProgress(emExportaLoteXML)
end;

procedure TfoPrincipal.dbgNfebkpTitleClick(Column: TColumn);
var iFirst, iLast: Integer;
    wDataINI, wDataFIN,DtAUX1,DtAUX2 : TDate;
    wValue1, wValue2, wValueAux : string;
    wFieldFiltro : TFieldFiltros;
begin
  iFirst := 1;
  iLast := dbgNfebkp.DataSource.DataSet.RecordCount;
  wFiltroOrdem := TConvert<TFieldFiltros>.StrConvertEnum('ff'+Column.FieldName);
  wDataINI := dtpDataFiltroINI.Date;
  wDataFIN := dtpDataFiltroFIN.Date;

 wFieldFiltro := TConvert<TFieldFiltros>.StrConvertEnum('ff'+dbgNfebkp.Columns[Column.Index].FieldName);

  case wFieldFiltro of

   ffDATARECTO,
   ffDATAEMISSAO,
   ffDATAALTERACAO:
           begin
             dbgNfebkp.DataSource.DataSet.First;
             DtAUX1 := dbgNfebkp.DataSource.DataSet.FieldByName(Column.FieldName).AsDateTime;
             dbgNfebkp.DataSource.DataSet.Last;
             DtAUX2 := dbgNfebkp.DataSource.DataSet.FieldByName(Column.FieldName).AsDateTime;
             if DtAUX1 <= DtAUX2 then
             begin
               DateTimeToString(wValueAux, 'yyyy/mm/dd',DtAUX1);
               DateTimeToString(wValue2, 'yyyy/mm/dd', DtAUX2);
             end
             else
             begin
               DateTimeToString(wValueAux, 'yyyy/mm/dd',DtAUX2);
               DateTimeToString(wValue2, 'yyyy/mm/dd', DtAUX1);
             end;

             if wValueAux <> '' then
               wValueAux := QuotedStr(wValueAux);

             if wValue2 <> '' then
               wValue2 := QuotedStr(wValue2);
           end;

    ffIDF_DOCUMENTO:
       begin
         dbgNfebkp.DataSource.DataSet.First;
         wValueAux := IntToStr(dbgNfebkp.DataSource.DataSet.FieldByName(Column.FieldName).AsInteger);
         dbgNfebkp.DataSource.DataSet.Last;
         wValue2 := IntToStr(dbgNfebkp.DataSource.DataSet.FieldByName(Column.FieldName).AsInteger);
       end;

    ffTIPO,
    ffCNPJ,
    ffCHAVE,
    ffMODELO,
    ffMOTIVO,
    ffMOTIVOCANC,
    ffPROTOCOLOAUT,
    ffTIPOAMBIENTE,
    ffPROTOCOLOCANC,
    ffPROTOCOLORECTO,
    ffEMAILSNOTIFICADOS:
    begin
      dbgNfebkp.DataSource.DataSet.First;
      wValueAux := dbgNfebkp.DataSource.DataSet.FieldByName(Column.FieldName).AsString;
      dbgNfebkp.DataSource.DataSet.Last;
      wValue2 := dbgNfebkp.DataSource.DataSet.FieldByName(Column.FieldName).AsString;

      if wValueAux <> '' then
        wValueAux := QuotedStr(wValueAux);

      if wValue2 <> '' then
        wValue2 := QuotedStr(wValue2);
    end;

    ffXMLENVIO,
    ffXMLEXTEND,
    ffXMLENVIOCANC,
    ffXMLEXTENDCANC:
    begin
     dbgNfebkp.DataSource.DataSet.First;
     wValueAux := IntToStr(dbgNfebkp.DataSource.DataSet.FieldByName('id').AsInteger);
     dbgNfebkp.DataSource.DataSet.Last;
     wValue2 := IntToStr(dbgNfebkp.DataSource.DataSet.FieldByName('id').AsInteger);
    end;
  end;

  if wValueAux > wValue2 then
  begin
    wValue1 := wValue2;
    wValue2 := wValueAux;
  end
  else
  wValue1 := wValueAux;

  if FLastOrderBy = obyNone then
    FLastOrderBy:= obyASCENDENTE;

  if FLastOrderBy = obyASCENDENTE then
    FLastOrderBy := obyDESCEDENTE
  else
   FLastOrderBy := obyASCENDENTE;

  if FLastColunm >= 0 then
    dbgNfebkp.Columns[FLastColunm].Title.Font.Style := [];

  dbgNfebkp.Columns[Column.Index].Title.Font.Style := [fsBold];
  FLastColunm := Column.Index;

  dbgNfebkp.Refresh;
end;

procedure TfoPrincipal.DoMax(const PMax: Int64);
begin
  pnlProgressWheel.Visible := true;
  pnlProgressWheel.BringToFront;
  pbw1.Min := 0;
  pbw1.Max := PMax;
  pbw1.Position := 0;
  pbw1.DoubleBuffered := True;
  statPrincipal.Panels[2].Text := 'Processando!';
end;

procedure TfoPrincipal.DoProgress(const PText: String; const PNumber: Cardinal);
var I:Int64;
begin
  btnFiltrar.Enabled      := False;
  btnFiltroStatus.Enabled := False;
  cbbFIltroMes.Enabled    := False;
  cbbFiltroAno.Enabled    := False;
  cbbEmpCNPJ.Enabled      := False;
  if Split.SplitViewState = Expandido then
    Split.MoveSplitView;

  I:= pbw1.Position;
  Inc(I,1);
  pbw1.Position := I;
  statPrincipal.Panels[1].Text := FormatFloat('##0.00%',pbw1.Position / pbw1.Max * 100);

//  ProgressBar1.StepIt;
//  statPrincipal.Panels[1].Text := FormatFloat('##0.00%',ProgressBar1.Position / ProgressBar1.Max * 100);

  statPrincipal.Panels[3].Text := Inttostr(PNumber)+' - '+ PText;
end;

procedure TfoPrincipal.DoTerminate(PSender: TObject);
var wMSG: string;
 wCardinal : cardinal;
begin
//  statPrincipal.Panels[1].Text := FormatFloat('##0.00%',ProgressBar1.Position / ProgressBar1.Max * 100);
//  statPrincipal.Panels[2].Text := 'Concluído!';
  statPrincipal.Panels[1].Text := FormatFloat('##0.00%',pbw1.Position / pbw1.Max * 100);
  statPrincipal.Panels[2].Text := 'Concluído!';
  with wRotinas do
  case ExecuteMetodo of
        emLoadXMLNFe: begin
                        wMSG := Format('Tempo total: %s',[FormatDateTime('hh:nn:ss',Now - wStartTime)]);

                        pUpdateCampoCNPJE;
                      end;
//        emExportaPDF: wMSG := Format('Total %d de %d Arquivos exportados - Tempo total: %s',[ProgressBar1.Position, ProgressBar1.Max, FormatDateTime('hh:nn:ss',Now - wStartTime)]);
        emExportaPDF: wMSG := Format('Total %d de %d Arquivos exportados - Tempo total: %s',[pbw1.Position, pbw1.Max, FormatDateTime('hh:nn:ss',Now - wStartTime)]);

    emExportaLoteXML: wMSG := Format('Tempo total: %s',[FormatDateTime('hh:nn:ss',Now - wStartTime)]);

     emSelecionaRows: begin
//                        wMSG := Format('%d / %d Linhas selecionadas - Tempo total: %s',[ProgressBar1.Position,ProgressBar1.Max, FormatDateTime('hh:nn:ss',Now - wStartTime)])
                        wMSG := Format('%d / %d Linhas selecionadas - Tempo total: %s',[pbw1.Position,pbw1.Max, FormatDateTime('hh:nn:ss',Now - wStartTime)])
                      end;
  end;


//  SuspendThread(Handle);
  statPrincipal.Panels[3].Text := wMSG;
//  ProgressBar1.Step := 1;
//  ProgressBar1.Position := 0;
  pbw1.Position := 0;
  pnlProgressWheel.Visible := False;
  wRotinas.Terminate;
  if wRotinas.ExecuteMetodo <> emSelecionaRows then
    pAtualizaGrid;

  btnFiltrar.Enabled := True;
  btnFiltroStatus.Enabled := True;
  cbbFIltroMes.Enabled := True;
  cbbFiltroAno.Enabled := True;
  cbbEmpCNPJ.Enabled   := True;
  if Split.SplitViewState = Colapsado then
    Split.MoveSplitView;
end;

procedure TfoPrincipal.dtpDataFiltroFinKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var y,m,d:word;
begin
  if Key = VK_F2 then
  begin
   DecodeDate(now,y,m,d);
   dtpDataFiltroFin.DateTime := EncodeDate(y,m,01)
  end;

  if Key = VK_F3 then
   dtpDataFiltroFin.DateTime := now;

  if Key = VK_F4 then
  begin
    DecodeDate(now,y,m,d);
    dtpDataFiltroFin.DateTime := EncodeDate(y,m,DaysInMonth(Now));
  end;
end;

procedure TfoPrincipal.dtpDataFiltroINIExit(Sender: TObject);
var y,m,d: word;
    wDateIni : Tdate;
begin
  DecodeDate(dtpDataFiltroINI.Date,y,m,d);
  dtpDataFiltroFin.DateTime := EncodeDate(y,m,DaysInMonth(dtpDataFiltroINI.Date));
end;

procedure TfoPrincipal.dtpDataFiltroINIKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var y,m,d: word;
begin
  if Key = VK_F2 then
  begin
   DecodeDate(now,y,m,d);
   dtpDataFiltroINI.DateTime := EncodeDate(y,m,01)
  end;

  if Key = VK_F3 then
   dtpDataFiltroINI.DateTime := now;

  if Key = VK_F4 then
  begin
    DecodeDate(now,y,m,d);
    dtpDataFiltroINI.DateTime := EncodeDate(y,m,DaysInMonth(Now));
  end;

end;

procedure TfoPrincipal.edConsDocDestDblClick(Sender: TObject);
begin
  edConsDocDest.Clear;
end;

procedure TfoPrincipal.edConsDocDestExit(Sender: TObject);
begin
  wValue := Trim(LowerCase(edConsDocDest.Text));
  case cbbConsDocDest.ItemIndex of
   {MODELO}       0: begin

                     end;
   {CPF (DEST.)}  1: begin
                      if (Length(wValue) = 11) and (fValidaCPF(wValue)) then
                      begin
                        edConsDocDest.Text := wValue;
                        edConsDocDest.SelStart := Length( edConsDocDest.Text);
                      end;
                     end;
   {CNPJ (DEST.)} 2: begin
                      if (Length(wValue) = 14) and (fValidaCNPJ(wValue)) then
                      begin
                        edConsDocDest.Text := wValue;
                        edConsDocDest.SelStart := Length( edConsDocDest.Text);
                      end;
                     end;
   {CNPJ(EMIT.)}  3: begin
                      if (Length(wValue) = 14) and (fValidaCNPJ(wValue)) then
                      begin
                        edConsDocDest.Text := wValue;
                        edConsDocDest.SelStart := Length( edConsDocDest.Text);
                      end;
                     end;
   {DOCUMENTO}    4: begin
                      if (Length(wValue) = 08) then
                      begin
                        edConsDocDest.Text := wValue;
                        edConsDocDest.SelStart := Length( edConsDocDest.Text);
                      end;
                     end;
   {PROT. AUT.}   5: begin
                      if (Length(wValue) = 15) then
                      begin
                        edConsDocDest.Text := wValue;
                        edConsDocDest.SelStart := Length( edConsDocDest.Text);
                      end;
                     end;
   {PROT. CANC.}  6: begin
                      if (Length(wValue) = 15) then
                      begin
                        edConsDocDest.Text := wValue;
                        edConsDocDest.SelStart := Length( edConsDocDest.Text);
                      end;
                     end;
   {CHAVE}        7: begin
                      if (Length(wValue) = 44) then
                      begin
                        edConsDocDest.Text := wValue;
                        edConsDocDest.SelStart := Length(edConsDocDest.Text);
                      end;
                     end;
  end;
end;

procedure TfoPrincipal.edConsDocDestKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_Return then
  begin
    btnFIltroSQLClick(Sender);
  end
end;

procedure TfoPrincipal.FDEventAlerter1Alert(ASender: TFDCustomEventAlerter;
  const AEventName: string; const AArgument: Variant);
begin
  If (UpperCase(AEventName) = 'NOVO_XML') then
  begin
  //<Executa tratamento para novo cliente cadastrado>

    if Self.WindowState = wsMinimized then
      Self.WindowState := wsNormal;

    self.BringToFront;
  end
end;

procedure TfoPrincipal.pFiltroEmissaoXML;
var STR1,STR2: string;
    wMesCons, wAnoCons : Word;
begin
  wFiltroDetalhe := ffDATAEMISSAO;
  wFiltroOrdem   := ffDATAEMISSAO;
  pDataFiltro;
  if (bPrimeiraVez) and (StrToIntDef(Trim(ParamStr(1)),0) = 0) then
  begin
    bPrimeiraVez := False;
    if (Trim(ParamStr(6)) <> '')  and (Trim(ParamStr(7)) <> '')then
    begin
      wMesCons := StrToIntDef(Trim(ParamStr(6)),wMesFiltro);
      wAnoCons := StrToIntDef(Trim(ParamStr(7)),wANoFiltro);

      if wMesCons in [wMesMin..wMesMax] then
        wMesFiltro := wMesCons;

      if wAnoCons in [wAnoMin..wAnoMax] then
        wANoFiltro := wANoCons;


      cbbFIltroMes.ItemIndex := cbbFIltroMes.Items.IndexOf(RetornaMes2(wMesFiltro));
      cbbFiltroAno.ItemIndex := cbbFiltroAno.Items.IndexOf(IntToStr(wANoFiltro));
    end;
  end;

  DaoObjetoXML.fFiltroOrdAnoMes(wMesFiltro,wAnoFiltro,wFiltroData,wFiltroDetalhe,wFiltroOrdem, FLastOrderBy ,CNPJDOC.Documento,'','', FetchALL);
  dbgNfebkp.Refresh;
end;

procedure TfoPrincipal.dbgNfebkpCellClick(Column: TColumn);
begin
  case Column.Index of//DataSource.DataSet.Fields.i of
  {MODELO}       03: begin
                      cbbConsDocDest.ItemIndex := 0;
                      edConsDocDest.Text :=  Column.Grid.DataSource.DataSet.FieldByName('modelo').AsString;
                     end;
  {CPF (DEST.)}
  {CNPJ (DEST.)} 05: begin
                       if Length(Column.Grid.DataSource.DataSet.FieldByName('cnpjdest').AsString) = 11 then
                         cbbConsDocDest.ItemIndex := 1
                       else
                         cbbConsDocDest.ItemIndex := 2;

                       edConsDocDest.Text := Column.Grid.DataSource.DataSet.FieldByName('cnpjdest').AsString;
                     end;
  {CNPJ(EMIT.)}  02: begin
                       cbbConsDocDest.ItemIndex := 3;
                       edConsDocDest.Text := Column.Grid.DataSource.DataSet.FieldByName('cnpj').AsString;
                     end;
  {DOCUMENTO}    07: begin
                       cbbConsDocDest.ItemIndex := 4;
                       edConsDocDest.Text := Column.Grid.DataSource.DataSet.FieldByName('idf_documento').AsString;
                     end;
  {PROT. AUT.}   09: begin
                     cbbConsDocDest.ItemIndex := 5;
                     edConsDocDest.Text := Column.Grid.DataSource.DataSet.FieldByName('protocoloaut').AsString;
                     end;
  {PROT. CANC.}  10: begin
                       cbbConsDocDest.ItemIndex := 6;
                       edConsDocDest.Text := Column.Grid.DataSource.DataSet.FieldByName('protocolocanc').AsString;
                     end;
  {CHAVE}        04: begin
                      cbbConsDocDest.ItemIndex := 7;
                      edConsDocDest.Text := Column.Grid.DataSource.DataSet.FieldByName('chave').AsString;
                     end
  else
    wFiltroDetalhe := ffDATAEMISSAO;
    edConsDocDest.Text := '';
  end;

  pPosicionaDocDest;
end;

procedure TfoPrincipal.dbgNfebkpDblClick(Sender: TObject);
var wStream : TStream;
    wFileName : String;
begin
   with (Sender as TDBGrid) do
   if SelectedField.IsBlob then
   begin
     if (MessageDlg('Deseja salvar o XML?', mtConfirmation, [mbYes, mbNo],0)= mrNo) then
       exit;

     SelectedField.DataSet.Edit;
     wStream := TMemoryStream.Create;
     wStream := SelectedField.DataSet.CreateBlobStream(SelectedField, bmReadWrite);
     pSalveName(SelectedField.FieldName, wFileName);
     dlgSaveXML.Filter := 'XML | *.xml';
     dlgSaveXML.Title :=  'Salve o arquivo: '+ Columns[SelectedField.Index].Title.Caption;
     dlgSaveXML.InitialDir := ExtractFileDir(wFileName);
     dlgSaveXML.FileName := wFileName;

     if dlgSaveXML.Execute then
     begin
       wRotinas.pDecompress(wStream, dlgSaveXML.FileName);
     end;
   end;
end;

procedure TfoPrincipal.dbgNfebkpDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  const IsChecked : array[Boolean] of Integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
var
    wColor: TColor;
    wStream : TStream;
    wRow, wStatus : Integer;
    wFileName, wSTR : String;

  procedure pSetColorLinhas;
  begin
    with (Sender as TDBGrid) do
    begin
      wSTR := DataSource.DataSet.FieldByName('cnpj').AsString;
      wStatus := wListaEmp.IndexOf(wSTR);

      case wStatus of
        000: begin
               Canvas.Brush.Color := clCorGrid00;
             end;

        001: begin
               Canvas.Brush.Color := clCorGrid01;
             end;

        002: begin
               Canvas.Brush.Color := clCorGrid02;
             end;

        003: begin
               Canvas.Brush.Color := clCorGrid03;
             end;

        004: begin
               Canvas.Brush.Color := clCorGrid04;
             end;

        005: begin
               Canvas.Brush.Color := clPurple;
             end;

        006: begin
              Canvas.Brush.Color := clAqua;
             end;

        007: begin
               Canvas.Brush.Color := clOlive;
             end;
      end;
    end;
  end;

begin
  with (Sender as TDBGrid) do
  begin
    wStatus := DataSource.DataSet.FieldByName('STATUSXML').AsInteger;
    case wStatus of
     -999: Canvas.Font.Color := clXmlDefeito;
      001: Canvas.Font.Color := clEnvAguard;     //XML Envio aguardando
      004: Canvas.Font.Color := clCancAguard;   //XML Cancelamento Envio aguardando
      100: Canvas.Font.Color := clProcessado;    //XML Envio Processado
      101,
      135: if DataSource.DataSet.FieldByName('tpEvento').AsInteger = 110110 then
             Canvas.Font.Color := clCartaCorrecao      //XML Carta Correção
           else
//           if DataSource.DataSet.FieldByName('tpEvento').AsInteger = 110111 then
             Canvas.Font.Color := clCancProcessado;      //XML Cancel. Processado
      110,205,301,302,
      303: Canvas.Font.Color := clDenegada;     //Denegada
      206,
      256,
      662: Canvas.Font.Color := clInutilizada;  //Inutilizada
    else
      Canvas.Font.Color := clNaoIdent;
    end;

    if ((gdSelected in State) or (gdRowSelected in State)) or SelectedRows.CurrentRowSelected then
    begin
      if SelectedRows.CurrentRowSelected then
        Canvas.Brush.Color := clDkGray
      else
        Canvas.Brush.Color := clGray;

      Canvas.Font.Style := [];
      Canvas.FillRect(Rect);
      Canvas.Font.Color:= clBlack;
      Canvas.TextOut(Rect.Left, Rect.Top,Column.Field.AsString);
      Canvas.FillRect(Rect);
    end
    else
    if (cbbEmpCNPJ.Items[cbbEmpCNPJ.ItemIndex] = 'Todos') then
      pSetColorLinhas;

   Canvas.FillRect(Rect);
   DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TfoPrincipal.dbgNfebkpKeyPress(Sender: TObject; var Key: Char);
var wOK : Boolean;
    wMR,I : Integer;
begin
  if (key = Chr(9)) then
   Exit;
end;

procedure TfoPrincipal.dbgNfebkpKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
  begin
    if((Trim(tabUsuarios.Usuario) = 'master') and (tabUsuarios.Senha = fSenhaAtual(''))) then
      pmDelTodosSelecionados.Click;
  end;
end;

procedure TfoPrincipal.dbgNfebkpMouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
//  var wI: Integer;
begin
//  if Button = mbRight then
//  begin
//    wI := dbgNfebkp.SelectedRows.Count;
//    if wI > 0 then
//    begin
//      dbgNfebkp.PopupMenu := pmExporta;
//    end
//    else
//    begin
//      dbgNfebkp.PopupMenu := pmSelecionar;
//    end;
//  end;
end;

procedure TfoPrincipal.dbgNfebkpMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin

  case TDBGrid(Sender).SelectedIndex of//DataSource.DataSet.Fields.i of
  {MODELO}       03: begin
                      cbbConsDocDest.ItemIndex := 0;
                      edConsDocDest.Text := TDBGrid(Sender).Columns.Grid.DataSource.DataSet.FieldByName('modelo').AsString;
                     end;
  {CPF (DEST.)}
  {CNPJ (DEST.)} 05: begin
                       if Length(TDBGrid(Sender).Columns.Grid.DataSource.DataSet.FieldByName('cnpjdest').AsString) = 11 then
                         cbbConsDocDest.ItemIndex := 1
                       else
                         cbbConsDocDest.ItemIndex := 2;

                       edConsDocDest.Text := TDBGrid(Sender).Columns.Grid.DataSource.DataSet.FieldByName('cnpjdest').AsString;
                     end;
  {CNPJ(EMIT.)}  02: begin
                       cbbConsDocDest.ItemIndex := 3;
                       edConsDocDest.Text := TDBGrid(Sender).Columns.Grid.DataSource.DataSet.FieldByName('cnpj').AsString;
                     end;
  {DOCUMENTO}    07: begin
                       cbbConsDocDest.ItemIndex := 4;
                       edConsDocDest.Text := TDBGrid(Sender).Columns.Grid.DataSource.DataSet.FieldByName('idf_documento').AsString;
                     end;
  {PROT. AUT.}   09: begin
                     cbbConsDocDest.ItemIndex := 5;
                     edConsDocDest.Text := TDBGrid(Sender).Columns.Grid.DataSource.DataSet.FieldByName('protocoloaut').AsString;
                     end;
  {PROT. CANC.}  10: begin
                       cbbConsDocDest.ItemIndex := 6;
                       edConsDocDest.Text := TDBGrid(Sender).Columns.Grid.DataSource.DataSet.FieldByName('protocolocanc').AsString;
                     end;
  {CHAVE}        04: begin
                      cbbConsDocDest.ItemIndex := 7;
                      edConsDocDest.Text := TDBGrid(Sender).Columns.Grid.DataSource.DataSet.FieldByName('chave').AsString;
                     end
  else
    wFiltroDetalhe := ffDATAEMISSAO;
    edConsDocDest.Text := '';
  end;

  pPosicionaDocDest;
end;

procedure TfoPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(wListaSelecionados);
  Split.Free;
end;

procedure TfoPrincipal.FormCreate(Sender: TObject);
var i,k:Integer;
    dts : TDataSet;

 procedure pSetaCores;
 begin
   clCorGrid00 := StrToInt('$D6FEE1');
   clCorGrid01 := StrToInt('$ffd7e1');
   clCorGrid02 := StrToInt('$fdfad0');
   clCorGrid03 := StrToInt('$ffffda');
   clCorGrid04 := StrToInt('$B4D0F7');
 end;

 procedure pProgressBarStyle;
var
  ProgressBarStyle: integer;
  begin
    statPrincipal.Panels[3].Style := psOwnerDraw;
    ProgressBar1.Parent := statPrincipal;
    ProgressBarStyle := GetWindowLong(ProgressBar1.Handle, GWL_EXSTYLE);
    ProgressBarStyle := (ProgressBarStyle - WS_EX_STATICEDGE);
    SetWindowLong(ProgressBar1.Handle, GWL_EXSTYLE, ProgressBarStyle);
  end;

begin
   bPrimeiraVez := true;
   pInitSplitView;
   pCarregaListaMesesAno(0);

  foPrincipal.Caption := 'SOUIS - MAXXML Versão 2.0';
  pSetaCores;
  pIniciaGrid;

  if not Assigned(DaoObjetoXML) then
    DaoObjetoXML := TDaoBkpdfe.create;

  if not Assigned(ObjetoXML) then
    ObjetoXML := TLm_bkpdfe.Create;

  if not Assigned(tabConfiguracoes) then
    tabConfiguracoes := TConfiguracoes.Create;

  if not Assigned(daoConfiguracoes) then
    daoConfiguracoes := TDaoConfiguracoes.Create;

  dts := DM_NFEDFE.Dao.ConsultaTab(tabUsuarios, ['id']);
  i:= dts.FieldByName('configsalva').AsInteger;
  dts.Free;

  wVisible := wRotinas.fMaster(tabUsuarios);
  pMenuMaster(wVisible);

  statPrincipal.Panels[0].Text := 'Usuário: '+ tabUsuarios.Usuario;
  statPrincipal.Panels[1].Text := '0.00%';
  statPrincipal.Panels[2].Text := 'MAXXML!';
  statPrincipal.Panels[3].Text := 'SOUIS, '+ FormatDateTime('dddd d, mmmm yyyy ',now);

  wLoadXML := lxNone;
  FLastColunm := -1;
  FLastOrderBy := obyNone;

  wListaSelecionados := TStringList.Create;
  pUpdateCampoCNPJE;
  wFiltroOrdem    := ffDATAEMISSAO;
  wFiltroData     := ffDATAEMISSAO;
  wFiltroDetalhe  := ffCNPJ;
  pMenuFiltroData(wFiltroData);
end;

procedure TfoPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
  begin
    if MessageDlg('Deseja sair?', mtConfirmation, mbYesNo,0) = mrYes then
     Close;
  end
end;

procedure TfoPrincipal.FormShow(Sender: TObject);
begin
  pCarregaMenuPrincipal;
  pFiltroEmissaoXML;
  cbbConsDocDest.ItemIndex := 2;
  edConsDocDest.EditMask := '99.999.999/9999-99;0;_';
  edConsDocDest.MaxLength := 18;
end;

procedure TfoPrincipal.pSalveName(pFieldName: string; var wFileName: string);
begin
  if (pFieldName = 'XMLENVIO')  or ( pFieldName = 'XMLEXTEND') then
   wFileName := 'Env_NFe'+dbgNfebkp.Fields[1].AsString + '.xml';

  if (pFieldName = 'XMLENVIOCANC') or (pFieldName = 'XMLEXTENDCANC' ) then
   wFileName := 'Can_'+dbgNfebkp.Fields[1].AsString + '.xml';
end;

procedure TfoPrincipal.pSelecaoChave(var pLista: TStringList; pAddObjet : boolean = true);
var I : Integer;
    wObjXML :TLm_bkpdfe;
    wSLAux : TStringList;
begin
  if not Assigned(pLista) then
    pLista := TStringList.Create
  else
  begin
    FreeAndNil(pLista);
    pLista := TStringList.Create;
  end;

  with DM_NFEDFE do
  begin
    for i := 0 to  dbgNfebkp.SelectedRows.Count - 1 do
    begin
      if dbgNfebkp.SelectedRows.IndexOf(dbgNfebkp.SelectedRows.Items[i]) > -1 then
      begin
        dbgNfebkp.DataSource.DataSet.Bookmark := dbgNfebkp.SelectedRows.Items[i];

        if pLista.IndexOf(dbgNfebkp.DataSource.DataSet.FieldByName('chave').AsString) < 0 then
        begin
          wObjXML := TLm_bkpdfe.Create;
          wObjXML.Chave := dbgNfebkp.DataSource.DataSet.FieldByName('chave').AsString;
          if pAddObjet then
          begin
            DaoObjetoXML.fConsObjXML4Exportar(wObjXML,['chave']);
            pLista.AddObject(wObjXML.Chave, wObjXML);
          end
          else
          pLista.Add(wObjXML.Chave);
        end;
      end;
    end;

    if pLista.Count > 0 then
  end;
end;

procedure TfoPrincipal.pTrocaUsuario;
var wShowResult : Byte;
begin
  foLogin := TfoLogin.Create(Application);
  try
    wShowResult := foLogin.ShowModal;

    if wShowResult = mrOk then
    begin
      wVisible := wRotinas.fMaster(tabUsuarios);
      statPrincipal.Panels[0].Text := 'Usuário: '+ tabUsuarios.Usuario;
    end
    else
      Application.Terminate;

  finally
    FreeAndNil(foLogin);
  end;
end;

function TfoPrincipal.fSelecionaLinhaGrid(var pLista: TStringList;pSelecao : TSelectRowsGrid = sgTodos; pCNPJ : String = '*'): Int64;
var
 wDataSet     : TDataSet;
 ObjXML       : TLm_bkpdfe;
 DaoObjetoXML : TDaoBkpdfe;
 wAno, wMes, wDia : word;
 DataIniStr, DataFinStr, sSQL: string;

  procedure pSelectRows;
  var wLinha: Integer;
  begin
    with wDataSet do
    begin
      Last;
      for wLinha := 0 to RecordCount-1 do
      begin
        wRotinas.pProgress('Linha',wLinha);
        dbgNfebkp.SelectedRows.CurrentRowSelected := True;
        Next;
      end;
    end;
  end;

  procedure pSelectRowsFiltro;
    var wLinha: Integer;
  begin
    if not Assigned(wRotinas) then
      wRotinas := TRotinas.Create;

    Result :=0;
    with dbgNfebkp.Datasource.DataSet do
    begin
//      dbgNfebkp.Datasource.DataSet.RecNo := 1;
      First;
      for wLinha := 1 to dbgNfebkp.DataSource.DataSet.RecordCount do
      begin
//        dbgNfebkp.SelectedRows.Count;
        wRotinas.pProgress('Linha',wLinha);
        Inc(Result,1);
        if not (dbgNfebkp.SelectedRows.CurrentRowSelected) then
        begin
          dbgNfebkp.SelectedRows.CurrentRowSelected := True;
        end;

        if pLista.IndexOf(dbgNfebkp.DataSource.DataSet.FieldByName('chave').AsString) < 0 then
        begin
          ObjXML.Chave := dbgNfebkp.DataSource.DataSet.FieldByName('chave').AsString;
          DaoObjetoXML.fConsObjXML4Exportar(ObjXML,['chave']);
          pLista.AddObject(ObjXML.Chave, ObjXML);
        end;

//       if dbgNfebkp.SelectedRows.Count > 0 then
         Next;
//       else
//         Break;
      end;

//      wRotinas.OnTerminate := DoTerminate;
    end;
  end;

begin
   ObjXML := TLm_bkpdfe.Create;

   if not(Assigned(DaoObjetoXML)) then
      DaoObjetoXML := TDaoBkpdfe.create;

  if not Assigned(pLista) then
    pLista := TStringList.Create
  else
  begin
    FreeAndNil(pLista);
    pLista := TStringList.Create;
  end;

  try
    case pSelecao of
      sgTodos  : begin
                    pDataFiltro;
                    if not ((wAnoFiltro > 0) and ((wMesFiltro > 0) and (wMesFiltro in [1..12]))) then
                     exit;

                    DateTimeToString(DataIniStr, 'yyyy/mm/dd', EncodeDate(wAnoFiltro,wMesFiltro,01));
                    DataIniStr := QuotedStr(DataIniStr);

                    DecodeDate(EndOfTheMonth(EncodeDate(wAnoFiltro,wMesFiltro,01)),wAno, wMes, wDia);
                    DateTimeToString(DataFinStr, 'yyyy/mm/dd', EncodeDate(wAnoFiltro,wMesFiltro, wDia));
                    DataFinStr := QuotedStr(DataFinStr);
                    sSQL := sSQL + 'select * from LM_BKPDFE ';
                    sSQL := sSQL + Format(' WHERE ( DATAEMISSAO between %s and %s) ',[DataIniStr, DataFinStr]);

                   if pCNPJ = '*' then
                   begin


                     wDataSet := DM_NFEDFE.Dao.ConsultaSql(sSQL);
                   end
                   else
                   begin
                     sSQL := sSQL + Format('and (%s like '+QuotedStr('%s')+') ',['CNPJ', '%'+pCNPJ+'%']);
                     wDataSet := DM_NFEDFE.Dao.ConsultaSql(sSQL);
                   end;

                   pSelectRowsFiltro;
                 end;

      sgNenhum : begin
                   pRemoveSelTodasLinhas;
                 end;


      sgFiltro : begin
                   pSelectRowsFiltro;
                 end;
    end;
  finally
    wDataSet.Free;
    ObjXML.Free;
//    DaoObjetoXML.Free;
  end;
end;

procedure TfoPrincipal.lb2DblClick(Sender: TObject);
var wTipStatXML: TStatusXML;
begin
  with TLabel(Sender)do
  begin
    Font.Color := clBlue;
    case tag of
      1000: begin wTipStatXML := tsxNormal; end;      //Normal
      1001: begin wTipStatXML := tsxNormAguard end;   //Aguard. Retorno
      1002: begin wTipStatXML := tsxCanecelada end;   //Cancelada
      1003: begin wTipStatXML := tsxCancAguard end;   //Aguard. Retorno cancelado
      1004: begin wTipStatXML := tsxDenegada; end;    //Denegada
      1005: begin wTipStatXML := tsxInutilizada; end; //Inutilizada
      1006: begin wTipStatXML := tsxDefeito; end;     //Defeito
      1007: begin wTipStatXML := tsxCartaCorr; end;   //Carta Correção
    end;

    wValue := TConvert<TStatusXML>.EnumConvertStr(wTipStatXML);

    pDataFiltro;
    wFiltroOrdem   := ffStatusXml;
    wFiltroDetalhe := ffStatusXml;
    Lm_bkpdfe.DaoObjetoXML.fFiltroOrdAnoMes(wMesFiltro,wAnoFiltro,wFiltroData,wFiltroDetalhe,wFiltroOrdem, FLastOrderBy, CNPJDOC.Documento ,wValue,'', FetchALL);
  end;
end;

procedure TfoPrincipal.lb2MouseEnter(Sender: TObject);
begin
  with TLabel(Sender)do
  begin
    Font.Color := clWebCoral;
  end;
end;

procedure TfoPrincipal.lb2MouseLeave(Sender: TObject);
begin
  with TLabel(Sender)do
  begin
    Font.Color := clBlack;
  end;
end;

procedure TfoPrincipal.pRemoveSelTodasLinhas;
var
wlLinha: Integer;
begin
  with dbgNfebkp.DataSource.DataSet do
  begin
    First;
    for wlLinha := 0 to RecordCount - 1 do
    begin
      dbgNfebkp.SelectedRows.CurrentRowSelected := False;
      Next;
    end;
  end;
end;

procedure TfoPrincipal.pUpdateCampoCNPJE;
var
  k, PosCNPJ : Integer;
  wCNPJ: string;
begin
if Assigned(CNPJDOC) then
  begin
    wFiltroDetalhe := ffCHAVE;
    cbbEmpCNPJ.Clear;
    pDataFiltro;
    wListaEmp := Lm_bkpdfe.CNPJDOC.fListaEmpresas(wMesFiltro, wAnoFiltro);
    if not Assigned(wListaEmp) then
    begin
      cbbEmpCNPJ.Items.Add('Não há registros!');
      exit;
    end;

    if CNPJDOC.Parametro then
      wCNPJ := CNPJDOC.Documento
    else
      wCNPJ := '';

    if (wCNPJ <> '') and (wListaEmp.IndexOf(wCNPJ) < 0) then
    begin
      PosCNPJ := wListaEmp.IndexOf(wCNPJ);
      if fValidaCNPJ(wCNPJ) then
         wListaEmp.Add(wCNPJ);
    end;


    if wListaEmp.Count = 0 then
      cbbEmpCNPJ.Items.Add('Não há registros!')
    else
    if wListaEmp.Count = 1 then
    begin
      wCNPJ := wListaEmp.Strings[0];
      if fValidaCNPJ(wCNPJ,true) then
        cbbEmpCNPJ.Items.Add('CNPJ: '+ wCNPJ);
    end
    else
    if wListaEmp.Count > 1 then
    begin
      cbbEmpCNPJ.Items.Add('Todos');
      for K := 0 to wListaEmp.Count-1 do
      begin
        wCNPJ := wListaEmp.Strings[K];
        if (fValidaCNPJ(wCNPJ,true)) then
          cbbEmpCNPJ.Items.Add('CNPJ: '+ wCNPJ);
      end;
    end;

    if wCNPJ = '*' then
       cbbEmpCNPJ.ItemIndex := 0
    else
    begin
      if PosCNPJ >= 0 then
      begin
        wCNPJ := wListaEmp.Strings[PosCnpj];
        if fValidaCNPJ(wCNPJ, true) then
          cbbEmpCNPJ.ItemIndex := cbbEmpCNPJ.Items.IndexOf('CNPJ: '+ wCNPJ);
      end
      else
      if fValidaCNPJ(wCNPJ, true) then
        cbbEmpCNPJ.ItemIndex := cbbEmpCNPJ.Items.IndexOf('CNPJ: '+ wCNPJ);
    end;

    if fValidaCNPJ(wCNPJ,False)then
      CNPJDOC.Documento := wCNPJ;
  end;
end;

procedure TfoPrincipal.statPrincipalDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = statPrincipal.Panels[3] then
  begin
    ProgressBar1.Top := Rect.Top;
    ProgressBar1.Left := Rect.Left;
    ProgressBar1.Width := Rect.Right - Rect.Left - 15;
    ProgressBar1.Height := Rect.Bottom - Rect.Top;
  end;
end;

procedure TfoPrincipal.mmGeraclasseClick(Sender: TObject);
var wSenha :string;
begin
 foGeraClasse := TfoGeraClasse.Create(Application);
 try
   wSenha := InputBox('Digite a senha do desenvolvimento!', 'Senha:','');
   if (Trim(wSenha) <> '') and (Trim(wSenha) = '$ouis2017') then
     foGeraClasse.ShowModal
   else
     ShowMessage('Senha incorreta!');
 finally
   foGeraClasse.Free;
 end;
end;

procedure TfoPrincipal.pmMarcarTodosClick(Sender: TObject);
begin
  pRotinasProgress(emSelecionaRows);
end;

procedure TfoPrincipal.pmRefazAutorizacaoSelecaoClick(Sender: TObject);
begin
  if dbgNfebkp.SelectedRows.Count = wListaSelecionados.Count then
  begin
    dlgDir := TJvSelectDirectory.Create(Application);
    dlgDir.InitialDir := GetCurrentDir;
    dlgDir.Title := 'Seleceione o diretório dos Processados.';
    if dlgDir.Execute then
      tabConfiguracoes.NFePathProcessado := dlgDir.Directory;

    if wRotinas.fLoadXMLNFeLista(wListaSelecionados)then
    begin
      dbgNfebkp.Refresh;
      ShowMessage('Autorizações selecionadas reprocessadas!');
    end;
  end;
end;

procedure TfoPrincipal.pmRefazAutorizacaoTodosClick(Sender: TObject);
var
    wI : Integer;
    wColumn : TColumn;
begin
   dlgDir := TJvSelectDirectory.Create(Application);
   try
     wPathXML := ExtractFileDir(ParamStr(0));
     wPathXML := Copy(wPathXML, 1, LastDelimiter('\', wPathXML));
     if FileExists(wPathXML+'Maxwin.exe') or (FileExists(wPathXML+'Maxecv.exe')) then
       wPathXML := wPathXML + 'DFE\XML\';

     if DirectoryExists(wPathXML) then
       dlgDir.InitialDir := wPathXML
     else
       dlgDir.InitialDir := GetCurrentDir;

     dlgDir.Title := 'Seleceione o diretório dos arquivos de XMLs.';
    if dlgDir.Execute then
    begin
      wPathXML  := dlgDir.Directory;

    if (wPathXML = '') OR (NOT DirectoryExists(wPathXML)) then
      exit;

      if not Assigned(wRotinas) then
        wRotinas := TRotinas.Create;

      wSlLoadLote := TStringList.Create;

      FindFiles(wSlLoadLote, wPathXML,'*.xml');
      pRotinasProgress(emLoadLoteXMLNFe);
    end;

   finally
     dlgDir.Free;
   end;
end;

procedure TfoPrincipal.pmRefazXMLClick(Sender: TObject);
var I: Integer;
    wFileName: string;
begin
  wFileName := ExtractFileDir(ParamStr(0));
  wFileName := Copy(wFileName, 1, LastDelimiter('\', wFileName));
  if FileExists(wFileName+'Maxwin.exe') or (FileExists(wFileName+'Maxecv.exe')) then
    wFileName := wFileName + 'DFE\XML\Envio\Processado'
  else
    wFileName := wFileName + 'DFE\XML\';;

  dlgvOpenXML.DefaultExtension := 'xml';
  dlgvOpenXML.Title := 'Escolha o Arquivo XML';
  dlgvOpenXML.DefaultFolder := wFileName;
//  dlgvOpenXML.Filter := '*.*XML';
  dlgvOpenXML.Options := [fdoAllowMultiSelect];
  if dlgvOpenXML.Execute then
  begin
    if not Assigned(wRotinas) then
      wRotinas := TRotinas.Create;

    wSlLoadLote := TStringList.Create;
    for I := 0 to dlgvOpenXML.Files.Count-1 do
      wSlLoadLote.Add(dlgvOpenXML.Files[I]);

    pRotinasProgress(emLoadLoteXMLNFe);
  end;

  pUpdateCampoCNPJE;
end;

procedure TfoPrincipal.pmDescmarcarSelTodosClick(Sender: TObject);
begin
  pRemoveSelTodasLinhas;
end;

procedure TfoPrincipal.mmSelTodosClick(Sender: TObject);
var wI: Integer;
begin
  fSelecionaLinhaGrid(wListaSelecionados);
end;

procedure TfoPrincipal.mmSelTodosExportarClick(Sender: TObject);
begin
  fSelecionaLinhaGrid(wListaSelecionados);
//  pSelecaoChave(wListaSelecionados);
  wRotinas.fExportaLoteXML(wListaSelecionados);
end;

procedure TfoPrincipal.mmUseAnimationClick(Sender: TObject);
begin
  mmUseAnimation.Checked := not mmUseAnimation.Checked;
  FUseAnim := mmUseAnimation.Checked;
  Split.UseAnimation := mmUseAnimation.Checked;
end;

procedure TfoPrincipal.mniReconectarClick(Sender: TObject);
var statusCon : string;
begin

end;

procedure TfoPrincipal.opcLimparBaseClick(Sender: TObject);
var wMsg : string;
    ShowResult : Byte;
begin
  wMsg := 'Você está prestes a limpar a base de dados.';
  if MessageDlg(wMsg, mtConfirmation, [mbNo, mbYesToAll],0 )= mrYesToAll then
  begin
    try
      Application.CreateForm(TfoAutoriza, foAutoriza);
      ShowResult := foAutoriza.ShowModal;

      if ShowResult = mrOk then
      begin
//        fSelecionaLinhaGrid(wListaSelecionados,sgTodos);
        pRotinasProgress(emDeleteTudo);
      end;

    finally
      FreeAndNil(foAutoriza);
    end;
  end;
end;

procedure TfoPrincipal.pmTrocarUsuarioClick(Sender: TObject);
begin

 pTrocaUsuario;
//  foLogin := TfoLogin.Create(Application);
//  try
//    wShowResult := foLogin.ShowModal;
//
//    if wShowResult = mrOk then
//    begin
//      wVisible := wRotinas.fMaster(tabUsuarios);
//      statPrincipal.Panels[0].Text := 'Usuário: '+ tabUsuarios.Usuario;
//    end
//    else
//      Application.Terminate;
//
//  finally
//    FreeAndNil(foLogin);
//  end;
end;

procedure TfoPrincipal.pPosicionaDocDest;
begin
   case cbbConsDocDest.ItemIndex of
    {MODELO}       0: begin
                        edConsDocDest.EditMask := '99;0;';
                        edConsDocDest.MaxLength := 02;
                      end;
    {CPF (DEST.)}  1: begin
                        edConsDocDest.EditMask := '999.999.999-99;0;';
                        edConsDocDest.MaxLength := 14;
                      end;
    {CNPJ (DEST.)} 2: begin
                        edConsDocDest.EditMask := '99.999.999/9999-99;0;';
                      end;
    {CNPJ(EMIT.)}  3: begin
                        edConsDocDest.EditMask := '99.999.999/9999-99;0;';
                        edConsDocDest.MaxLength := 18;
                      end;
    {DOCUMENTO}    4: begin
                        edConsDocDest.EditMask := '99999999;0;';
                        edConsDocDest.MaxLength := 08;
                      end;
    {PROT. AUT.}   5: begin
                        edConsDocDest.EditMask := '999999999999999;0;';
                        edConsDocDest.MaxLength := 15;
                      end;
    {PROT. CANC.}  6: begin
                        edConsDocDest.EditMask := '999999999999999;0;';
                        edConsDocDest.MaxLength := 15;
                      end;
    {CHAVE.}       7: begin
                        edConsDocDest.EditMask := '99999999999999999999999999999999999999999999;0;';
                        edConsDocDest.MaxLength := 44;
                      end;
   else
     edConsDocDest.MaxLength := 0;
   end;

  edConsDocDest.SelStart := 0;
end;

function TfoPrincipal.OpenTabela: boolean;
var wDataSet : TDataSet;
    wDS : TDataSource;
    wDSAux : TDataSource;
begin
  result := false;
  try
    try
       with DM_NFEDFE do
      begin
        if not Assigned(ObjetoXML) then
           ObjetoXML := TLm_bkpdfe.Create;

        dsBkpdfe.DataSet :=  dao.SelectAll(ObjetoXML);
        dbgNfebkp.Refresh;
       result := true;
      end;
    except
      on E: Exception do
      begin
        showmessage(E.Message + 'Houve um problema na rotina Open da tabela LM_BKPDFE');
      end;
    end;
  finally

  end;
end;

procedure TfoPrincipal.ToolButton1Click(Sender: TObject);
begin
   ShowMessage('usuario: '+ tabUsuarios.Usuario);
end;

procedure TfoPrincipal.TrayIconBkpNfeDblClick(Sender: TObject);
begin
//  Self.Visible := True;
//  Self.WindowState := wsNormal;
//  Self.Resizing(wsNormal);
//  Self.BringToFront;
//  TrayIconBkpNfe.Visible := false;
//  TrayIconBkpNfe.Animate := false;;
end;

{ TDBGrid }

//procedure TDBGrid.WMVScroll(var Message: TWMVScroll);
//begin
//  if Message.ScrollCode = SB_THUMBTRACK then
//    Message.ScrollCode := SB_THUMBPOSITION;
//
//  inherited;
//end;
initialization

end.

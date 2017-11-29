unit uFoPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,uDMnfebkp,
  Vcl.StdCtrls, Vcl.ToolWin, FireDAC.Comp.Client, Lm_bkpdfe, Datasnap.DBClient, usuarios,
  uMetodosUteis, uPadraoCons, GerarClasse, ufoGerarClasse,System.DateUtils,
  FireDAC.Phys.Intf, FireDAC.Stan.Option, FireDAC.Stan.Intf, JvComponentBase,
  JvTrayIcon, IPPeerClient, REST.Backend.PushTypes, System.JSON,
  System.PushNotification, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Backend.BindSource, REST.Backend.PushDevice,System.TypInfo, Vcl.Buttons,uRotinas,
  Vcl.DBCtrls, Vcl.AppEvnts, JvBaseDlg, JvSelectDirectory,System.MaskUtils,
  IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient;

type
  TOrdena = (ordCodigo, ordData, ordChave);
  TSelectRowsGrid = (sgTodos, sgNenhum, sgVarios, sgFiltro);

//type
//  TDBGrid = class(Vcl.DBGrids.TDBGrid)
//  private
//    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
//  end;

  TfoPrincipal = class(TForm)
    ilPrincipal: TImageList;
    tmrTempo: TTimer;
    pmExpSelecao: TMenuItem;
    ilMenu: TImageList;
    pnlMenu: TPanel;
    edConfiguracao: TEdit;
    EvaAlertas: TFDEventAlerter;
    tiTryIcon: TJvTrayIcon;
    btnCarregaConfig: TSpeedButton;
    dlgSaveXML: TSaveDialog;
    pmExpTodos: TMenuItem;
    lbDataIni: TLabel;
    dtpDataFiltroINI: TDateTimePicker;
    lbDataFIm: TLabel;
    dtpDataFiltroFin: TDateTimePicker;
    lbConfig: TLabel;
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
    btnFiltrar: TButton;
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
    mmConfgDiretorios: TMenuItem;
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
    jopdDirDir: TJvSelectDirectory;
    dlgOpenPrinc: TOpenDialog;
    pmHabiltaLogs: TMenuItem;
    lbEmp: TLabel;
    cbbEmpCNPJ: TComboBox;
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
    shp7: TShape;
    edConsultaSQL: TEdit;
    lbConsultas: TLabel;
    btnFIltroSQL: TBitBtn;
    bvl1: TBevel;
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
    procedure btnProcessaEnvioClick(Sender: TObject);
    procedure btnCarregaConfigClick(Sender: TObject);
    procedure dbgNfebkpDblClick(Sender: TObject);
    procedure btnPelaChaveClick(Sender: TObject);
    procedure pmExpTodosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgNfebkpColExit(Sender: TObject);
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
    procedure mmConfgDiretoriosClick(Sender: TObject);
    procedure pmDelRefazAutTodosClick(Sender: TObject);
    procedure pmRefazAutorizacaoSelecaoClick(Sender: TObject);
    procedure pmTrocarUsuarioClick(Sender: TObject);
    procedure pmConfigUsauriosClick(Sender: TObject);
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
    procedure edConsultaSQLChange(Sender: TObject);
    procedure edConsultaSQLKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    wValue: String;
    wStartTime: TTime;
    wVisible: boolean;
    wLastFieldFiltros : TFieldFiltros;
    wFetchALL :Boolean;

    {Métodos da barra de progresso em threds}
    procedure DoMax(const PMax: Int64);
    procedure DoProgress (const PText: String; const PNumber: Cardinal);
    procedure pRotinasProgress(pNomeMetodo: TExecuteMetodo);
    procedure DoTerminate(PSender: TObject);
    procedure pMenuMaster(pAtiva : boolean);

    procedure pDataFiltro;
    procedure pFiltroEmissaoXML;
    procedure pUpdateCampoCNPJE;
    procedure pSalveName(pFieldName: string; var wFileName: string);
    procedure pSelecaoChave(var pLista: TStringList; pAddObjet : boolean = false);
    procedure pDeleteRowsSelectGrid;
    procedure pRemoveSelTodasLinhas;
    procedure pIniciaGrid;
    procedure pMenuFiltroData(pFieldFiltros : TFieldFiltros);



  public
    { Public declarations }
    procedure pAtualizaGrid;
    function fSelecionaLinhaGrid(pSelecao : TSelectRowsGrid = sgTodos; pCNPJ : String = '*'): Int64;
    property FetchALL : Boolean read wFetchALL;
  published
    function OpenTabela:boolean;
  end;

var
  foPrincipal : TfoPrincipal;
  wLastColunm,AtualColunm,i  : Integer;
  wUpDown,
  wLastOrderBy: TOrdenaBy;
  wLastField : string;
  wLoadXML : TLoadXML;
  SLXMLEnv :TStringList;
  wListaEmp, wListaSelecionados : TStringList;
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

uFoConsConfiguracao, Configuracoes, uFoXMLSimulacao, ufoLogin, uFoCadUsuario, uFoConsUsuario, ufoTamanhoArquivos, uFoFiltroDetalhe, uFoConexao;

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

procedure TfoPrincipal.btnCarregaConfigClick(Sender: TObject);
begin
//  foConsConfiguracoes := TfoConsConfiguracoes.Create(Application);
//try
//  with foConsConfiguracoes do
//  begin
//    evtTelaUsuarios := etuEditar;
//    ShowModal;
//  end;
//  pCarregaConfigUsuario(tabConfiguracoes.Id);
//
//finally
//  FreeAndNil(foConsConfiguracoes);
//end;
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
  DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,wLastOrderBy, CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
end;

procedure TfoPrincipal.btnEnvioExtClick(Sender: TObject);
var wFilename: string;
begin
  wFilename := 'Env_Nfe';
  fOpenFile('Selecione o XML de Envio processado', wFilename,['XML | *.*xml'],1);
  wRotinas.fLoadXMLNFe(tabConfiguracoes,txNFe_EnvExt, False, wFilename);
  pDataFiltro;
  DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,wLastOrderBy,CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
end;

procedure TfoPrincipal.btnEnvioLoteClick(Sender: TObject);
begin
  wRotinas.fLoadXMLNFe(tabConfiguracoes,txNFE_EnvLote, True);
  pDataFiltro;
  DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,wLastOrderBy, CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
end;

procedure TfoPrincipal.btnFiltrarClick(Sender: TObject);
begin
  pFiltroEmissaoXML;
  dbgNfebkp.Refresh;
end;

procedure TfoPrincipal.btnFIltroSQLClick(Sender: TObject);
begin
  if Trim(LowerCase(wValue)) = '' then
  begin
    if edConsultaSQL.CanFocus then
    begin
     edConsultaSQL.SetFocus;
     edConsultaSQL.SelStart := 1;
    end;
  end
  else  
  begin
   DaoObjetoXML.pFiltraOrdena(wLastFieldFiltros, wLastOrderBy, CNPJDOC.Documento, 'CNPJDEST'{wLastField}, dtpDataFiltroINI.Date, dtpDataFiltroFin.Date, wValue);
   if dbgNfebkp.DataSource.DataSet.RecordCount > 0 then
     edConsultaSQL.Clear;
  end;
end;

procedure TfoPrincipal.btnInserirClick(Sender: TObject);
begin
  if not Assigned(tabConfiguracoes) then
    tabConfiguracoes := TConfiguracoes.Create;
end;

procedure TfoPrincipal.btnPelaChaveClick(Sender: TObject);
var wFilename: string;
begin
//  fOpenFileName(['XML | *.*xml'],['XML Arquivo | *.*xml'], wFilename,'Selecione o XML');
//  fLoadXMLNFe(tabConfiguracoes,[txTodos],false,wFilename);
//  pDataFiltro;
//  DaoObjetoXML.fFiltraOrdena(ffDATAALTERACAO,obyASCENDENTE,'Dataalteracao', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
end;

procedure TfoPrincipal.btnProcessaEnvioClick(Sender: TObject);
begin
//  if fLoadXMLNFe(tabConfiguracoes,[txNFE_EnvLote],True) then
//  begin
//   pDataFiltro;
//   DaoObjetoXML.fFiltraOrdena(ffDATAALTERACAO,wLastOrderBy,'Dataalteracao', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date, '','');
//  end;
end;

procedure TfoPrincipal.btnProcRetornoClick(Sender: TObject);
begin
  if wRotinas.fLoadXMLNFe(tabConfiguracoes,txRet_Sai,True)> 0 then
  begin
    pDataFiltro;
    DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,wLastOrderBy,CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
  end;
end;

procedure TfoPrincipal.btnSIMULACAOClick(Sender: TObject);
var wProcess: integer;
begin
  foXMLSimulcao := TfoXMLSimulcao.Create(Application);
  try
    wProcess:= wRotinas.fNumProcessThreads;
    foXMLSimulcao.ShowModal;
    pDataFiltro;
    DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,wLastOrderBy,CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
    LastColunm := dbgNfebkp.SelectedIndex;
  finally
    foXMLSimulcao.Free;
  end;
end;

procedure TfoPrincipal.btnXMLEnvioExtLoteClick(Sender: TObject);
begin
  wRotinas.fLoadXMLNFe(tabConfiguracoes,txNFe_EnvExtLote, True);
  pDataFiltro;
  DaoObjetoXML.pFiltraOrdena(ffDATAALTERACAO,wLastOrderBy,CNPJDOC.Documento,'cnpj', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date,'','');
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

procedure TfoPrincipal.pAtualizaGrid;
begin
  pUpdateCampoCNPJE;
  pDataFiltro;
  DaoObjetoXML.pFiltraOrdena(ffDATAEMISSAO, wLastOrderBy, CNPJDOC.Documento, wLastField, dtpDataFiltroINI.Date, dtpDataFiltroFin.Date);
  dbgNfebkp.Refresh;
  dbgNfebkp.DataSource.DataSet.First;
end;

procedure TfoPrincipal.pDataFiltro;
var y,m,d: word;
begin
  DecodeDate(now,y,m,d);
  dtpDataFiltroINI.DateTime := EncodeDate(y,m,01);
  dtpDataFiltroFin.DateTime := EncodeDate(y,m,DaysInMonth(Now));
end;

procedure TfoPrincipal.pDeleteRowsSelectGrid;
begin
  if dbgNfebkp.SelectedRows.Count > 1 then
  begin
    if wListaSelecionados.Count = 0 then
      pSelecaoChave(wListaSelecionados);

    if MessageDlg('Você está prestes a deletar '+ IntToStr(wListaSelecionados.Count) +' arquivos.'+#10#13+
                   'Confirma ?',
       mtConfirmation, [mbNo, mbYesToAll],0 )= mrYesToAll then
      if wRotinas.fDeleteObjetoXML(wListaSelecionados) then
        dbgNfebkp.Refresh;;
  end
  else
  if dbgNfebkp.SelectedRows.Count = 1 then
  begin
    if MessageDlg('Deseja excluir o XML selecionado ?', mtConfirmation, [mbNo, mbYes],0 ) = mrYes then
      if wRotinas.fDeleteObjetoXML(wListaSelecionados) then
        dbgNfebkp.Refresh;;
  end;
end;

procedure TfoPrincipal.pRotinasProgress(pNomeMetodo: TExecuteMetodo);
begin
  if not Assigned(wRotinas) then
    wRotinas := TRotinas.Create;

  with wRotinas do
  begin
    ExecuteMetodo := pNomeMetodo;

    case pNomeMetodo of
          emLoadXMLNFe: begin
                          statPrincipal.Panels[1].Text := '0.00%';
                        end;

      emExportaLoteXML: begin
                          Lista := wListaSelecionados;
                          statPrincipal.Panels[1].Text := '0.00%';
                        end;

          emExportaPDF: begin
                         Lista := wListaSelecionados;
                        end;

       emSelecionaRows: begin

                        end;

    end;

    OnMax := DoMax;
    OnProgress := DoProgress;
    OnTerminate := DoTerminate;
    wStartTime := Now;
    start;
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

  wLastFieldFiltros := pFieldFiltros;
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
  pSelecaoChave(wListaSelecionados);
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
  if True then


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
      if fValidaCNPJ(wDocDest, true) or fValidCPF(wDocDest, true) then
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

procedure TfoPrincipal.mmConfgDiretoriosClick(Sender: TObject);
begin
  foConexao:= TfoConexao.Create(Application);
try
  foConexao.ShowModal;
finally
  FreeAndNil(foConexao);
end;
end;

procedure TfoPrincipal.pmConfigUsauriosClick(Sender: TObject);
begin
  FoConsUsuario := TfoConsUsuario.Create(Application);
  try
    FoConsUsuario.ShowModal;
    statPrincipal.Panels[0].Text := 'Usuário: '+ tabUsuarios.Usuario;

  finally
    FreeAndNil(FoConsUsuario);
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
  wFetchALL := mmFetchAll.Checked;
end;

procedure TfoPrincipal.pmDeletarTodosClick(Sender: TObject);
var wMsg, wCNPJEmit : string;
begin
  cbbEmpCNPJChange(Sender);
  wMsg := 'Você está prestes a deletar.';
  wCNPJEmit := CNPJDOC.Documento;
  begin
    if wCNPJEmit = '*' then
      wMsg := 'Você está prestes a deletar todos os arquivos.'
    else
    if fValidaCNPJ(wCNPJEmit, true)then
     wMsg := 'Você está prestes a deletar todos os arquivos do CNPJ '+ wCNPJEmit+'.';

    if MessageDlg(wMsg, mtConfirmation, [mbNo, mbYesToAll],0 )= mrYesToAll then
     if wRotinas.fDeleteObjetoXML(wListaSelecionados, CNPJDOC.Documento) then
     begin
       cbbEmpCNPJ.Clear;
     end;
  end;
 dbgNfebkp.Refresh;
end;

procedure TfoPrincipal.pmDelRefazAutTodosClick(Sender: TObject);
begin
  fSelecionaLinhaGrid;
  pSelecaoChave(wListaSelecionados);
  wRotinas.fDeleteObjetoXML(wListaSelecionados);
  if wRotinas.fLoadXMLNFe(tabConfiguracoes,txNFe_EnvExt,true,'','') > 0 then
  begin
    dbgNfebkp.Refresh;
  end;
end;

procedure TfoPrincipal.pmDelTodosSelecionadosClick(Sender: TObject);
begin
  if wListaSelecionados.Count <> dbgNfebkp.SelectedRows.Count then
    pSelecaoChave(wListaSelecionados);

  if dbgNfebkp.SelectedRows.Count = wListaSelecionados.Count then
  begin
    if MessageDlg('Você está prestes a deletar '+ IntToStr(wListaSelecionados.Count) +' arquivos.',
       mtConfirmation, [mbNo, mbYesToAll],0 )= mrYesToAll then
      wRotinas.fDeleteObjetoXML(wListaSelecionados);
  end
  else
  if wListaSelecionados.Count = 1 then
  begin
    if MessageDlg('Deseja excluir o arquivo XML ?', mtConfirmation, [mbNo, mbYes],0 ) = mrYes then
      wRotinas.fDeleteObjetoXML(wListaSelecionados);
  end;

  dbgNfebkp.Refresh;
end;

procedure TfoPrincipal.pmExpTodosClick(Sender: TObject);
begin
  fSelecionaLinhaGrid;
  pSelecaoChave(wListaSelecionados);

  if dbgNfebkp.SelectedRows.Count = wListaSelecionados.Count then
  begin
    pRotinasProgress(emExportaLoteXML);
  end;

end;

procedure TfoPrincipal.pmExpPDFSelecaoClick(Sender: TObject);
var wTotSalvos: integer;
begin
  pSelecaoChave(wListaSelecionados);
  pRotinasProgress(emExportaPDF);
//  wTotSalvos :=  wRotinas.fExportaPDF(wListaSelecionados);
//  if wTotSalvos > 0 then
//  begin
//    if wTotSalvos = wListaSelecionados.Count then
//      ShowMessage(IntToStr(wTotSalvos) + ' Todos PFDs selecionados exportados com sucesso!')
//    else
//    if wTotSalvos > 0 then
//      ShowMessage(IntToStr(wTotSalvos) + ' arquivos de PFDs exportados com sucesso!');
//  end;
end;

procedure TfoPrincipal.pmExpPDFTodosClick(Sender: TObject);
var wTotSalvos: integer;
begin
  fSelecionaLinhaGrid;
  pSelecaoChave(wListaSelecionados);
  pRotinasProgress(emExportaPDF);

//  wTotSalvos :=  wRotinas.fExportaPDF(wListaSelecionados);
//  if (wTotSalvos > 0)then
//  begin
//    if wTotSalvos > wListaSelecionados.Count then
//      ShowMessage(IntToStr(wTotSalvos) + ' Todos PFDs exportados com sucesso!')
//    else
//    if wTotSalvos > 0 then
//       ShowMessage(IntToStr(wTotSalvos) + ' arquivos de PFDs exportados com sucesso!');
//  end;
end;

procedure TfoPrincipal.pmExpSelecaoClick(Sender: TObject);
begin
  if dbgNfebkp.SelectedRows.Count = wListaSelecionados.Count then
    pRotinasProgress(emExportaLoteXML)
end;

procedure TfoPrincipal.dbgNfebkpTitleClick(Column: TColumn);
//var
//  sIndexName: string;
//  oOrdenacao: TIndexOptions;
//  i: smallint;
//begin
//  try
//    // retira a formatação em negrito de todas as colunas
//    for i := 0 to dbgNfebkp.Columns.Count - 1 do
//      dbgNfebkp.Columns[i].Title.Font.Style := [];
//
//    // configura a ordenação ascendente ou descendente
//    if DM_NFEDFE.cdsBkpdfe.IndexName = Column.FieldName + '_ASC' then
//    begin
//      sIndexName := Column.FieldName + '_DESC';
//      oOrdenacao := [ixDescending];
//    end
//    else
//    begin
//      sIndexName := Column.FieldName + '_ASC';
//      oOrdenacao := [];
//    end;
//
//    DM_NFEDFE.cdsBkpdfe.Open;
//
//    // adiciona a ordenação no DataSet, caso não exista
//    if DM_NFEDFE.cdsBkpdfe.IndexDefs.IndexOf(sIndexName) < 0 then
//      DM_NFEDFE.cdsBkpdfe.AddIndex(sIndexName, Column.FieldName, oOrdenacao);
//
//    DM_NFEDFE.cdsBkpdfe.IndexDefs.Update;
//
//    // formata o título da coluna em negrito
//    Column.Title.Font.Style := [fsBold];
//
//    // atribui a ordenação selecionada
//    DM_NFEDFE.cdsBkpdfe.IndexName := sIndexName;
//
//
//
//    DM_NFEDFE.cdsBkpdfe.close;
//    DM_NFEDFE.cdsBkpdfe.Open;
//
//    DM_NFEDFE.cdsBkpdfe.First;
//    dbgNfebkp.Refresh;
//  except
//
//  end;
//end;

var iFirst, iLast: Integer;
    wDataINI, wDataFIN,DtAUX1,DtAUX2 : TDate;
    wValue1, wValue2, wValueAux : string;
    wFieldOrd : TFieldFiltros;
    wFieldFiltro : TFieldFiltros;
begin
  iFirst := 1;
  iLast := dbgNfebkp.DataSource.DataSet.RecordCount;
  wFieldOrd := TConvert<TFieldFiltros>.StrConvertEnum('ff'+Column.FieldName);
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

  if wLastOrderBy = obyNone then
    wLastOrderBy:= obyASCENDENTE;

  wLastField := Column.FieldName;
  DaoObjetoXML.pFiltraOrdena(wFieldOrd,wLastOrderBy,CNPJDOC.Documento,wLastField ,wDataINI, wDataFIN,'','');

  if wLastOrderBy = obyASCENDENTE then
    wLastOrderBy := obyDESCEDENTE
  else
   wLastOrderBy := obyASCENDENTE;

  if wLastColunm >= 0 then
    dbgNfebkp.Columns[wLastColunm].Title.Font.Style := [];

  dbgNfebkp.Columns[Column.Index].Title.Font.Style := [fsBold];
  wLastColunm := Column.Index;

  dbgNfebkp.Refresh;
end;

procedure TfoPrincipal.DoMax(const PMax: Int64);
begin
  statPrincipal.Panels[2].Text := 'Processando!';
  ProgressBar1.Step := 1;
  ProgressBar1.Position := 0;
  ProgressBar1.Max := PMax;
  ProgressBar1.DoubleBuffered := True;
end;

procedure TfoPrincipal.DoProgress(const PText: String; const PNumber: Cardinal);
begin
  ProgressBar1.StepIt;
  statPrincipal.Panels[1].Text := FormatFloat('##0.00%',ProgressBar1.Position / ProgressBar1.Max * 100);
  statPrincipal.Panels[3].Text := Inttostr(PNumber)+' - '+ PText;
end;

procedure TfoPrincipal.DoTerminate(PSender: TObject);
var wMSG: string;
begin
//  Application.MessageBox(PChar('Feito! '),PChar(Format('Processamento concluído em %s',[FormatDateTime('hh:nn:ss',Now - wStartTime)])),MB_ICONINFORMATION);
  statPrincipal.Panels[1].Text := FormatFloat('##0.00%',ProgressBar1.Position / ProgressBar1.Max * 100);
  statPrincipal.Panels[2].Text := 'Concluído!';
  with wRotinas do
  case ExecuteMetodo of
        emLoadXMLNFe: wMSG := Format('Tempo total: %s',[FormatDateTime('hh:nn:ss',Now - wStartTime)]);
        emExportaPDF: wMSG := Format('Total %d de %d Arquivos exportados - Tempo total: %s',[ProgressBar1.Position, ProgressBar1.Max, FormatDateTime('hh:nn:ss',Now - wStartTime)]);
    emExportaLoteXML: wMSG := Format('Tempo total: %s',[FormatDateTime('hh:nn:ss',Now - wStartTime)]);
     emSelecionaRows: begin
                        wMSG := Format('%d / %d Linhas selecionadas - Tempo total: %s',[ProgressBar1.Position,ProgressBar1.Max, FormatDateTime('hh:nn:ss',Now - wStartTime)]);
                      end;
  end;

  statPrincipal.Panels[3].Text := wMSG;
  ProgressBar1.Step := 1;
  ProgressBar1.Position := 0;
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

procedure TfoPrincipal.edConsultaSQLChange(Sender: TObject);
begin
  wValue := Trim(LowerCase(edConsultaSQL.Text));
  if (Length(wValue) = 14) and (fValidaCNPJ(wValue, true)) then
  begin
    edConsultaSQL.Text := wValue;
    edConsultaSQL.SelStart := Length( edConsultaSQL.Text);
  end;

  if (Length(wValue) = 9) and (fValidCPF(wValue, true)) then
  begin
    edConsultaSQL.Text := wValue;
    edConsultaSQL.SelStart := Length( edConsultaSQL.Text);
  end;
end;

procedure TfoPrincipal.edConsultaSQLKeyUp(Sender: TObject; var Key: Word;
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
begin
 if dtpDataFiltroINI.Date > dtpDataFiltroFin.Date then
     dtpDataFiltroFin.Date := dtpDataFiltroINI.Date;

  if dtpDataFiltroINI.Date <= dtpDataFiltroFin.Date then
    DaoObjetoXML.pFiltraOrdena(wLastFieldFiltros, wLastOrderBy, CNPJDOC.Documento,wLastField, dtpDataFiltroINI.Date, dtpDataFiltroFin.Date);
end;

procedure TfoPrincipal.dbgNfebkpColExit(Sender: TObject);
begin
//   if dbgNfebkp.SelectedField.FieldName = dbchkCHECKBOX.DataField then
//     dbchkCHECKBOX.Visible := False
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
var wStream : TStream;
    wFileName, wSTR : String;
    wRow, wStatus : Integer;
    wColor: TColor;

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

    wStatus := DataSource.DataSet.FieldByName('STATUS').AsInteger;
    case wStatus of
     -999: Canvas.Font.Color := clXmlDefeito;
      001: Canvas.Font.Color := clEnvAguard;     //XML Envio aguardando
      004: Canvas.Font.Color := clCancAguard;   //XML Cancelamento Envio aguardando
      100: Canvas.Font.Color := clProcessado;    //XML Envio Processado
      101,
      135: Canvas.Font.Color := clCancProcessado;      //XML Cancel. Processado
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
      pDeleteRowsSelectGrid;
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

procedure TfoPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(wListaSelecionados);
  DM_NFEDFE.conConexaoFD.Connected := false;
end;

procedure TfoPrincipal.FormCreate(Sender: TObject);
var i,k:Integer;
    dts : TDataSet;

 procedure pSetaCores;
 begin
   clCorGrid00 := StrToInt('$D6FEE1'); //Menta suave
   clCorGrid01 := StrToInt('$ffd7e1'); //Algodão-Doce framboesa
   clCorGrid02 := StrToInt('$fdfad0'); //Laranja Cream
   clCorGrid03 := StrToInt('$ffffda'); //Amarelo suave
   clCorGrid04 := StrToInt('$B4D0F7'); //Azul calcinha
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
  if not Assigned(wRotinas) then
    wRotinas := TRotinas.Create;

  DaoObjetoXML.pAtualizaTabela;
  foPrincipal.Caption := 'SOUIS - MAXXML Versão 1.4';
  pSetaCores;
  pIniciaGrid;
//  pProgressBarStyle;

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
  wLastColunm := -1;
  wLastOrderBy := obyNone;

  wListaSelecionados := TStringList.Create;
  pUpdateCampoCNPJE;
  wLastField := 'CNPJ';
  wLastFieldFiltros := ffDATAEMISSAO;
  pMenuFiltroData(wLastFieldFiltros);
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
  pDataFiltro;
  DaoObjetoXML.pFiltraOrdena(ffDATAEMISSAO, wLastOrderBy, CNPJDOC.Documento, wLastField, dtpDataFiltroINI.Date, dtpDataFiltroFin.Date);
  dbgNfebkp.Refresh;
  wFetchALL := mmFetchAll.Checked;
end;

procedure TfoPrincipal.pSalveName(pFieldName: string; var wFileName: string);
begin
  if (pFieldName = 'XMLENVIO')  or ( pFieldName = 'XMLEXTEND') then
   wFileName := 'Env_NFe'+dbgNfebkp.Fields[1].AsString + '.xml';

  if (pFieldName = 'XMLENVIOCANC') or (pFieldName = 'XMLEXTENDCANC' ) then
   wFileName := 'Can_'+dbgNfebkp.Fields[1].AsString + '.xml';
end;

procedure TfoPrincipal.pSelecaoChave(var pLista: TStringList; pAddObjet : boolean = false);
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
            DaoObjetoXML.fConsultaObjXML(wObjXML,['chave']);
            pLista.AddObject(wObjXML.Chave, wObjXML);
          end
          else
          pLista.Add(wObjXML.Chave);
        end;
      end;
    end;
  end;
end;

function TfoPrincipal.fSelecionaLinhaGrid(pSelecao : TSelectRowsGrid = sgTodos; pCNPJ : String = '*'): Int64;
var
 wDataSet : TDataSet;

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
    Result :=0;

    with dbgNfebkp.Datasource.DataSet do
    begin
      Last;
      for wLinha := RecordCount  downto 1 do
      begin
        wRotinas.pProgress('Linha',wLinha);
        Inc(Result,1);
        dbgNfebkp.SelectedRows.CurrentRowSelected := True;
        Prior;
      end;
    end;
  end;


begin
  try
  case pSelecao of
    sgTodos  : begin
                 wDataSet := DM_NFEDFE.Dao.ConsultaSql('select * from LM_BKPDFE');
                 pSelectRows;
               end;

    sgNenhum : begin
                 pRemoveSelTodasLinhas;
               end;


    sgFiltro : begin
                 pSelectRowsFiltro;
               end;
  end;
  finally
//    wDataSet.Free;
  end;
end;

procedure TfoPrincipal.pRemoveSelTodasLinhas;
var
wlLinha: Integer;
begin
//  DaoObjetoXML.fFiltraOrdena(ffDATAALTERACAO,wLastOrderBy,'Dataalteracao', dtpDataFiltroINI.Date, dtpDataFiltroFin.Date);
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
var k : Integer;
    wCNPJ: string;
begin
if Assigned(CNPJDOC) then
  begin
    wLastField := 'CNPJ';
    cbbEmpCNPJ.Clear;
    wListaEmp := Lm_bkpdfe.CNPJDOC.fListaEmpresas;
    wCNPJ := CNPJDOC.Documento;

    if wListaEmp.IndexOf(wCNPJ) < 0 then
      if fValidaCNPJ(wCNPJ) then
         wListaEmp.Add(wCNPJ);

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
    if fValidaCNPJ(wCNPJ, true) then
      cbbEmpCNPJ.ItemIndex := cbbEmpCNPJ.Items.IndexOf('CNPJ: '+ wCNPJ);
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
begin
 foGeraClasse := TfoGeraClasse.Create(Application);
 try
   foGeraClasse.ShowModal;
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
    jopdDirDir := TJvSelectDirectory.Create(Application);
    jopdDirDir.InitialDir := GetCurrentDir;
    jopdDirDir.Title := 'Seleceione o diretório dos Processados.';
    if jopdDirDir.Execute then
      tabConfiguracoes.NFePathProcessado := jopdDirDir.Directory;

    if wRotinas.fLoadXMLNFeLista(wListaSelecionados)then
    begin
      dbgNfebkp.Refresh;
      ShowMessage('Autorizações selecionadas reprocessadas!');
    end;
  end;
end;

procedure TfoPrincipal.pmRefazAutorizacaoTodosClick(Sender: TObject);
var wPathInit : TStringList;
    wPathMAX : string;
    wI : Integer;
    wColumn : TColumn;
begin
   wPathInit := TStringList.Create;
   jopdDirDir := TJvSelectDirectory.Create(Application);
   try
     wPathMAX := ExtractFileDir(ParamStr(0));
     wPathMAX := Copy(wPathMAX, 1, LastDelimiter('\', wPathMAX));
     if FileExists(wPathMAX+'Maxwin.exe') or (FileExists(wPathMAX+'Maxecv.exe')) then
       wPathMAX := wPathMAX + 'DFE\XML\Envio\Processado';

     if DirectoryExists(wPathMAX) then
       jopdDirDir.InitialDir := wPathMAX
     else
       jopdDirDir.InitialDir := GetCurrentDir;

     jopdDirDir.Title := 'Seleceione o diretório dos Processados.';
    if jopdDirDir.Execute then
      wRotinas.InitialDir := jopdDirDir.Directory;

    if (wRotinas.InitialDir = '') OR (NOT DirectoryExists(wRotinas.InitialDir)) then
      exit;

    pRotinasProgress(emLoadXMLNFe);

   finally
     wPathInit.free;
     jopdDirDir.Free;
   end;

end;

procedure TfoPrincipal.pmRefazXMLClick(Sender: TObject);
var wFileName: string;
begin
  wFileName := ExtractFileDir(ParamStr(0));
  wFileName := Copy(wFileName, 1, LastDelimiter('\', wFileName));
  if FileExists(wFileName+'Maxwin.exe') or (FileExists(wFileName+'Maxecv.exe')) then
  begin
    wFileName := wFileName + 'DFE\XML\Envio\Processado';
  end;

  dlgOpenPrinc.Title := 'Escolha o Arquivo XML';
  dlgOpenPrinc.InitialDir := wFileName;
  dlgOpenPrinc.Filter := '*.*XML';

  if dlgOpenPrinc.Execute then
  begin
    tabConfiguracoes.NFePathProcessado := dlgOpenPrinc.FileName;
  end;

  if not Assigned(wRotinas) then
     wRotinas := TRotinas.Create;

 wRotinas.fLoadXMLNFe(tabConfiguracoes,txNFE_Env,true,dlgOpenPrinc.FileName);
end;

procedure TfoPrincipal.pmDescmarcarSelTodosClick(Sender: TObject);
begin
  pRemoveSelTodasLinhas;
end;

procedure TfoPrincipal.mmSelTodosClick(Sender: TObject);
var wI: Integer;
begin
  fSelecionaLinhaGrid;
end;

procedure TfoPrincipal.mmSelTodosExportarClick(Sender: TObject);
begin
  fSelecionaLinhaGrid;
  pSelecaoChave(wListaSelecionados);
  wRotinas.fExportaLoteXML(wListaSelecionados);
end;

procedure TfoPrincipal.mniReconectarClick(Sender: TObject);
var statusCon : string;
begin
//  if ConexaoBD(DM_NFEDFE.conConexaoFD, DM_NFEDFE.fddrfbDriver) then
//   statusCon := 'Conectado'
//  else
//   statusCon := 'Desconecado';

//  statPrincipal.Panels[1].text := statusCon;
end;

procedure TfoPrincipal.pmTrocarUsuarioClick(Sender: TObject);
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

end.

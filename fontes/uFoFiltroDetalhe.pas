unit uFoFiltroDetalhe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadraoForm, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Lm_bkpdfe, uMetodosUteis,System.DateUtils,
  JvExStdCtrls, JvCombobox, JvColorCombo, Vcl.CheckLst, Vcl.Mask, JvExMask,
  JvToolEdit;

type
  TfoFiltroDetalahado = class(TfoPadraoForm)
    pnl1: TPanel;
    edIdf_DocIni: TLabeledEdit;
    edCNPJDest: TLabeledEdit;
    edCNPJEmi: TLabeledEdit;
    lbDataIni: TLabel;
    lbDataFIm: TLabel;
    dtpDataFiltroINI: TDateTimePicker;
    dtpDataFiltroFin: TDateTimePicker;
    btnOK: TBitBtn;
    edIdf_DocFin: TLabeledEdit;
    lbA: TLabel;
    lbA1: TLabel;
    lbTitle: TLabel;
    rgFiltroData: TRadioGroup;
    rbRecebimento: TRadioButton;
    rbAlteracao: TRadioButton;
    rbEmissao: TRadioButton;
    lbStatusIni: TLabel;
    jcbbStatus: TJvCheckedComboBox;
    jcbbOrdena: TJvCheckedComboBox;
    lbOrdena: TLabel;
    procedure dtpDataFiltroINIExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
//    procedure jcbbStatusIniDrawItem(Control: TWinControl; Index: Integer;
//      Rect: TRect; State: TOwnerDrawState);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    procedure pMenuFiltroData(pFieldFiltros: TFieldFiltros);
    procedure pMontaListaStatus;
    procedure pMontaListaOrdenacao;
  public
    { Public declarations }
  end;

TFiltroDetalhado = class(TObject)
private
  FCnpjEmi  : string;
  FCnpjDest : String;
  FDocIni   : Integer;
  FDocFin   : Integer;
  FDataIni  : TDateTime;
  FDataFin  : TDateTime;
  FTipoData : TFieldFiltros;

public
  property CnpjEmi  : string          read  FCnpjEmi   write  FCnpjEmi;
  property CnpjDest : String          read  FCnpjDest  write  FCnpjDest;
  property DocIni   : Integer         read  FDocIni    write  FDocIni;
  property DocFin   : Integer         read  FDocFin    write  FDocFin;
  property DataIni  : TDateTime       read  FDataIni   write  FDataIni;
  property DataFin  : TDateTime       read  FDataFin   write  FDataFin;
  property TipoData : TFieldFiltros   read  FTipoData  write  FTipoData;

  constructor Create overload;
end;

var
  foFiltroDetalahado: TfoFiltroDetalahado;
  wFiltroDetalhado : TFiltroDetalhado;

implementation

uses
  uFoPrincipal;

{$R *.dfm}

{ TFiltroDetalhado }

constructor TFiltroDetalhado.Create;
begin
  FCnpjEmi  := '';
  FCnpjDest := '';
  FDocIni   := 001;
  FDocFin   := 001;
  FDataIni  := 0;
  FDataFin  := 0;
  FTipoData := ffDATAEMISSAO;
end;

procedure TfoFiltroDetalahado.btnOKClick(Sender: TObject);
begin
  inherited;
  DaoObjetoXML.pFiltraOrdena()
end;

//procedure TfoFiltroDetalahado.jcbbStatusIniDrawItem(Control: TWinControl;
//  Index: Integer; Rect: TRect; State: TOwnerDrawState);
//begin
//  inherited;
// with Control as TComboBox do
//  begin
//    case Index of
//      000: begin
//             Canvas.Font.Color := clProcessado; //cbbStatus.Items.Add('Processado');
//           end;
//
//      001: begin
//             Canvas.Brush.Color := clEnvAguard; //cbbStatus.Items.Add('Envio aguardando');
//           end;
//
//      002: begin
//             Canvas.Brush.Color := clCancAguard; //cbbStatus.Items.Add('Canc. envio aguard.');
//           end;
//
//      003: begin
//             Canvas.Brush.Color := clCancProcessado; //cbbStatus.Items.Add('Canc. Processado');
//           end;
//
//      004: begin
//             Canvas.Brush.Color := clDenegada; //cbbStatus.Items.Add('Denegada');
//           end;
//
//      005: begin
//             Canvas.Brush.Color := clInutilizada; //cbbStatus.Items.Add('Inutilizada');
//           end;
//
//      006: begin
//            Canvas.Brush.Color := clXmlDefeito; //cbbStatus.Items.Add('Xml Defeito');
//           end;
//
//      007: begin
//             Canvas.Brush.Color := clNaoIdent; //cbbStatus.Items.Add('Não identificado');
//           end;
//    end;
//    //pintar a barra
////    Canvas.Brush.Color := TColor(Colors[Index]) ;
//    //pintar a fonte
////    Canvas.Font.Color := TColor(Colors[Index]);
//    Canvas.FillRect(Rect) ;
//    Canvas.TextOut(Rect.Left,Rect.Top,TComboBox(Control).Items[Index]);
//  end;
//end;

procedure TfoFiltroDetalahado.dtpDataFiltroINIExit(Sender: TObject);
var y,m,d: word;
    wDateIni : Tdate;
begin
  DecodeDate(dtpDataFiltroINI.DateTime,y,m,d);
  dtpDataFiltroFin.DateTime := EncodeDate(y,m,DaysInMonth(dtpDataFiltroINI.Date));
end;

procedure TfoFiltroDetalahado.pMenuFiltroData(pFieldFiltros: TFieldFiltros);

 procedure pCheck(pEmissao, pAlterecao, pReceb:boolean);
 begin
  rbEmissao.Checked     := pEmissao;
  rbAlteracao.Checked   := pAlterecao;
  rbRecebimento.Checked := pReceb;
 end;
begin

  case pFieldFiltros of

       ffDATARECTO   : pCheck(false, false, True);
     ffDATAEMISSAO   : pCheck(true, false, false);
   ffDATAALTERACAO   : pCheck(false, true, false);
  end;
end;
procedure TfoFiltroDetalahado.pMontaListaOrdenacao;
var I: Integer;
begin
   for I := 0 to foPrincipal.dbgNfebkp.Columns.Count-1 do


end;

procedure TfoFiltroDetalahado.pMontaListaStatus;
begin
   jcbbStatus.Clear;
   jcbbStatus.Items.Add('Processado');
   jcbbStatus.Items.Add('Envio aguardando');
   jcbbStatus.Items.Add('Canc. envio aguard.');
   jcbbStatus.Items.Add('Canc. processado');
   jcbbStatus.Items.Add('Denegada');
   jcbbStatus.Items.Add('Inutilizada');
   jcbbStatus.Items.Add('Xml Defeito');
   jcbbStatus.Items.Add('Não identificado');
   jcbbStatus.Items.Add('Todos');
end;

procedure TfoFiltroDetalahado.FormCreate(Sender: TObject);
begin
  inherited;
  wFiltroDetalhado := TFiltroDetalhado.Create;
end;

procedure TfoFiltroDetalahado.FormShow(Sender: TObject);
begin
  inherited;
  with wFiltroDetalhado do
  begin
    edCNPJEmi.Text := trim(FCnpjEmi);
    edCNPJDest.Text := trim(FCnpjDest);
    pMenuFiltroData(FTipoData);
    edIdf_DocIni.Text := trim(IntToStr(FDocIni));
    edIdf_DocFin.Text := trim(IntToStr(FDocFin));
    dtpDataFiltroINI.DateTime := FDataIni;
    dtpDataFiltroFin.DateTime := FDataFin;
    pMontaListaStatus;
  end;
end;

end.

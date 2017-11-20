unit uFoFiltroDetalhe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadraoForm, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Lm_bkpdfe, uMetodosUteis,System.DateUtils;

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
    procedure dtpDataFiltroINIExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pMenuFiltroData(pFieldFiltros: TFieldFiltros);
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
  end;
end;

end.

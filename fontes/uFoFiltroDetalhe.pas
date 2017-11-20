unit uFoFiltroDetalhe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadraoForm, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foFiltroDetalahado: TfoFiltroDetalahado;

implementation

{$R *.dfm}

end.

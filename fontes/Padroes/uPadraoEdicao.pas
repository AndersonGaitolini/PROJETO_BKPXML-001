unit uPadraoEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmPadraoEdi = class(TForm)
    pnlEdicao: TPanel;
    pnlRodape: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPadraoEdi: TfrmPadraoEdi;

implementation

{$R *.dfm}

procedure TfrmPadraoEdi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

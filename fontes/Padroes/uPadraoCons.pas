unit uPadraoCons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TfrmPadraoCons = class(TForm)
    pnlCadastro: TPanel;
    tlbCadastro: TToolBar;
    ilCadastro: TImageList;
    btnIncluir: TToolButton;
    btnEditar: TToolButton;
    btnExcluir: TToolButton;
    dbnPadraoCad: TDBNavigator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPadraoCons: TfrmPadraoCons;

implementation

{$R *.dfm}

procedure TfrmPadraoCons.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

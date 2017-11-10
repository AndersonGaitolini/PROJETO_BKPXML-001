unit uFoConsultaPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ToolWin, Vcl.ComCtrls, JvExComCtrls, JvToolBar, Vcl.ExtCtrls;

type
  TfoConsultaPadrao = class(TForm)
    pnlCentral: TPanel;
    statMsg: TStatusBar;
    JvToolBar1: TJvToolBar;
    dbgConsulta: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foConsultaPadrao: TfoConsultaPadrao;

implementation

{$R *.dfm}

procedure TfoConsultaPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action := caFree;
end;

end.

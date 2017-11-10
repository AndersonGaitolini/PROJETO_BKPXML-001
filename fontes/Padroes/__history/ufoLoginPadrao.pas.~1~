unit ufoLoginPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TfoLoginPadrao = class(TForm)
    pnl1: TPanel;
    edUsuario: TEdit;
    edSenha: TEdit;
    mmMenuTelaAcesso: TMainMenu;
    btnAcessar: TBitBtn;
    lbUserNome: TLabel;
    lbUSerNivelAcesso: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }

  end;


const

 wMsgClose = 'Deseja mesmo fechar o login?';

implementation



{$R *.dfm}


procedure TfoLoginPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action := caFree;
end;


procedure TfoLoginPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    Perform(Wm_NextDlgCtl,0,0);

  if (Key = #27) then
     if MessageDlg(wMsgClose, mtInformation, mbYesNo,0) = mrYes then
    close;
end;

end.

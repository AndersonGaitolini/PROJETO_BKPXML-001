unit ufoLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufoLoginPadrao, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,uDMnfebkp,Configuracoes, Vcl.ComCtrls,
  uMetodosUteis, Usuarios, Data.DB, Vcl.Imaging.jpeg;

type
  TfoLogin = class(TfoLoginPadrao)
    btnCancelar: TBitBtn;
    lbSenha: TLabel;
    lbMAXXML: TLabel;
    img1: TImage;
    lb1: TLabel;
    btnConfig: TBitBtn;
    procedure btnAcessarClick(Sender: TObject);
    procedure edSenhaExit(Sender: TObject);
    procedure edUsuarioExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
  private
    { Private declarations }
    statusCon : string;
  public
    { Public declarations }
    wObjUsuarios : TUsuarios;
  published

  end;

var
  foLogin: TfoLogin;

implementation

uses
  uFoConexao;

{$R *.dfm}

procedure TfoLogin.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfoLogin.btnConfigClick(Sender: TObject);
begin
  inherited;
    foConexao := TfoConexao.Create(Application);
  try
    foConexao.ShowModal;

    if ConecxaoBD.Conectado then
    begin
      btnConfig.Visible := false;
      lb1.Caption := 'Base de dados: Conectado!';
    end
    else
    begin
      btnConfig.Visible := true;
      lb1.Caption := 'Base de dados: Desconectado';
    end;
  finally
    FreeAndNil(foConexao);
  end;
end;

procedure TfoLogin.btnAcessarClick(Sender: TObject);
var wSenhaAtual: string;
    wDataSet : TDataSet;

begin
  if not ConecxaoBD.Conectado then
  begin
    ShowMessage('Verifique a conexão com a base de dados.');
    Exit;
  end;


  if not Assigned(tabUsuarios) then
    Exit;

  wDataSet := TDataSet.Create(Application);
  wSenhaAtual := uMetodosUteis.fSenhaAtual('');
  if ((tabUsuarios.Senha = wSenhaAtual) and (Trim(LowerCase(tabUsuarios.Usuario)) = 'master'))  then
  begin
    wDataSet := DM_NFEDFE.dao.ConsultaTab(tabUsuarios, ['usuario']);
    if wDataSet.RecordCount = 0 then 
    begin
      tabUsuarios.Id := daoUsuarios.fNextID(tabUsuarios);
      DM_NFEDFE.dao.Inserir(tabUsuarios);
    end
    else 
    if wDataSet.RecordCount = 1 then   
    begin
      if wDataSet.FieldByName('senha').AsString <> wSenhaAtual then
      begin
        tabUsuarios.Senha := wSenhaAtual;
        DM_NFEDFE.dao.Salvar(tabUsuarios, ['Senha','usuario']);
      end;
    end;
  end;

  if daoLogin.fLogar(tabUsuarios) then
  begin
    wObjUsuarios := tabUsuarios;
    ModalResult := mrOk;
  end
  else
  begin
    edUsuario.SetFocus;
    ModalResult := mrNone;
  end;
end;

procedure TfoLogin.edSenhaExit(Sender: TObject);
begin;
   tabUsuarios.senha := Trim(edSenha.Text);
end;

procedure TfoLogin.edUsuarioExit(Sender: TObject);
begin
  tabUsuarios.Usuario := Trim(edUsuario.Text);
end;

procedure TfoLogin.FormCreate(Sender: TObject);
begin
//  statMsg.Panels[0].Text := 'Base de dados:';

  if ConecxaoBD.Conectado then
  begin
    btnConfig.Visible := false;
    lb1.Caption := 'Base de dados: Conectado!';
  end
  else
  begin
    btnConfig.Visible := true;
    lb1.Caption := 'Base de dados: Desconectado';
  end;

  edUsuario.Clear;
  edSenha.Clear;
//  statMsg.Panels[1].Text := statusCon;
  if not Assigned(tabUsuarios) then
    tabUsuarios := TUsuarios.Create;

  if not Assigned(daoLogin) then
    daoLogin := TDaoLogin.Create;
end;

initialization

end.


unit uFoAutoriza;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufoLoginPadrao, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Lm_bkpdfe, Usuarios, uMetodosUteis;

type
  TfoAutoriza = class(TfoLoginPadrao)
    lbSenha: TLabel;
    lbTitulo: TLabel;
    procedure btnAcessarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edUsuarioExit(Sender: TObject);
    procedure edSenhaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    wObjUsuarios : TUsuarios;
    daoUsuarios : TDaoCadUsuario;
    daoLogin    : TDaoLogin;
    evtTelaUsuarios : TEventoTelaUsuario;
    sMsg :string;
  end;

 var
  foAutoriza: TfoAutoriza;

implementation

uses
  uDMnfebkp;

{$R *.dfm}

procedure TfoAutoriza.btnAcessarClick(Sender: TObject);
var wSenhaAtual: string;
    wDataSet : TDataSet;
    AuxStream : TStream;
begin
  if not Assigned(wObjUsuarios) then
    Exit;

  AuxStream := TMemoryStream.Create;
  wDataSet := TDataSet.Create(Application);
  try
    wSenhaAtual := uMetodosUteis.fSenhaAtual('');
    if ((wObjUsuarios.Senha = wSenhaAtual) and (Trim(LowerCase(wObjUsuarios.Usuario)) = 'master'))  then
    begin
      wDataSet := DM_NFEDFE.dao.ConsultaTab(wObjUsuarios, ['usuario']);
      if wDataSet.RecordCount = 0 then
      begin
        wObjUsuarios.Id := daoUsuarios.fNextID(wObjUsuarios);
        DM_NFEDFE.dao.Inserir(wObjUsuarios);
      end
      else
      if wDataSet.RecordCount = 1 then
      begin
        if wDataSet.FieldByName('senha').AsString <> wSenhaAtual then
        begin
          wObjUsuarios.Senha := wSenhaAtual;
          DM_NFEDFE.dao.Salvar(wObjUsuarios, ['Senha','usuario']);
        end;
      end;
    end;

    if daoLogin.fLogar(wObjUsuarios) then
    begin
      sMsg := 'Delete no banco de dados por '+ wObjUsuarios.Usuario;
      if not (Assigned(wObjUsuarios.LoggerUser)) then
        wObjUsuarios.LoggerUser := TMemoryStream.Create;

      LogStream(wObjUsuarios.Usuario, GetCurrentDir,sMsg,AuxStream);
      wObjUsuarios.LoggerUser.Read(AuxStream, SizeOf(AuxStream));
      DM_NFEDFE.Dao.Salvar(wObjUsuarios, ['Senha','usuario','loggeruser']);
      ModalResult := mrOk;
    end
    else
    begin
      edUsuario.SetFocus;
      ModalResult := mrNone;
    end;
  finally
    FreeandNil(AuxStream);
  end;
end;

procedure TfoAutoriza.edSenhaExit(Sender: TObject);
begin
//  inherited;
  wObjUsuarios.senha := Trim(edSenha.Text);
end;

procedure TfoAutoriza.edUsuarioExit(Sender: TObject);
begin
//  inherited;
  wObjUsuarios.Usuario := Trim(edUsuario.Text);
end;

procedure TfoAutoriza.FormCreate(Sender: TObject);
begin
  wObjUsuarios := TUsuarios.Create;
end;

procedure TfoAutoriza.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;
  if key = VK_ESCAPE then
  begin
    if MessageDlg('Deseja sair?', mtConfirmation, mbYesNo,0) = mrYes then
    begin
     ModalResult := mrCancel;
     Close;
    end;
  end
end;

end.

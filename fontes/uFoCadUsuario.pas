unit uFoCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufoLoginPadrao, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB;

type
  TfoCadUsuario = class(TfoLoginPadrao)
    edSenha2: TEdit;
    lb1: TLabel;
    lb2: TLabel;
    btnAplicar: TBitBtn;
    btnCancelar: TBitBtn;
    btnOK: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnAplicarClick(Sender: TObject);
    procedure edSenha2Exit(Sender: TObject);
    procedure edUsuarioExit(Sender: TObject);
    procedure edSenhaExit(Sender: TObject);
  private
    { Private declarations }
    function fValidaCampos(pSender : TObject): boolean;
  public
    { Public declarations }
  end;

var
  foCadUsuario: TfoCadUsuario;
  wOk : Boolean;

implementation

uses
  uMetodosUteis, Usuarios, uDMnfebkp, Configuracoes;

{$R *.dfm}

procedure TfoCadUsuario.btnAplicarClick(Sender: TObject);
begin
  inherited;
  if wOk and fValidaCampos(Sender) then
  case wOpe of

    opAlterar:begin
                btnOK.Enabled := DM_NFEDFE.Dao.Salvar(tabUsuarios) = 1;
                btnAplicar.Enabled := NOT (btnOK.Enabled)
              end;

    opInserir: begin
                  tabUsuarios.Id := daoUsuarios.fNextID(tabUsuarios);
                  btnOK.Enabled := DM_NFEDFE.Dao.Inserir(tabUsuarios) = 1;
                  btnAplicar.Enabled := NOT (btnOK.Enabled)
               end;
  end;

end;

procedure TfoCadUsuario.edSenha2Exit(Sender: TObject);
begin
  inherited;

   if (Trim(edSenha.Text) <> Trim(edSenha2.Text))then
   begin
     ShowMessage('Senhas não conferem!');
     if edSenha.CanFocus then
       edSenha.SetFocus;
      edSenha.Clear;
      edSenha2.Clear;
   end;

   wOk := (edSenha2.Text <> '');
   if not wOk then
   begin

     ShowMessage('Preencha campo senha de confirmação.');
     if edSenha2.CanFocus then
       edSenha2.SetFocus;
   end
   else
   begin
     btnAplicar.Enabled := True;
     btnOK.Enabled := True;
   end;

end;

procedure TfoCadUsuario.edSenhaExit(Sender: TObject);
begin
  inherited;
  wOk :=  Trim(edSenha.Text) <> '';
  if not wOk then
  begin
    ShowMessage('Preencha o campo senha!');
    if edSenha.CanFocus then
     edSenha.SetFocus;
  end;

end;

procedure TfoCadUsuario.edUsuarioExit(Sender: TObject);
begin
  inherited;
  wOk :=  Trim(edUsuario.Text) <> '';
  if not wOk then
  begin
    ShowMessage('Preencha o campo usuário!');
    if edUsuario.CanFocus then
     edUsuario.SetFocus;
  end;

end;

procedure TfoCadUsuario.FormCreate(Sender: TObject);
var wDataSet : TDataset;
begin
  inherited;
  wDataSet := TDataSet.Create(Application);

  case wOpe of

    opInserir: begin

               end;

    opAlterar: begin
                 wDataSet       := DM_NFEDFE.Dao.ConsultaTab(tabUsuarios, ['id']);
                 edUsuario.Text := wDataSet.FieldByName('Usuario').AsString;
                 edSenha.Text   := wDataSet.FieldByName('senha').AsString;
                 edSenha2.Text  := wDataSet.FieldByName('senha').AsString;
               end;
  end;
end;

function TfoCadUsuario.fValidaCampos(pSender : TObject): boolean;
var i,wTabOrd,iTab : Integer;
    wCampoName, NameComp : string;
begin
   result := True;

   tabUsuarios.Usuario := Trim(edUsuario.Text);
   tabUsuarios.Senha   := Trim(edSenha2.Text);
   tabUsuarios.ConfigSalva :=  tabConfiguracoes.Id;

//  if not Assigned(pSender) then
//  exit;
//
//  for i:= 0 to TfoCadUsuario(pSender).ComponentCount-1 do  //Percorre todos os componentes da tela
//  begin
////    NameComp := (pForm.Components[i]).
//    if TfoCadUsuario(pSender).Components[i] is TEdit then
//    begin
//      with TEdit(TfoCadUsuario(pSender).Components[i]), tabUsuarios do
//      begin
//        wTabOrd := TabOrder;  //Salva o tab order
//        iTab := i;
//        wCampoName := Copy(Name, 3,Length(Name));
//        if Trim(text) = ''  then
//        begin
//           text := 'Preencha  o campo ' + wCampoName ;
//           SelText;
//           if CanFocus then
//             SetFocus;
//           Result := False;
//           Break;
//        end
//        else
//        begin
//          if Name = 'edUsuario' then
//            Usuario := Trim(Text);
//
//          if (Name = 'edSenha2' ) and  (Trim(Text) = edSenha.Text ) then
//           Senha := Trim(text);
//
//        end;
//      end;
//    end;
//  end;
end;

end.

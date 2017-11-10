unit uEditPessoas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadraoEdi, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls,uMetodosUteis;

type
  TfrmPessoasEdi = class(TfrmPadraoEdi)
    statMsg: TStatusBar;
  private
    { Private declarations }
    FdOperacao: TOperacao;
    Fdnome : string;
    function Inserir:Boolean;
    function Editar:Boolean;
    function Deletar: Boolean;
    function Valida: Boolean;
  public
    { Public declarations }
  published
    property Nome: String read Fdnome write FdNome;
    property Operacao: TOperacao read FdOperacao write FdOperacao;
  end;

var
  frmPessoasEdi: TfrmPessoasEdi;

implementation

uses
  uDMPonto;


{$R *.dfm}

{ TfrmPessoasEdi }

function TfrmPessoasEdi.Deletar: Boolean;
begin
 inherited;
 Result := False;
  try
    with dmPonto do
    begin
      SQLFeriados.Close;
      SQLFeriados.SQL.Clear;
      SQLFeriados.SQL.Add('delete from pessoas');
      SQLFeriados.SQL.Add(' where nome = :nome');
      SQLFeriados.ParamByName('nome').AsString := '';
      Result := SQLFeriados.ExecSQL() = 1;
    end;
  except
    on E: Exception do
    begin
      showmessage(E.Message + 'Houve um problema na rotina Deletar pessoas');
    end;
  end;

end;

function TfrmPessoasEdi.Editar: Boolean;
begin
  Result := False;
  try
    with dmPonto do
    begin
      SQLPessoas.Close;
      SQLPessoas.SQL.Clear;
      SQLPessoas.SQL.Add('update pessoas');
      SQLPessoas.SQL.Add(' set :nome');
      SQLPessoas.SQL.Add(' where codigo = :codigo');
      SQLPessoas.ParamByName('codigo').AsInteger := 1;
      Result := SQLPessoas.ExecSQL() = 1;
    end;
  except
    on E: Exception do
    begin
      showmessage(E.Message + 'Houve um problema na rotina Editar Pessoas');
    end;
  end;
end;

function TfrmPessoasEdi.Inserir: Boolean;
begin
  Result := False;
  try
    with dmPonto do
    begin
      SQLPessoas.Close;
      SQLPessoas.SQL.Clear;
      SQLPessoas.SQL.Add('Insert into pessoas');
      SQLPessoas.SQL.Add('(nome)');
      SQLPessoas.SQL.Add(' values');
      SQLPessoas.SQL.Add('( :nome)');
      SQLPessoas.ParamByName('nome').AsString := '';
      Result := SQLPessoas.ExecSQL() = 1;
    end;
  except
    on E: Exception do
    begin
      showmessage(E.Message + 'Houve um problema na rotina Inserir pessoas');
    end;
  end;
end;

function TfrmPessoasEdi.Valida: Boolean;
begin
  if FdOperacao = opInserir then
  begin
//  Caption := 'Inclusão de Feriados';
//  if dtpDataFer.CanFocus then
//    dtpDataFer.SetFocus;
  end
  else
  if FdOperacao = opAlterar then
  begin
  Caption := 'Alteração de Pessoas';
//  dtpDataFer.Enabled  := False;
//
//  dtpDataFer.DateTime := FdData;
//  edDescricaoFer.Text := FdDescricao;

//  if edDescricaoFer.CanFocus then
//    edDescricaoFer.SetFocus;
  end
  else
  begin
  Caption := 'Exclusão de Pessoas';
  pnlEdicao.Enabled := False;

//  dtpDataFer.DateTime := FdData;
//  edDescricaoFer.Text := FdDescricao;

  if btnOK.CanFocus then
    btnOK.SetFocus;
  end;
end;

end.

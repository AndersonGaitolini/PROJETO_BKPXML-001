unit uFoConsUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFoConsultaPadrao, Data.DB, Vcl.ToolWin,
  Vcl.ComCtrls, JvExComCtrls, JvToolBar, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList;

type
  TfoConsUsuario = class(TfoConsultaPadrao)
    ilCadastro: TImageList;
    btnInserir: TToolButton;
    btnAlterar: TToolButton;
    btnExcluir: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure pShowTabela;
  public
    { Public declarations }
  end;

var
  foConsUsuario: TfoConsUsuario;

implementation

uses
  uDMnfebkp, Usuarios, uFoCadUsuario, uMetodosUteis;

{$R *.dfm}

procedure TfoConsUsuario.btnAlterarClick(Sender: TObject);
begin
  inherited;
  tabUsuarios.Id := dbgConsulta.Fields[0].AsInteger;
  wOpe := opAlterar;
  foCadUsuario := TfoCadUsuario.Create(Application);
  try
    foCadUsuario.ShowModal;
  finally
    FreeAndNil(foCadUsuario);
  end;
end;

procedure TfoConsUsuario.btnExcluirClick(Sender: TObject);
begin
  inherited;
  foCadUsuario := TfoCadUsuario.Create(Application);
  wOpe := opExcluir;
  dbgConsulta.SelectedIndex;
  daoUsuarios.fExcluir(tabUsuarios);
end;

procedure TfoConsUsuario.btnInserirClick(Sender: TObject);
begin
  inherited;
  tabUsuarios.Id := daoUsuarios.fNextID(tabUsuarios);
  wOpe := opInserir;
  foCadUsuario := TfoCadUsuario.Create(Application);
  try
    foCadUsuario.ShowModal;
    pShowTabela;
    tabUsuarios.Id := dbgConsulta.Fields[0].AsInteger;
  finally
    FreeAndNil(foCadUsuario);
  end;
end;

procedure TfoConsUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  tabUsuarios.Id := dbgConsulta.Fields[0].AsInteger;
  tabUsuarios.ConfigSalva := dbgConsulta.Fields[3].AsInteger;
end;

procedure TfoConsUsuario.FormShow(Sender: TObject);
begin
  inherited;
  pShowTabela;
end;

procedure TfoConsUsuario.pShowTabela;
var wSQL : string;
begin
  try
    with daoUsuarios, DM_NFEDFE do
    begin
      try
        wSQL := '';
        wSQL := wSQL + 'Select * from usuarios order by id asc';
        dsUsuarios.DataSet := Dao.ConsultaSql(wSQL);
        dbgConsulta.Refresh;
      except

      end;
    end;
  finally

  end;
end;

end.

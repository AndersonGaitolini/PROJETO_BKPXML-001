unit uFoConsConfiguracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFoConsultaPadrao, Data.DB,
  Vcl.ComCtrls, Vcl.ToolWin, JvExComCtrls, JvToolBar, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Configuracoes, uDMnfebkp,Usuarios, System.ImageList, Vcl.ImgList,uMetodosUteis,uFoConfiguracao;


type
  TfoConsConfiguracoes = class(TfoConsultaPadrao)
    btnInserir: TToolButton;
    btnAlterar: TToolButton;
    btnExcluir: TToolButton;
    ilCadastro: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbg1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaTitleClick(Column: TColumn);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnLoadIniClick(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure pShowTabela;
    procedure pEnableBotoes(pEnable: Boolean = false);
    procedure pAtualizaGrid;
  public
    { Public declarations }
  published
  end;

var
  LastColunm  : Integer;
  foConsConfiguracoes: TfoConsConfiguracoes;

implementation


{$R *.dfm}

{Eventos do form}
procedure TfoConsConfiguracoes.pAtualizaGrid;
var DataSetAux : TDataSet;
begin
  DataSetAux := TDataSet.Create(Application);
  try
  with daoConfiguracoes, DM_NFEDFE do
  begin
    DataSetAux := Dao.ConsultaAll(tabConfiguracoes, 'id');
    dsConfiguracoes.DataSet := DataSetAux;
    dbgConsulta.Refresh;
  end;
  finally
//    FreeAndNil(DataSetAux);
  end;
end;

procedure TfoConsConfiguracoes.pEnableBotoes(pEnable: Boolean);
begin
  btnInserir.Enabled := pEnable;
  btnAlterar.Enabled := pEnable;
  btnExcluir.Enabled := pEnable;
end;

procedure TfoConsConfiguracoes.btnInserirClick(Sender: TObject);
begin
  inherited;

  statMsg.Panels[1].Text := 'Inserindo um Registro';

  foConfiguracao := TfoConfiguracao.Create(Application);
  try
    wOpe := opInserir;
    tabConfiguracoes.IDusuario := tabUsuarios.Id;
    foConfiguracao.ShowModal;

    pAtualizaGrid;
  finally
    foConfiguracao.Free;
  end;

end;

procedure TfoConsConfiguracoes.btnLoadIniClick(Sender: TObject);
begin
  inherited;
 // LoadIniFile
end;

procedure TfoConsConfiguracoes.dbgConsultaDblClick(Sender: TObject);
begin
  inherited;
  tabConfiguracoes.Id := DM_NFEDFE.cdsConfiguracoes.FieldByName('id').AsInteger;
  tabUsuarios.ConfigSalva := tabConfiguracoes.Id;
  DM_NFEDFE.Dao.Salvar(tabUsuarios, ['ConfigSalva']);
  Close;
end;

procedure TfoConsConfiguracoes.btnAlterarClick(Sender: TObject);
begin
  inherited;
//  if evtTelaUsuarios = etuEditar then
  begin
    if dbgConsulta.DataSource.DataSet.IsEmpty then
    begin
      statMsg.Panels[1].Text := 'Selecione um Registro';
      exit
    end;
    foConfiguracao := TfoConfiguracao.Create(Application);
    try
      wOpe := opAlterar;
      tabConfiguracoes.Id := DM_NFEDFE.cdsConfiguracoes.FieldByName('id').AsInteger;
      daoConfiguracoes.fCarregaConfiguracoes(tabConfiguracoes,['id']);
      foConfiguracao.ShowModal;

      pAtualizaGrid;
    finally
      foConfiguracao.Free;
    end;
//  end
//  else
//  if evtTelaUsuarios = etuConsultar then
//  begin
    tabConfiguracoes.Id := DM_NFEDFE.cdsConfiguracoes.FieldByName('id').AsInteger;
    tabUsuarios.ConfigSalva := tabConfiguracoes.Id;
    DM_NFEDFE.Dao.Salvar(tabUsuarios, ['ConfigSalva']);
    Close;
  end;
end;

procedure TfoConsConfiguracoes.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if DM_NFEDFE.cdsConfiguracoes.IsEmpty then
  begin
    statMsg.Panels[1].Text := 'Selecione um Registro';
    exit
  end;

  try
    wOpe := opExcluir;
    tabConfiguracoes.Id := DM_NFEDFE.cdsConfiguracoes.FieldByName('id').AsInteger;

    if MessageDlg('Deseja excluir esta configuração', mtConfirmation, mbYesNo,0) = mrNo then
      exit
    else
      if daoConfiguracoes.fExcluirConfiguracoes(tabConfiguracoes) then
        statMsg.Panels[1].Text := 'Exclusão ok';

    pShowTabela;
//    foConfiguracao.ShowModal;
  finally
//    foConfiguracao.Free;
  end;
end;

procedure TfoConsConfiguracoes.dbg1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  with (Sender as TDBGrid).Canvas do
  begin
    if (gdSelected in State) then
    begin
     Brush.Color := cl3DLight;
     FillRect(Rect);
     Font.Color:= clBlue;
     TextOut(Rect.Left, Rect.Top,Column.Field.AsString);
    end;
  end;
  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfoConsConfiguracoes.dbgConsultaTitleClick(Column: TColumn);
var wSQL :string;
   wIdUsu: integer;
   tipoOrdDesc : boolean;
begin
  inherited;
  with DM_NFEDFE do
  begin
    tipoOrdDesc := LastColunm = Column.Index;
    try
      wIdUsu := tabUsuarios.Id;
      wSql := 'Select * from configuracoes';
      wSql := wSql + ' where idusuario = '+IntToStr(wIdUsu);

      if tipoOrdDesc then
        wSql := wSql + ' order by  '+ Column.FieldName +' Desc'
      else
        wSql := wSql + ' order by ' + Column.FieldName+' Asc';

      dsConfiguracoes.DataSet := dao.ConsultaSql(wSql);
    except
      on E: Exception do
      begin
        showmessage(E.Message + 'Houve um problema na rotina dbgConsultaTitleClick(fieldbyname)');
      end;
    end;

    if LastColunm > 0 then
    begin
      dbgConsulta.Columns[LastColunm].Title.Font.Style := [];
      dbgConsulta.Columns[LastColunm].Title.Font.Color := clBlue;
    end;

   dbgConsulta.Columns[Column.Index].Title.Font.Style := [fsBold];
   dbgConsulta.Columns[LastColunm].Title.Font.Color := clBlack;
   LastColunm := Column.Index;

  end;
end;

procedure TfoConsConfiguracoes.FormCreate(Sender: TObject);
begin
  inherited;
  if not Assigned(tabConfiguracoes) then
    tabConfiguracoes.Create;

  LastColunm       := -1;
end;

procedure TfoConsConfiguracoes.FormShow(Sender: TObject);
begin
  inherited;
  pShowTabela;
  case evtTelaUsuarios of
    etuEditar : pEnableBotoes(True);
    etuConsultar : pEnableBotoes(False);
  end;
end;

{Métodos do form}
procedure TfoConsConfiguracoes.pShowTabela;
begin
  try
    with daoConfiguracoes, DM_NFEDFE do
    begin
      tabConfiguracoes.IDusuario := tabUsuarios.ID;
      dsConfiguracoes.DataSet :=  Dao.ConsultaTab(tabConfiguracoes,['idusuario']);
      dbgConsulta.Refresh;
    end;
  except

  end;
end;
end.

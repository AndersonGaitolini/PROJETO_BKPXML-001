unit uFoConfigPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, JvBaseDlg, JvSelectDirectory,
  uMetodosUteis,
  Configuracoes,
  Vcl.ToolWin,
  JvExComCtrls,
  JvToolBar,
  System.ImageList,
  Vcl.ImgList,
  Vcl.DBCtrls,
  uDMnfebkp,Usuarios,uFoPrincipal,
  Data.DB, Datasnap.DBClient,Datasnap.Provider, Atributos, ConfigPadrao,
  Vcl.Menus;

type

  TfoConfigPadrao = class(TForm)
    pnlConfig: TPanel;
    pgcConfig: TPageControl;
    tsConfigBD: TTabSheet;
    btnGetDirBanco: TSpeedButton;
    edUsuarioBD: TLabeledEdit;
    edSenhaBD: TLabeledEdit;
    edArquivo: TLabeledEdit;
    tsConfigNFe: TTabSheet;
    edNFePathEnvio: TLabeledEdit;
    edNFePathProcessado: TLabeledEdit;
    edNFePathRejeitado: TLabeledEdit;
    edNFePathRetornoLido: TLabeledEdit;
    edNFePathPDFSalvo: TLabeledEdit;
    btnOpen1: TBitBtn;
    btnOpen2: TBitBtn;
    btnOpen3: TBitBtn;
    btnOpen4: TBitBtn;
    btnOpen5: TBitBtn;
    tsConfigNFCe: TTabSheet;
    edNFCePathEnvio: TLabeledEdit;
    edNFCePathProcessado: TLabeledEdit;
    edNFCePathPDFSalvo: TLabeledEdit;
    btnOpenNFCe1: TBitBtn;
    btnOpenNFCe2: TBitBtn;
    btnOpenNFCe3: TBitBtn;
    btnOpenNFCe4: TBitBtn;
    btnOpenNFCe5: TBitBtn;
    tsConfigNFSe: TTabSheet;
    edNFSePathEnvio: TLabeledEdit;
    edNFSePathProcessado: TLabeledEdit;
    edNFSePathRejeitado: TLabeledEdit;
    edNFSePathPDFSalvo: TLabeledEdit;
    btnOpenNFSe1: TBitBtn;
    btnOpenNFSe2: TBitBtn;
    btnOpenNFSe3: TBitBtn;
    btnOpenNFSe4: TBitBtn;
    btnOpenNFSe5: TBitBtn;
    dlgOpenDir: TOpenDialog;
    ilCadastro: TImageList;
    statMSg: TStatusBar;
    pnlRodape: TPanel;
    btn2: TBitBtn;
    btnOK: TBitBtn;
    pnlMenu: TPanel;
    jtobMenuConfig: TJvToolBar;
    btnAplicar: TBitBtn;
    edDescriConfig: TLabeledEdit;
    btn3: TToolButton;
    jopdOpenDir: TJvSelectDirectory;
    edNFSePathRetornoLido: TLabeledEdit;
    edNFCePathRejeitado: TLabeledEdit;
    edNFCePathRetornoLido: TLabeledEdit;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOpen1Click(Sender: TObject);
    procedure btnGetDirBancoClick(Sender: TObject);
    procedure btnOpen2Click(Sender: TObject);
    procedure btnOpen3Click(Sender: TObject);
    procedure btnOpen4Click(Sender: TObject);
    procedure btnOpen5Click(Sender: TObject);
    procedure btnOpenNFCe1Click(Sender: TObject);
    procedure btnOpenNFCe2Click(Sender: TObject);
    procedure btnOpenNFCe3Click(Sender: TObject);
    procedure btnOpenNFCe4Click(Sender: TObject);
    procedure btnOpenNFCe5Click(Sender: TObject);
    procedure btnOpenNFSe1Click(Sender: TObject);
    procedure btnOpenNFSe2Click(Sender: TObject);
    procedure btnOpenNFSe3Click(Sender: TObject);
    procedure btnOpenNFSe4Click(Sender: TObject);
    procedure btnOpenNFSe5Click(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAplicarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edDescriConfigExit(Sender: TObject);
    procedure edUsuarioBDExit(Sender: TObject);
    procedure edSenhaBDExit(Sender: TObject);
    procedure edArquivoExit(Sender: TObject);
    procedure edNFePathEnvioExit(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure edNFePathProcessadoExit(Sender: TObject);
    procedure edNFePathRejeitadoExit(Sender: TObject);
    procedure edNFePathRetornoLidoExit(Sender: TObject);
    procedure edNFePathPDFSalvoExit(Sender: TObject);
    procedure edNFCePathEnvioExit(Sender: TObject);
    procedure edNFCePathProcessadoExit(Sender: TObject);
    procedure edNFCePathRejeitadoExit(Sender: TObject);
    procedure edNFCePathRetornoLidoExit(Sender: TObject);
    procedure edNFCePathPDFSalvoExit(Sender: TObject);
    procedure edNFSePathEnvioExit(Sender: TObject);
    procedure edNFSePathProcessadoExit(Sender: TObject);
    procedure edNFSePathRejeitadoExit(Sender: TObject);
    procedure NFSePathRetornoLidoNFSePathRetornoLidoExit(Sender: TObject);
    procedure edNFSePathPDFSalvoExit(Sender: TObject);
    procedure edExtInutNFeExit(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure mniAjustarconfiguraopadro1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure edNFSePathRetornoLidoExit(Sender: TObject);
  private
    { Private declarations }
    function validacampos(pForm : TForm): boolean;
    function LimpaCampos(pForm : TForm): boolean;
    procedure SalvarParametros;
    procedure AlteraEditaExcluiConfig;
    procedure LerParametros;
    procedure MsgStatus(pMsg : string; pCor : TColor = clBlack);
    function CarregaConfig(pTab : TConfigPadrao): Boolean; overload;
    procedure FormShowAlterar;
    procedure FormShowInserir;
    procedure FormShowDeletar;

//    function fOpenFileName(pFilter: array of string; pFilterName: array of string;var prFileName:string;pTitle : string = ''): Boolean;
//    function fOpenPath(var prDirectory: string; pTitle : string = ''): Boolean;
    procedure pEnableConfig(pForm : TForm;pEnable: boolean);
    function fCriarConfigPadrao:Boolean;
    procedure EditToTabela;
    procedure TabelaToEdit;
  public
    { Public declarations }
    FUsuarios : TUsuarios;
    ConfigId : integer;
    LastId   : integer;
  published
   property Usuarios : TUsuarios read FUsuarios write FUsuarios;
  end;

var
  foConfigPadrao : TfoConfigPadrao;
  wPathAux: string;
  SavStr : String;
implementation


{$R *.dfm}

procedure TfoConfigPadrao.AlteraEditaExcluiConfig;
begin
  if wOpe = opNil then
    exit;

  with daoConfigPadrao, tabConfigPadrao do
  begin
    case wOpe of
      opExcluir: begin
                   if MessageDlg('Deseja excluir a configuração '+ DescriConfig, mtConfirmation, mbYesNo,0) = mrYes then
                     if fExcluirConfigPadrao(tabConfigPadrao) then
                     begin
                       statMSg.Panels[1].Text := 'Deletado!';
                       ModalResult := mrOK;
                       wOpe := opOK;
                     end;
                  end;

      opAlterar: begin
                   if fSalvarConfigPadrao(tabConfigPadrao) then
                   begin
                     statMSg.Panels[1].Text := 'Salvo!';
                     ModalResult := mrOK;
                     wOpe := opOK;
                   end;
                 end;

      opInserir: begin

                   if fInserirConfigPadrao(tabConfigPadrao) > 0 then
                   begin
                     statMSg.Panels[1].Text := 'Novo registo!';
                     ModalResult := mrOK;
                     wOpe := opOK;
                   end;
                 end;
    end;
  end;
end;

procedure TfoConfigPadrao.btn1Click(Sender: TObject);
begin
  if CarregaConfig(tabConfigpadrao) then
    MsgStatus('Configuração Padrão', clRed);
end;

procedure TfoConfigPadrao.btn2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfoConfigPadrao.btn3Click(Sender: TObject);
begin
  LimpaCampos(foConfigPadrao);
  fCriarConfigPadrao;
end;

procedure TfoConfigPadrao.btnAplicarClick(Sender: TObject);
begin
  if Validacampos(foConfigPadrao) then
  begin
    AlteraEditaExcluiConfig;
  end;
end;

procedure TfoConfigPadrao.btnOKClick(Sender: TObject);
begin

  if wOpe = opOK then
     ModalResult := mrOk
end;

procedure TfoConfigPadrao.btnEditarClick(Sender: TObject);
begin
  pgcConfig.Enabled := true;
  pnlRodape.Enabled := false;
  statMSg.Panels[1].Text := 'Alterando!';

end;

procedure TfoConfigPadrao.btnExcluirClick(Sender: TObject);
begin
  wOpe := opExcluir;
  pEnableConfig(foConfigPadrao, false);
end;

procedure TfoConfigPadrao.btnGetDirBancoClick(Sender: TObject);
begin
  if fOpenFileName(wPathAux, 'Aponte o seu banco de dados', [ ' Todos | *.*', 'FDB | *.*fdb'],0) then
 begin
   edArquivo.Text := wPathAux;
   tabConfiguracoes.PathBD := wPathAux;
 end;
end;

procedure TfoConfigPadrao.btnInserirClick(Sender: TObject);
begin
  statMSg.Panels[1].Text := 'Inserindo!';
end;


procedure TfoConfigPadrao.btnOpen1Click(Sender: TObject);
begin
 if fOpenPath(wPathAux) then
 begin
   edNFePathEnvio.Text := wPathAux;
   tabConfiguracoes.NFePathEnvio := wPathAux;
 end;
end;

procedure TfoConfigPadrao.btnOpen2Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFePathProcessado.Text := wPathAux;
    tabConfiguracoes.NFePathProcessado := wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpen3Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFePathRejeitado.Text := wPathAux;
    tabConfiguracoes.NFePathRejeitado := wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpen4Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFePathRetornoLido.Text := wPathAux;
    tabConfiguracoes.NFePathRetornoLido := wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpen5Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFePathPDFSalvo.Text := wPathAux;
    tabConfiguracoes.NFePathPDFSalvo := wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpenNFCe1Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFCePathEnvio.Text := wPathAux;
    tabConfiguracoes.NFCePathEnvio := wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpenNFCe2Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFCePathProcessado.Text := wPathAux;
    tabConfiguracoes.NFCePathRejeitado := wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpenNFCe3Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFCePathRejeitado.Text := wPathAux;
    tabConfiguracoes.NFCePathProcessado := wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpenNFCe4Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFCePathRetornoLido.Text := wPathAux;
    tabConfiguracoes.NFCePathRetornoLido := wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpenNFCe5Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFCePathPDFSalvo.Text := wPathAux;
    tabConfiguracoes.NFCePathPDFSalvo := wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpenNFSe1Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFSePathEnvio.Text := wPathAux;
    tabConfiguracoes.NFSePathEnvio:= wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpenNFSe2Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFSePathProcessado.Text := wPathAux;
    tabConfiguracoes.NFSePathProcessado:= wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpenNFSe3Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFSePathRejeitado.Text := wPathAux;
    tabConfiguracoes.NFSePathRejeitado:= wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpenNFSe4Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFSePathRetornoLido.Text := wPathAux;
    tabConfiguracoes.NFSePathRetornoLido:= wPathAux;
  end;
end;

procedure TfoConfigPadrao.btnOpenNFSe5Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFSePathPDFSalvo.Text := wPathAux;
    tabConfiguracoes.NFSePathPDFSalvo:= wPathAux;
  end;
end;

function TfoConfigPadrao.CarregaConfig(pTab: TConfigPadrao): Boolean;
begin
  Result := false;
  try
    try
      pTab.IDusuario := 0;
      with pTab do
      begin
        daoConfigPadrao.fCarregaConfigPadrao(pTab, ['id']);
        TabelaToEdit;
        Result := true;
      end;
    except

    end;
  finally
  end;
end;


procedure TfoConfigPadrao.edArquivoExit(Sender: TObject);
var bdPath, bdSource :string;
begin

  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if PathBD+'\'+NameBD <> Text then
    begin
      PathBD := ExtractFileDir(Trim(Text));
      NameBD := ExtractFileName(Trim(Text));
    end;

//    ShowHint := False;
//    if Length(Text) > 255  then
//      if CanFocus then
//      begin
//        Hint := 'Este campo pode ter no máximo 255 caracteres.';
//        ShowHint := true;
//        SetFocus;
//      end;

   if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;

  pgcConfig.TabIndex := 1;
end;

procedure TfoConfigPadrao.edDescriConfigExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if DescriConfig <> Text then
    begin
      DescriConfig := Trim(Text);
    end;

    ShowHint := False;
    if Length(Text) > 20  then
      if CanFocus then
      begin
        Hint := 'Este campo pode ter no máximo 20 caracteres.';
        ShowHint := true;
        SetFocus;
      end;
  end;
end;

procedure TfoConfigPadrao.edExtInutNFeExit(Sender: TObject);
begin

  pgcConfig.TabIndex := 2;
end;

procedure TfoConfigPadrao.EditToTabela;
begin
  if NOT Assigned(tabConfigpadrao) then
    exit;

  with tabConfigpadrao do
  begin
   UsuarioBD          := edUsuarioBD.Text;
   SenhaBD            := edSenhaBD.Text;
   PathBD             := ExtractFileDir(edArquivo.Text);
   NameBD            := ExtractFileName(edArquivo.Text);
                         //Aba Configura NFe
   NFePathEnvio          := edNFePathEnvio.Text;
   NFePathProcessado      := edNFePathProcessado.Text;
   NFePathRejeitado      := edNFePathRejeitado.Text;
   NFePathRetornoLido     := edNFePathRetornoLido.Text;
   NFePathPDFSalvo       := edNFePathPDFSalvo.Text;

                         //Aba Configura NFCe
   NFCePathEnvio       := edNFCePathEnvio.Text;
   NFCePathRejeitado     := edNFCePathRejeitado.Text;
   NFCePathProcessado     := edNFCePathProcessado.Text;
   NFCePathRetornoLido    := edNFCePathRetornoLido.Text;
   NFCePathPDFSalvo    := edNFCePathPDFSalvo.Text;

                         //Aba Configura NFSe
   NFSePathEnvio       := edNFSePathEnvio.Text;
   NFSePathProcessado     := edNFSePathProcessado.Text;
   NFSePathRejeitado     := edNFSePathRejeitado.Text;
   NFSePathRetornoLido    := edNFSePathRetornoLido.Text;
   NFSePathPDFSalvo    := edNFSePathPDFSalvo.Text;
  end;
end;

procedure TfoConfigPadrao.edNFCePathProcessadoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFCePathRejeitado <> Text then
    begin
      NFCePathRejeitado := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFCePathEnvioExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFCePathEnvio <> Text then
    begin
      NFCePathEnvio := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFePathProcessadoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFePathProcessado <> Text then
    begin
      NFePathProcessado := Trim(Text);
    end;

//    ShowHint := False;
//    if Length(Text) > 255  then
//      if CanFocus then
//      begin
//        Hint := 'Este campo pode ter no máximo 255 caracteres.';
//        ShowHint := true;
//        SetFocus;
//      end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFePathEnvioExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFePathEnvio <> Text then
    begin
      NFePathEnvio := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFSePathProcessadoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFSePathProcessado <> Text then
    begin
      NFSePathProcessado := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFSePathEnvioExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFSePathEnvio <> Text then
    begin
      NFSePathEnvio := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFCePathRetornoLidoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFCePathRetornoLido <> Text then
    begin
      NFCePathRetornoLido := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFePathRetornoLidoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFePathRetornoLido <> Text then
    begin
      NFePathRetornoLido := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.NFSePathRetornoLidoNFSePathRetornoLidoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFSePathRetornoLido <> Text then
    begin
      NFSePathRetornoLido := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFCePathRejeitadoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFCePathProcessado <> Text then
    begin
      NFCePathProcessado := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFePathRejeitadoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFePathRejeitado <> Text then
    begin
      NFePathRejeitado := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFSePathRejeitadoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFSePathRejeitado <> Text then
    begin
      NFSePathRejeitado := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFSePathRetornoLidoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFSePathRetornoLido <> Text then
    begin
      NFSePathRetornoLido := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFCePathPDFSalvoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFCePathPDFSalvo <> Text then
    begin
      NFCePathPDFSalvo := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFePathPDFSalvoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFePathPDFSalvo <> Text then
    begin
      NFePathPDFSalvo := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edNFSePathPDFSalvoExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if NFSePathPDFSalvo <> Text then
    begin
      NFSePathPDFSalvo := Trim(Text);
    end;

    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;
end;

procedure TfoConfigPadrao.edSenhaBDExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if SenhaBD <> Text then
    begin
      SenhaBD := Trim(Text);
    end;

    ShowHint := False;
    if Length(Text) > 10  then
      if CanFocus then
      begin
        Hint := 'Este campo pode ter no máximo 10 caracteres.';
        ShowHint := true;
        SetFocus;
      end;
  end;
end;

procedure TfoConfigPadrao.edUsuarioBDExit(Sender: TObject);
begin
  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if UsuarioBD <> Text then
    begin
      UsuarioBD := Trim(Text);
    end;

    ShowHint := False;
    if Length(Text) > 15  then
      if CanFocus then
      begin
        Hint := 'Este campo pode ter no máximo 15 caracteres.';
        ShowHint := true;
        SetFocus;
      end;
  end;
end;

function TfoConfigPadrao.fCriarConfigPadrao: Boolean;
var
  dirAux, dirBD, dirEnvio, dirRetorno, dirRetEnv, dirRetCan, dirRetInu :string;

 procedure DiretorioBD;
 begin

  pgcConfig.TabIndex :=  tsConfigBD.TabIndex;
  edDescriConfig.Text    := fNomePC;
  edUsuarioBD.Text       := 'sysdba';
  edSenhaBD.Text         := 'masterkey';
  //    pOpenFileName(['*.fdb'],['Firebird'], dirAux, 'Aponte o seu banco de dados');
  dirBD := dirAux+'\bd';
  if not DirectoryExists(dirBD) then
    ForceDirectories(dirBD);

  edArquivo.Text := dirBD;
 end;

 procedure DiretorioNFE;
 begin
   with tabConfigpadrao do
   begin
      pgcConfig.TabIndex := tsConfigNFe.TabIndex;
     //Aba Configura NFe

     dirEnvio := dirAux +'\NFe\Envio';
     if not DirectoryExists(dirEnvio) then
       ForceDirectories(dirEnvio);

     edNFePathEnvio.Text := dirEnvio;

     dirRetorno := dirAux +'\NFe\Retorno';
     if not DirectoryExists(dirRetorno) then
       ForceDirectories(dirRetorno);

     edNFePathProcessado.Text   := dirRetorno;

     dirRetEnv := dirRetorno +'\Enviado';
      if not DirectoryExists(dirRetEnv) then
        ForceDirectories(dirRetEnv);

      edNFePathRejeitado.Text := dirRetEnv;

     dirRetCan := dirRetorno +'\Cancelado';
     if not DirectoryExists(dirRetCan) then
       ForceDirectories(dirRetCan);

     edNFePathRetornoLido.Text := dirRetCan;

     dirRetInu := dirRetorno +'\Inutilizado';
     if not DirectoryExists(dirRetInu) then
       ForceDirectories(dirRetInu);

     edNFePathPDFSalvo.Text := dirRetInu;
   end;
 end;

 procedure DiretorioNFCE;
 begin
    pgcConfig.TabIndex := tsConfigNFCe.TabIndex;
   //Aba Configura NFCe

   dirEnvio := dirAux +'\NFCe\Envio';
   if not DirectoryExists(dirEnvio) then
     ForceDirectories(dirEnvio);

   edNFCePathEnvio.Text := dirEnvio;

   dirRetorno := dirAux +'\NFCe\Retorno';
   if not DirectoryExists(dirRetorno) then
     ForceDirectories(dirRetorno);

   edNFCePathRejeitado.Text   := dirRetorno;

   dirRetEnv := dirRetorno +'\Enviado';
    if not DirectoryExists(dirRetEnv) then
     ForceDirectories(dirRetEnv);

   edNFCePathProcessado.Text := dirRetEnv;

   dirRetCan := dirRetorno +'\Cancelado';
   if not DirectoryExists(dirRetCan) then
     ForceDirectories(dirRetCan);

   edNFCePathRetornoLido.Text := dirRetCan;

   dirRetInu := dirRetorno +'\Inutilizado';
   if not DirectoryExists(dirRetInu) then
     ForceDirectories(dirRetInu);

   edNFCePathPDFSalvo.Text := dirRetInu;
 end;

 procedure DiretorioNFSE;
 begin
    pgcConfig.TabIndex := tsConfigNFe.TabIndex;
   //Aba Configura NFSe

   dirEnvio := dirAux +'\NFSe\Envio';
   if not DirectoryExists(dirEnvio) then
     ForceDirectories(dirEnvio);

   edNFSePathEnvio.Text := dirEnvio;

   dirRetorno := dirAux +'\NFSe\Retorno';
   if not DirectoryExists(dirRetorno) then
     ForceDirectories(dirRetorno);

   edNFSePathProcessado.Text := dirRetorno;

   dirRetEnv := dirRetorno +'\Enviado';
    if not DirectoryExists(dirRetEnv) then
     ForceDirectories(dirRetEnv);

   edNFSePathRejeitado.Text := dirRetEnv;

   dirRetCan := dirRetorno +'\Cancelado';
   if not DirectoryExists(dirRetCan) then
     ForceDirectories(dirRetCan);

   edNFSePathRetornoLido.Text := dirRetCan;

   dirRetInu := dirRetorno +'\Inutilizado';
   if not DirectoryExists(dirRetInu) then
     ForceDirectories(dirRetInu);

   edNFSePathPDFSalvo.Text := dirRetInu;
end;

begin
  fOpenPath(dirAux,'Informe o diretório padrão');

  if not DirectoryExists(dirAux) then
   if ForceDirectories(dirAux) then
     ShowMessage('GetLastError : '+ IntToStr(GetLastError));

  DiretorioBD;
  DiretorioNFE;
  DiretorioNFCE;
  DiretorioNFSE;
  EditToTabela;
end;

procedure TfoConfigPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
end;

procedure TfoConfigPadrao.FormCreate(Sender: TObject);
begin
  if not Assigned(tabConfigpadrao) then
    tabConfigpadrao := TConfigPadrao.Create;

  pgcConfig.TabIndex := 0;
end;

procedure TfoConfigPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{// key down                                    }
  if (Shift = [ssCtrl]) and (key = vk_return) then
  begin
    btnAplicarClick(Self);
    btnOKClick(Self);
  end;
   //ShowMessage('Voce apertou Crtl + Enter');
end;

procedure TfoConfigPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
{//Key press
if (key = #10) then
ShowMessage('Voce apertou Crtl + Enter');
}
  if key = #13 then  //Enter
  begin
    key := #0;
    perform(wm_nextdlgctl,0,0);
  end;

end;

procedure TfoConfigPadrao.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{// key up
if (Shift = [ssCtrl]) and (key = vk_return) then
ShowMessage('Voce apertou Crtl + Enter');}
  if key = VK_ESCAPE then
  begin
    if MessageDlg('Deseja cancelar a operação de inserir', mtConfirmation, mbYesNo,0) = mrNo then
    begin
       case wOpe of
        opInserir: begin

                   end;

        opAlterar: begin


                   end;

       end;
    end
    else
     ModalResult := mrCancel;

  end;

end;

procedure TfoConfigPadrao.FormShow(Sender: TObject);
begin
  LimpaCampos(foConfigPadrao);
  pgcConfig.TabIndex := 0;
  wOpe := opAlterar;
  FormShowAlterar;

end;

procedure TfoConfigPadrao.FormShowAlterar;
begin
  if not (CarregaConfig(tabConfigpadrao)) then
  begin
    MsgStatus('Configuração padrãoa não foi defina', clBlue);
    wOpe := opInserir;
    FormShowInserir;
  end;
end;

procedure TfoConfigPadrao.FormShowDeletar;
begin

end;

procedure TfoConfigPadrao.FormShowInserir;
begin
   if edDescriConfig.CanFocus then
   begin
     edDescriConfig.SetFocus;
   end;
end;

procedure TfoConfigPadrao.LerParametros;
begin
  if FileExists(fArqIni) then
  begin
    edUsuarioBD.Text := getINI(fArqIni, 'BD', 'USUARIO', '');
    edSenhaBD.Text   := getINI(fArqIni, 'BD', 'SENHA', '');
    edArquivo.Text   := getINI(fArqIni, 'BD', 'ARQUIVO', '');
  end;
end;

function TfoConfigPadrao.LimpaCampos(pForm: TForm): boolean;
var i: Integer;
begin
   result := false;

  if not Assigned(pForm) then
  exit;

  for i:= 0 to pForm.ComponentCount-1 do  //Percorre todos os componentes da tela
  begin
    if pForm.Components[i] is TLabeledEdit then
      TLabeledEdit(pForm.Components[i]).Clear;
  end;

  result := true;
end;

procedure TfoConfigPadrao.mniAjustarconfiguraopadro1Click(Sender: TObject);
begin

  foConfigPadrao := TfoConfigPadrao.Create(Application);
  try
    wOpe := opAlterar;
    daoConfigPadrao.fCarregaConfigPadrao(tabConfigPadrao,['id']);
    foConfigPadrao.ShowModal;

  finally
    foConfigPadrao.Free;
  end;
end;

procedure TfoConfigPadrao.MsgStatus(pMsg: string; pCor: TColor);
begin
  statMSg.Font.Color := pCor;
  statMSg.Panels[1].Text := Trim(pMsg);
end;

procedure TfoConfigPadrao.pEnableConfig(pForm : TForm; pEnable: boolean);
var i : integer;
begin
  if not Assigned(pForm) then
    exit;

  for i:= 0 to pForm.ComponentCount-1 do
  begin
    if pForm.Components[i] is TTabSheet then
      TTabSheet(pForm.Components[i]).Enabled := pEnable;
  end;
end;

//function TfoConfigPadrao.pOpenFileName(pFilter: array of string;
//pFilterName: array of string;var prFileName:string;pTitle : string = ''): Boolean;
//var auxFilter, auxFilterName : string;
//    i : Integer;
// begin
//  dlgOpenDir := TOpenDialog.Create(Application);
//  try
//     dlgOpenDir.Filter :='';
//     for I := Low(pFilter) to High(pFilter) do
//     begin
//       dlgOpenDir.Filter := pFilterName[i] + '|' + pFilter[i]+'|';
//     end;
//
//     dlgOpenDir.FilterIndex := 0;
//     dlgOpenDir.Title := pTitle;
//     Result := dlgOpenDir.Execute;
//
//     if Result then
//       prFileName := dlgOpenDir.FileName
//     else
//       prFileName := '';
//  finally
//    dlgOpenDir.Free;
//  end;
//end;

//function TfoConfigPadrao.fOpenPath(var prDirectory: string; pTitle : string = ''): Boolean;
//begin
//  Result := false;
//  jopdOpenDir := TJvSelectDirectory.Create(Application);
//  jopdOpenDir.title := pTitle;
//
//  if prDirectory <> '' then
//    jopdOpenDir.InitialDir := prDirectory;
//
//  try
//     Result := jopdOpenDir.Execute;
//     if Result then
//       prDirectory := jopdOpenDir.Directory
//     else
//       prDirectory := '';
//  finally
//    dlgOpenDir.Free;
//  end;
//end;

procedure TfoConfigPadrao.SalvarParametros;
var
 wINI : string;
begin
  wINI := ExtractFileName(ChangeFileExt(Application.ExeName, 'INI'));
  wINI := GetCurrentDir +'\'+wIni;
  setINI(wINI, 'BD', 'USUARIO', Trim(edUsuarioBD.Text));
  setINI(wINI, 'BD', 'SENHA', Trim(edSenhaBD.Text));
  setINI(wINI, 'BD', 'ARQUIVO', Trim(edArquivo.Text));
end;

procedure TfoConfigPadrao.tabelaToEdit;
begin
  LimpaCampos(foConfigPadrao);
  with tabConfigpadrao do
  begin
    edUsuarioBD.Text       := UsuarioBD;
    edSenhaBD.Text         := SenhaBD;
    edArquivo.Text         := PathBD+'\'+NameBD;
    //Aba Configura NFe
    edNFePathEnvio.Text     := NFePathEnvio;
    edNFePathProcessado.Text   := NFePathProcessado;
    edNFePathRejeitado.Text   := NFePathRejeitado;
    edNFePathRetornoLido.Text  := NFePathRetornoLido;
    edNFePathPDFSalvo.Text  := NFePathPDFSalvo;
    //Aba Configura NFCe
    edNFCePathEnvio.Text    := NFCePathEnvio;
    edNFCePathRejeitado.Text  := NFCePathRejeitado;
    edNFCePathProcessado.Text  := NFCePathProcessado;
    edNFCePathRetornoLido.Text := NFCePathRetornoLido;
    edNFCePathPDFSalvo.Text := NFCePathPDFSalvo;
    //Aba Configura NFSe
    edNFSePathEnvio.Text    := NFSePathEnvio;
    edNFSePathProcessado.Text  := NFSePathProcessado;
    edNFSePathRejeitado.Text  := NFSePathRejeitado;
    edNFSePathRetornoLido.Text := NFSePathRetornoLido;
    edNFSePathPDFSalvo.Text := NFSePathPDFSalvo;
  end;

end;

function TfoConfigPadrao.validacampos(pForm : TForm): boolean;
var i,tabIdx,iTab : Integer;
    NameLabel, NameComp : string;

begin
   result := True;

  if not Assigned(pForm) then
  exit;

  for i:= 0 to pForm.ComponentCount-1 do                  //Percorre todos os componentes da tela
  begin
    if pForm.Components[i] is TTabSheet then              // Verifica seé TabSheet
    begin
      tabIdx := TTabSheet(pForm.Components[i]).TabIndex;  //Salva o tab order
      iTab := i;                                         //Salva o index da tab atual
    end;

    if pForm.Components[i] is TLabeledEdit then
      if Trim(TLabeledEdit(pForm.Components[i]).Text) = '' then
      begin
        if pForm.Components[iTab] is TTabSheet then
        begin
          pgcConfig.TabIndex := tabIdx;
            if TLabeledEdit(pForm.Components[i]).CanFocus then
            begin
              NameLabel :=  TLabeledEdit(pForm.Components[i]).EditLabel.Caption;
              MsgStatus('O Campo '+ NameLabel + ' está vazio!', clRed);
              TLabeledEdit(pForm.Components[i]).SetFocus;
              result := False;
              Break;

            end;
        end;
      end
      else
       result := true;
  end;

  if result then
     MsgStatus('Validação OK', clBlack);

end;

end.

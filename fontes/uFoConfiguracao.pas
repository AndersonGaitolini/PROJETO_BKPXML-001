unit uFoConfiguracao;

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
  Vcl.Menus,uFoConfigPadrao;

type

  TfoConfiguracao = class(TForm)
    pnlConfig: TPanel;
    pgcConfig: TPageControl;
    tsConfigBD: TTabSheet;
    btnGetDirBanco: TSpeedButton;
    edUsuarioBD: TLabeledEdit;
    edSenhaBD: TLabeledEdit;
    edArquivo: TLabeledEdit;
    tsConfigNFCe: TTabSheet;
    edNFCePathEnvio: TLabeledEdit;
    edNFCePathProcessado: TLabeledEdit;
    edNFCePathRejeitado: TLabeledEdit;
    edNFCePathRetornoLido: TLabeledEdit;
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
    edNFSePathRetornoLido: TLabeledEdit;
    edNFSePathPDFSalvo: TLabeledEdit;
    btnOpenNFSe1: TBitBtn;
    btnOpenNFSe2: TBitBtn;
    btnOpenNFSe3: TBitBtn;
    btnOpenNFSe4: TBitBtn;
    btnOpenNFSe5: TBitBtn;
    jopdOpenDir: TJvSelectDirectory;
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
    btn1: TToolButton;
    mm1: TMainMenu;
    mniAjuste1: TMenuItem;
    mniAjustarconfiguraopadro1: TMenuItem;
    btnIniFile: TToolButton;
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
    procedure edNFSePathRetornoLidoExit(Sender: TObject);
    procedure edNFSePathPDFSalvoExit(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure mniAjustarconfiguraopadro1Click(Sender: TObject);
    procedure btnIniFileClick(Sender: TObject);
    procedure pgcConfigChange(Sender: TObject);
  private
    { Private declarations }
    function validacampos(pForm : TForm): boolean;
    function LimpaCampos(pForm : TForm): boolean;
    procedure SalvarParametros;
    procedure AlteraEditaExcluiConfig;
    procedure LerParametros;
    procedure MsgStatus(pMsg : string; pCor : TColor = clBlack);
    function CarregaConfig(pTab : TConfiguracoes; pIdUsuario : integer): Boolean; overload;
    function CarregaConfig(pTab : TConfiguracoes; pIdUsuario : integer; pDescriConfig : string): Boolean; overload;
    function CarregaConfigPadrao(pTab : TConfigPadrao): Boolean;
    function CarregaIniFile: Boolean;
    procedure FormShowAlterar;
    procedure FormShowInserir;
    procedure FormShowDeletar;

//    function pOpenFileName(var prFileName:string): Boolean;
//    function pOpenPath(var prDirectory:string):boolean;
    procedure pEnableConfig(pForm : TForm;pEnable: boolean);
    procedure EditToTabela;
    procedure TabelaToEdit;

  public
    { Public declarations }
    IDConfig : Integer; //temporario
    FUsuarios : TUsuarios;
    ConfigId : integer;
    LastId   : integer;
  published
   property Usuarios : TUsuarios read FUsuarios write FUsuarios;
  end;

var
  foConfiguracao : TfoConfiguracao;
  wPathAux: string;
  SavStr : String;
implementation


{$R *.dfm}

procedure TfoConfiguracao.AlteraEditaExcluiConfig;
begin
  if wOpe = opNil then
    exit;

  with daoConfiguracoes, tabConfiguracoes do
  begin
    case wOpe of
      opExcluir: begin
                   if MessageDlg('Deseja excluir a configuração '+ DescriConfig, mtConfirmation, mbYesNo,0) = mrYes then
                     if fExcluirConfiguracoes(tabConfiguracoes) then
                     begin
                       statMSg.Panels[1].Text := 'Deletado!';
                       wOpe := opOK;
                     end;
                  end;

      opAlterar: begin
                   tabUsuarios := TUsuarios.Create;
                   tabUsuarios.ConfigSalva := tabConfiguracoes.id;
                   if fSalvarConfiguracoes(tabConfiguracoes) then
                   begin
                     statMSg.Panels[1].Text := 'Salvo!';
                     daoUsuarios.fSalvar(tabUsuarios);
                     wOpe := opOk;
                     btnAplicar.Enabled := false;
                     btnOK.Enabled := true;
                   end;
                 end;

      opInserir: begin
                   if fInserirConfiguracoes(tabConfiguracoes) > 0 then
                   begin
                     statMSg.Panels[1].Text := 'Novo registo!';
                     wOpe := opOk;

                   end;
                 end;
    end;
  end;
end;

procedure TfoConfiguracao.btn1Click(Sender: TObject);
begin
  if CarregaConfigPadrao(tabConfigpadrao) then
    MsgStatus('Configuração Padrão', clRed);
end;

procedure TfoConfiguracao.btn2Click(Sender: TObject);
begin
  //
end;

procedure TfoConfiguracao.btnAplicarClick(Sender: TObject);
begin
  if Validacampos(foConfiguracao) then
  begin
    EditToTabela;
    AlteraEditaExcluiConfig;
  end;
end;

procedure TfoConfiguracao.btnOKClick(Sender: TObject);
begin

  if wOpe = opOK then
     ModalResult := mrOk
end;

procedure TfoConfiguracao.btnEditarClick(Sender: TObject);
begin
  pgcConfig.Enabled := true;
  pnlRodape.Enabled := false;
  statMSg.Panels[1].Text := 'Alterando!';

end;

procedure TfoConfiguracao.btnExcluirClick(Sender: TObject);
begin
  wOpe := opExcluir;
  pEnableConfig(foConfiguracao, false);
end;

procedure TfoConfiguracao.btnGetDirBancoClick(Sender: TObject);
begin
//  if fOpenFile('Selecione o Diretório do seu Banco de DADOS', wPathAux, ['FDB | *.*fdb'],1) then
 dlgOpenDir := TOpenDialog.Create(Application);
 dlgOpenDir.DefaultExt := 'FDB';
 dlgOpenDir.InitialDir := GetCurrentDir;
 if dlgOpenDir.Execute then
 begin
   edArquivo.Text := dlgOpenDir.FileName;
   tabConfiguracoes.PathBD := dlgOpenDir.FileName;
 end;
end;

procedure TfoConfiguracao.btnIniFileClick(Sender: TObject);
begin
 if CarregaIniFile then
end;

procedure TfoConfiguracao.btnInserirClick(Sender: TObject);
begin
  statMSg.Panels[1].Text := 'Inserindo!';
end;


procedure TfoConfiguracao.btnOpen1Click(Sender: TObject);
begin
 if fOpenPath(wPathAux) then
 begin
   edNFePathEnvio.Text := wPathAux;
   tabConfiguracoes.NFePathEnvio := wPathAux;
 end;
end;

procedure TfoConfiguracao.btnOpen2Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFePathProcessado.Text := wPathAux;
    tabConfiguracoes.NFePathProcessado := wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpen3Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFePathRejeitado.Text := wPathAux;
    tabConfiguracoes.NFePathRejeitado := wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpen4Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFePathRetornoLido.Text := wPathAux;
    tabConfiguracoes.NFePathRetornoLido := wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpen5Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFePathPDFSalvo.Text := wPathAux;
    tabConfiguracoes.NFePathPDFSalvo := wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpenNFCe1Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFCePathEnvio.Text := wPathAux;
    tabConfiguracoes.NFCePathEnvio := wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpenNFCe2Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFCePathProcessado.Text := wPathAux;
    tabConfiguracoes.NFCePathProcessado := wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpenNFCe3Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFCePathRejeitado.Text := wPathAux;
    tabConfiguracoes.NFCePathRejeitado := wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpenNFCe4Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFCePathRetornoLido.Text := wPathAux;
    tabConfiguracoes.NFCePathRetornoLido := wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpenNFCe5Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFCePathPDFSalvo.Text := wPathAux;
    tabConfiguracoes.NFCePathPDFSalvo := wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpenNFSe1Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFSePathEnvio.Text := wPathAux;
    tabConfiguracoes.NFSePathEnvio:= wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpenNFSe2Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFSePathProcessado.Text := wPathAux;
    tabConfiguracoes.NFSePathProcessado:= wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpenNFSe3Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFSePathRejeitado.Text := wPathAux;
    tabConfiguracoes.NFSePathRejeitado:= wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpenNFSe4Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFSePathRetornoLido.Text := wPathAux;
    tabConfiguracoes.NFSePathRetornoLido:= wPathAux;
  end;
end;

procedure TfoConfiguracao.btnOpenNFSe5Click(Sender: TObject);
begin
  if fOpenPath(wPathAux) then
  begin
    edNFSePathPDFSalvo.Text := wPathAux;
    tabConfiguracoes.NFSePathPDFSalvo:= wPathAux;
  end;
end;

function TfoConfiguracao.CarregaConfigPadrao(pTab: TConfigPadrao): Boolean;
begin
  Result := false;
  try
    try
      pTab.IDusuario := 0;
      with pTab do
      begin
        daoConfigPadrao.fCarregaConfigPadrao(pTab, ['id']);

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
          edNFCePathProcessado.Text  := NFCePathProcessado;
          edNFCePathRejeitado.Text  := NFCePathRejeitado;
          edNFCePathRetornoLido.Text := NFCePathRetornoLido;
          edNFCePathPDFSalvo.Text := NFCePathPDFSalvo;

          //Aba Configura NFSe
          edNFSePathEnvio.Text    := NFSePathEnvio;
          edNFSePathProcessado.Text  := NFSePathProcessado;
          edNFSePathRejeitado.Text  := NFSePathRejeitado;
          edNFSePathRetornoLido.Text := NFSePathRetornoLido;
          edNFSePathPDFSalvo.Text := NFSePathPDFSalvo;
          Result := true;
        end;
      end;
    except

    end;
  finally
  end;
end;

function TfoConfiguracao.CarregaIniFile: Boolean;
var wFilePathIni : string;
begin
//if fOpenFile('Localiza o INI File MAXWIN/MAXECV',wFilePathIni, ['INI | *.*ini'],1,'*.*ini') then
 dlgOpenDir := TOpenDialog.Create(Application);
 dlgOpenDir.DefaultExt := 'INI';
 dlgOpenDir.InitialDir := GetCurrentDir;
 if dlgOpenDir.Execute then
 begin
  wFilePathIni := dlgOpenDir.FileName;

  edUsuarioBD.Text       := 'sysdba';
  edSenhaBD.Text         := 'masterkey';
  edArquivo.Text         := '';
  edDescriConfig.Text    := fNomePC;

  //Aba Configura NFe
  edNFePathEnvio.Text        := getINI(wFilePathIni,'NFe','Caminho','');
  edNFePathProcessado.text   := getINI(wFilePathIni,'NFe','Caminho','')  + '\Processado';
  edNFePathRejeitado.text    := getINI(wFilePathIni,'NFe','Caminho','')  + '\Rejeitado';
  edNFePathRetornoLido.Text  := getINI(wFilePathIni,'NFe','Retorno','') + '\lido';
  edNFePathPDFSalvo.Text     := getINI(wFilePathIni,'NFe','Caminho','')   +'\PDF';
//Aba Configura NFCe
  edNFCePathEnvio.Text        := getINI(wFilePathIni,'NFCe','Caminho','');
  edNFCePathProcessado.Text   := getINI(wFilePathIni,'NFCe','Caminho','')+'\Processado';
  edNFCePathRejeitado.Text    := getINI(wFilePathIni,'NFCe','Caminho','')+'\Rejeitado';
  edNFCePathRetornoLido.Text  := getINI(wFilePathIni,'NFCe','Retorno','')+ '\lido';
  edNFCePathPDFSalvo.Text     := getINI(wFilePathIni,'NFCe','Caminho','')+'\PDF';
 //Aba Configura NFSe
  edNFSePathEnvio.Text        := getINI(wFilePathIni,'NFSe','Caminho','');
  edNFSePathProcessado.Text   := getINI(wFilePathIni,'NFSe','Caminho','')+'\Processado';
  edNFSePathRejeitado.Text    := getINI(wFilePathIni,'NFSe','Caminho','')+'\Rejeitado';
  edNFSePathRetornoLido.Text  := getINI(wFilePathIni,'NFSe','Retorno','')+ '\lido';
  edNFSePathPDFSalvo.Text     := getINI(wFilePathIni,'NFSe','Caminho','')+'\PDF';
 end;
end;

function TfoConfiguracao.CarregaConfig(pTab : TConfiguracoes; pIdUsuario : integer;
 pDescriConfig : string): Boolean;
begin
  Result := false;
  try
    try
      pTab.DescriConfig :=  pDescriConfig;
      pTab.IDusuario    := pIdUsuario;
      with pTab do
      begin

        daoConfiguracoes.fCarregaConfiguracoes(pTab, ['idusuario','DescriConfig']);

        with tabConfiguracoes do
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
          edNFCePathProcessado.Text  := NFCePathProcessado;
          edNFCePathRejeitado.Text  := NFCePathRejeitado;
          edNFCePathRetornoLido.Text := NFCePathRetornoLido;
          edNFCePathPDFSalvo.Text := NFCePathPDFSalvo;
          //Aba Configura NFSe
          edNFSePathEnvio.Text    := NFSePathEnvio;
          edNFSePathProcessado.Text  := NFSePathProcessado;
          edNFSePathRejeitado.Text  := NFSePathRejeitado;
          edNFSePathRetornoLido.Text := NFSePathRetornoLido;
          edNFSePathPDFSalvo.Text := NFSePathPDFSalvo;
          Result := true;
        end;
      end;
    except

    end;
  finally
  end;
end;

function TfoConfiguracao.CarregaConfig(pTab : TConfiguracoes ;
 pIdUsuario : integer): Boolean;
begin
  Result := false;
  try
    try
      pTab.ID :=  pIdUsuario;
      with pTab do
      begin
        if not Assigned(ptab) then
          daoConfiguracoes.fCarregaConfiguracoes(pTab, ['id']);

        with pTab do
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
          edNFCePathProcessado.Text  := NFCePathProcessado;
          edNFCePathRejeitado.Text  := NFCePathRejeitado;
          edNFCePathRetornoLido.Text := NFCePathRetornoLido;
          edNFCePathPDFSalvo.Text := NFCePathPDFSalvo;

          //Aba Configura NFSe
          edNFSePathEnvio.Text    := NFSePathEnvio;
          edNFSePathProcessado.Text  := NFSePathProcessado;
          edNFSePathRejeitado.Text  := NFSePathRejeitado;
          edNFSePathRetornoLido.Text := NFSePathRetornoLido;
          edNFSePathPDFSalvo.Text := NFSePathPDFSalvo;

          edDescriConfig.Text    := DescriConfig;
          Result := true;
        end;
      end;
    except

    end;
  finally
  end;
end;

procedure TfoConfiguracao.edArquivoExit(Sender: TObject);
var bdPath, bdSource :string;
begin

  with tabConfiguracoes, TLabeledEdit(Sender) do
  begin
    if PathBD+'\'+NameBD <> Text then
    begin
      PathBD := ExtractFileDir(Trim(Text));
      NameBD := ExtractFileName(Trim(Text));
    end;

   if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
    if CanFocus then
    begin
      MsgStatus('Diretório informado não existe', clRed);
      SetFocus;
    end;
  end;

  pgcConfig.TabIndex := 1;
end;

procedure TfoConfiguracao.edDescriConfigExit(Sender: TObject);
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

procedure TfoConfiguracao.EditToTabela;
begin
  if NOT Assigned(tabConfiguracoes) then
    exit;

  with tabConfiguracoes do
  begin
   DescriConfig       := edDescriConfig.Text;
//   IDusuario
   UsuarioBD          := Trim(edUsuarioBD.Text);
   SenhaBD            := edSenhaBD.Text;
   PathBD             := ExtractFileDir(edArquivo.Text);
   NameBD             := ExtractFileName(edArquivo.Text);

   //Aba Configura NFe
   NFePathEnvio        := edNFePathEnvio.Text;
   NFePathProcessado      := edNFePathProcessado.Text;
   NFePathRejeitado      := edNFePathRejeitado.Text;
   NFePathRetornoLido     := edNFePathRetornoLido.Text;
   NFePathPDFSalvo     := edNFePathPDFSalvo.Text;

  //Aba Configura NFCe
   NFCePathEnvio       := edNFCePathEnvio.Text;
   NFCePathProcessado     := edNFCePathProcessado.Text;
   NFCePathRejeitado     := edNFCePathRejeitado.Text;
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

procedure TfoConfiguracao.edNFCePathProcessadoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFCePathEnvioExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFePathProcessadoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFePathEnvioExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFSePathProcessadoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFSePathEnvioExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFCePathRetornoLidoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFePathRetornoLidoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFSePathRetornoLidoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFCePathRejeitadoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFePathRejeitadoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFSePathRejeitadoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFCePathPDFSalvoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFePathPDFSalvoExit(Sender: TObject);
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

procedure TfoConfiguracao.edNFSePathPDFSalvoExit(Sender: TObject);
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

procedure TfoConfiguracao.edSenhaBDExit(Sender: TObject);
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

procedure TfoConfiguracao.edUsuarioBDExit(Sender: TObject);
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

procedure TfoConfiguracao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
end;

procedure TfoConfiguracao.FormCreate(Sender: TObject);
begin
  if not Assigned(tabConfiguracoes) then
    tabConfiguracoes := TConfiguracoes.Create;


  pgcConfig.TabIndex := 0;
  //validacampos(foConfiguracao);

end;

procedure TfoConfiguracao.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfoConfiguracao.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then  //Enter
  begin
    key := #0;
    perform(wm_nextdlgctl,0,0);
  end;
end;

procedure TfoConfiguracao.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TfoConfiguracao.FormShow(Sender: TObject);
begin
  LimpaCampos(foConfiguracao);
  pgcConfig.TabIndex := 0;
  case wOpe of
    opInserir: FormShowInserir;
    opAlterar: FormShowAlterar;
  end;

end;

procedure TfoConfiguracao.FormShowAlterar;
begin

  btnOK.Enabled := not (CarregaConfig(tabConfiguracoes,tabConfiguracoes.Id));
end;

procedure TfoConfiguracao.FormShowDeletar;
begin

end;

procedure TfoConfiguracao.FormShowInserir;
begin
   if edDescriConfig.CanFocus then
   begin
     edDescriConfig.SetFocus;
   end;
end;

procedure TfoConfiguracao.LerParametros;
begin
  if FileExists(fArqIni) then
  begin
    edUsuarioBD.Text := getINI(fArqIni, 'BD', 'USUARIO', '');
    edSenhaBD.Text   := getINI(fArqIni, 'BD', 'SENHA', '');
    edArquivo.Text   := getINI(fArqIni, 'BD', 'ARQUIVO', '');
    IDConfig         := StrToIntDef (getINI(fArqIni, 'Config','id', ''),0);
  end;
end;

function TfoConfiguracao.LimpaCampos(pForm: TForm): boolean;
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

procedure TfoConfiguracao.mniAjustarconfiguraopadro1Click(Sender: TObject);
begin

  foConfigPadrao := TfoConfigPadrao.Create(Application);
  try
    wOpe := opAlterar;
    daoConfigPadrao.fCarregaConfigPadrao(tabConfigPadrao,['id']);
    TabelaToEdit;
    foConfigPadrao.ShowModal;

  finally
    foConfigPadrao.Free;
  end;
end;

procedure TfoConfiguracao.MsgStatus(pMsg: string; pCor: TColor);
begin
  statMSg.Font.Color := pCor;
  statMSg.Panels[1].Text := Trim(pMsg);
end;

procedure TfoConfiguracao.pEnableConfig(pForm : TForm; pEnable: boolean);
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

procedure TfoConfiguracao.pgcConfigChange(Sender: TObject);
begin

end;

//function TfoConfiguracao.pOpenFileName(var prFileName:string): Boolean;
//begin
//  dlgOpenDir := TOpenDialog.Create(Application);
//  try
//     Result := dlgOpenDir.Execute;
//     if Result then
//       prFileName := dlgOpenDir.FileName
//     else
//       prFileName := '';
//  finally
//    dlgOpenDir.Free;
//  end;
//end;

//function TfoConfiguracao.pOpenPath(var prDirectory: string): Boolean;
//begin
//  Result := false;
//  jopdOpenDir := TJvSelectDirectory.Create(Application);
//  try
//     Result := jopdOpenDir.Execute;
//     if Result then
//       prDirectory := jopdOpenDir.Directory
//     else
//       prDirectory := '';
//  finally
//    jopdOpenDir.Free;
//  end;
//end;

procedure TfoConfiguracao.SalvarParametros;
var
 wINI : string;
begin
  wINI := ExtractFileName(ChangeFileExt(Application.ExeName, 'INI'));
  wINI := GetCurrentDir +'\'+wIni;
  setINI(wINI, 'BD', 'USUARIO', Trim(edUsuarioBD.Text));
  setINI(wINI, 'BD', 'SENHA', Trim(edSenhaBD.Text));
  setINI(wINI, 'BD', 'ARQUIVO', Trim(edArquivo.Text));
end;

procedure TfoConfiguracao.TabelaToEdit;
begin
  LimpaCampos(foConfiguracao);
  with tabConfiguracoes do
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
    edNFCePathProcessado.Text  := NFCePathProcessado;
    edNFCePathRejeitado.Text  := NFCePathRejeitado;
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

function TfoConfiguracao.validacampos(pForm : TForm): boolean;
var i,tabIdx,iTab : Integer;
    NameLabel, NameComp : string;
begin
   result := True;

  if not Assigned(pForm) then
  exit;

  for i:= 0 to pForm.ComponentCount-1 do  //Percorre todos os componentes da tela
  begin
//    NameComp := (pForm.Components[i]).
    if pForm.Components[i] is TTabSheet then  // Verifica seé TabSheet
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
//          if TTabSheet(pForm.Components[iTab]).CanFocus then
//            begin
//              TTabSheet(pForm.Components[iTab]).SetFocus;
              if TLabeledEdit(pForm.Components[i]).CanFocus then
              begin
                NameLabel :=  TLabeledEdit(pForm.Components[i]).EditLabel.Caption;
                MsgStatus('O Campo '+ NameLabel + ' está vazio!', clRed);
//                ShowMessage('O Campo '+ NameLabel + ' está vazio!' );
                TLabeledEdit(pForm.Components[i]).SetFocus;
                result := False;
                Break;

              end;
//            end;
        end;
      end
    else
    result := true;

  end;

  if result then
     MsgStatus('Validação OK', clBlack);

end;

end.

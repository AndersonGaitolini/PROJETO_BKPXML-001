unit uFoConexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, JvBaseDlg, JvSelectDirectory,System.IniFiles,
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

  TfoConexao = class(TForm)
    pnlConfig: TPanel;
    pgcConfig: TPageControl;
    tsConfigBD: TTabSheet;
    edUsuarioBD: TLabeledEdit;
    edSenhaBD: TLabeledEdit;
    edDataBase: TLabeledEdit;
    dlgOpenDir: TOpenDialog;
    ilCadastro: TImageList;
    pnlMenu: TPanel;
    jtobMenuConfig: TJvToolBar;
    btnIniFile: TToolButton;
    btnFindBD: TButton;
    btnLimpa: TToolButton;
    lbStatusConn: TLabel;
    cbbTipoCon: TComboBox;
    stat1: TStatusBar;
    btnConectar1: TButton;
    edServerName: TLabeledEdit;
    btnPing: TButton;
    btnSalvaIni: TToolButton;
    cbbPerfilCon: TComboBox;
    lbPerfilCon: TLabel;
    lbTipoCon: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFindBDClick(Sender: TObject);
    procedure btnIniFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConectar1Click(Sender: TObject);
    procedure btnPingClick(Sender: TObject);
    procedure cbbTipoConChange(Sender: TObject);
    procedure btnSalvaIniClick(Sender: TObject);
  private
    { Private declarations }
    wPress: Boolean;
    wRemote :boolean;
    function validacampos(pForm : TForm): boolean;
    function LimpaCampos(pForm : TForm): boolean;
    procedure pMontaListaPerfil;
    procedure pSalvarParametros;
    procedure pLerParametros;
    procedure pPreemcheCampos;
    procedure pLocalRemote;
    procedure pShowBotaoConectar;
    procedure pShowStatusBar;
    procedure pConLocal;
    procedure pConLocalEmbedded;
    procedure pConRemote;

    procedure pEnableConfig(pForm : TForm;pEnable: boolean);
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
  foConexao : TfoConexao;
  wPathAux: string;
  SavStr : String;
implementation


{$R *.dfm}


procedure TfoConexao.pConLocal;
begin
  with ConecxaoBD do
  begin
    if fServiceStart(fNomePC,'FirebirdServerDefaultInstance') then
      ShowMessage('O Serviço '+QuotedStr('FirebirdServerDefaultInstance')+' não pode ser iniciado!'+#13#13+
                  'Alt+ R e digite '+ QuotedStr('services.msc'));
    TipoCon := tcLocal;

    UserName     := trim(LowerCase(edUsuarioBD.Text));
    Password     := trim(LowerCase(edSenhaBD.Text));
    DataBase     := trim(LowerCase(edDataBase.Text));
    SQLDialect   := '3';
    DriverID     := 'FB';
    CharacterSet := 'WIN1252';
    Protocol     := 'Local';
    VendorLib    := 'fbclient.dll'
  end;
end;

procedure TfoConexao.pConLocalEmbedded;
begin
  with ConecxaoBD do
  begin
    if fServiceStop(fNomePC,'FirebirdServerDefaultInstance') then
      ShowMessage('O Serviço '+QuotedStr('FirebirdServerDefaultInstance')+' não pode ser parado!'+#13#13+
                  'Alt+ R e digite '+ QuotedStr('services.msc'));

    TipoCon := tcLocalEmbed;
    UserName     := trim(LowerCase(edUsuarioBD.Text));
    Password     := trim(LowerCase(edSenhaBD.Text));
    DataBase     := trim(LowerCase(edDataBase.Text));
    SQLDialect   := '3';
    DriverID     := 'FBEmbed';
    CharacterSet := 'WIN1252';
    VendorLib    := 'fbembed.dll';
    VendorHome   := ExtractFileDir(Application.ExeName)+'\fb\';
    Protocol     := 'Local';
    Embedded     := true;
  end;
end;

procedure TfoConexao.pConRemote;
begin
  with ConecxaoBD do
  begin
    TipoCon      := tcRemote;
    UserName     := trim(LowerCase(edUsuarioBD.Text));
    Password     := trim(LowerCase(edSenhaBD.Text));
    DataBase     := trim(LowerCase(edDataBase.Text));
    SQLDialect   := '3';
    DriverID     := 'FB';
    VendorLib    := 'fbclient.dll';
    CharacterSet := 'WIN1252';
    Server       := trim(UpperCase(edServerName.Text));
    Protocol     := 'TCPIP';
    Port         := '3050';
  end;
end;

procedure TfoConexao.btnConectar1Click(Sender: TObject);

begin
  if ConecxaoBD.Conectado  then
  begin
   DM_NFEDFE.conConexaoFD.Close;
   DM_NFEDFE.conConexaoFD.Connected := False;
   ConecxaoBD.Conectado := False;

   pShowBotaoConectar;
   pShowStatusBar;
  end
  else
  begin
    case cbbTipoCon.ItemIndex of
     0: pConLocal;
     1: pConLocalEmbedded;
     2: pConRemote;
    end;

    ConecxaoBD.pWriteParams;
    ConecxaoBD.pConecta;

    pShowBotaoConectar;
    pShowStatusBar;
  end;
//  btnConectar1.Enabled := not ConecxaoBD.Conectado;
end;

procedure TfoConexao.btnFindBDClick(Sender: TObject);
begin
 dlgOpenDir := TOpenDialog.Create(Application);
 dlgOpenDir.DefaultExt := 'FDB';
 dlgOpenDir.InitialDir := GetCurrentDir;
 dlgOpenDir.FileName := 'BACKUPXML.FDB';

 if dlgOpenDir.Execute then
 begin
   edDataBase.Text := dlgOpenDir.FileName;
 end;
end;

procedure TfoConexao.btnIniFileClick(Sender: TObject);
begin
  pPreemcheCampos;
end;

procedure TfoConexao.btnPingClick(Sender: TObject);
var wHost: string;
begin
  wHost := Trim(UpperCase(edServerName.Text));
  if fPingIP(wHost) then
  begin
    stat1.Panels[1].Text := 'Ping Ok!';
  end
  else
  begin
    stat1.Panels[1].Text := 'Falha no Ping!';
  end;

end;

procedure TfoConexao.btnSalvaIniClick(Sender: TObject);
begin
  ConecxaoBD.pWriteParams;
end;

procedure TfoConexao.cbbTipoConChange(Sender: TObject);
begin
  edServerName.Visible := cbbTipoCon.ItemIndex = 2;
  btnPing.Visible := cbbTipoCon.ItemIndex = 2;
  edServerName.Text := Trim(UpperCase(fNomePC));
end;

//procedure TfoConfiguracao.edNFCePathEnvioExit(Sender: TObject);
//begin
//  with tabConfiguracoes, TLabeledEdit(Sender) do
//  begin
//    if NFCePathEnvio <> Text then
//    begin
//      NFCePathEnvio := Trim(Text);
//    end;
//
//    if (Trim(Text) <> '') and not (DirectoryExists(Trim(ExtractFileDir(Text)))) then
//    if CanFocus then
//    begin
//      MsgStatus('Diretório informado não existe', clRed);
//      SetFocus;
//    end;
//  end;
//end;

//procedure TfoConfiguracao.edSenhaBDExit(Sender: TObject);
//begin
//  with tabConfiguracoes, TLabeledEdit(Sender) do
//  begin
//    if SenhaBD <> Text then
//    begin
//      SenhaBD := Trim(Text);
//    end;
//
//    ShowHint := False;
//    if Length(Text) > 10  then
//      if CanFocus then
//      begin
//        Hint := 'Este campo pode ter no máximo 10 caracteres.';
//        ShowHint := true;
//        SetFocus;
//      end;
//  end;
//end;



procedure TfoConexao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
end;

procedure TfoConexao.FormCreate(Sender: TObject);
begin
 if not Assigned(ConecxaoBD) then
     ConecxaoBD := TConecxaoBD.Create;

 ConecxaoBD.pReadParams;
end;

procedure TfoConexao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (key = vk_return) then
  begin

  end;
end;

procedure TfoConexao.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then  //Enter
  begin
    key := #0;
    perform(wm_nextdlgctl,0,0);
  end;
end;

procedure TfoConexao.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
  begin
    if MessageDlg('Deseja cancelar a operação de inserir', mtConfirmation, mbYesNo,0) = mrNo then
      ModalResult := mrCancel;
  end;
end;

procedure TfoConexao.FormShow(Sender: TObject);
begin

  pLerParametros;
  pgcConfig.TabIndex := 0;
  if (ConecxaoBD.Protocol = 'TCPIP') then
    cbbTipoCon.ItemIndex := 2
  else
  if (ConecxaoBD.Protocol= 'LOCAL') and (ConecxaoBD.Embedded) then
    cbbTipoCon.ItemIndex := 1
  else
    cbbTipoCon.ItemIndex := 0;

  edServerName.Visible := cbbTipoCon.ItemIndex = 2;
  btnPing.Visible := cbbTipoCon.ItemIndex = 2;

  pShowBotaoConectar;
  pShowStatusBar;
//  btnConectar1.Enabled := not ConecxaoBD.Conectado;
end;

procedure TfoConexao.pLerParametros;
begin
  ConecxaoBD.pReadParams;
  edUsuarioBD.Text    := ConecxaoBD.UserName;
  edSenhaBD.Text      := ConecxaoBD.Password;
  edDataBase.Text     := ConecxaoBD.Database;
end;

procedure TfoConexao.pLocalRemote;
begin

end;

procedure TfoConexao.pMontaListaPerfil;
var wINI : TIniFile;
begin
  wINI := TIniFile.Create(ConecxaoBD.IniFile);
  try
    cbbPerfilCon.Clear;
  finally
    FreeAndNil(wINI);
  end;
end;

procedure TfoConexao.pPreemcheCampos;
begin
  edUsuarioBD.Text    := 'sysdba';
  edSenhaBD.Text      := 'masterkey';

  if cbbTipoCon.ItemIndex = 2 then
    edDataBase.Text :=  '{Nome / IP do servidor}..\BACKUPXML.FDB' //'\\'+fNomePC+ '\..\MAXXML\BACKUPXML.FDB'
  else
    edDataBase.Text := Application.GetNamePath+ '\BACKUPXML.FDB';

  edServerName.Text   := '{Nome / IP do servidor}'; //fNomePC;

end;

function TfoConexao.LimpaCampos(pForm: TForm): boolean;
var i: Integer;
begin
  result := false;
  if not Assigned(pForm) then
  exit;

  for i:= 0 to pForm.ComponentCount-1 do  //Percorre todos os componentes da tela
  begin
    if pForm.Components[i] is TLabeledEdit then
    begin
      TLabeledEdit(pForm.Components[i]).Clear;
    end
    else
    if pForm.Components[i] is TComboBox then
    begin
      TComboBox(pForm.Components[i]).Items[-1];
    end
    else
    if pForm.Components[i] is TCheckBox then
      TCheckBox(pForm.Components[i]).Checked := false;
  end;

  result := true;
end;


procedure TfoConexao.pEnableConfig(pForm : TForm; pEnable: boolean);
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

procedure TfoConexao.pSalvarParametros;
var
 wIniFile : string;
 wHandle : THandle;
begin
  wIniFile := ExtractFileName(ChangeFileExt(Application.ExeName, '.INI'));
  wIniFile := {GetCurrentDir}Application.GetNamePath +'\'+wIniFile;
//  if FileExists(wIniFile) then
//  begin
//    wHandle := FindWindow( 0,pWideChar(wIniFile));
//    CloseHandle(wHandle);
//    DeleteFile(wIniFile);
//  end;

    setINI(wIniFile, 'MAXXML', 'User_Name',   Trim(edUsuarioBD.Text   ));
    setINI(wIniFile, 'MAXXML', 'Password',   Trim(edSenhaBD.Text     ));
    setINI(wIniFile, 'MAXXML', 'Database',   Trim(edDataBase.Text    ));
end;

procedure TfoConexao.pShowBotaoConectar;
begin
  if ConecxaoBD.Conectado then
    btnConectar1.Caption := 'Conectado!'
  else
    btnConectar1.Caption := 'Conectar..'
end;

procedure TfoConexao.pShowStatusBar;
begin
  if ConecxaoBD.Conectado then
    stat1.Panels[1].Text := 'Conexão ativa!'
  else
    stat1.Panels[1].Text := 'Conexão inativa!';
end;

function TfoConexao.validacampos(pForm : TForm): boolean;
var i,tabIdx,iTab : Integer;
    NameLabel, NameComp : string;
begin
  result := True;
  if not Assigned(pForm) then
  exit;

  for i:= 0 to pForm.ComponentCount-1 do  //Percorre todos os componentes da tela
  begin
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
          if TLabeledEdit(pForm.Components[i]).CanFocus then
          begin
            NameLabel :=  TLabeledEdit(pForm.Components[i]).EditLabel.Caption;
            TLabeledEdit(pForm.Components[i]).SetFocus;
            result := False;
            Break;
          end;
        end;
      end
      else
        result := true;
  end;
end;

end.

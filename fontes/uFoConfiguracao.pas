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
    edUsuarioBD: TLabeledEdit;
    edSenhaBD: TLabeledEdit;
    edDataBase: TLabeledEdit;
    dlgOpenDir: TOpenDialog;
    ilCadastro: TImageList;
    pnlRodape: TPanel;
    btn2: TBitBtn;
    pnlMenu: TPanel;
    jtobMenuConfig: TJvToolBar;
    btnAplicar: TBitBtn;
    btnIniFile: TToolButton;
    edVendorHome: TLabeledEdit;
    edSQLDialect: TLabeledEdit;
    edVendorLib: TLabeledEdit;
    btnFindPathLib: TButton;
    btnFindBD: TButton;
    cbEmbedded: TCheckBox;
    edDriverName: TLabeledEdit;
    cbbTipoConexao: TComboBox;
    Label1: TLabel;
    edCharacterSet: TLabeledEdit;
    btnLimpa: TToolButton;
    pmHost: TPopupMenu;
    mmNomedoPC: TMenuItem;
    mmIPLocal: TMenuItem;
    btnConectar: TButton;
    lbStatusConn: TLabel;
    pnlRemote: TPanel;
    edProtocol: TLabeledEdit;
    edServerPort: TLabeledEdit;
    edServerName: TLabeledEdit;
    lbRemote: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAplicarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFindBDClick(Sender: TObject);
    procedure btnIniFileClick(Sender: TObject);
    procedure cbbTipoConexaoChange(Sender: TObject);
    procedure btnFindPathLibClick(Sender: TObject);
    procedure btnLimpaClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure mmIPLocalClick(Sender: TObject);
    procedure mmNomedoPCClick(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
  private
    { Private declarations }
    wRemote :boolean;
    function validacampos(pForm : TForm): boolean;
    function LimpaCampos(pForm : TForm): boolean;
    procedure pSalvarParametros;
    procedure pLerParametros;
    procedure pPreemcheCampos;
    procedure pLocalRemote;

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
  foConfiguracao : TfoConfiguracao;
  wPathAux: string;
  SavStr : String;
implementation


{$R *.dfm}


procedure TfoConfiguracao.btn2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfoConfiguracao.btnAplicarClick(Sender: TObject);
begin
//  if Validacampos(foConfiguracao) then
  begin
    pSalvarParametros;
    ModalResult := mrOk;
  end;
end;

procedure TfoConfiguracao.btnConectarClick(Sender: TObject);
begin
  pSalvarParametros;

  if DM_NFEDFE.fConexaoBD then
    lbStatusConn.Caption := 'Conectado'
  else
    lbStatusConn.Caption := 'Desconectado';

  btnConectar.Enabled := not DM_NFEDFE.Conectado;

end;

procedure TfoConfiguracao.btnOKClick(Sender: TObject);
begin
  if wOpe = opOK then
    foConfiguracao.Close;
end;

procedure TfoConfiguracao.cbbTipoConexaoChange(Sender: TObject);
begin
  pLocalRemote;
end;

procedure TfoConfiguracao.btnFindBDClick(Sender: TObject);
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

procedure TfoConfiguracao.btnFindPathLibClick(Sender: TObject);
begin
 dlgOpenDir := TOpenDialog.Create(Application);
 dlgOpenDir.DefaultExt := 'dll';
 dlgOpenDir.InitialDir := GetCurrentDir;
 dlgOpenDir.FileName := 'fbClient.dll';

 if dlgOpenDir.Execute then
 begin
   edVendorLib.Text  := ExtractFileName(dlgOpenDir.FileName);
   edVendorHome.Text := ExtractFileDir(dlgOpenDir.FileName);
 end;
end;

procedure TfoConfiguracao.btnIniFileClick(Sender: TObject);
begin
  pPreemcheCampos;
end;


procedure TfoConfiguracao.btnLimpaClick(Sender: TObject);
begin
  LimpaCampos(foConfiguracao);
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



procedure TfoConfiguracao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
end;

procedure TfoConfiguracao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (key = vk_return) then
  begin
    btnAplicarClick(Self);
    btnOKClick(Self);
  end;
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
  if key = VK_ESCAPE then
  begin
    if MessageDlg('Deseja cancelar a operação de inserir', mtConfirmation, mbYesNo,0) = mrNo then
      ModalResult := mrCancel;
  end;
end;

procedure TfoConfiguracao.FormShow(Sender: TObject);
begin
  pLerParametros;
//  pLocalRemote;
  pgcConfig.TabIndex := 0;

  if DM_NFEDFE.Conectado then
    lbStatusConn.Caption := 'Conectado'
  else
    lbStatusConn.Caption := 'Desconectado';

  btnConectar.Enabled := not DM_NFEDFE.Conectado;
end;

procedure TfoConfiguracao.pLerParametros;
begin
  if FileExists(ChangeFileExt(Application.ExeName, '.INI')) then
  begin
    edUsuarioBD.Text    := getINI(fArqIni, 'MAXXML', 'User_Name', '');
    edSenhaBD.Text      := getINI(fArqIni, 'MAXXML', 'Password', '');
    edDataBase.Text     := getINI(fArqIni, 'MAXXML', 'Database', '');
    edSQLDialect.Text   := getINI(fArqIni, 'MAXXML', 'SQLDialect', '');
    edVendorLib.Text    := getINI(fArqIni, 'MAXXML', 'VendorLib', '');
    edVendorHome.Text   := getINI(fArqIni, 'MAXXML', 'VendorHome', '');
    cbEmbedded.Checked  := StrToBoolDef(getINI(fArqIni, 'MAXXML', 'Embedded',''),true);
    edDriverName.Text   := getINI(fArqIni, 'MAXXML', 'DriverId', '');
    edServerName.Text   := getINI(fArqIni, 'MAXXML', 'Server', '');
    edServerPort.Text   := getINI(fArqIni, 'MAXXML', 'Port', '');
    edCharacterSet.Text := getINI(fArqIni, 'MAXXML', 'CharacterSet', '');
    edProtocol.Text     := getINI(fArqIni, 'MAXXML', 'Protocol', '');

    if (getINI(fArqIni,   'MAXXML', 'Conexao', '') = 'Remote') then
      cbbTipoConexao.ItemIndex := 1
    else
      cbbTipoConexao.ItemIndex := 0;
  end;
end;

procedure TfoConfiguracao.pLocalRemote;
begin
  wRemote := cbbTipoConexao.ItemIndex = 1;
  edServerName.Enabled := wRemote;
  edProtocol.Enabled   := wRemote;
  edServerPort.Enabled := wRemote;

  if cbbTipoConexao.ItemIndex = 1 then
  begin
    edServerName.Text   := fNomePC;
    edServerPort.Text   := '3050';
    edProtocol.Text     := 'TCPIP';
    edServerName.Enabled := true;
    edServerPort.Enabled := true;
    edProtocol.Enabled   := true;
  end
  else
  if cbbTipoConexao.ItemIndex = 0 then
  begin
    edServerName.Text   := '';
    edServerPort.Text   := '';
    edProtocol.Text     := 'LOCAL';
    edServerName.Enabled := false;
    edServerPort.Enabled := false;
    edProtocol.Enabled := false;
  end
end;

procedure TfoConfiguracao.pPreemcheCampos;
begin
  edConfigName.Text   := 'MAXXML-'+fNomePC;
  edUsuarioBD.Text    := 'sysdba';
  edSenhaBD.Text      := 'masterkey';
  edDataBase.Text     := GetCurrentDir+ '\BACKUPXML.FDB';
  edSQLDialect.Text   := '3';
  edVendorLib.Text    := 'fbembed.dll';
  edVendorHome.Text   := GetCurrentDir+ '\fb\';
  edDriverName.Text   := 'FBEmbed';

  edCharacterSet.Text := 'WIN1252';
  cbEmbedded.Checked := True;
  if cbbTipoConexao.ItemIndex = 1 then
  begin
    edServerName.Text   := fNomePC;
    edServerPort.Text   := '3050';
    edProtocol.Text     := 'TCPIP';
    edServerName.Enabled := true;
    edServerPort.Enabled := true;
    edProtocol.Enabled   := true;
  end
  else
  if cbbTipoConexao.ItemIndex = 0 then
  begin
    edServerName.Text   := '';
    edServerPort.Text   := '';
    edProtocol.Text     := 'LOCAL';
    edServerName.Enabled := false;
    edServerPort.Enabled := false;
    edProtocol.Enabled := false;
  end
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

procedure TfoConfiguracao.mmIPLocalClick(Sender: TObject);
var wStr: String;
begin
  wStr := fLocalIP;
  edServerName.clear;
  edServerName.Text := wStr;
end;

procedure TfoConfiguracao.mmNomedoPCClick(Sender: TObject);
begin
  edServerName.Text := fNomePC;
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

procedure TfoConfiguracao.pSalvarParametros;
var
 wIniFile : string;
 wHandle : THandle;
begin
  wIniFile := ExtractFileName(ChangeFileExt(Application.ExeName, '.INI'));
  wIniFile := GetCurrentDir +'\'+wIniFile;

  if FileExists(wIniFile) then
  begin
    wHandle := FindWindow( 0,pWideChar(wIniFile));
    CloseHandle(wHandle);
    DeleteFile(wIniFile);
  end;

    setINI(wIniFile, 'MAXXML', 'User_Name',   Trim(edUsuarioBD.Text   ));
    setINI(wIniFile, 'MAXXML', 'Password',   Trim(edSenhaBD.Text     ));
    setINI(wIniFile, 'MAXXML', 'Database',   Trim(edDataBase.Text    ));
    setINI(wIniFile, 'MAXXML', 'SQLDialect', Trim(edSQLDialect.Text  ));
    setINI(wIniFile, 'MAXXML', 'VendorLib',  Trim(edVendorLib.Text   ));
    setINI(wIniFile, 'MAXXML', 'VendorHome', Trim(edVendorHome.Text  ));
    setINI(wIniFile, 'MAXXML', 'DriverId',   Trim(edDriverName.Text  ));

    if (cbEmbedded.Checked) then
      setINI(wIniFile, 'MAXXML', 'Embedded',  'True')
    else
      setINI(wIniFile, 'MAXXML', 'Embedded',  'False');

    setINI(wIniFile, 'MAXXML', 'CharacterSet',  Trim(edCharacterSet.Text));
    setINI(wIniFile, 'MAXXML', 'Conexao',    cbbTipoConexao.Items[cbbTipoConexao.ItemIndex]);

    if cbbTipoConexao.ItemIndex = 1 then
    begin
      setINI(wIniFile, 'MAXXML', 'Port',     Trim(edServerPort.Text  ));
      setINI(wIniFile, 'MAXXML', 'Server',   Trim(edServerName.Text  ));
      setINI(wIniFile, 'MAXXML', 'Protocol', Trim(edProtocol.Text));
    end
    else
    if cbbTipoConexao.ItemIndex = 0 then
    begin
      setINI(wIniFile, 'MAXXML', 'Port'    ,'local');
      setINI(wIniFile, 'MAXXML', 'Server  ','' );
      setINI(wIniFile, 'MAXXML', 'Protocol','');
    end
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

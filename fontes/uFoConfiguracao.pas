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
    statMSg: TStatusBar;
    pnlRodape: TPanel;
    btn2: TBitBtn;
    btnOK: TBitBtn;
    pnlMenu: TPanel;
    jtobMenuConfig: TJvToolBar;
    btnAplicar: TBitBtn;
    edConfigName: TLabeledEdit;
    btnIniFile: TToolButton;
    edServerName: TLabeledEdit;
    edServerPort: TLabeledEdit;
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
    edProtocol: TLabeledEdit;
    btnLimpa: TToolButton;
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
  private
    { Private declarations }
    function validacampos(pForm : TForm): boolean;
    function LimpaCampos(pForm : TForm): boolean;
    procedure pSalvarParametros;
    procedure pLerParametros;
    procedure pPreemcheCampos;

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


procedure TfoConfiguracao.btnAplicarClick(Sender: TObject);
begin
  if Validacampos(foConfiguracao) then
  begin
    pSalvarParametros;
  end;
end;

procedure TfoConfiguracao.btnOKClick(Sender: TObject);
begin

  if wOpe = opOK then
     ModalResult := mrOk
end;




procedure TfoConfiguracao.cbbTipoConexaoChange(Sender: TObject);
var wRemote :boolean;
begin
   wRemote := cbbTipoConexao.ItemIndex = 0;
   edServerName.Enabled := wRemote;
   edProtocol.Enabled   := wRemote;
   edServerPort.Enabled := wRemote;
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
  pgcConfig.TabIndex := 0;
end;

procedure TfoConfiguracao.pLerParametros;
begin
  if FileExists(ExtractFileName(ChangeFileExt(Application.ExeName, 'INI'))) then
  begin
    edConfigName.Text   := getINI(fArqIni, 'MAXXML', 'ConfigName', '');
    edUsuarioBD.Text    := getINI(fArqIni, 'MAXXML', 'usuario', '');
    edSenhaBD.Text      := getINI(fArqIni, 'MAXXML', 'password', '');
    edDataBase.Text     := getINI(fArqIni, 'MAXXML', 'Database', '');
    edSQLDialect.Text   := getINI(fArqIni, 'MAXXML', 'SQLDialect', '');
    edVendorLib.Text    := getINI(fArqIni, 'MAXXML', 'VendorLib', '');
    edVendorHome.Text   := getINI(fArqIni, 'MAXXML', 'VendorHome', '');
    edDriverName.Text   := getINI(fArqIni, 'MAXXML', 'DriverId', '');
    edServerName.Text   := getINI(fArqIni, 'MAXXML', 'Server', '');
    edServerPort.Text   := getINI(fArqIni, 'MAXXML', 'Port', '');
    edCharacterSet.Text := getINI(fArqIni, 'MAXXML', 'CharacterSet', '');
    edProtocol.Text     := getINI(fArqIni, 'MAXXML', 'Protocol', '');
    cbbTipoConexao.Items[cbbTipoConexao.Items.IndexOf(getINI(fArqIni,   'MAXXML', 'Conexao', ''))];
  end;
end;

procedure TfoConfiguracao.pPreemcheCampos;
begin
  edConfigName.Text   := 'MAXXML-'+fNomePC;
  edUsuarioBD.Text    := 'sysdba';
  edSenhaBD.Text      := 'masterkey';
  edDataBase.Text     := GetCurrentDir+ '\MAXXML\BACKUPXML.FDB';
  edSQLDialect.Text   := '3';
  edVendorLib.Text    := 'fbembed.dll';
  edVendorHome.Text   := GetCurrentDir+ '\MAXXML\fb\';
  edDriverName.Text   := 'FBembed';
  edServerName.Text   := fNomePC;
  edServerPort.Text   := '3050';
  edProtocol.Text     := 'TCPIP';
  cbbTipoConexao.Items[0];
  edCharacterSet.Text := 'WIN1252';
  cbEmbedded.Checked := True;
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
begin
  wIniFile := ExtractFileName(ChangeFileExt(Application.ExeName, '.INI'));
  wIniFile := GetCurrentDir +'\'+wIniFile;

  if FileExists(fArqIni) then
  begin
    setINI(wIniFile, 'MAXXML', 'ConfigName', Trim(edConfigName.Text));
    setINI(wIniFile, 'MAXXML', 'usuario',    Trim(edUsuarioBD.Text   ));
    setINI(wIniFile, 'MAXXML', 'password',   Trim(edSenhaBD.Text     ));
    setINI(wIniFile, 'MAXXML', 'Database',   Trim(edDataBase.Text    ));
    setINI(wIniFile, 'MAXXML', 'SQLDialect', Trim(edSQLDialect.Text  ));
    setINI(wIniFile, 'MAXXML', 'VendorLib',  Trim(edVendorLib.Text   ));
    setINI(wIniFile, 'MAXXML', 'VendorHome', Trim(edVendorHome.Text  ));
    setINI(wIniFile, 'MAXXML', 'DriverId',   Trim(edDriverName.Text  ));
    setINI(wIniFile, 'MAXXML', 'Server',     Trim(edServerName.Text  ));
    setINI(wIniFile, 'MAXXML', 'Port',       Trim(edServerPort.Text  ));
    setINI(wIniFile, 'MAXXML', 'Conexao',       cbbTipoConexao.Items[cbbTipoConexao.ItemIndex]);
    setINI(wIniFile, 'MAXXML', 'Protocol',      Trim(edProtocol.Text));
    setINI(wIniFile, 'MAXXML', 'CharacterSet',  Trim(edCharacterSet.Text));
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

unit uFoConexao;

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
  private
    { Private declarations }
    wRemote :boolean;
    function validacampos(pForm : TForm): boolean;
    function LimpaCampos(pForm : TForm): boolean;
    procedure pSalvarParametros;
    procedure pLerParametros;
    procedure pPreemcheCampos;
    procedure pLocalRemote;

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
    UserName     := trim(LowerCase(edUsuarioBD.Text));
    Password     := trim(LowerCase(edSenhaBD.Text));
    DataBase     := trim(LowerCase(edDataBase.Text));
    SQLDialect   := '3';
    DriverID     := 'FB';
    CharacterSet := 'WIN1252';
  end;
end;

procedure TfoConexao.pConLocalEmbedded;
begin
  with ConecxaoBD do
  begin
    UserName     := trim(LowerCase(edUsuarioBD.Text));
    Password     := trim(LowerCase(edSenhaBD.Text));
    DataBase     := trim(LowerCase(edDataBase.Text));
    SQLDialect   := '3';
    DriverID     := 'FBEmbed';
    CharacterSet := 'WIN1252';
    VendorLib    := 'fbembed.dll';
    VendorHome   := ExtractFileDir(Application.ExeName)+'\fb\';
    Embedded     := true;
  end;
end;

procedure TfoConexao.pConRemote;
begin
  with ConecxaoBD do
  begin
    UserName     := trim(LowerCase(edUsuarioBD.Text));
    Password     := trim(LowerCase(edSenhaBD.Text));
    DataBase     := trim(LowerCase(edDataBase.Text));
    SQLDialect   := '3';
    DriverID     := 'FBEmbed';
    CharacterSet := 'WIN1252';
    Server       := trim(UpperCase(edServerName.Text));
    Protocol     := 'TCPIP';
    Port         := '3050';

  end;
end;

procedure TfoConexao.btnConectar1Click(Sender: TObject);
begin
  //
  case cbbTipoCon.ItemIndex of
   0: pConLocal;
   1: ConecxaoBD.TipoCon := tcLocalEmbed;
   2: ConecxaoBD.TipoCon := tcRemote;
  end;

  ConecxaoBD.pConecta;
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
    btnConectar1.Enabled := true;
    stat1.Panels[1].Text := 'Ping('+wHost+') Ok!';
  end
  else
  begin
    stat1.Panels[1].Text := 'Falha no Ping('+wHost+')!';
    btnConectar1.Enabled := false;
  end;

end;

procedure TfoConexao.cbbTipoConChange(Sender: TObject);
begin
  edServerName.Visible := cbbTipoCon.ItemIndex = 1;
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
//      MsgStatus('Diret�rio informado n�o existe', clRed);
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
//        Hint := 'Este campo pode ter no m�ximo 10 caracteres.';
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
 ConecxaoBD.pReadDriver;
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
    if MessageDlg('Deseja cancelar a opera��o de inserir', mtConfirmation, mbYesNo,0) = mrNo then
      ModalResult := mrCancel;
  end;
end;

procedure TfoConexao.FormShow(Sender: TObject);
begin
  pLerParametros;
  pgcConfig.TabIndex := 0;

  if ConecxaoBD.Conectado then
    stat1.Panels[1].Text := 'Conectado'
  else
    stat1.Panels[1].Text := 'Desconectado';

  btnConectar1.Enabled := not ConecxaoBD.Conectado;
end;

procedure TfoConexao.pLerParametros;
begin
  if FileExists(ChangeFileExt(Application.ExeName, '.INI')) then
  begin
    edUsuarioBD.Text    := ConecxaoBD.UserName;
    edSenhaBD.Text      := ConecxaoBD.Password;
    edDataBase.Text     := ConecxaoBD.Database;
  end;
end;

procedure TfoConexao.pLocalRemote;
begin

end;

procedure TfoConexao.pPreemcheCampos;
begin
  edUsuarioBD.Text    := 'sysdba';
  edSenhaBD.Text      := 'masterkey';
  edDataBase.Text     := GetCurrentDir+ '\BACKUPXML.FDB';
  edServerName.Text   := fNomePC;

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
    if pForm.Components[i] is TTabSheet then  // Verifica se� TabSheet
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
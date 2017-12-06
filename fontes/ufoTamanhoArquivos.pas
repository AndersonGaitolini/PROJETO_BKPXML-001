unit ufoTamanhoArquivos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadraoForm,UDirectoryTreeSize,
  Vcl.StdCtrls, Vcl.ComCtrls, JvBaseDlg, JvSelectDirectory;

type
  TfoTamArquivos = class(TfoPadraoForm)
    btnProcPesado: TButton;
    pbBarra: TProgressBar;
    lbArquivo: TLabel;
    lbPerc: TLabel;
    edPath: TEdit;
    jopd1: TJvSelectDirectory;
    procedure btnProcPesadoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edPathDblClick(Sender: TObject);

  private
    { Private declarations }
    FStartTime: TTime;
    FDirectoryTreeSize: TDirectoryTreeSize;
    procedure DoProgress (const PText: String; const PNumber: Cardinal);
    procedure DoMax(const PMax: Int64);
    procedure DoTerminate(PSender: TObject);
  public
    { Public declarations }
  end;

var
  foTamArquivos: TfoTamArquivos;

implementation

{$R *.dfm}

procedure TfoTamArquivos.btnProcPesadoClick(Sender: TObject);
begin
  inherited;
  FDirectoryTreeSize := TDirectoryTreeSize.Create;

  with FDirectoryTreeSize do
  begin
    InitialDir := edPath.Text;
    OnMax := DoMax;
    OnProgress := DoProgress;
    OnTerminate := DoTerminate;

    lbPerc.Caption := '0.00%';
    FStartTime := Now;
    edPath.Enabled := False;
    edPath.Enabled := False;

    Resume;
  end;
end;

procedure TfoTamArquivos.DoMax(const PMax: Int64);
begin
  pbBarra.Step := 1;
  pbBarra.Position := 0;
  pbBarra.Max := PMax;
  pbBarra.DoubleBuffered := True;

end;

procedure TfoTamArquivos.DoProgress(const PText: String; const PNumber: Cardinal);
begin
  pbBarra.StepIt;
  lbArquivo.Caption := 'Arquivo ' + IntToStr(pbBarra.Position) + ' / ' + IntToStr(pbBarra.Max) + ': ' + FormatFloat('(###,###,###,###,##0 bytes) ',PNumber) + PText;
  lbPerc.Caption := FormatFloat('##0.00%',pbBarra.Position / pbBarra.Max * 100);
end;

procedure TfoTamArquivos.DoTerminate(PSender: TObject);
begin
  Application.MessageBox(PChar('O tamanho total dos arquivos contidos na estrutura de diretórios "' + edPath.Text + '" é ' + FormatFloat('###,###,###,###,##0 bytes',FDirectoryTreeSize.Result)),PChar(Format('Processamento concluído em %s',[FormatDateTime('hh:nn:ss',Now - FStartTime)])),MB_ICONINFORMATION);
  btnProcPesado.Enabled := True;
  edPath.Enabled := True;
end;

procedure TfoTamArquivos.edPathDblClick(Sender: TObject);
begin
  inherited;
  with jopd1 do
  begin
    if DirectoryExists(Trim(edPath.Text)) then
      InitialDir := Trim(edPath.Text)
    else
      InitialDir := GetCurrentDir;

    if Execute then
    begin
      edPath.Text := Trim(Directory)
    end;
  end;
end;

procedure TfoTamArquivos.FormCreate(Sender: TObject);
begin
  inherited;
  edPath.Text := GetCurrentDir;
end;

end.


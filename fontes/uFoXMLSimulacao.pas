unit uFoXMLSimulacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfoXMLSimulcao = class(TForm)
    edXML: TLabeledEdit;
    btnPath: TButton;
    btnOK: TButton;
    edEmail: TLabeledEdit;
    procedure btnPathClick(Sender: TObject);
    procedure edXMLExit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  foXMLSimulcao: TfoXMLSimulcao;
  wFileName : String;

implementation

uses
  uMetodosUteis, uRotinas, Configuracoes, Lm_bkpdfe;

{$R *.dfm}

procedure TfoXMLSimulcao.btnOKClick(Sender: TObject);
var pEmail : String;
begin
  pEmail :='';

  if Trim(edEmail.Text) <> '' then
      pEmail := Trim(edEmail.Text);

 if fLoadXMLNFe(tabConfiguracoes, txTodos,false, Trim(edXML.Text), pEmail) then
   CLose
 else
    ShowMessage('Não carregou XML');
end;

procedure TfoXMLSimulcao.btnPathClick(Sender: TObject);
begin
  fOpenFile('Selecione o XML',wFilename,['XML | *.*xml'],1);
  edXML.Text := wFileName;


end;

procedure TfoXMLSimulcao.edXMLExit(Sender: TObject);
begin
  if not FileExists(edXML.Text) then
  begin
   if btnPath.CanFocus then
     btnPath.SetFocus;

   ShowMessage('Arquivo não existe: '+edXML.Text);
  end;


end;

end.

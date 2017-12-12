unit uFoProgressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  ProgressWheel;

type
  TfoProgressao = class(TForm)
    pbw1: TProgressWheel;
    btnStop: TButton;
    btnPause: TButton;
    procedure btnStopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pIncrementa;
  end;

var foProgressao : TfoProgressao;

implementation

{$R *.dfm}

{ TfoProgressao }

procedure TfoProgressao.btnStopClick(Sender: TObject);
begin
  ModalResult := mrClose
end;

procedure TfoProgressao.FormShow(Sender: TObject);
begin
  BringToFront;
end;

procedure TfoProgressao.pIncrementa;
var wPos : Int64;
begin
  wPos := pbw1.Position;
  Inc(wPos,1);
  pbw1.Position := wPos;
end;

end.

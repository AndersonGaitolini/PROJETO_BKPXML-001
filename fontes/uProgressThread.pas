unit uProgressThread;

interface

uses
  Classes;

type
  TOnProgress = procedure (const PText: String; const PNumber: Cardinal) of object;
  TOnMax = procedure (const PMax: Int64) of object;

  TProgressThread = class (TThread)
  private
    FText: String;
    FNumber: Cardinal;
    FOnProgress: TOnProgress;
    FMax: Int64;
    FOnMax: TOnMax;
    procedure CallOnProgress;
    procedure CallOnMax;
  protected
    procedure DoProgress;
    procedure DoMax;
    property Text: String read FText write FText;
    property Number: Cardinal read FNumber write FNumber;
    property Max: Int64 read FMax write FMax;
  public
    constructor Create; reintroduce;
    property OnProgress: TOnProgress read FOnProgress write FOnProgress;
    property OnMax: TOnMax read FOnMax write FOnMax;
  end;

implementation

{ TProgressBarThread }

procedure TProgressThread.CallOnMax;
begin
  if Assigned(FOnMax) then
    FOnMax(FMax);
end;

procedure TProgressThread.CallOnProgress;
begin
  if Assigned(FOnProgress) then
    FOnProgress(FText,FNumber);
end;

procedure TProgressThread.DoMax;
begin
  if Assigned(FOnMax) then
    Synchronize(CallOnMax);
end;

procedure TProgressThread.DoProgress;
begin
  if Assigned(FOnProgress) then
    Synchronize(CallOnProgress);
end;

constructor TProgressThread.Create;
begin
  inherited Create(True);
  FreeOnTerminate := True;
end;

end.

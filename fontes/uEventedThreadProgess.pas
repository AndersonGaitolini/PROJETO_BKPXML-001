unit uEventedThreadProgress;



interface
uses
  Classes,
  uProgressThread;

type
  TCustomEventedThreadProgress = class(TProgressThread)
  private
    FOnExecute: TNotifyEvent;
    FOnSetUp: TNotifyEvent;
    FOnTearDown: TNotifyEvent;
  strict protected
    procedure DoExecute; override;
    procedure DoSetUp; override;
    procedure DoTearDown; override;
  public
    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
    property OnSetUp: TNotifyEvent read FOnSetUp write FOnSetUp;
    property OnTearDown: TNotifyEvent read FOnTearDown write FOnTearDown;
  end;

  // in case you want to use RTTI
  TEventedThread = class(TCustomEventedThreadProgress)
  published
    property OnExecute;
    property OnSetUp;
    property OnTearDown;
  end;

implementation

{ TCustomEventedThread }

procedure TCustomEventedThreadProgress.DoExecute;
var
  TheOnExecute: TNotifyEvent;
begin
  inherited;
  TheOnExecute := OnExecute;
  if Assigned(TheOnExecute) then
    TheOnExecute(Self);
end;

procedure TCustomEventedThreadProgress.DoSetUp;
var
  TheOnSetUp: TNotifyEvent;
begin
  inherited;
  TheOnSetUp := OnSetUp;
  if Assigned(TheOnSetUp) then
    TheOnSetUp(Self);
end;

procedure TCustomEventedThreadProgress.DoTearDown;
var
  TheOnTearDown: TNotifyEvent;
begin
  inherited;
  TheOnTearDown := OnTearDown;
  if Assigned(TheOnTearDown) then
    TheOnTearDown(Self);
end;

end.

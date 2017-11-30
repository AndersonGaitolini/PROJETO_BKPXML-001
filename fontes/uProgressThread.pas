unit uProgressThread;

interface
uses
  Classes;

type
  TOnProgress = procedure (const PText: String; const PNumber: Cardinal) of object;
  TOnMax = procedure (const PMax: Int64) of object;


  TProgressThread = class (TThread)
  strict protected
    //1 called in the context of the thread
    procedure DoExecute; virtual;
    //1 Called in the context of the creating thread (before context of the new thread actualy lives)
    procedure DoSetUp; virtual;
    //1 called in the context of the thread right after OnTerminate, but before the thread actually dies
    procedure DoTearDown; virtual;
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

    procedure DoTerminate; override;
    procedure Execute; override;
  public
    constructor Create; reintroduce;
    property OnProgress: TOnProgress read FOnProgress write FOnProgress;
    property OnMax: TOnMax read FOnMax write FOnMax;

    procedure AfterConstruction; override;

  end;


implementation

{ TProgressBarThread }

procedure TProgressThread.AfterConstruction;
begin
  // DoSetUp() needs to be called without the new thread in suspended state
  DoSetUp();
  // this will unsuspend the underlying thread
  inherited AfterConstruction;
end;

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

//procedure TProgressThread.DoExecute;
//var
//  TheOnExecute: TNotifyEvent;
//begin
//  inherited;
//  TheOnExecute := OnExecute;
//  if Assigned(TheOnExecute) then
//    TheOnExecute(Self);
//end;

procedure TProgressThread.DoExecute;
begin

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

procedure TProgressThread.DoSetUp;
begin

end;

//procedure TProgressThread.DoSetUp;
//var
//  TheOnSetUp: TNotifyEvent;
//begin
//  inherited;
//  TheOnSetUp := OnSetUp;
//  if Assigned(TheOnSetUp) then
//    TheOnSetUp(Self);
//end;

//procedure TProgressThread.DoTearDown;
//var
//  TheOnTearDown: TNotifyEvent;
//begin
//  inherited;
//  TheOnTearDown := OnTearDown;
//  if Assigned(TheOnTearDown) then
//    TheOnTearDown(Self);
//end;

procedure TProgressThread.DoTearDown;
begin

end;

procedure TProgressThread.DoTerminate;
begin
  inherited DoTerminate();
  // call DoTearDown on in the thread context right before it dies:
  DoTearDown();
end;

procedure TProgressThread.Execute;
begin
  inherited;
    // call DoExecute on in the thread context
  DoExecute();
end;

constructor TProgressThread.Create;
begin
  inherited Create(True);
  FreeOnTerminate := True;
end;



end.

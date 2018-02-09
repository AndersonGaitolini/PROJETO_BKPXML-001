unit uProgressWheel;

interface

uses
  Windows, SysUtils, Classes, Controls, Messages, Graphics;

type

  TProgressAlign = (paCenter,paLeftOrTop,paRightOrBottom);
  TGradientMode = (gmNone,gmPosition,gmAngle);
  TStringEvent = procedure(Sender: TObject; var Text: string) of object;

  TProgressWheel = class(TCustomControl)
  private
    { Private declarations }
    FGradient: TBitmap;
    FProgressAlign: TProgressAlign;
    FColorDoneMin: TColor;
    FColorDoneMax: TColor;
    FColorRemain: TColor;
    FColorInner: TColor;
    FStartAngle: Integer;
    FMin: Integer;
    FMax: Integer;
    FPosition: Integer;
    FInnerSize: Integer;
    FShowText: Boolean;
    FGradientMode: TGradientMode;
    FOnText: TStringEvent;
    procedure SetProgressAlign(const Value: TProgressAlign);
    procedure SetColorDoneMin(const Value: TColor);
    procedure SetColorDoneMax(const Value: TColor);
    procedure SetColorRemain(const Value: TColor);
    procedure SetColorInner(const Value: TColor);
    procedure SetStartAngle(const Value: Integer);
    procedure SetMin(const Value: Integer);
    procedure SetMax(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetInnerSize(const Value: Integer);
    procedure SetShowText(const Value: Boolean);
    procedure SetGradientMode(const Value: TGradientMode);
    function GradientColor(ColorBegin,ColorEnd: TColor; AMin,AMax,APosition: Integer): TColor;
    function AnglePosition(R: TRect; AMin,AMax,APosition: Integer): TPoint;
    procedure UpdateAngleGradientBrush;
  protected
    { Protected declarations }
    procedure WndProc(var Msg: TMessage); override;
    procedure Loaded; override;
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property ProgressAlign: TProgressAlign read FProgressAlign write SetProgressAlign default paCenter;
    property ColorDoneMin: TColor read FColorDoneMin write SetColorDoneMin default clMaroon;
    property ColorDoneMax: TColor read FColorDoneMax write SetColorDoneMax default clRed;
    property ColorRemain: TColor read FColorRemain write SetColorRemain default clSilver;
    property ColorInner: TColor read FColorInner write SetColorInner default clWhite;
    property StartAngle: Integer read FStartAngle write SetStartAngle default 0;
    property Min: Integer read FMin write SetMin default 0;
    property Max: Integer read FMax write SetMax default 100;
    property Position: Integer read FPosition write SetPosition default 0;
    property InnerSize: Integer read FInnerSize write SetInnerSize default 75;
    property ShowText: Boolean read FShowText write SetShowText default True;
    property GradientMode: TGradientMode read FGradientMode write SetGradientMode default gmNone;
    property OnText: TStringEvent read FOnText write FOnText;
    property Align;
    property Anchors;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Font;
    property ParentFont;
    property Color;
    property ParentColor;
    property ParentShowHint;
    property ShowHint;
    property PopupMenu;
    property Visible;
    property UseDockManager;
  end;

procedure Register;

implementation

const
  BufScale = 3;

procedure TProgressWheel.SetProgressAlign(const Value: TProgressAlign);
begin
  if FProgressAlign<>Value then
  begin
    FProgressAlign:=Value;
    UpdateAngleGradientBrush;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetColorDoneMin(const Value: TColor);
begin
  if FColorDoneMin<>Value then
  begin
    FColorDoneMin:=Value;
    UpdateAngleGradientBrush;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetColorDoneMax(const Value: TColor);
begin
  if FColorDoneMax<>Value then
  begin
    FColorDoneMax:=Value;
    UpdateAngleGradientBrush;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetColorRemain(const Value: TColor);
begin
  if FColorRemain<>Value then
  begin
    FColorRemain:=Value;
    UpdateAngleGradientBrush;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetColorInner(const Value: TColor);
begin
  if FColorInner<>Value then
  begin
    FColorInner:=Value;
    UpdateAngleGradientBrush;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetStartAngle(const Value: Integer);
var
  V: Integer;
begin
  V:=Value;
  if V<0 then V:=0;
  if V>359 then V:=359;
  if FStartAngle<>V then
  begin
    FStartAngle:=V;
    UpdateAngleGradientBrush;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetMin(const Value: Integer);
var
  V: Integer;
begin
  V:=Value;
  if V>=FMax then V:=Pred(MaxInt);
  if FMin<>V then
  begin
    FMin:=V;
    if FPosition<FMin then FPosition:=FMin;
    UpdateAngleGradientBrush;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetMax(const Value: Integer);
var
  V: Integer;
begin
  V:=Value;
  if V<=FMin then V:=Succ(FMin);
  if FMax<>V then
  begin
    FMax:=V;
    if FPosition>FMax then FPosition:=FMax;
    UpdateAngleGradientBrush;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetPosition(const Value: Integer);
var
  V: Integer;
begin
  V:=Value;
  if V<Min then V:=Min;
  if V>Max then V:=Max;
  if FPosition<>V then
  begin
    FPosition:=V;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetInnerSize(const Value: Integer);
var
  V: Integer;
begin
  V:=Value;
  if V<0 then V:=0;
  if V>99 then V:=99;
  if FInnerSize<>V then
  begin
    FInnerSize:=V;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetShowText(const Value: Boolean);
begin
  if FShowText<>Value then
  begin
    FShowText:=Value;
    Invalidate;
  end;
end;

procedure TProgressWheel.SetGradientMode(const Value: TGradientMode);
begin
  if FGradientMode<>Value then
  begin
    FGradientMode:=Value;
    UpdateAngleGradientBrush;
    Invalidate;
  end;
end;

function TProgressWheel.GradientColor(ColorBegin,ColorEnd: TColor; AMin,AMax,APosition: Integer): TColor;
var
  B,E,B1,B2,B3,E1,E2,E3: Integer;
  P: Double;
begin
  B:=ColorToRGB(ColorBegin);
  B1:=B and $FF;
  B2:=(B shr 8) and $FF;
  B3:=(B shr 16) and $FF;
  E:=ColorToRGB(ColorEnd);
  E1:=E and $FF;
  E2:=(E shr 8) and $FF;
  E3:=(E shr 16) and $FF;
  if AMax-AMin<>0 then P:=(APosition-AMin)/(AMax-AMin)
  else P:=0;
  Result:=Round(B1+(E1-B1)*P)+Round(B2+(E2-B2)*P) shl 8+Round(B3+(E3-B3)*P) shl 16;
end;

function TProgressWheel.AnglePosition(R: TRect; AMin,AMax,APosition: Integer): TPoint;
var
  a: Double;
begin
  a:=(StartAngle-90)+360*(APosition/(AMax-AMin)-AMin);
  a:=pi*a/180;
  with R do
  begin
    Result.X:=Round(Cos(a)*(Right-Left)/2+(Left+Right)/2);
    Result.Y:=Round(Sin(a)*(Bottom-Top)/2+(Bottom+Top)/2);
  end;
end;

procedure TProgressWheel.UpdateAngleGradientBrush;
var
  R: TRect;
  i: Integer;
  P1,P2: TPoint;
begin
  if GradientMode<>gmAngle then FreeAndNil(FGradient)
  else
  begin
    FGradient:=TBitmap.Create;
    with FGradient do
    begin
      if ClientWidth<ClientHeight then
      begin
        Width:=ClientWidth*BufScale;
        Height:=ClientWidth*BufScale;
      end
      else
      begin
        Width:=ClientHeight*BufScale;
        Height:=ClientHeight*BufScale;
      end;
      R:=Rect(0,0,Width,Height);
      with Canvas do
      begin
        Pen.Style:=psClear;
        for i:=0 to 99 do
          with R do
          begin
            P1:=AnglePosition(R,0,100,i);
            P2:=AnglePosition(R,0,100,Succ(i));
            Brush.Color:=GradientColor(ColorDoneMin,ColorDoneMax,0,100,i);
            Pie(Left,Top,Right,Bottom,P2.X,P2.Y,P1.X,P1.Y);
          end;
      end;
    end;
    FGradient.SaveToFile('grad.bmp');
  end;
end;

procedure TProgressWheel.WndProc(var Msg: TMessage);
begin
  with Msg do
    case Msg of
      WM_ERASEBKGND: Result:=1;
      WM_SIZE:
      begin
        UpdateAngleGradientBrush;
        inherited;
      end;
    else inherited;
    end;
end;

procedure TProgressWheel.Loaded;
begin
  inherited;
  UpdateAngleGradientBrush;
end;

procedure TProgressWheel.Paint;
var
  Buf: TBitmap;
  R,RR: TRect;
  P1,P2: TPoint;
  S: string;
begin
  if Width>Height then R:=Rect(0,0,Height,Height)
  else R:=Rect(0,0,Width,Width);
  case ProgressAlign of
    paCenter: OffsetRect(R,(Width-R.Right) div 2,(Height-R.Bottom) div 2);
    paRightOrBottom: OffsetRect(R,Width-R.Right,Height-R.Bottom);
  end;
  Buf:=TBitmap.Create;
  with Buf do
  begin
    Width:=BufScale*ClientWidth;
    Height:=BufScale*ClientHeight;
    with Canvas do
    begin
      Pen.Color:=Color;
      Brush.Color:=Color;
      FillRect(Rect(0,0,Width,Height));
      Pen.Style:=psClear;
      Brush.Color:=ColorRemain;
      with R do
      begin
        Left:=Left*BufScale;
        Right:=Right*BufScale;
        Top:=Top*BufScale;
        Bottom:=Bottom*BufScale;
        RR:=Rect(Left+(Right-Left) div 4,Top+(Bottom-Top) div 4,Right-(Right-Left) div 4,Bottom-(Bottom-Top) div 4);
      end;
      with R do
      begin
        Ellipse(Left,Top,Right,Bottom);
        if Position>Min then
        begin
          P1:=AnglePosition(R,Min,Max,0);
          P2:=AnglePosition(R,Min,Max,Position);
          case GradientMode of
            gmNone: Brush.Color:=ColorDoneMax;
            gmPosition: Brush.Color:=GradientColor(ColorDoneMin,ColorDoneMax,Min,Max,Position);
            gmAngle:
            begin
              Brush.Bitmap:=FGradient;
              case ProgressAlign of
                paCenter: SetBrushOrgEx(Handle,(Width-FGradient.Width-BufScale) div 2,(Height-FGradient.Height-BufScale) div 2,nil);
                paRightOrBottom: SetBrushOrgEx(Handle,Width-FGradient.Width,Height-FGradient.Height,nil);
              else SetBrushOrgEx(Handle,0,0,nil);
              end;
            end;
          end;
          Pie(Left,Top,Right,Bottom,P2.X,P2.Y,P1.X,P1.Y);
        end;
        if InnerSize>0 then
        begin
          RR:=Rect(
            Left+(100-InnerSize)*(Right-Left) div 200,
            Top+(100-InnerSize)*(Bottom-Top) div 200,
            Right-(100-InnerSize)*(Right-Left) div 200,
            Bottom-(100-InnerSize)*(Bottom-Top) div 200);
          Brush.Color:=ColorInner;
          with RR do Ellipse(Left,Top,Right,Bottom);
        end;
      end;
    end;
  end;
  with Canvas do
  begin
    SetStretchBltMode(Handle,HALFTONE);
    SetBrushOrgEx(Handle,0,0,nil);
    CopyRect(Rect(0,0,ClientWidth,ClientHeight),Buf.Canvas,Rect(0,0,Buf.Width,Buf.Height));
    if ShowText then
    begin
      S:=IntToStr(100*(Position-Min) div (Max-Min))+'%';
      if Assigned(OnText) then OnText(Self,S);
      Font.Assign(Self.Font);
      Brush.Style:=bsClear;
      R:=ClientRect;
      DrawText(Handle,PChar(S),-1,R,DT_NOPREFIX or DT_CENTER or DT_CALCRECT);
      with R do
        R:=Rect(
          (ClientWidth-Right+Left) div 2,
          (ClientHeight-Bottom+Top) div 2,
          ClientWidth-(ClientWidth-(Right-Left)) div 2,
          ClientHeight-(ClientHeight-(Bottom-Top)) div 2);
      OffsetRect(R,0,-InnerSize*ClientHeight div 6000);
      DrawText(Handle,PChar(S),-1,R,DT_NOPREFIX or DT_CENTER);
    end;
  end;
  Buf.Free;
end;

constructor TProgressWheel.Create(AOwner: TComponent);
begin
  inherited;
  FColorDoneMin:=clMaroon;
  FColorDoneMax:=clRed;
  FColorRemain:=clSilver;
  FColorInner:=clWhite;
  FMax:=100;
  FInnerSize:=75;
  FShowText:=True;
  DoubleBuffered:=True;
end;

destructor TProgressWheel.Destroy;
begin
  if Assigned(FGradient) then FGradient.Free;
  inherited;
end;

procedure Register;
begin
  RegisterComponents('Standard', [TProgressWheel]);
end;

end.


//procedure Register;
//begin
//  RegisterComponents('Standard', [TCustomControl1]);
//end;
//
//end.


object foProgressao: TfoProgressao
  Left = 0
  Top = 0
  HorzScrollBar.Style = ssFlat
  Anchors = [akLeft]
  AutoSize = True
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 161
  ClientWidth = 178
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  PrintScale = poNone
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pbw1: TProgressWheel
    Left = 0
    Top = 0
    Width = 178
    Height = 123
    Align = alTop
    ExplicitTop = -6
  end
  object btnStop: TButton
    Left = 88
    Top = 123
    Width = 90
    Height = 38
    Align = alRight
    Caption = '&Pare'
    TabOrder = 1
    OnClick = btnStopClick
    ExplicitLeft = 80
    ExplicitTop = 129
  end
  object btnPause: TButton
    Left = 0
    Top = 123
    Width = 90
    Height = 38
    Align = alLeft
    Caption = '&Pause'
    TabOrder = 0
    OnClick = btnStopClick
    ExplicitLeft = 88
    ExplicitTop = 112
    ExplicitHeight = 29
  end
end

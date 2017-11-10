object foXMLSimulcao: TfoXMLSimulcao
  Left = 0
  Top = 0
  Caption = 'XML Simul'#231#227'o de envio por  par'#226'metros'
  ClientHeight = 242
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edXML: TLabeledEdit
    Left = 51
    Top = 55
    Width = 289
    Height = 21
    EditLabel.Width = 140
    EditLabel.Height = 13
    EditLabel.Caption = 'Arquivo XML(Nfe_Env, Can_)'
    TabOrder = 0
    OnExit = edXMLExit
  end
  object btnPath: TButton
    Left = 346
    Top = 53
    Width = 75
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = btnPathClick
  end
  object btnOK: TButton
    Left = 211
    Top = 164
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 2
    OnClick = btnOKClick
  end
  object edEmail: TLabeledEdit
    Left = 51
    Top = 105
    Width = 289
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Email'
    TabOrder = 3
  end
end

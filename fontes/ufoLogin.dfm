inherited foLogin: TfoLogin
  Left = 146
  Top = 55
  Anchors = []
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SOUIS  - MAXXML'
  ClientHeight = 195
  ClientWidth = 197
  OnCreate = FormCreate
  ExplicitWidth = 203
  ExplicitHeight = 224
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnl1: TPanel
    Width = 197
    Height = 176
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    ExplicitHeight = 284
    inherited lbUserNome: TLabel
      Left = 7
      Top = 60
      Width = 38
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      Anchors = []
      Caption = 'Usu'#225'rio:'
      ExplicitLeft = 7
      ExplicitTop = 60
      ExplicitWidth = 38
    end
    object lbSenha: TLabel [1]
      Left = 10
      Top = 86
      Width = 32
      Height = 13
      Anchors = []
      Caption = 'Senha:'
    end
    object lbMAXXML: TLabel [2]
      Left = 36
      Top = 14
      Width = 125
      Height = 19
      Anchors = []
      Caption = 'LOGIN - MAXXML'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    inherited edUsuario: TEdit
      Left = 48
      Top = 57
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      Anchors = []
      OnChange = edUsuarioChange
      OnExit = edUsuarioExit
      ExplicitLeft = 48
      ExplicitTop = 57
    end
    inherited edSenha: TEdit
      Left = 48
      Top = 83
      Height = 21
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      Anchors = []
      OnChange = edSenhaChange
      OnExit = edSenhaExit
      ExplicitLeft = 48
      ExplicitTop = 83
      ExplicitHeight = 21
    end
    inherited btnAcessar: TBitBtn
      Left = 36
      Top = 110
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      Anchors = []
      Caption = '&Entrar'
      Default = True
      OnClick = btnAcessarClick
      ExplicitLeft = 36
      ExplicitTop = 110
    end
    object btnCancelar: TBitBtn
      Left = 101
      Top = 110
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = []
      Caption = '&Cancelar'
      Default = True
      ModalResult = 2
      TabOrder = 3
      OnClick = btnCancelarClick
    end
  end
  object statMsg: TStatusBar
    Left = 0
    Top = 176
    Width = 197
    Height = 19
    Panels = <
      item
        Width = 60
      end
      item
        Width = 50
      end>
    ExplicitTop = 284
    ExplicitWidth = 242
  end
end

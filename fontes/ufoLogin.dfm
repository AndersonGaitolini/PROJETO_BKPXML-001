inherited foLogin: TfoLogin
  Left = 146
  Top = 55
  Anchors = []
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SOUIS  - MAXXML'
  ClientHeight = 175
  ClientWidth = 197
  Menu = mmMenuLogin
  OnCreate = FormCreate
  ExplicitWidth = 203
  ExplicitHeight = 224
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnl1: TPanel
    Width = 197
    Height = 156
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    ExplicitTop = -6
    ExplicitWidth = 197
    ExplicitHeight = 156
    inherited lbUserNome: TLabel
      Left = 7
      Top = 53
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
      Top = 76
      Width = 32
      Height = 12
      Anchors = []
      Caption = 'Senha:'
      ExplicitTop = 86
    end
    object lbMAXXML: TLabel [2]
      Left = 36
      Top = 11
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
      ExplicitTop = 14
    end
    inherited edUsuario: TEdit
      Left = 48
      Top = 49
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      Anchors = []
      OnChange = edUsuarioChange
      OnExit = edUsuarioExit
      ExplicitLeft = 48
      ExplicitTop = 49
    end
    inherited edSenha: TEdit
      Left = 48
      Top = 72
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      Anchors = []
      OnChange = edSenhaChange
      OnExit = edSenhaExit
      ExplicitLeft = 48
      ExplicitTop = 72
    end
    inherited btnAcessar: TBitBtn
      Left = 36
      Top = 96
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      Anchors = []
      Caption = '&Entrar'
      Default = True
      OnClick = btnAcessarClick
      ExplicitLeft = 36
      ExplicitTop = 96
    end
    object btnCancelar: TBitBtn
      Left = 101
      Top = 96
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
    Top = 156
    Width = 197
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
    ExplicitTop = 162
  end
  object mmMenuLogin: TMainMenu
    Left = 156
    Top = 21
    object Configura1: TMenuItem
      Caption = 'Configura'#231#245'es'
      object mmConexoBD: TMenuItem
        Caption = 'Conex'#227'o BD'
        OnClick = mmConexoBDClick
      end
    end
  end
end

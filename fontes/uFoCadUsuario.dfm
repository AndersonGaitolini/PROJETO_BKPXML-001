inherited foCadUsuario: TfoCadUsuario
  Caption = 'Cadastro de usu'#225'rio e senha'
  ClientHeight = 157
  ClientWidth = 255
  Position = poMainFormCenter
  OnCreate = FormCreate
  ExplicitWidth = 271
  ExplicitHeight = 196
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnl1: TPanel
    Width = 255
    Height = 157
    ExplicitLeft = 1
    ExplicitWidth = 281
    ExplicitHeight = 176
    inherited lbUserNome: TLabel
      Left = 62
      Top = 30
      Width = 38
      Caption = 'Usu'#225'rio:'
      ExplicitLeft = 62
      ExplicitTop = 30
      ExplicitWidth = 38
    end
    object lb1: TLabel [1]
      Left = 68
      Top = 52
      Width = 32
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Senha:'
    end
    object lb2: TLabel [2]
      Left = 32
      Top = 72
      Width = 68
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Repita a senha:'
    end
    inherited btnAcessar: TBitBtn [3]
      Left = 34
      Top = 114
      Enabled = False
      TabOrder = 3
      Visible = False
      ExplicitLeft = 34
      ExplicitTop = 114
    end
    inherited edUsuario: TEdit [4]
      Left = 104
      Top = 25
      OnExit = edUsuarioExit
      ExplicitLeft = 104
      ExplicitTop = 25
    end
    inherited edSenha: TEdit [5]
      Left = 104
      Top = 49
      OnExit = edSenhaExit
      ExplicitLeft = 104
      ExplicitTop = 49
    end
    object edSenha2: TEdit
      Left = 105
      Top = 73
      Width = 97
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      PasswordChar = '*'
      TabOrder = 2
      OnExit = edSenha2Exit
    end
    object btnAplicar: TBitBtn
      Left = 98
      Top = 114
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'OK'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btnAplicarClick
    end
    object btnCancelar: TBitBtn
      Left = 162
      Top = 114
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 5
    end
    object btnOK: TBitBtn
      Left = 34
      Top = 114
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Enabled = False
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 6
    end
  end
  inherited mmMenuTelaAcesso: TMainMenu
    Left = 256
    Top = 8
  end
end

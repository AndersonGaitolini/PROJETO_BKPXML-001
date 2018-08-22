inherited foAutoriza: TfoAutoriza
  BorderStyle = bsDialog
  Caption = 'Autoriza'#231#227'o'
  ClientHeight = 136
  ClientWidth = 215
  Font.Name = 'Segoe UI'
  Position = poMainFormCenter
  PrintScale = poNone
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  ExplicitWidth = 221
  ExplicitHeight = 165
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnl1: TPanel
    Width = 215
    Height = 136
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 203
    ExplicitHeight = 136
    inherited lbUserNome: TLabel
      Left = 21
      Top = 53
      Width = 33
      Caption = 'Usu'#225'rio'
      ExplicitLeft = 21
      ExplicitTop = 53
      ExplicitWidth = 33
    end
    object lbSenha: TLabel [1]
      Left = 29
      Top = 83
      Width = 27
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Senha'
    end
    object lbTitulo: TLabel [2]
      Left = 19
      Top = 21
      Width = 177
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Autorize com usu'#225'rio e senha '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    inherited edUsuario: TEdit
      Left = 59
      Top = 50
      OnExit = edUsuarioExit
      ExplicitLeft = 59
      ExplicitTop = 50
    end
    inherited edSenha: TEdit
      Left = 59
      Top = 80
      OnExit = edSenhaExit
      ExplicitLeft = 59
      ExplicitTop = 80
    end
    inherited btnAcessar: TBitBtn
      Top = 104
      OnClick = btnAcessarClick
      ExplicitTop = 104
    end
  end
end

inherited foLogin: TfoLogin
  Left = 146
  Top = 55
  Caption = 'Tela de Login'
  ClientHeight = 303
  OnCreate = FormCreate
  ExplicitHeight = 342
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnl1: TPanel
    Height = 284
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    ExplicitHeight = 284
    inherited lbUserNome: TLabel
      Left = 34
      Top = 66
      Width = 38
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      Caption = 'Usu'#225'rio:'
      ExplicitLeft = 34
      ExplicitTop = 66
      ExplicitWidth = 38
    end
    inherited edUsuario: TEdit
      Top = 64
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      OnExit = edUsuarioExit
      ExplicitTop = 64
    end
    inherited edSenha: TEdit
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      OnExit = edSenhaExit
    end
    inherited btnAcessar: TBitBtn
      Left = 59
      Margins.Left = 3
      Margins.Top = 3
      Margins.Right = 3
      Margins.Bottom = 3
      Caption = '&Entrar'
      Default = True
      OnClick = btnAcessarClick
      ExplicitLeft = 59
    end
    object btnCancelar: TBitBtn
      Left = 124
      Top = 147
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '&Cancelar'
      Default = True
      ModalResult = 2
      TabOrder = 3
      OnClick = btnCancelarClick
    end
  end
  object statMsg: TStatusBar [1]
    Left = 0
    Top = 284
    Width = 242
    Height = 19
    Panels = <
      item
        Text = 'Conexao:'
        Width = 60
      end
      item
        Text = 'Desconectado'
        Width = 50
      end>
  end
end

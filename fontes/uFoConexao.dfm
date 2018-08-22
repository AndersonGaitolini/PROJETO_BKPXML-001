object foConexao: TfoConexao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configura'#231#245'es do banco de dados'
  ClientHeight = 325
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object pnlConfig: TPanel
    Left = 0
    Top = 37
    Width = 373
    Height = 288
    Align = alClient
    TabOrder = 2
    object pgcConfig: TPageControl
      Left = 1
      Top = 1
      Width = 371
      Height = 267
      Hint = 'Configura par'#226'metros do banco de dados'
      ActivePage = tsConfigBD
      Align = alClient
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object tsConfigBD: TTabSheet
        Caption = 'Configura BD'
        object lbStatusConn: TLabel
          Left = 94
          Top = 343
          Width = 58
          Height = 12
          Caption = 'Desconetado'
        end
        object lbPerfilCon: TLabel
          Left = 13
          Top = 18
          Width = 81
          Height = 12
          Caption = 'Perfis de Conex'#227'o'
        end
        object lbTipoCon: TLabel
          Left = 174
          Top = 18
          Width = 77
          Height = 12
          Caption = 'Tipo de Conex'#227'o'
        end
        object edUsuarioBD: TLabeledEdit
          AlignWithMargins = True
          Left = 13
          Top = 73
          Width = 155
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditLabel.Width = 34
          EditLabel.Height = 12
          EditLabel.Margins.Left = 2
          EditLabel.Margins.Top = 2
          EditLabel.Margins.Right = 2
          EditLabel.Margins.Bottom = 2
          EditLabel.Caption = 'Usu'#225'rio'
          TabOrder = 2
        end
        object edSenhaBD: TLabeledEdit
          AlignWithMargins = True
          Left = 175
          Top = 73
          Width = 155
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditLabel.Width = 28
          EditLabel.Height = 12
          EditLabel.Margins.Left = 2
          EditLabel.Margins.Top = 2
          EditLabel.Margins.Right = 2
          EditLabel.Margins.Bottom = 2
          EditLabel.Caption = 'Senha'
          TabOrder = 3
        end
        object edDataBase: TLabeledEdit
          AlignWithMargins = True
          Left = 14
          Top = 148
          Width = 284
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditLabel.Width = 72
          EditLabel.Height = 12
          EditLabel.Margins.Left = 2
          EditLabel.Margins.Top = 2
          EditLabel.Margins.Right = 2
          EditLabel.Margins.Bottom = 2
          EditLabel.Caption = 'Banco de dados'
          TabOrder = 5
        end
        object btnFindBD: TButton
          Left = 303
          Top = 148
          Width = 27
          Height = 20
          Caption = '...'
          TabOrder = 6
          OnClick = btnFindBDClick
        end
        object cbbTipoCon: TComboBox
          Left = 174
          Top = 36
          Width = 156
          Height = 20
          ItemIndex = 0
          TabOrder = 1
          Text = 'Local'
          OnChange = cbbTipoConChange
          Items.Strings = (
            'Local'
            'Local(Embarcado)'
            'Remoto')
        end
        object btnConectar1: TButton
          Left = 14
          Top = 212
          Width = 317
          Height = 25
          Caption = 'Conectar'
          DoubleBuffered = False
          HotImageIndex = 0
          Images = ilCadastro
          ParentDoubleBuffered = False
          TabOrder = 9
          OnClick = btnConectar1Click
        end
        object edServerName: TLabeledEdit
          AlignWithMargins = True
          Left = 14
          Top = 187
          Width = 284
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditLabel.Width = 74
          EditLabel.Height = 12
          EditLabel.Margins.Left = 2
          EditLabel.Margins.Top = 2
          EditLabel.Margins.Right = 2
          EditLabel.Margins.Bottom = 2
          EditLabel.Caption = 'Servername / IP'
          TabOrder = 7
        end
        object btnPing: TButton
          Left = 303
          Top = 187
          Width = 27
          Height = 20
          Caption = 'Ping'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnClick = btnPingClick
        end
        object cbbPerfilCon: TComboBox
          Left = 13
          Top = 36
          Width = 155
          Height = 20
          ItemIndex = 0
          Sorted = True
          TabOrder = 0
          Text = 'MAXXML'
          OnChange = cbbPerfilConChange
          OnClick = cbbPerfilConClick
          OnDblClick = cbbPerfilConDblClick
          Items.Strings = (
            'MAXXML')
        end
        object edPorta: TLabeledEdit
          AlignWithMargins = True
          Left = 13
          Top = 110
          Width = 81
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditLabel.Width = 24
          EditLabel.Height = 12
          EditLabel.Margins.Left = 2
          EditLabel.Margins.Top = 2
          EditLabel.Margins.Right = 2
          EditLabel.Margins.Bottom = 2
          EditLabel.Caption = 'Porta'
          MaxLength = 4
          NumbersOnly = True
          TabOrder = 4
        end
        object edServer: TLabeledEdit
          AlignWithMargins = True
          Left = 98
          Top = 110
          Width = 200
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditLabel.Width = 30
          EditLabel.Height = 12
          EditLabel.Margins.Left = 2
          EditLabel.Margins.Top = 2
          EditLabel.Margins.Right = 2
          EditLabel.Margins.Bottom = 2
          EditLabel.Caption = 'Server'
          TabOrder = 10
          OnDblClick = edServerDblClick
        end
      end
    end
    object stat1: TStatusBar
      Left = 1
      Top = 268
      Width = 371
      Height = 19
      Panels = <
        item
          Text = 'Status:'
          Width = 50
        end
        item
          Text = 'Conex'#227'o inativa!'
          Width = 100
        end
        item
          Text = 'Servi'#231'o do Firebird est'#225' parado!'
          Width = 50
        end>
    end
  end
  object pnlMenu: TPanel
    Left = 0
    Top = 36
    Width = 373
    Height = 1
    Align = alTop
    TabOrder = 1
  end
  object jtobMenuConfig: TJvToolBar
    Left = 0
    Top = 0
    Width = 373
    Height = 36
    ButtonHeight = 35
    ButtonWidth = 74
    Caption = 'Configura'#231#245'es por usuario'
    Images = ilCadastro
    ShowCaptions = True
    TabOrder = 0
    object btnIniFile: TToolButton
      Left = 0
      Top = 0
      Caption = 'Auto Preenche'
      ImageIndex = 1
      OnClick = btnIniFileClick
    end
    object btnSalvaIni: TToolButton
      Left = 74
      Top = 0
      Caption = 'Salvar'
      ImageIndex = 3
      OnClick = btnSalvaIniClick
    end
    object btnLimpa: TToolButton
      Left = 148
      Top = 0
      Caption = 'Limpa'
      Enabled = False
      ImageIndex = 2
    end
  end
  object dlgOpenDir: TOpenDialog
    Left = 323
    Top = 2
  end
  object ilCadastro: TImageList
    Left = 272
    Top = 4
    Bitmap = {
      494C010104000C00940110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF05710A00FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF05710A0005710A00FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7818300B7818300B7818300B781
      8300B7818300B7818300B7818300B7818300B7818300B7818300B7818300B781
      8300B7818300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF5CA9900F6D1A100F5CB9900F3C18B00F2C08800F3C38E00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF05710A0076F9A70005710A0005710A0005710A000571
      0A0005710A0005710A00FFFFFFFFFFFFFFFFB7818300FDEFD900F4E1C900E4CF
      B400D1BCA000CDB79800DAC09A00E4C59900E9C89600EDCB9600EECC9700F3D1
      9900B7818300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF0
      CC00FEF6D500FCE6BE00F6D5A600FCC69600FFC49500FDD6AE00FFE2BF00FEE2
      BA00F4C59000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF2469D3002469D3001F5BC4001E5AC300FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF05710A0076F9A70076F9A7006FF39E005BE3830042CE610028B9
      3F0014A8240005710A00FFFFFFFFFFFFFFFFB4817600FEF3E300F8E7D3004946
      4500373C3E0051606100AE9C8200BFA88900D0B48D00E4C39300EDCB9600F3D1
      9900B7818300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFB
      DD00FEF9D800FCE4BB00F0D6A700BBC888009CBD6F0043A7360072BA5E00EFF6
      D400FDEECC00F2BF8900FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF338D
      FB003F91F400A3B6CF00E3D0BB00F5CEAD00EBBEA200E9AA7A00F2BE8E002469
      D3002469D300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF05710A0076F9A70005710A0005710A0005710A000571
      0A0005710A0005710A00FFFFFFFFFFFFFFFFB4817600FFF7EB00F9EBDA00B0A5
      98001B617D00097CA80018556F0066625B00A7947900C5AC8600DCBD8D00EECD
      9500B7818300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1B87F00F6D0
      A100FDF4D100FDEBC500FCDBB30044AB3800009402000E9A0F0010970B0057B6
      4E00FEF5DB00F4C28C00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FAC
      E200FDDCB400FDDCB500FDDDB600F7D2B000F9D7B400E4A17200EFBB9100E0D6
      D2005D90DD00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1C78D5001C78D5001C78
      D5001C78D5001C599600FFFFFFFF05710A0005710A00FFFFFFFFFFFFFFFFE4F0
      FC001C78D5001C78D5001C78D5001C78D500BA8E8500FFFCF400FAEFE400F2E5
      D6003872860029799A008D787F00956D6F00795953009D8B7300BAA38000D9BC
      8C00B47F8100FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2BD8700F1BA
      8100F3C18A00F8D5A600FFE1BE0047AD3A000088000084CD8500FFF4EF0063B5
      5200B6C07900FDC08D00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4187DA00FEE7
      CA00FEECD500FEEDD800FEEDD900F3D1B800E4AE8B00EEBA9000F9DDC200FCF0
      E400FEF6EF00D7E5F8005394EC00FFFFFFFF1C78D50082C6F90057BCFF004EB5
      FF004DB4FF001C599600FFFFFFFFFFFFFFFF05710A00FFFFFFFFFFFFFFFFE4F0
      FC002A95FF00369BFF00379CFF001C78D500BA8E8500FFFFFD00FBF4EC00FAEF
      E300A5B3B1007C707800E5A6A300C8929200A47272007657510095856C00AF99
      7800A8777900FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5C49200F5C7
      9600F4C39000F4BE8900FCC5960093C47B005CB95C0089CB8300FFFFFF00F7FE
      FC00CBCA9200F6BC8500FFFFFFFFFFFFFFFFFFFFFFFF3491FF00807F7600FEF2
      E200FEF2E300FEF3E500FEF3E600F3D7C300DD986E00F1C39E00FAE4CF00FDF4
      EC00FEF9F500FFFEFE00E5EFFD002E80ED001C78D5007DC3F70056BCFF004EB4
      FE004DB3FF001C599600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4F0
      FC002893FF003499FF00359AFF001C78D500CB9A8200FFFFFF00FEF9F500FBF3
      EC00F4EBDF0085787C00EEB7B500DAA6A600C38E8E009E6E6E0073564F009383
      6B00996E6F00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9D0A800FBD2
      AD00FAD0A900FACEA600F6CDA100D0DFB800FFFFFF00E2F2DF0071C26E0066C0
      6600C8CB9200FAC18E00FFFFFFFFFFFFFFFFFFFFFFFF3478B70033CB6700FFFA
      F500FFFBF600FFFBF700F7E2D400E4B29400ECB78E00FBE7D400B1AFAA00F0ED
      EA00FFFDFB00FFFFFF00D6ACAC00328CF9001C78D50080C6F9005BC1FF0053BA
      FF0052B8FF001C599600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4F0
      FC001F8EFF002B95FF002C96FF001C78D500CB9A8200FFFFFF00FFFEFD00FDF8
      F400FBF3EC00F0E4D900A3797800E9B5B500D9A5A500C48F8F009D6D6D007759
      52008F676900FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D4A800FDDEBF00FDDE
      BE00FDDBBB00FDDBBB00FFDEC50078BB610098D49800E7F5E6003EAD3B00008A
      00009AC17600FFCCA600F2BE8700FFFFFFFFFFFFFFFF347F6E0033CB6700FFFD
      FB00FFFDFB00FFFDFB00FAEEE700DB956B00DF986A00FCEDDE00FDF4EB00A4A6
      A400C7C8C700F9F2F200CD999900FFFFFFFF1C78D50080C6F9005BC1FF0053BA
      FF0052B8FF001C599600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4F0
      FC00E4F0FC00E4F0FC00E4F0FC00E4F0FC00DCA88700FFFFFF00FFFFFF00FFFE
      FD00FEF9F400FBF3EB00E8D9CE009E747300E8B5B500D8A4A400C18D8D009D6C
      6C007D555600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D4A800FFEFD100FEEA
      CB00FEE9C900FEE7C800FFE7C900E2E2BE00169A14002BA12900089708000092
      000090C47800FFD9BC00F2BE8700FFFFFFFFFFFFFFFF0033FF00CFD9FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E8B18B00ECB89300E2DDD600FEFAF600FFFE
      FE00FFFFFF0080BAFF003491FF00FFFFFFFF1C78D500629DCF003589CF003589
      CF003589CF001C5996001C5996001C5996001C5996001C5996001C599600FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCA88700FFFFFF00FFFFFF00FFFF
      FF00FFFEFD00FDF9F400FBF3EB00E0CFC500A1767600ECB9B900D6A2A200C68E
      8E00965F5D00585C6000FFFFFFFFFFFFFFFFFFFFFFFFFBE5BD00FFFCDF00FFF7
      D800FFF6D600FFF4D500FFF3D200FFF5DC00C5DFAD0042AB3B0043AE3B00AFD7
      9E00C5DCAA00FFE7C900F5C79300FFFFFFFFFFFFFFFF0033FF00FFFFFF00FFFF
      FF00FFFFFF0093C4FF0059A5FF0097BAE500FCECDD00B2B2AF00B2B3B100FFFF
      FF00FFFFFF004198FF003491FF00FFFFFFFF1C78D50086CCF90065CBFF005DC3
      FF005CC4FF003589CF0053BAFF0053BAFF004EB4FF004DB4FF001C78D500FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3B18E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFEFD00FDF8F300FDF6EC00DAC5BC00AC808000F3BCBB00A387
      8C003392B30019ADCC0019ADCC00FFFFFFFFFFFFFFFFFDF3D100FFFFE100FFFC
      DD00FFFDDE00FFFCDD00FFFCDE00FFFDDE00FFFFE800FFFFF000FFFFED00FFFF
      E700FFFAE000FFF7D700F6CE9D00FFFFFFFF3491FF003491FF003491FF00FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6CEFD00FFFEFE00CECF
      CE00F8F8F8003491FF00FFFFFFFFFFFFFFFF1C78D50084C9F70065CAFF005EC3
      FE005EC4FF003589CF0053BAFF0054BAFF004FB4FE004FB4FF001C78D500FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3B18E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFEFC00FFFEF900E3CFC900AA7A7100B2787300469C
      BA000FCAF40000A4E600021EAA0000009900FFFFFFFFFEF7D700FFFFE500FFFF
      E200FFFFE200FFFFE300FFFEE000FEF8D800FAE3B600F7CE9500F7CF9700F9E1
      B600FEF5D200FFFFE500F6D5A700FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF78B6FF00FFFF
      FF00C0DDFF003491FF00FFFFFFFFFFFFFFFF1C78D50085CBF80064CBFF005EC6
      FF005EC7FF003589CF0053BAFF0055BDFF0050B7FF0050B7FF001C78D500FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDBD9200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4D4D200B8857A00DCA76A0010A5
      CF0004A8E6000936C900092CC3000318AE00FFFFFFFFF7D8AB00FAE6C000FAE5
      BE00F9E1B900F8DAAE00F6CD9800F3BE8000F0B16A00F0B06700F0B37000F4BE
      8800FBCE9E00FDDDB400FBCEA000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF3491FF00FFFFFFFFFFFFFFFFFFFFFFFF1C78D5009ECFF50092D7FD0088D2
      FC008CD5FD00629DCF0085CEFD0085CEFD0080C9FC0084CBFD001C78D500FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDBD9200FCF7F400FCF7F300FBF6
      F300FBF6F300FAF5F300F9F5F300F9F5F300E1D0CE00B8857A00CF9B8600FFFF
      FFFF077DCD004860F100204ADD000416AA00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1B66F00F3BD8200F9CB
      9B00FBCD9F00FBCB9B00FBCB9B00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF001C78D5001C78D5001C78
      D5001C78D5001C78D5001C78D5001C78D5001C78D5001C78D500FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDBD9200DCA88700DCA88700DCA8
      8700DCA88700DCA88700DCA88700DCA88700DCA88700B8857A00FFFFFFFFFFFF
      FFFFFFFFFFFF3E4BDB00192DC400FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBCE
      9F00FBCE9F00FBCE9F00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end

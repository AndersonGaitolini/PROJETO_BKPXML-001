inherited foFiltroDetalahado: TfoFiltroDetalahado
  BorderIcons = [biSystemMenu]
  Caption = 'Filtro detalhado - MAXXML'
  ClientHeight = 367
  ClientWidth = 377
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 393
  ExplicitHeight = 406
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 377
    Height = 367
    Align = alClient
    TabOrder = 0
    ExplicitTop = 1
    object lbDataIni: TLabel
      Left = 49
      Top = 264
      Width = 94
      Height = 13
      Caption = 'Data emiss'#227'o Inicial'
    end
    object lbDataFIm: TLabel
      Left = 198
      Top = 264
      Width = 89
      Height = 13
      Caption = 'Data emiss'#227'o Final'
    end
    object lbA: TLabel
      Left = 180
      Top = 290
      Width = 7
      Height = 13
      Caption = 'A'
    end
    object lbA1: TLabel
      Left = 181
      Top = 163
      Width = 7
      Height = 13
      Caption = 'A'
    end
    object lbTitle: TLabel
      Left = 106
      Top = 0
      Width = 165
      Height = 29
      Caption = 'Filtro detalhado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbStatusIni: TLabel
      Left = 201
      Top = 180
      Width = 31
      Height = 13
      Caption = 'Status'
    end
    object lbOrdena: TLabel
      Left = 49
      Top = 92
      Width = 53
      Height = 13
      Caption = 'Ordena'#231#227'o'
    end
    object lbCNPJEmpresa: TLabel
      Left = 185
      Top = 92
      Width = 70
      Height = 13
      Caption = 'CNPJ Emitente'
    end
    object edIdf_DocIni: TLabeledEdit
      Left = 49
      Top = 159
      Width = 121
      Height = 21
      EditLabel.Width = 64
      EditLabel.Height = 13
      EditLabel.Caption = 'N'#186' NFe Inicial'
      MaxLength = 9
      NumbersOnly = True
      TabOrder = 0
      Text = '0001'
    end
    object edCNPJDest: TLabeledEdit
      Left = 49
      Top = 196
      Width = 121
      Height = 21
      EditLabel.Width = 86
      EditLabel.Height = 13
      EditLabel.Caption = 'CNPJ Destinat'#225'rio'
      TabOrder = 2
      Text = '0.000.000.0001-00'
    end
    object dtpDataFiltroINI: TDateTimePicker
      Left = 48
      Top = 283
      Width = 121
      Height = 20
      Date = 43006.636531076380000000
      Time = 43006.636531076380000000
      TabOrder = 4
      OnExit = dtpDataFiltroINIExit
    end
    object dtpDataFiltroFin: TDateTimePicker
      Left = 197
      Top = 285
      Width = 121
      Height = 20
      Date = 43006.636531076380000000
      Time = 43006.636531076380000000
      TabOrder = 5
    end
    object btnOK: TBitBtn
      Left = 157
      Top = 321
      Width = 75
      Height = 25
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
      NumGlyphs = 2
      TabOrder = 6
      OnClick = btnOKClick
    end
    object edIdf_DocFin: TLabeledEdit
      Left = 198
      Top = 159
      Width = 121
      Height = 21
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = 'N'#186' NFe Final'
      MaxLength = 9
      NumbersOnly = True
      TabOrder = 1
      Text = '0001'
    end
    object rgFiltroData: TRadioGroup
      Left = 48
      Top = 223
      Width = 270
      Height = 35
      Caption = 'Data'
      TabOrder = 3
    end
    object rbRecebimento: TRadioButton
      Left = 227
      Top = 234
      Width = 81
      Height = 17
      Caption = 'Recebimento'
      TabOrder = 7
    end
    object rbAlteracao: TRadioButton
      Left = 135
      Top = 234
      Width = 86
      Height = 17
      Caption = 'Altera'#231#227'o'
      TabOrder = 8
    end
    object rbEmissao: TRadioButton
      Left = 69
      Top = 234
      Width = 60
      Height = 17
      Caption = 'Emissao'
      TabOrder = 9
    end
    object jcbbStatus: TJvCheckedComboBox
      Left = 198
      Top = 196
      Width = 121
      Height = 21
      CapSelectAll = '&Select all'
      CapDeSelectAll = '&Deselect all'
      CapInvertAll = '&Invert all'
      Flat = False
      ParentFlat = False
      TabOrder = 10
    end
    object cbbOrdenaCampo: TComboBox
      Left = 46
      Top = 111
      Width = 123
      Height = 21
      TabOrder = 11
    end
    object cbbCNPJEmpresa: TComboBox
      Left = 201
      Top = 111
      Width = 118
      Height = 21
      TabOrder = 12
    end
  end
end

inherited foFiltroDetalahado: TfoFiltroDetalahado
  BorderIcons = [biSystemMenu]
  Caption = 'Filtro detalhado - MAXXML'
  ClientHeight = 283
  ClientWidth = 377
  ExplicitWidth = 393
  ExplicitHeight = 322
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 377
    Height = 283
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 2
    object lbDataIni: TLabel
      Left = 49
      Top = 159
      Width = 94
      Height = 13
      Caption = 'Data emiss'#227'o Inicial'
    end
    object lbDataFIm: TLabel
      Left = 198
      Top = 159
      Width = 89
      Height = 13
      Caption = 'Data emiss'#227'o Final'
    end
    object lbA: TLabel
      Left = 181
      Top = 177
      Width = 7
      Height = 13
      Caption = 'A'
    end
    object lbA1: TLabel
      Left = 181
      Top = 100
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
    object edIdf_DocIni: TLabeledEdit
      Left = 49
      Top = 99
      Width = 121
      Height = 21
      EditLabel.Width = 64
      EditLabel.Height = 13
      EditLabel.Caption = 'N'#186' NFe Inicial'
      TabOrder = 0
      Text = '0001'
    end
    object edCNPJDest: TLabeledEdit
      Left = 49
      Top = 136
      Width = 121
      Height = 21
      EditLabel.Width = 86
      EditLabel.Height = 13
      EditLabel.Caption = 'CNPJ Destinat'#225'rio'
      TabOrder = 1
      Text = '0.000.000.0001-00'
    end
    object edCNPJEmi: TLabeledEdit
      Left = 49
      Top = 53
      Width = 121
      Height = 21
      EditLabel.Width = 70
      EditLabel.Height = 13
      EditLabel.Caption = 'CNPJ Emitente'
      TabOrder = 2
      Text = '0.000.000.0001-00'
    end
    object dtpDataFiltroINI: TDateTimePicker
      Left = 49
      Top = 175
      Width = 121
      Height = 20
      Date = 43006.636531076380000000
      Time = 43006.636531076380000000
      TabOrder = 3
    end
    object dtpDataFiltroFin: TDateTimePicker
      Left = 198
      Top = 175
      Width = 105
      Height = 20
      Date = 43006.636531076380000000
      Time = 43006.636531076380000000
      TabOrder = 4
    end
    object btnOK: TBitBtn
      Left = 142
      Top = 227
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
      TabOrder = 5
    end
    object edIdf_DocFin: TLabeledEdit
      Left = 198
      Top = 99
      Width = 121
      Height = 21
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = 'N'#186' NFe Final'
      TabOrder = 6
      Text = '0001'
    end
  end
end

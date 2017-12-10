inherited foTamArquivos: TfoTamArquivos
  Caption = 'Tamanho de arquivos(Treeview)'
  ClientHeight = 181
  OnCreate = FormCreate
  ExplicitWidth = 519
  ExplicitHeight = 220
  PixelsPerInch = 96
  TextHeight = 13
  object lbArquivo: TLabel
    Left = 17
    Top = 68
    Width = 37
    Height = 13
    Caption = 'Arquivo'
  end
  object lbPerc: TLabel
    Left = 17
    Top = 114
    Width = 51
    Height = 13
    Caption = 'Percentual'
  end
  object btnProcPesado: TButton
    Left = 144
    Top = 85
    Width = 99
    Height = 25
    Caption = 'Proc. Pesado'
    TabOrder = 0
    OnClick = btnProcPesadoClick
  end
  object pbBarra: TProgressBar
    Left = 0
    Top = 164
    Width = 503
    Height = 17
    Align = alBottom
    TabOrder = 1
  end
  object edPath: TEdit
    Left = 17
    Top = 87
    Width = 121
    Height = 21
    TabOrder = 2
    OnDblClick = edPathDblClick
  end
  object jopd1: TJvSelectDirectory
    Left = 450
    Top = 20
  end
end

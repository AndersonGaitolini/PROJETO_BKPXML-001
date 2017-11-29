object DM_NFEDFE: TDM_NFEDFE
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 330
  Width = 364
  object conConexaoFD: TFDConnection
    Params.Strings = (
      'CharacterSet=WIN1252'
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=E:\BT\7.0\MaxWin\Zancanaro\MAXXML\BACKUPXML.FDB'
      '|Database=E:\BT\7.0\MaxWin\Zancanaro\MAXXML\BACKUPXML.FDB'
      'Port=3050'
      'Protocol=Local'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 28
    Top = 80
  end
  object fdtrTransacao: TFDTransaction
    Connection = conConexaoFD
    Left = 252
    Top = 77
  end
  object fdWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 100
    Top = 77
  end
  object fddrfbDriver: TFDPhysFBDriverLink
    DriverID = 'FBEmbed'
    VendorLib = 'C:\fb\bin\fbembed.dll'
    Embedded = True
    Left = 171
    Top = 79
  end
  object dsConfiguracoes: TDataSource
    DataSet = cdsConfiguracoes
    Left = 171
    Top = 138
  end
  object dsBkpdfe: TDataSource
    DataSet = cdsBkpdfe
    Left = 173
    Top = 256
  end
  object cdsBkpdfe: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'STATUS'
        DataType = ftSmallint
      end
      item
        Name = 'CNPJ'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'CHAVE'
        DataType = ftString
        Size = 300
      end
      item
        Name = 'DATAEMISSAO'
        DataType = ftDate
      end
      item
        Name = 'DATARECTO'
        DataType = ftDate
      end
      item
        Name = 'IDF_DOCUMENTO'
        DataType = ftInteger
      end
      item
        Name = 'MOTIVO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PROTOCOLOCANC'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PROTOCOLORECTO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DATAALTERACAO'
        DataType = ftDate
      end
      item
        Name = 'TIPO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'EMAILSNOTIFICADOS'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'TIPOAMBIENTE'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'XMLENVIO'
        DataType = ftBlob
      end
      item
        Name = 'XMLEXTEND'
        DataType = ftBlob
      end
      item
        Name = 'MOTIVOCANC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'XMLENVIOCANC'
        DataType = ftBlob
      end
      item
        Name = 'XMLEXTENDCANC'
        DataType = ftBlob
      end
      item
        Name = 'PROTOCOLOAUT'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'XMLERRO'
        DataType = ftMemo
      end
      item
        Name = 'SELECAO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CHECKBOX'
        DataType = ftSmallint
      end
      item
        Name = 'CNPJDEST'
        DataType = ftString
        Size = 14
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'provBkpdfe'
    StoreDefs = True
    Left = 21
    Top = 256
    object cdsBkpdfeID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsBkpdfeSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
    end
    object cdsBkpdfeCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 14
    end
    object cdsBkpdfeCHAVE: TStringField
      FieldName = 'CHAVE'
      Origin = 'CHAVE'
      Size = 300
    end
    object cdsBkpdfeDATAEMISSAO: TDateField
      FieldName = 'DATAEMISSAO'
      Origin = 'DATAEMISSAO'
    end
    object cdsBkpdfeDATARECTO: TDateField
      FieldName = 'DATARECTO'
      Origin = 'DATARECTO'
    end
    object cdsBkpdfeIDF_DOCUMENTO: TIntegerField
      FieldName = 'IDF_DOCUMENTO'
      Origin = 'IDF_DOCUMENTO'
    end
    object cdsBkpdfeMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Origin = 'MOTIVO'
    end
    object cdsBkpdfePROTOCOLOCANC: TStringField
      FieldName = 'PROTOCOLOCANC'
      Origin = 'PROTOCOLOCANC'
      Size = 50
    end
    object cdsBkpdfePROTOCOLORECTO: TStringField
      FieldName = 'PROTOCOLORECTO'
      Origin = 'PROTOCOLORECTO'
      Size = 50
    end
    object cdsBkpdfeDATAALTERACAO: TDateField
      FieldName = 'DATAALTERACAO'
      Origin = 'DATAALTERACAO'
    end
    object cdsBkpdfeTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object cdsBkpdfeEMAILSNOTIFICADOS: TStringField
      FieldName = 'EMAILSNOTIFICADOS'
      Origin = 'EMAILSNOTIFICADOS'
      Size = 150
    end
    object cdsBkpdfeTIPOAMBIENTE: TStringField
      FieldName = 'TIPOAMBIENTE'
      Origin = 'TIPOAMBIENTE'
      Size = 30
    end
    object cdsBkpdfeXMLENVIO: TBlobField
      FieldName = 'XMLENVIO'
      Origin = 'XMLENVIO'
    end
    object cdsBkpdfeXMLEXTEND: TBlobField
      FieldName = 'XMLEXTEND'
      Origin = 'XMLEXTEND'
    end
    object cdsBkpdfeMOTIVOCANC: TStringField
      FieldName = 'MOTIVOCANC'
      Origin = 'MOTIVOCANC'
    end
    object cdsBkpdfeXMLENVIOCANC: TBlobField
      FieldName = 'XMLENVIOCANC'
      Origin = 'XMLENVIOCANC'
    end
    object cdsBkpdfeXMLEXTENDCANC: TBlobField
      FieldName = 'XMLEXTENDCANC'
      Origin = 'XMLEXTENDCANC'
    end
    object cdsBkpdfePROTOCOLOAUT: TStringField
      FieldName = 'PROTOCOLOAUT'
      Origin = 'PROTOCOLOAUT'
      Size = 50
    end
    object cdsBkpdfeCAMPOSTREAM: TMemoField
      FieldName = 'CAMPOSTREAM'
      Origin = 'CAMPOSTREAM'
      BlobType = ftMemo
    end
    object cdsBkpdfeCHECKBOX: TSmallintField
      FieldName = 'CHECKBOX'
      Origin = 'CHECKBOX'
    end
    object cdsBkpdfeXMLERRO: TMemoField
      FieldName = 'XMLERRO'
      BlobType = ftMemo
    end
    object cdsBkpdfeCNPJDEST: TStringField
      FieldName = 'CNPJDEST'
      Size = 14
    end
  end
  object provBkpdfe: TDataSetProvider
    DataSet = sqlBkpDfe
    Left = 97
    Top = 256
  end
  object sqlBkpDfe: TFDQuery
    Connection = conConexaoFD
    Transaction = fdtrTransacao
    SQL.Strings = (
      'select * from LM_bkpdfe')
    Left = 250
    Top = 257
  end
  object dsUsuarios: TDataSource
    DataSet = cdsUsuarios
    Left = 170
    Top = 198
  end
  object cdsUsuarios: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'provUsuarios'
    Left = 18
    Top = 198
    object cdsUsuariosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsUsuariosUSUARIO: TStringField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Size = 30
    end
    object cdsUsuariosSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 16
    end
    object cdsUsuariosCONFIGSALVA: TIntegerField
      FieldName = 'CONFIGSALVA'
      Required = True
    end
  end
  object provUsuarios: TDataSetProvider
    DataSet = sqlUsuarios
    Left = 94
    Top = 198
  end
  object sqlUsuarios: TFDQuery
    Connection = conConexaoFD
    Transaction = fdtrTransacao
    SQL.Strings = (
      'select * from usuarios')
    Left = 246
    Top = 198
  end
  object cdsConfiguracoes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'provConfiguracoes'
    Left = 19
    Top = 138
    object intgrfldConfiguracoesID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object intgrfldConfiguracoesIDUSUARIO: TIntegerField
      FieldName = 'IDUSUARIO'
    end
    object strngfldConfiguracoesDESCRICONFIG: TStringField
      FieldName = 'DESCRICONFIG'
      Required = True
    end
    object strngfldConfiguracoesNAMEBD: TStringField
      FieldName = 'NAMEBD'
      Required = True
      Size = 50
    end
    object strngfldConfiguracoesPATHBD: TStringField
      FieldName = 'PATHBD'
      Required = True
      Size = 255
    end
    object strngfldConfiguracoesSENHABD: TStringField
      FieldName = 'SENHABD'
      Required = True
      Size = 10
    end
    object strngfldConfiguracoesUSUARIOBD: TStringField
      FieldName = 'USUARIOBD'
      Required = True
      Size = 15
    end
    object strngfldConfiguracoesNFEPATHENVIO: TStringField
      FieldName = 'NFEPATHENVIO'
      Size = 255
    end
    object strngfldConfiguracoesNFEPATHPROCESSADO: TStringField
      FieldName = 'NFEPATHPROCESSADO'
      Size = 255
    end
    object strngfldConfiguracoesNFEPATHREJEITADO: TStringField
      FieldName = 'NFEPATHREJEITADO'
      Size = 255
    end
    object strngfldConfiguracoesNFEPATHRETORNOLIDO: TStringField
      FieldName = 'NFEPATHRETORNOLIDO'
      Size = 255
    end
    object strngfldConfiguracoesNFEPATHPDFSALVO: TStringField
      FieldName = 'NFEPATHPDFSALVO'
      Size = 255
    end
    object strngfldConfiguracoesNFCEPATHENVIO: TStringField
      FieldName = 'NFCEPATHENVIO'
      Size = 255
    end
    object strngfldConfiguracoesNFCEPATHPROCESSADO: TStringField
      FieldName = 'NFCEPATHPROCESSADO'
      Size = 255
    end
    object strngfldConfiguracoesNFCEPATHREJEITADO: TStringField
      FieldName = 'NFCEPATHREJEITADO'
      Size = 255
    end
    object strngfldConfiguracoesNFCEPATHRETORNOLIDO: TStringField
      FieldName = 'NFCEPATHRETORNOLIDO'
      Size = 255
    end
    object strngfldConfiguracoesNFCEPATHPDFSALVO: TStringField
      FieldName = 'NFCEPATHPDFSALVO'
      Size = 255
    end
    object strngfldConfiguracoesNFSEPATHENVIO: TStringField
      FieldName = 'NFSEPATHENVIO'
      Size = 255
    end
    object strngfldConfiguracoesNFSEPATHPROCESSADO: TStringField
      FieldName = 'NFSEPATHPROCESSADO'
      Size = 255
    end
    object strngfldConfiguracoesNFSEPATHREJEITADO: TStringField
      FieldName = 'NFSEPATHREJEITADO'
      Size = 255
    end
    object strngfldConfiguracoesNFSEPATHRETORNOLIDO: TStringField
      FieldName = 'NFSEPATHRETORNOLIDO'
      Size = 255
    end
    object strngfldConfiguracoesNFSEPATHPDFSALVO: TStringField
      FieldName = 'NFSEPATHPDFSALVO'
      Size = 255
    end
  end
  object provConfiguracoes: TDataSetProvider
    Left = 95
    Top = 138
  end
  object sqlConfiguracoes: TFDQuery
    Connection = conConexaoFD
    Transaction = fdtrTransacao
    SQL.Strings = (
      'select * from configuracoes')
    Left = 247
    Top = 138
  end
end

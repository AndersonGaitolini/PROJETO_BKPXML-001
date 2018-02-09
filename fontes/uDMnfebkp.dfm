object DM_NFEDFE: TDM_NFEDFE
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 343
  Width = 308
  object conConexaoFD: TFDConnection
    Params.Strings = (
      'CharacterSet=WIN1252'
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=E:\BT\7.0\MaxWin\Zancanaro\MAXXML\BACKUPXML.FDB'
      'Port=3050'
      'DriverID=FB')
    UpdateOptions.AssignedValues = [uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockWait, uvRefreshDelete]
    UpdateOptions.LockWait = True
    LoginPrompt = False
    Transaction = fdtrTransacao
    Left = 22
    Top = 19
  end
  object fdtrTransacao: TFDTransaction
    Connection = conConexaoFD
    Left = 231
    Top = 20
  end
  object fdWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 95
    Top = 21
  end
  object fddrfbDriver: TFDPhysFBDriverLink
    DriverID = 'FBEmbed'
    VendorLib = 'C:\fb\bin\fbembed.dll'
    Embedded = True
    Left = 163
    Top = 21
  end
  object dsConfiguracoes: TDataSource
    DataSet = cdsConfiguracoes
    Left = 164
    Top = 81
  end
  object dsBkpdfe: TDataSource
    DataSet = cdsBkpdfe
    Left = 167
    Top = 198
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
        Name = 'STATUSXML'
        DataType = ftInteger
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
        Name = 'CAMPOSTREAM'
        DataType = ftBlob
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
      end
      item
        Name = 'XMLERRO'
        DataType = ftBlob
      end
      item
        Name = 'XMLINUTILIZACAO'
        DataType = ftBlob
      end
      item
        Name = 'XMLCARTACORRECAO'
        DataType = ftBlob
      end
      item
        Name = 'TPEVENTO'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'provBkpdfe'
    StoreDefs = True
    Left = 15
    Top = 198
    object cdsBkpdfeID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsBkpdfeSTATUS: TSmallintField
      FieldName = 'STATUSXML'
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
    object cdsBkpdfeXMLINUTILIZACAO: TBlobField
      FieldName = 'XMLINUTILIZACAO'
    end
    object cdsBkpdfeXMLCARTACORRECAO: TBlobField
      FieldName = 'XMLCARTACORRECAO'
    end
    object cdsBkpdfeTPEVENTO: TIntegerField
      FieldName = 'TPEVENTO'
    end
  end
  object provBkpdfe: TDataSetProvider
    DataSet = sqlBkpDfe
    Left = 91
    Top = 198
  end
  object sqlBkpDfe: TFDQuery
    Connection = conConexaoFD
    Transaction = fdtrTransacao
    SQL.Strings = (
      'select * from LM_bkpdfe')
    Left = 243
    Top = 199
  end
  object dsUsuarios: TDataSource
    DataSet = cdsUsuarios
    Left = 164
    Top = 140
  end
  object cdsUsuarios: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'provUsuarios'
    Left = 12
    Top = 140
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
    Left = 88
    Top = 140
  end
  object sqlUsuarios: TFDQuery
    Connection = conConexaoFD
    Transaction = fdtrTransacao
    SQL.Strings = (
      'select * from usuarios')
    Left = 240
    Top = 140
  end
  object cdsConfiguracoes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'provConfiguracoes'
    Left = 13
    Top = 80
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
    Left = 88
    Top = 81
  end
  object sqlConfiguracoes: TFDQuery
    Connection = conConexaoFD
    Transaction = fdtrTransacao
    SQL.Strings = (
      'select * from configuracoes')
    Left = 241
    Top = 80
  end
  object dsTPEvento: TDataSource
    DataSet = cdsTPEvento
    OnDataChange = dsTPEventoDataChange
    Left = 163
    Top = 274
  end
  object cdsTPEvento: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODEVENTO'
        DataType = ftInteger
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'provTPEvento'
    StoreDefs = True
    Left = 13
    Top = 275
    object cdsTPEventoID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsTPEventoCODEVENTO: TIntegerField
      FieldName = 'CODEVENTO'
    end
    object cdsTPEventoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
  end
  object provTPEvento: TDataSetProvider
    DataSet = sqlTPEvento
    Left = 90
    Top = 273
  end
  object sqlTPEvento: TFDQuery
    Connection = conConexaoFD
    Transaction = fdtrTransacao
    SQL.Strings = (
      'select * from tpevento')
    Left = 240
    Top = 276
  end
end

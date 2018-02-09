unit Lm_bkpdfe;

interface

uses
  Base, System.SysUtils, Atributos, System.Classes,Data.DB,
  uDMnfebkp,FireDAC.Comp.Client,Vcl.DBGrids,
  Datasnap.DBClient, Datasnap.Provider,Vcl.Forms,Vcl.Dialogs,Vcl.Controls;
type
  TPushXML = (pshNone, pshEnvio1st, pshEnvioSinc);
  TLoadXML = (lxNone,lxXMLEnvio, lxXMLProc, lxXMLRetSai, lxXMLArquivo, lxXMLFull);
  TTipoXML = (txTodos, txNFE_Env, txNFe_EnvExt,txNFE_EnvLote, txNFe_EnvExtLote, txRet_Sai, txCan_, txCan_Ext, txCan_Lote, txCan_ExtLote, txRetEven, txCartaCorrecao);

  [attTabela('LM_BKPDFE')]
  TLm_bkpdfe = class(TTabela)
  private
    FId: Integer;
    FStatusXml : Integer;
    FCNPJ : string;
    FChave: string;
    FIdf_documento: Integer;
    FDataemissao: TDate;
    FDatarecto: TDate;
    FMotivo: string;
    FProtocolocanc: string;
    FProtocolorecto: string;
    FDataalteracao: TDate;
    FTipo: string;
    FEmailsnotificados: string;
    FTipoambiente: string;
    FXmlenvio: TStream;
    FXmlextend: TStream;
    FMotivocanc: string;
    FXmlenviocanc: TStream;
    FXmlextendcanc: TStream;
    FXmlInutilizacao : TStream;
    FXmlCartaCorrecao : TStream;
    FProtocoloaut: string;
    FXmlerro : TStream;
    FSelecao: string;
    FCheckBox: smallInt;
    FCNPJDest: string;
    FTPEvento: Integer;
  public
    [attPK]
    property Id: Integer read FId write FId;
    property StatusXML : Integer read FStatusXml write FStatusXml;
    property CNPJ: string read FCNPJ write FCNPJ;
    property Chave: string read FChave write FChave;
    property Idf_documento: Integer read FIdf_documento write FIdf_documento;
    property Dataemissao: TDate read FDataemissao write FDataemissao;
    property Datarecto: TDate read FDatarecto write FDatarecto;
    property Motivo: string read FMotivo write FMotivo;
    property Protocolocanc: string read FProtocolocanc write FProtocolocanc;
    property Protocolorecto: string read FProtocolorecto write FProtocolorecto;
    property Dataalteracao: TDate read FDataalteracao write FDataalteracao;
    property Tipo: string read FTipo write FTipo;
    property Emailsnotificados: string read FEmailsnotificados write FEmailsnotificados;
    property Tipoambiente: string read FTipoambiente write FTipoambiente;
    property Xmlenvio: TStream read FXmlenvio write FXmlenvio;
    property Xmlextend: TStream read FXmlextend write FXmlextend;
    property Motivocanc: string read FMotivocanc write FMotivocanc;
    property Xmlenviocanc: TStream read FXmlenviocanc write FXmlenviocanc;
    property Xmlextendcanc: TStream read FXmlextendcanc write FXmlextendcanc;
    property XmlInutilizacao: TStream read FXmlInutilizacao write FXmlInutilizacao;
    property XmlCartaCorrecao: TStream read FXmlCartaCorrecao write FXmlCartaCorrecao;
    property Protocoloaut: string read FProtocoloaut write FProtocoloaut;
    property Xmlerro : TStream read FXmlerro write FXmlerro;
    property Selecao: string read FSelecao write FSelecao;
    property CheckBox: SmallInt read FCheckBox write FCheckBox;
    property CNPJDest: string read FCNPJDest write FCNPJDest;
    property tpEvento: Integer read FtpEvento write FtpEvento;
  end;

type
  TValorData = record
   DataInicial,
   DataFinal  : TDateTime;
  end;

type
  TValorStr = record
   StrInicial,
   StrFinal  : String;
  end;

  type
  TValorInt = record
    IntInicial,
    IntFinal : Integer;
  end;

type
  TFieldFiltros  = (ffNone,
                    ffID,
                    ffStatusXml,
                    ffCHAVE,
                    ffCNPJ,
                    ffIDF_DOCUMENTO,
                    ffDATAEMISSAO,
                    ffDATARECTO,
                    ffMOTIVO,
                    ffPROTOCOLOCANC,
                    ffPROTOCOLORECTO,
                    ffDATAALTERACAO,
                    ffTIPO,
                    ffEMAILSNOTIFICADOS,
                    ffTIPOAMBIENTE,
                    ffXMLENVIO,
                    ffXMLEXTEND,
                    ffMOTIVOCANC,
                    ffXMLENVIOCANC,
                    ffXMLEXTENDCANC,
                    ffXmlInutilizacao,
                    ffXmlCartaCorrecao,
                    ffPROTOCOLOAUT,
                    ffXMLERRO,
                    ffSELECAO,
                    ffCHECKBOX,
                    ffCNPJDEST,
                    ffTPEvento,
                    ffFILTRODETALHADO);

  TOrdenaBy = (obyASCENDENTE, obyDESCEDENTE, obyNone);
  TOperacaoTab = (otUpadate, otInsert, otNone);

  TDaoBkpdfe = class(TObject)
    private

  public
    function fNextId(pObjXML                : TLm_bkpdfe): Integer;
    function fExcluirObjXML(pObjXML         : TLm_bkpdfe): Integer;
    function fTotalArquivos(pObjXML         : TLm_bkpdfe): Integer;
    function fCarregaXMLEnvio(pObjXML       : TLm_bkpdfe): Boolean;
    function fFindChaveXML(var pObjXML      : TLm_bkpdfe): Boolean;
    function fCarregaXMLRetorno(pObjXML     : TLm_bkpdfe): Boolean;
    function fConsObjXML4Exportar(var pObjXML    : TLm_bkpdfe; pCampos: array of string): Boolean;
    function fConsObj4Gravar(var pObjXML    : TLm_bkpdfe; pCampos: array of string): TOperacaoTab;
    function fConsDeleteObjXML(var pObjXML  : TLm_bkpdfe; pCampos: array of string): Boolean;

    procedure pLimpaObjetoXML(var pObjXML   : TLm_bkpdfe);
    procedure pAtualizaBD;
    procedure pFiltraOrdena2 (pFieldFiltros : TFieldFiltros = ffDATAEMISSAO; pUpDown: TOrdenaBy = obyNone; pCNPJDest: string = '*';
                             pListFields: TStringList = nil);

    function pFiltraOrdena (pFieldFiltros : TFieldFiltros = ffDATAEMISSAO; pUpDown: TOrdenaBy = obyNone; pCNPJDest: string = '*'; pFieldName: string = ''; pDtINI: TDate = 0; pDtFin: TDate = 0 ;
                            pValue1: string = '';pValue2: string = ''): TDataSet;
    function fFiltroFieldToFiledName(pFieldFiltros : TFieldFiltros):string;
    function fFieldNameToFiltroField(pFieldName: String): TFieldFiltros;

    constructor create; overload;
  end;

type
  TCNPJDOC = class(TObject)
   private
   FDocumento: String;
   FFantasia : String;
   FParametro: boolean;

   procedure setDocumento(const Value: string);
   procedure setParametro(const Value: boolean);

   public
   property Fantasia : String read FFantasia write FFantasia;
   property Documento: String read FDocumento write setDocumento;
   property Parametro: boolean read FParametro write setParametro;

   function fListaEmpresas: TStringList;
  end;

  var
   ObjetoXML : TLm_bkpdfe;
   DaoObjetoXML : TDaoBkpdfe;
   FieldFiltros : TFieldFiltros;
   Ordenaby     : TOrdenaBy;
   CNPJDOC  : TCNPJDOC;
   CNPJDOCarray : array of TCNPJDOC;

implementation

uses
  uMetodosUteis, uRotinas, Usuarios, uFoPrincipal;

{ TDaoBkpdfe }

constructor TDaoBkpdfe.create;
begin
//  DaoObjetoXML.pAtualizaTabela;
end;

function TDaoBkpdfe.fCarregaXMLEnvio(pObjXML : TLm_bkpdfe): Boolean;
var
    wControle : Integer;
    wSQL : string;
    wOperacao : TOperacaoTab;
    wArquivo : String;
begin
  try
    with DM_NFEDFE do
    begin
      wArquivo := pObjXML.Chave;
      wOperacao := DaoObjetoXML.fConsObj4Gravar(pObjXML,['chave', 'Idf_documento']);

      if (wOperacao =  otUpadate) then
      begin
        DM_NFEDFE.Dao.StartTransaction;
        wControle := Dao.Salvar(pObjXML);
        DM_NFEDFE.Dao.Commit
      end
      else
      if (wOperacao =  otInsert) then
      begin  //Insert
        DM_NFEDFE.Dao.StartTransaction;
        pObjXML.Id := fNextId(pObjXML);
        wControle:= Dao.Inserir(pObjXML);
        DM_NFEDFE.Dao.Commit
      end;

      Result := (wControle > 0);
    end;
  except on E: Exception do
         begin
           DM_NFEDFE.Dao.RollBack;
           ShowMessage('Método: fCarregaXMLEnvio!'+#10#13+
                       'Exception: '+E.Message);
         end;
  end;

end;

function TDaoBkpdfe.fCarregaXMLRetorno(pObjXML: TLm_bkpdfe): Boolean;
var wDataSet : TDataSet;
    wChaveAux : String;
begin
  wDataSet := TDataSet.Create(Application);
  try
    try
      with DM_NFEDFE do
      begin
        DM_NFEDFE.Dao.StartTransaction;
        wDataSet := Dao.ConsultaTab(pObjXML,['chave']);
        if (wDataSet.RecordCount = 1) and
           (wDataSet.FieldByName('chave').AsString = pObjXML.Chave) then
        begin
          pObjXML.Id := wDataSet.FieldByName('id').AsInteger;
          Result := Dao.Salvar(pObjXML,['id','chave','Dataemissao','Datarecto','Tipoambiente','Xmlenvio']) > 0
        end
        else
          Result := Dao.Inserir(pObjXML,['id'],fcIgnore) > 0;

        DM_NFEDFE.Dao.Commit;
      end;

    except on E: Exception do
           begin
             DM_NFEDFE.Dao.RollBack;
             ShowMessage('Método: fCarregaXMLRetorno!'+#10#13+'Exception: '+E.Message);
           end;
    end;
  finally
   FreeAndNil(wDataSet);
  end;
end;

function TDaoBkpdfe.fConsDeleteObjXML(var pObjXML: TLm_bkpdfe;
  pCampos: array of string): Boolean;
var wDataSet : TDataSet;
    wStream : TStream;
    i: Integer;
begin
  Result := False;
  wDataSet := TDataSet.Create(Application);
  try
    with DM_NFEDFE do
    begin
      wDataSet := dao.ConsultaTab(pObjXML, pCampos);
      wDataSet.Close;
      wDataSet.Open;
      if wDataSet.RecordCount >= 1 then
      begin
        Result := true;
        if wDataSet.RecordCount > 1 then
          wDataSet.First
      end;

      if Result then
        pObjXML.Idf_documento :=  wDataSet.FieldByName('Idf_documento').AsInteger;
    end;
  except on E: Exception do
          ShowMessage('Método: fConsDeleteObjXML!'+#10#13+
                      'Exception: '+e.Message);
  end;
end;

function TDaoBkpdfe.fConsObj4Gravar(var pObjXML: TLm_bkpdfe; pCampos: array of string): TOperacaoTab;
var wDataSet : TDataSet;
    wStream : TStream;
    i: Integer;

  procedure pReplaceIfNecessario;
  begin
    with wDataSet do
    begin
      if (pObjXML.Id < 1) then
      pObjXML.Id := FieldByName('id').AsInteger;

      if (pObjXML.StatusXml = 0) then
        pObjXML.StatusXml := FieldByName('Statusxml').AsInteger;

      if pObjXML.CNPJ = '' then
      pObjXML.CNPJ := FieldByName('CNPJ').AsString;

      if (pObjXML.Chave = '') then
      pObjXML.Chave := FieldByName('chave').AsString;

      if (pObjXML.Idf_documento = 0) then
      pObjXML.Idf_documento := FieldByName('Idf_documento').AsInteger;

      if (pObjXML.Dataemissao = 0)then
      pObjXML.Dataemissao := FieldByName('Dataemissao').AsDateTime;

      if (pObjXML.Datarecto = 0) then
      pObjXML.Datarecto := FieldByName('Datarecto').AsDateTime;

      if (pObjXML.Motivo = '') then
      pObjXML.Motivo := FieldByName('Motivo').AsString;

      if (pObjXML.Protocolocanc = '') then
      pObjXML.Protocolocanc := FieldByName('Protocolocanc').AsString;

      if (pObjXML.Protocolorecto = '') then
      pObjXML.Protocolorecto := FieldByName('Protocolorecto').AsString;

      if (pObjXML.Dataalteracao = 0) then
      pObjXML.Dataalteracao := Trunc(Now); //FieldByName('Dataalteracao').AsDateTime;

      if (pObjXML.Tipo = '') then
      pObjXML.Tipo := FieldByName('Tipo').AsString;

      if (pObjXML.Emailsnotificados = '') then
      pObjXML.Emailsnotificados := FieldByName('Emailsnotificados').AsString;

      if (pObjXML.Tipoambiente = '') then
      pObjXML.Tipoambiente := FieldByName('Tipoambiente').AsString;

      if (pObjXML.Motivocanc = '') then
      pObjXML.Motivocanc := FieldByName('Motivocanc').AsString;

      if (pObjXML.Protocoloaut = '') then
      pObjXML.Protocoloaut := FieldByName('Protocoloaut').AsString;

      if pObjXML.Selecao = '' then
      pObjXML.Selecao := FieldByName('selecao').AsString;

      if pObjXML.CheckBox = -1 then
      pObjXML.CheckBox := FieldByName('CheckBox').AsInteger;

      if pObjXML.CNPJDEST = '' then
      pObjXML.CNPJDEST := FieldByName('CNPJDEST').AsString;

      if pObjXML.TPEvento = 0 then
      pObjXML.TPEvento := FieldByName('TPEvento').AsInteger;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('XMLERRO'),bmReadWrite);
      if Assigned(wStream) then
      begin
        if not Assigned(pObjXML.FXmlerro) then
          pObjXML.FXmlerro :=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('Xmlenvio'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.Xmlenvio) then
        pObjXML.Xmlenvio:=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('Xmlextend'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.Xmlextend) then
        pObjXML.Xmlextend:=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('Xmlenviocanc'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.Xmlenviocanc) then
        pObjXML.Xmlenviocanc :=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('Xmlextendcanc'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.Xmlextendcanc) then
        pObjXML.Xmlextendcanc :=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('XmlInutilizacao'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.XmlInutilizacao) then
        pObjXML.XmlInutilizacao :=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('XmlCartaCorrecao'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.XmlCartaCorrecao) then
        pObjXML.XmlInutilizacao :=  wStream;
      end
      else
      wStream := nil;
    end;
  end;

begin
  Result := otNone;
  wDataSet := TDataSet.Create(Application);
    try
      with DM_NFEDFE do
      begin
        wDataSet := dao.ConsultaTab(pObjXML, pCampos);
        wDataSet.Edit;

        if (wDataSet.RecordCount = 1)  then
        begin
          pReplaceIfNecessario;
          Result := otUpadate;
        end
        else
        if (wDataSet.RecordCount = 0) then
           Result := otInsert;
      end;
    except on E: Exception do
           ShowMessage('Método: fConsObj4Gravar!'+#10#13+
                       'Exception: '+e.Message);
    end;
end;

function TDaoBkpdfe.fConsObjXML4Exportar(var pObjXML: TLm_bkpdfe; pCampos: array of string): Boolean;
var wDataSet : TDataSet;
    wStream : TStream;
    i: Integer;

 procedure pReplaceIfNecessario;
  begin
    with wDataSet do
    begin
      if (pObjXML.Id < 1) then
      pObjXML.Id := FieldByName('id').AsInteger;

      if (pObjXML.StatusXml = 0) then
      pObjXML.StatusXml := FieldByName('Statusxml').AsInteger;

      if pObjXML.CNPJ = '' then
      pObjXML.CNPJ := FieldByName('CNPJ').AsString;

      if (pObjXML.Chave = '') then
      pObjXML.Chave := FieldByName('chave').AsString;

      if (pObjXML.Idf_documento = 0) then
      pObjXML.Idf_documento := FieldByName('Idf_documento').AsInteger;

      if (pObjXML.Dataemissao = 0)then
      pObjXML.Dataemissao := FieldByName('Dataemissao').AsDateTime;

      if (pObjXML.Datarecto = 0) then
      pObjXML.Datarecto := FieldByName('Datarecto').AsDateTime;

      if (pObjXML.Motivo = '') then
      pObjXML.Motivo := FieldByName('Motivo').AsString;

      if (pObjXML.Protocolocanc = '') then
      pObjXML.Protocolocanc := FieldByName('Protocolocanc').AsString;

      if (pObjXML.Protocolorecto = '') then
      pObjXML.Protocolorecto := FieldByName('Protocolorecto').AsString;

      if (pObjXML.Dataalteracao = 0) then
      pObjXML.Dataalteracao := Trunc(Now); //FieldByName('Dataalteracao').AsDateTime;

      if (pObjXML.Tipo = '') then
      pObjXML.Tipo := FieldByName('Tipo').AsString;

      if (pObjXML.Emailsnotificados = '') then
      pObjXML.Emailsnotificados := FieldByName('Emailsnotificados').AsString;

      if (pObjXML.Tipoambiente = '') then
      pObjXML.Tipoambiente := FieldByName('Tipoambiente').AsString;

      if (pObjXML.Motivocanc = '') then
      pObjXML.Motivocanc := FieldByName('Motivocanc').AsString;

      if (pObjXML.Protocoloaut = '') then
      pObjXML.Protocoloaut := FieldByName('Protocoloaut').AsString;

      if pObjXML.Selecao = '' then
      pObjXML.Selecao := FieldByName('selecao').AsString;

      if pObjXML.CheckBox = -1 then
      pObjXML.CheckBox := FieldByName('CheckBox').AsInteger;

      if pObjXML.CNPJDEST = '' then
      pObjXML.CNPJDEST := FieldByName('CNPJDEST').AsString;

      if pObjXML.TPEvento = 0 then
      pObjXML.TPEvento := FieldByName('TPEvento').AsInteger;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('XMLERRO'),bmReadWrite);
      if Assigned(wStream) then
      begin
        if not Assigned(pObjXML.FXmlerro) then
          pObjXML.FXmlerro :=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('Xmlenvio'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.Xmlenvio) then
        pObjXML.Xmlenvio:=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('Xmlextend'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.Xmlextend) then
        pObjXML.Xmlextend:=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('Xmlenviocanc'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.Xmlenviocanc) then
        pObjXML.Xmlenviocanc :=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('Xmlextendcanc'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.Xmlextendcanc) then
        pObjXML.Xmlextendcanc :=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('XmlInutilizacao'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.XmlInutilizacao) then
        pObjXML.XmlInutilizacao :=  wStream;
      end
      else
      wStream := nil;

      wStream := wDataSet.CreateBlobStream(wDataSet.FieldByName('XmlCartaCorrecao'),bmReadWrite);
      if Assigned(wStream) then
      begin
      if not Assigned(pObjXML.XmlCartaCorrecao) then
        pObjXML.XmlCartaCorrecao :=  wStream;
      end
      else
      wStream := nil;

    end;
  end;

begin
  Result := false;
  wDataSet := TDataSet.Create(Application);
    try
      with DM_NFEDFE do
      begin
        wDataSet := dao.ConsultaTab(pObjXML, pCampos);
        wDataSet.Edit;

        if (wDataSet.RecordCount = 1) then
        begin
          pReplaceIfNecessario;
          Result := true;
        end;

      end;
    except on E: Exception do
           ShowMessage('Método: fConsObjXML4Exportar!'+#10#13+
                       'Exception: '+e.Message);
    end;
end;

function TDaoBkpdfe.fExcluirObjXML(pObjXML : TLm_bkpdfe): Integer;
begin
  Result := 0;
  try
    DM_NFEDFE.Dao.StartTransaction;
    try
      Result := DM_NFEDFE.Dao.Excluir(pObjXML);

      DM_NFEDFE.Dao.Commit;
    except
      on E: Exception do
      begin
        DM_NFEDFE.Dao.RollBack;
        ShowMessage('Método: fExcluirObjXML!'+#10#13+
                    'Exception: '+e.Message);
      end;
    end;
  finally
    pObjXML.Free;
  end;
end;

function TDaoBkpdfe.fFindChaveXML(var pObjXML: TLm_bkpdfe): Boolean;
var wDataSet : TDataSet;
begin
  wDataSet := TDataSet.Create(Application);
  try
    with DM_NFEDFE do
    begin
      if pObjXML.Chave = '' then
      begin
        Result := False;
        Exit;
      end;

      wDataSet := Dao.ConsultaTab(pObjXML,['Chave']);
      if wDataSet.RecordCount > 0 then
      begin
        if wDataSet.FieldByName('Chave').AsString = pObjXML.Chave then
          Result := True;
      end;
    end;
  finally
    FreeAndNil(wDataSet);
  end;
end;

function TDaoBkpdfe.fFieldNameToFiltroField(pFieldName: String): TFieldFiltros;
var wFieldFiltros : TFieldFiltros;
begin
 try
   Result := TConvert<TFieldFiltros>.StrConvertEnum('ff'+pFieldName);
 except
   Result := ffNone;
 end;
end;

function TDaoBkpdfe.fFiltroFieldToFiledName(pFieldFiltros: TFieldFiltros): string;
begin
  try
    Result := TConvert<TFieldFiltros>.EnumConvertStr(pFieldFiltros);
  except
     Result := '';
  end;
end;

function TDaoBkpdfe.fNextId(pObjXML: TLm_bkpdfe): integer;
var wDataSet: TDataset;
begin
  if not Assigned(pObjXML) then
    pObjXML := TLm_bkpdfe.Create;

  Result := 0;
  pObjXML.Id := Result;
  wDataSet := TDataSet.Create(Application);
  try
    try
      wDataSet := DM_NFEDFE.dao.ConsultaAll(pObjXML,'id' );
      wDataSet.Close;
      wDataSet.Open;
      wDataSet.last;
      Result := wDataSet.FieldByName('id').AsInteger+1;
    except on E: Exception do
             ShowMessage('Método: fNextId!'+#10#13 + 'Exception: '+e.Message);
    end;
  finally
    FreeAndNil(wDataSet);
  end;
end;

procedure TDaoBkpdfe.pAtualizaBD;
VAR wDataSet : TdataSet;
    wSql: TStringList;
    I :Integer;
begin
  with DM_NFEDFE do
  begin
    wSql := TStringList.Create;
    try
      try
        wDataSet := Dao.ConsultaSql('SELECT * FROM LM_BKPDFE');
        if Assigned(wDataSet.FindField('STATUS')) then
           wSql.Add('ALTER TABLE LM_BKPDFE ALTER STATUS TO STATUSXML')
        else
        if not Assigned(wDataSet.FindField('STATUSXML')) then
          wSql.Add('ALTER TABLE LM_BKPDFE ADD STATUSXML INTEGER');

        if not Assigned(wDataSet.FindField('CNPJ')) then
         wSql.Add('ALTER TABLE LM_BKPDFE ADD CNPJ VARCHAR(14) CHARACTER SET WIN1252 COLLATE WIN1252');

        if not Assigned(wDataSet.FindField('CNPJDEST')) then
         wSql.Add('ALTER TABLE LM_BKPDFE ADD CNPJDEST VARCHAR(14) CHARACTER SET WIN1252 COLLATE WIN1252');

        if not Assigned(wDataSet.FindField('XMLERRO')) then
          wSql.Add('ALTER TABLE LM_BKPDFE ADD XMLERRO BLOB SUB_TYPE 0 SEGMENT SIZE 80');

        if not Assigned(wDataSet.FindField('XMLINUTILIZACAO')) then
          wSql.Add('ALTER TABLE LM_BKPDFE ADD XMLINUTILIZACAO BLOB SUB_TYPE 0 SEGMENT SIZE 80');

        if not Assigned(wDataSet.FindField('XMLCARTACORRECAO')) then
          wSql.Add('ALTER TABLE LM_BKPDFE ADD XMLCARTACORRECAO BLOB SUB_TYPE 0 SEGMENT SIZE 80');

        if not Assigned(wDataSet.FindField('TPEvento')) then
          wSql.Add('ALTER TABLE LM_BKPDFE ADD TPEvento Integer');

        if wSql.Count > 0 then
        for I := 0 to wSql.Count-1 do
        begin
//          dao.StartTransaction;
          Dao.ConsultaSqlExecute(wSql.Strings[I]);
//          Dao.Commit;
        end;
      except
        on E: Exception do
//            Dao.RollBack;
      end;
    finally
      FreeAndNil(wSql);
    end;
  end;
end;

function TDaoBkpdfe.pFiltraOrdena(pFieldFiltros: TFieldFiltros;
  pUpDown: TOrdenaBy; pCNPJDest, pFieldName: string; pDtINI, pDtFin: TDate; pValue1,
  pValue2: string): TDataset;

var data1STR, data2STR, str1, str2: string;
    wDataSet : TDataSet;
    wUpDown: string;
    wV1Empty, wV2Empty : boolean;
const cAsc = 'Asc'; cdesc = 'desc';

  procedure pFiltroData(pFieldOrder:string);
  begin
    try
      with DM_NFEDFE, sqlBkpDfe do
      begin
        DateTimeToString(data1STR, 'yyyy/mm/dd', pDtINI);
        data1STR := QuotedStr(data1STR);
        DateTimeToString(data2STR, 'yyyy/mm/dd', pDtFin);
        data2STR := QuotedStr(data2STR);

        str1 := ('Select * from lm_bkpdfe where ');
        str1 :=  str1 + Format('(%s between %s and %s) ',[pFieldName,data1STR, data2STR]);

        if pUpDown = obyNone then
        begin
          str1 := str1 + Format(' order by %s %s',[pFieldOrder, wUpDown]);
        end;
      end;
    except on E: Exception do
               ShowMessage('Método: pFiltroData!'+#10#13+
                           'Exception: '+e.Message);
    end;
  end;

  procedure pFiltro(pFieldOrder:string);
  var wOrdData,wDataVal, wFetchAll, wAnd: Boolean;
      auxFF : TFieldFiltros;
      wList : TList;
      i:Integer;
      wFilename: string;
      wOpen : TOpenDialog;
  begin
    auxFF := TConvert<TFieldFiltros>.StrConvertEnum('ff'+pFieldOrder);
    wOrdData := ((auxFF = ffDATARECTO) or (auxFF = ffDATAALTERACAO) or (auxFF = ffDATAEMISSAO));
    try
      wDataVal := (pDtINI > 0) or (pDtFin > 0);
      DateTimeToString(data1STR, 'yyyy/mm/dd', pDtINI);
      data1STR := QuotedStr(data1STR);
      DateTimeToString(data2STR, 'yyyy/mm/dd', pDtFin);
      data2STR := QuotedStr(data2STR);

      wAnd := false;
      str1 := str1 + 'Select * from lm_bkpdfe where ';

      if auxFF = ffCNPJDEST then
      begin
        if (pCNPJDest <> '') and (fValidaCNPJ(pCNPJDest)) then
          str1 := str1 + Format('(%s like '+QuotedStr('%s')+') and',['CNPJDEST', pCNPJDest])
      end;

      if auxFF = ffSTATUSXML then
      begin
        if (not wV1Empty) then
        begin
          case TConvert<TStatusXML>.StrConvertEnum(pValue1) of
            tsxNormAguard: str1 := str1 + Format('(%s = %d) and',['STATUSXML', 001]);
            tsxNormal: str1 := str1 + Format('(%s = %d) and',['STATUSXML', 100]);
            tsxCartaCorr: str1 := str1 + Format('(%s in (%d, %d)) and (%s = %d) and',['STATUSXML',101, 135,'TPEVENTO', 110110]);
            tsxCancAguard: str1 := str1 + Format('(%s = %d) and',['STATUSXML', 004]);
            tsxCanecelada: str1 := str1 + Format('(%s IN (%d, %d)) and',['STATUSXML', 101,135]);
            tsxDenegada:   str1 := str1 + Format('(%s = %d) and',['STATUSXML', 303]);
            tsxInutilizada: str1 := str1 + Format('(%s = %d) and',['STATUSXML', 662]);
            tsxDefeito: str1 := str1 + Format('(%s = %d) and',['STATUSXML', -999]);
          end;
        end;
      end;

      if wDataVal then
        if wOrdData then
          str1 := str1 +  Format('(%s between %s and %s ) ',[pFieldOrder, data1STR, data2STR])
        else
          str1 := str1 + Format('(dataemissao between %s and %s ) ',[data1STR, data2STR]);

      if not (wV1Empty) and (pFieldName = 'CNPJDEST') and wDataVal then
         str1 := str1 + Format(' and (%s like '+QuotedStr('%s')+')',[pFieldName, '%'+pValue1+'%'])
      else
      if not (wV1Empty) and (pFieldName = 'CNPJDEST') and not wDataVal then
         str1 := str1 + Format(' (%s like '+QuotedStr('%s')+')',[pFieldName, '%'+pValue1+'%']);

      if pUpDown <> obyNone then
        str1 := str1 + Format(' order by %s %s',[pFieldOrder, wUpDown]);

      DM_NFEDFE.Dao.StartTransaction;
      Result := DM_NFEDFE.Dao.ConsultaSql(str1, foPrincipal.FetchALL);
      DM_NFEDFE.Dao.Commit;
      DM_NFEDFE.dsBkpdfe.DataSet := DM_NFEDFE.Dao.ConsultaSql(str1, foPrincipal.FetchALL);

    except on E: Exception do
           begin
             ShowMessage('Método: pFiltro!'+#10#13+
             'Exception: '+e.Message);
           end;
    end;
  end;

begin
  Result := nil;
  pFieldName := UpperCase(Trim(pFieldName));

   if Length(pCNPJDest) = 18 then
    pCNPJDest := fTiraMascaraCNPJ(pCNPJDest);

  if pUpDown = obyNone then
    pUpDown:= obyASCENDENTE;

  wV1Empty := pValue1 = '';
  wV2Empty := pValue2 = '';

  case pUpDown of
    obyASCENDENTE: wUpDown := cAsc;
    obyDESCEDENTE: wUpDown := cdesc;
  end;

  case pFieldFiltros of
    ffID: begin end;
    ffCHAVE: begin pFiltro('CHAVE') end;
    ffIDF_DOCUMENTO: begin pFiltro('IDF_DOCUMENTO') end;
    ffDATAEMISSAO: begin pFiltro('DATAEMISSAO') end;
    ffDATARECTO: begin pFiltro('DATARECTO') end;
    ffMOTIVO: begin pFiltro('MOTIVO') end;
    ffPROTOCOLOCANC: begin pFiltro('PROTOCOLOCANC') end;
    ffPROTOCOLORECTO: begin pFiltro('PROTOCOLORECTO') end;
    ffDATAALTERACAO: begin pFiltro('DATAALTERACAO') end;
    ffTIPO: begin pFiltro('TIPO') end;
    ffEMAILSNOTIFICADOS: begin pFiltro('EMAILSNOTIFICADOS') end;
    ffTIPOAMBIENTE: begin pFiltro('TIPOAMBIENTE') end;
    ffXMLENVIO: begin pFiltro('ID') end;
    ffXMLEXTEND: begin pFiltro('ID') end;
    ffMOTIVOCANC: begin pFiltro('MOTIVOCANC') end;
    ffXMLENVIOCANC: begin pFiltro('ID') end;
    ffXMLEXTENDCANC: begin pFiltro('ID') end;
    ffPROTOCOLOAUT: begin pFiltro('PROTOCOLOAUT') end;
    ffCNPJDEST : begin pFiltro('CNPJDEST') end;
    ffSTATUSXML : begin pFiltro('STATUSXML') end;
    ffTPEvento : begin pFiltro('TPEvento') end;
  end;
end;

procedure TDaoBkpdfe.pFiltraOrdena2(pFieldFiltros: TFieldFiltros;
  pUpDown: TOrdenaBy; pCNPJDest: string; pListFields: TStringList);
begin

end;

function TDaoBkpdfe.fTotalArquivos(pObjXML: TLm_bkpdfe): Integer;
begin
  if not Assigned(pObjXML) then
    Exit;

  Result := 0;
  try
    try
       with DM_NFEDFE do
       begin
         Result := Dao.GetRecordCount(pObjXML, ['id']);
       end;
    except on E: Exception do
            ShowMessage('Método: fTotalArquivos!'+#10#13+
            'Exception: '+e.Message);
    end;
  finally
  end;
end;

procedure TDaoBkpdfe.pLimpaObjetoXML(var pObjXML: TLm_bkpdfe);
begin
  with pObjXML do
  begin
    id := 0;
    StatusXml := 999;
    CNPJ := '';
    Chave := '';
    Idf_documento := 0;
    Dataemissao := 0;
    Datarecto := 0;
    Motivo := '';
    Protocolocanc := '';
    Protocolorecto := '';
    Dataalteracao := 0;
    Tipo := '';
    Emailsnotificados := '';
    Tipoambiente := '';
    Xmlenvio := nil;
    Xmlextend := nil;
    Motivocanc := '';
    Xmlenviocanc := nil;
    Xmlextendcanc := nil;
    Protocoloaut := '';
    XMLERRO  := nil;
    XmlInutilizacao := nil;
    XmlCartaCorrecao := nil;
    Selecao := '';
    CNPJDest := '';
    TPEvento := 0;
  end;
end;

{ TCNPJDOC }
function TCNPJDOC.fListaEmpresas: TStringList;
var wDataSet : TDataSet;
    wI: Integer;
    wCNPJ: string;
begin
  wDataSet := TDataSet.Create(Application);
  Result := TStringList.Create;
  try
    if not Assigned(ObjetoXML) then
       ObjetoXML := TLm_bkpdfe.Create;

    wDataSet := DM_NFEDFE.Dao.ConsultaSql('select cnpj, count(*) FROM lm_bkpdfe group by cnpj');
    for wI := 0 to wDataSet.RecordCount-1 do
    begin
      wCNPJ := wDataSet.FieldByName('CNPJ').AsString;
      if Trim(wCNPJ) <> ''  then
        Result.Add(Trim(wCNPJ));

      wDataSet.Next;
    end;
  finally
    wDataSet.Free;
  end;
end;

procedure TCNPJDOC.setDocumento(const Value: string);
begin
  if (Value = '*') or (fValidaCNPJ2(Value)) then
   FDocumento := Value
  else
   FDocumento := ''   ;
end;

procedure TCNPJDOC.setParametro(const Value: boolean);
begin
  FParametro := Value;
end;
end.

unit Lm_bkpdfe;

interface

uses
  Base, System.SysUtils, Atributos, System.Classes,Data.DB,
  uDMnfebkp,FireDAC.Comp.Client,Vcl.DBGrids,
  Datasnap.DBClient, Datasnap.Provider,Vcl.Forms,Vcl.Dialogs,Vcl.Controls, System.Contnrs,
  System.Generics.Collections,uMetodosUteis, System.DateUtils;
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
    FModelo  : string;
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
    property Modelo : string read FModelo write FModelo;

    constructor create overload;
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
                    ffFILTRODETALHADO,
                    ffModelo);

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
//    function pFiltraOrdena (pFieldFiltros : TFieldFiltros = ffDATAEMISSAO; pUpDown: TOrdenaBy = obyNone; pCNPJDest: string = '*'; pFieldDetalhe: TFieldFiltros = ''; pDtINI: TDate = 0; pDtFin: TDate = 0 ;
//                            pValue1: string = '';pValue2: string = ''): TDataSet;

    function fFiltroOrdAnoMes(pMes, pAno: word; pTipoDataFiltros, pFieldFiltrosDetalhe, pFieldOrder: TFieldFiltros; pUpDown: TOrdenaBy; pCNPJEmi: string = '*'; pValue1: string = ''; pValue2: string = ''; pFetchALL: Boolean = False): TDataSet;
    function fFiltroFieldToFiledName(pFieldFiltros : TFieldFiltros):string;
    function fFieldNameToFiltroField(pFieldDetalhe: String): TFieldFiltros;

    constructor create; overload;
  end;

type
  TCNPJDOC = class(TObject)
   private
   FDocParam: String;
   FDocumento: String;
   FFantasia : String;
   FParametro: boolean;

   procedure setDocumento(const Value: string);
   procedure setParametro(const Value: boolean);

   public
   property Fantasia : String read FFantasia write FFantasia;
   property Documento: String read FDocumento write setDocumento;
   property Parametro: boolean read FParametro write setParametro;

   function fListaEmpresas(pMes, pAno: word): TStringList;
  end;

  arrMesesInt = Array [1..12] of byte;
  arrMesesStr = Array [1..12] of String;

  TAnoMeses = Record
    Ano      : word;
    Meses    : arrMesesInt;
    MesesStr : arrMesesStr;
  end;

  TGETMAXMIN = (gMax, gMin);
  TPilhaAnoMes = class(TOBject)
  private
    FDataMax  : TDate;
    FDataMin  : TDate;
    AnoMeses : TAnoMeses;

    ListaAnoMeses : TStringList;
    function GetDate(pGet: TGETMAXMIN):Tdate;
    function GetDataMax: TDate;
    function GetDataMin: TDate;
  public
    MesLista : TStringList;
    AnoStack : TStack<String>;
    MesStack : TStack<String>;
    MesesAnoStack: TStack<TAnoMeses>;

    function CarregaMesesAno: Boolean;
    function PreencheAnoMes: Boolean;
    function PreencheMes(pAno: word): Boolean;
    procedure AtualizaDataMaxMin;
    property DataMax  : TDate read GetDataMax;
    property DataMin  : TDate read GetDataMin;
//    property MesLista : TStringList read FMesLista;

    constructor Create;
    destructor Destroy;
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
  uRotinas, Usuarios, uFoPrincipal;

const cAsc = 'Asc'; cdesc = 'desc';

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

//       AddLog('pReplaceIfNecessario',GetCurrentDir,'Carregou: '+IntToStr(pObjXML.StatusXml)+' Gravado: '+IntToStr(wDataSet.FieldByName('Statusxml').AsInteger),true);
       case pObjXML.StatusXml of
         -999:begin end;

         001: begin  //XML Envio aguardando
                if (wDataSet.FieldByName('Statusxml').AsInteger >=100) then
                 pObjXML.StatusXml := wDataSet.FieldByName('Statusxml').AsInteger;
              end;

         004: begin //XML Cancelamento Envio aguardando
                if (wDataSet.FieldByName('Statusxml').AsInteger = 101) then
                 pObjXML.StatusXml := wDataSet.FieldByName('Statusxml').AsInteger;
              end;

         100: begin //XML Envio Processado
                if (wDataSet.FieldByName('Statusxml').AsInteger > 100) then
                case wDataSet.FieldByName('Statusxml').AsInteger of
                  101: begin
                         if ((Trim(wDataSet.FieldByName('Protocoloaut').AsString) <> '') and
                             (Trim(wDataset.FieldByName('Protocolocanc').AsString) <> '')) then
                          pObjXML.StatusXml := wDataSet.FieldByName('Statusxml').AsInteger;
                       end;

                  135: begin
                        if (Trim(wDataset.FieldByName('Protocoloaut').AsString) <> '') then
                          pObjXML.StatusXml := wDataSet.FieldByName('Statusxml').AsInteger
                       end;
                end;

              end;

         101: begin  //XML Cancel. Processado
                if (wDataSet.FieldByName('Statusxml').AsInteger > 101) then
                 pObjXML.StatusXml := wDataSet.FieldByName('Statusxml').AsInteger;
//                if (pObjXML.TPEvento = 110111) then
              end;

         135: begin  //XML Carta Correção
                if (wDataSet.FieldByName('Statusxml').AsInteger > 135) then
                 pObjXML.StatusXml := wDataSet.FieldByName('Statusxml').AsInteger;
              end;

         110,
         205,
         301,
         302,
         303:  begin

               end;//Denegada

         206,
         256,
         662: begin end;//Inutilizada




       else

       end;


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

      if (pObjXML.Modelo = '') then
      pObjXML.Modelo := FieldByName('Modelo').AsString;

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

      if pObjXML.Modelo = '' then
      pObjXML.Modelo := FieldByName('MODELO').AsString;

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

function TDaoBkpdfe.fFieldNameToFiltroField(pFieldDetalhe: String): TFieldFiltros;
var wFieldFiltros : TFieldFiltros;
begin
 try
   Result := TConvert<TFieldFiltros>.StrConvertEnum('ff'+pFieldDetalhe);
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

function TDaoBkpdfe.fFiltroOrdAnoMes(pMes, pAno: word; pTipoDataFiltros, pFieldFiltrosDetalhe,  pFieldOrder: TFieldFiltros; pUpDown: TOrdenaBy; pCNPJEmi: string = '*'; pValue1: string = ''; pValue2: string = ''; pFetchALL: Boolean = False): TDataSet;

  var
  DataIniStr, DataFinStr, str1, str2: string;
  wDataSet : TDataSet;
  wUpDown: string;
  wV1Empty, wV2Empty : boolean;

  sSQL, sFieldDetalhe, sFieldOrder : String;
  wOrdData,wDataVal, wFetchAll, wAnd: Boolean;
  wList : TList;
  i:Integer;
  wFilename: string;
  wOpen : TOpenDialog;
  wAno, wMes, wDia : word;

  function ExtrairFiled(pFieldFiltrosDetalhe: TFieldFiltros): string;
  var wPos: Word;
  begin
    Result := TConvert<TFieldFiltros>.EnumConvertStr(pFieldFiltrosDetalhe);

    wPos := Pos(Result,'ff');
    if wPos >= 0 then
      Result := UpperCase(copy(Result, 3,length(Result)));
  end;

begin
  Result := nil;

  if pUpDown = obyNone then
    pUpDown:= obyASCENDENTE;

  case pUpDown of
    obyASCENDENTE: wUpDown := cAsc;
    obyDESCEDENTE: wUpDown := cdesc;
  end;

  sFieldDetalhe := ExtrairFiled(pFieldFiltrosDetalhe);
  sFieldOrder := ExtrairFiled(pFieldOrder);

  wOrdData := ((pFieldFiltrosDetalhe = ffDATARECTO) or (pFieldFiltrosDetalhe = ffDATAALTERACAO) or (pFieldFiltrosDetalhe = ffDATAEMISSAO));
  try
    if not ((pAno > 0) and ((pMes > 0) and (pMes in [1..12]))) then
      exit;

    DateTimeToString(DataIniStr, 'yyyy/mm/dd', EncodeDate(pAno,pMes,01));
    DataIniStr := QuotedStr(DataIniStr);

    DecodeDate(EndOfTheMonth(EncodeDate(pAno,pMes,01)),wAno, wMes, wDia);
    DateTimeToString(DataFinStr, 'yyyy/mm/dd', EncodeDate(pAno,pMes, wDia));
    DataFinStr := QuotedStr(DataFinStr);

    wAnd := false;
    sSQL := sSQL + 'Select * from lm_bkpdfe ';

    if not(pFieldFiltrosDetalhe in[ffCHAVE,ffIDF_DOCUMENTO])  then
    begin
      if wOrdData then
        sSQL := sSQL +  Format('where (%s between %s and %s) ',[sFieldDetalhe, DataIniStr, DataFinStr])
      else
        sSQL := sSQL + Format('where (DATAEMISSAO between %s and %s) ',[DataIniStr, DataFinStr]);
    end;

    if not(pFieldFiltrosDetalhe in[ffCNPJ, ffCHAVE,ffIDF_DOCUMENTO]) and (pCNPJEmi <> '') and  (pCNPJEmi <> '*') and ((fValidaCNPJ(pCNPJEmi)) or (fValidaCPF(pCNPJEmi))) then
       sSQL := sSQL + Format('and (%s like '+QuotedStr('%s')+') ',['CNPJ', '%'+pCNPJEmi+'%']);


    case pFieldFiltrosDetalhe of
      ffSTATUSXML:
      begin
        if (not wV1Empty) then
        begin
          case TConvert<TStatusXML>.StrConvertEnum(pValue1) of
            tsxNormAguard: sSQL := sSQL + Format('and (%s = %d) ',['STATUSXML', 001]);
            tsxNormal: sSQL := sSQL + Format('and (%s = %d) ',['STATUSXML', 100]);
            tsxCartaCorr: sSQL := sSQL + Format('and (%s in (%d, %d)) and (%s = %d) ',['STATUSXML',101, 135,'TPEVENTO', 110110]);
            tsxCancAguard: sSQL := sSQL + Format('and (%s = %d) ',['STATUSXML', 004]);
            tsxCanecelada: sSQL := sSQL + Format('and (%s IN (%d, %d)) ',['STATUSXML', 101,135]);
            tsxDenegada:   sSQL := sSQL + Format('and (%s = %d) ',['STATUSXML', 303]);
            tsxInutilizada: sSQL := sSQL + Format('and (%s = %d) ',['STATUSXML', 662]);
            tsxDefeito: sSQL := sSQL + Format('and (%s = %d) ',['STATUSXML', -999]);
          end;
        end;
      end;

      ffCNPJDEST:
      begin
        sSQL := sSQL + Format('and (%s like '+QuotedStr('%s')+') ',[sFieldDetalhe, '%'+pValue1+'%'])
      end;

      ffModelo:
      begin
        sSQL := sSQL + Format('and (%s = '+QuotedStr('%s')+') ',[sFieldDetalhe, copy(pValue1,1,2)]);
      end;

      ffCNPJ: begin
                sSQL := sSQL + Format('and (%s like '+QuotedStr('%s')+') ',[sFieldDetalhe, '%'+pValue1+'%']);
              end;

      ffIDF_DOCUMENTO,
               ffCHAVE : sSQL := sSQL + Format('where (%s like '+QuotedStr('%s')+') ',[sFieldDetalhe, '%'+pValue1+'%']);
      ffPROTOCOLOAUT,
      ffPROTOCOLOCANC: begin
                         sSQL := sSQL + Format('and (%s like '+QuotedStr('%s')+') ',[sFieldDetalhe, '%'+pValue1+'%']);
                       end;

    end;

    if pUpDown <> obyNone then
      sSQL := sSQL + Format(' order by %s, %s %s',[sFieldOrder, 'idf_documento', wUpDown]);

    DM_NFEDFE.Dao.StartTransaction;
    Result := DM_NFEDFE.Dao.ConsultaSql(sSQL, pFetchALL);
    DM_NFEDFE.Dao.Commit;
    DM_NFEDFE.dsBkpdfe.DataSet := DM_NFEDFE.Dao.ConsultaSql(sSQL, pFetchALL);

  except on E: Exception do
         begin
           ShowMessage('Método: fFiltroOrdAnoMes!'+#10#13+
           'Exception: '+e.Message);
         end;
  end;
end;

function TDaoBkpdfe.fNextId(pObjXML: TLm_bkpdfe): integer;
var wDataSet: TDataset;
begin
  if not Assigned(pObjXML) then
    pObjXML := TLm_bkpdfe.Create;

  Result := 0;
  pObjXML.Id := Result;
//  wDataSet := TDataSet.Create(Application);
  try
    try
//      wDataSet := DM_NFEDFE.dao.ConsultaAll(pObjXML,'id' );
      Result := DM_NFEDFE.Dao.ConsultaSql('SELECT MAX(lm_bkpdfe.id) FROM lm_bkpdfe').FieldByName('MAX').AsInteger;
      Inc(Result);
      //  wDataSet.Close;
//      wDataSet.Open;
//      wDataSet.last;
//      Result := wDataSet.FieldByName('id').AsInteger+1;
    except on E: Exception do
             ShowMessage('Método: fNextId!'+#10#13 + 'Exception: '+e.Message);
    end;
  finally
//    FreeAndNil(wDataSet);
  end;
end;

procedure TDaoBkpdfe.pAtualizaBD;
var wDataSet : TdataSet;
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

        if not Assigned(wDataSet.FindField('MODELO')) then
          wSql.Add('ALTER TABLE LM_BKPDFE ADD MODELO VARCHAR(02) CHARACTER SET WIN1252 COLLATE WIN1252');

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
    Modelo := '';
  end;
end;

{ TCNPJDOC }
function TCNPJDOC.fListaEmpresas(pMes, pAno: word): TStringList;
var wDataSet : TDataSet;
    bExit: boolean;
    wI: Integer;
    sCNPJ, sSQL: string;
    wAno, wMes, wDia : word;
    DataIniStr, DataFinStr: string;
begin
  wDataSet := TDataSet.Create(Application);
  Result := TStringList.Create;
  try
//    if not Assigned(ObjetoXML) then
//       ObjetoXML := TLm_bkpdfe.Create;
    if ((pAno <= 1899) and not(pMes in [1..12])) then
    begin
      bExit := true;
      Exit;
    end;

    DateTimeToString(DataIniStr, 'yyyy/mm/dd', EncodeDate(pAno,pMes,01));
    DataIniStr := QuotedStr(DataIniStr);

    DecodeDate(EndOfTheMonth(EncodeDate(pAno,pMes,01)),wAno, wMes, wDia);
    DateTimeToString(DataFinStr, 'yyyy/mm/dd', EncodeDate(pAno,pMes, wDia));
    DataFinStr := QuotedStr(DataFinStr);

    sSQL := sSQL + 'select CNPJ, count(*) FROM lm_bkpdfe ';
    sSQL := sSQL + Format('where (%s between %s and %s) ',['DATAEMISSAO', DataIniStr, DataFinStr]);
    sSQL := sSQL + 'group by CNPJ';
    wDataSet := DM_NFEDFE.Dao.ConsultaSql(sSQL);

    wDataSet.First;
    for wI := 0 to wDataSet.RecordCount-1 do
    begin
      sCNPJ := wDataSet.FieldByName('CNPJ').AsString;
      if Trim(sCNPJ) <> ''  then
        Result.Add(Trim(sCNPJ));

      wDataSet.Next;
    end;
  finally
    if bExit then
      Result := nil;
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
{ TPilhaAnoMes }

procedure TPilhaAnoMes.AtualizaDataMaxMin;
begin
  FDataMAX := GetDataMax;
  FDataMin := GetDataMin;
end;

function TPilhaAnoMes.CarregaMesesAno: Boolean;
var
 I, X, iMesMax, iMesMin, iAnoMax, iAnoMin, AnoX,MesX  : Integer;
 pDataMAX, pDataMin, DateX : TDate;
 sMes, sAno : String;
begin
  Result   := false;
  pDataMax := GetDataMax;
  pDataMin := GetDataMin;

  MesesAnoStack.Clear;
  DateX :=  EncodeDate(1899,12,30);
  if (pDataMin >= pDataMAX) and (pDataMin = DateX)then
  begin //or pDataMin =
     AnoMeses.Ano := 0;
     MesesAnoStack.Push(AnoMeses);
     Result   := True;
    exit;
  end;

  iMesMax := Mes(pDataMax);
  iAnoMax := Ano(pDataMax);

  iMesMin := Mes(pDataMin);
  iAnoMin := Ano(pDataMin);

  for I := iAnoMin to iAnoMax do
    AnoStack.Push(IntToStr(i));

  DateX := pDataMin;
  while pDataMax >= DateX  do
  begin
    AnoX := Ano(DateX);
    MesX := Mes(DateX);
    with AnoMeses do
    begin
      Ano   := AnoX;
      for I := MesX to 12 do
      begin
//        if (MesX in [1..12]) and ((I in [iMesMin..12]) or (I in [1..iMesMax]))then //and (I in [iMesMin, iMesMax]) then
        begin
          Meses[I] := I;
          MesesStr[I] := RetornaMes2(I);
        end
//        else
//        begin
//          Meses[I] := 0;
//          MesesStr[I] := '';
//        end;
      end;

      MesesAnoStack.Push(AnoMeses);
    end;
    DateX:= EncodeDate(Ano(DateX)+1,01,01);
  end;
  Result := (MesesAnoStack.Count > 0);
end;

constructor TPilhaAnoMes.Create;
begin
  FDataMax := 0;
  FDataMin := 0;
  AnoStack := TStack<String>.Create;
  MesStack := TStack<String>.Create;
  MesLista := TStringList.Create;
  MesesAnoStack := TStack<TAnoMeses>.Create;
end;

destructor TPilhaAnoMes.Destroy;
begin
  FDataMax := 0;
  FDataMin := 0;
  AnoStack.Free;
  MesStack.Free;
  MesLista.Free;
  MesesAnoStack.Free;
end;

function TPilhaAnoMes.GetDataMax: TDate;
begin
 Result := GetDate(gMax);
end;

function TPilhaAnoMes.GetDataMin: TDate;
begin
  Result := GetDate(gMin);
end;

function TPilhaAnoMes.GetDate(pGet: TGETMAXMIN): Tdate;
var
sParam , sSQL: String;
begin
  if pGet = gMax then
    sParam := 'MAX'
  else
    sParam := 'MIN';

  Result := 0;
  try
    sSQL := Format('SELECT %s (dataemissao) FROM lm_bkpdfe',[sParam]);
    Result := DM_NFEDFE.Dao.ConsultaSql(sSQL).FieldByName(sParam).AsDateTime;
    if Result <= 1899 then //Data Nula
      Result := 0;
  finally

  end;
end;

function TPilhaAnoMes.PreencheAnoMes: Boolean;
var
 I, iMesMax, iMesMin, iAnoMax, iAnoMin  : Integer;
 pDataMAX, pDataMin :TDate;
 sMes, sAno : String;
begin
  Result   := false;
  pDataMax := GetDataMax;
  pDataMin := GetDataMin;

  iMesMax := Mes(pDataMax);
  iAnoMax := Ano(pDataMax);

  iMesMin := Mes(pDataMin);
  iAnoMin := Ano(pDataMin);

  MesStack.Clear;
  if pDataMin > pDataMAX then
    exit;

  for i:= iMesMin to iMesMax do
    MesStack.Push(RetornaMes2(i));

  for I := iAnoMin to iAnoMax do
    AnoStack.Push(IntToStr(i));

  if (MesStack.Count > 0) and (AnoStack.Count > 0) then
    Result := true;
end;

function TPilhaAnoMes.PreencheMes(pAno: word): Boolean;
var
 sParam , sSQL,DataIniStr,DataFinStr: String;
 wDSet : TDataSet;
 sMes : String;
begin
  DateTimeToString(DataIniStr, 'yyyy/mm/dd', EncodeDate(pAno,01,01));
  DataIniStr := QuotedStr(DataIniStr);

  DateTimeToString(DataFinStr, 'yyyy/mm/dd', EncodeDate(pAno,12, 31));
  DataFinStr := QuotedStr(DataFinStr);

  Result := false;
  MesStack.Clear;
  MesLista.Clear;
  wDSet := TDataSet.Create(Application);

  try
    sSQL := 'SELECT DATAEMISSAO FROM lm_bkpdfe ';
    sSQL := sSQL + Format('where lm_bkpdfe.dataemissao between %s and %s ',[DataIniStr, DataFinStr]);
    sSQL := sSQL + 'group by dataemissao';
    wDSet := DM_NFEDFE.Dao.ConsultaSql(sSQL);

    wDSet.First;
    Result := (wDSet.RecordCount > 0);
    if not Result then
      exit;

    while Not wDSet.Eof do
    begin
      sMes := RetornaMes2(Mes(Tdate(wDSet.FieldByName('DATAEMISSAO').AsDateTime)));
      if MesLista.IndexOf(sMes) < 0 then
      begin
         MesLista.Add(sMes);
         MesStack.Push(sMes);
      end;

      wDSet.Next;
    end;
  finally
    wDSet.Free
  end;

end;

{ TLm_bkpdfe }

constructor TLm_bkpdfe.create;
begin
  inherited;
  //teste aqui
end;

end.

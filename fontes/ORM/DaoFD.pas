unit DaoFD;

interface

uses Db, Base, Rtti, Atributos, system.SysUtils, system.Classes,
  system.Generics.Collections, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Vcl.Forms;


type
  TQueryFireDac = class(TInterfacedObject, IQueryParams)
  public
    // m�todos respons�veis por setar os par�metros
    procedure SetParamInteger(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamString(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamDate(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamDateTime(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamCurrency(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamBoolean(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamVariant(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamFileStream(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamStream(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);

    // m�todos para setar os variados tipos de campos
    procedure SetCamposInteger(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposString(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposDate(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposDateTime(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposCurrency(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposBoolean(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposFileStream(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposStream(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
  end;

  TDaoFD = class(TInterfacedObject, IDaoBase)
  private
    FConexao: TFDConnection;
    FTransacao: TFDTransaction;

    FQuery: TFDQuery;
    FSql: IBaseSql;
    FDataSet: TDataSet;
    FParams: IQueryParams;

    Function DbToTabela<T: TTabela>(ATabela: TTabela; ADataSet: TDataSet): TObjectList<T>;

    procedure SetDataSet(const Value: TDataSet);
  protected
    function ExecutaQuery: Integer;
  public
    constructor Create(Conexao: TFDConnection; Transacao: TFDTransaction);
    destructor Destroy; override;

    function GerarClasse(ATabela, ANomeUnit, ANomeClasse: string): string;

    // dataset para as consultas
    function ConsultaAll(ATabela: TTabela; AOrderBy: string = ''): TDataSet;
    function SelectAll(ATabela: TTabela; AOrderBy: string = ''): TDataSet;

    function ConsultaSql(ASql: string): TDataSet; overload;
    function ConsultaSql(ASql: string; pFetchAll: Boolean): TDataSet; overload;
    function ConsultaSql(ASql: string; const ParamList: Array of Variant): TDataSet; overload;
    function ConsultaSql(ATabela: string; AWhere: string): TDataSet; overload;
    function ConsultaSqlExecute(ASql: string): TDataSet;

    function ConsultaTab(ATabela: TTabela; ACamposWhere: array of string)
      : TDataSet; overload;

    function ConsultaTabela(ATabela: TTabela; ACamposWhere: array of string)
      : TFDQuery;

    function ConsultaTab(ATabela: TTabela; ACampos, ACamposWhere: array of string)
      : TDataSet; overload;

    function ConsultaTab(ATabela: TTabela; ACampos, ACamposWhere, AOrdem: array of string;
      TipoOrdem: Integer = 0): TDataSet; overload;

    function ConsultaGen<T: TTabela>(ATabela: TTabela; ACamposWhere: array of string)
      : TObjectList<T>;

    // limpar campos da tabela
    procedure Limpar(ATabela: TTabela);

    // pega campo autoincremento
    function GetID(ATabela: TTabela; ACampo: string): Integer;
    function GetMax(ATabela: TTabela; ACampo: string;
      ACamposChave: array of string): Integer;

    // recordcount
    function GetRecordCount(ATabela: TTabela; ACamposWhere: array of string)
      : Integer; overload;
    function GetRecordCount(ATabela: string; AWhere: string): Integer; overload;

    // crud
    function Inserir(ATabela: TTabela): Integer; overload;
    function Inserir(ATabela: TTabela; ACampos: array of string; AFlag: TFlagCampos = fcIgnore): Integer; overload;
    function Inserir(ATabela: TTabela; ACampos: array of string;
    ACamposRequiredFalse: array of string; AFlag: TFlagCampos = fcIgnore): Integer; overload;

    function Salvar(ATabela: TTabela): Integer; overload;
    function Salvar(ATabela: TTabela; ACampos: array of string;
      AFlag: TFlagCampos = fcAdd): Integer; overload;

    function Excluir(ATabela: TTabela): Integer; overload;
    function Excluir(ATabela: TTabela; AWhere: array of string): Integer; overload;
    function Excluir(ATabela: string; AWhereValue: string): Integer; overload;
    function ExcluirTodos(ATabela: TTabela): Integer; overload;

    function Buscar(ATabela: TTabela): Integer;
    function BuscarID(ATabela: TTabela): TDataSet;

    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
    function  InTransaction: Boolean;

    property DataSet: TDataSet read FDataSet write SetDataSet;
  end;

implementation

uses dialogs, system.TypInfo, System.Variants,
  GerarClasseFireDac, GerarClasse.BancoFirebird, GerarClasse.BancoMySQL;

{ TQueryFireDac }
procedure TQueryFireDac.SetParamFileStream(AProp: TRttiProperty; ACampo: string;
  ATabela: TTabela; AQry: TObject);
var stream: TFileStream;
begin
  if Assigned(TFileStream(AProp.GetValue(ATabela).AsObject)) then
  begin
    stream := TFileStream(AProp.GetValue(ATabela).AsObject);
    TFDQuery(AQry).ParamByName(ACampo).LoadFromStream(stream, ftBlob);
  end
  else
  TFDQuery(AQry).ParamByName(ACampo).AsBlob := '';
end;

procedure TQueryFireDac.SetParamStream(AProp: TRttiProperty; ACampo: string;
  ATabela: TTabela; AQry: TObject);
var stream: Tstream;
begin
  if Assigned(TStream(AProp.GetValue(ATabela).AsObject)) then
  begin
    stream := TStream(AProp.GetValue(ATabela).AsObject);
    TFDQuery(AQry).ParamByName(ACampo).LoadFromStream(stream, ftBlob);
  end
  else
  TFDQuery(AQry).ParamByName(ACampo).AsBlob := '';
end;

procedure TQueryFireDac.SetParamBoolean(AProp: TRttiProperty; ACampo: string;
  ATabela: TTabela; AQry: TObject);
begin
  TFDQuery(AQry).ParamByName(ACampo).AsBoolean := AProp.GetValue(ATabela).AsBoolean;
end;

procedure TQueryFireDac.SetParamCurrency(AProp: TRttiProperty; ACampo: string;
  ATabela: TTabela; AQry: TObject);
begin
  TFDQuery(AQry).ParamByName(ACampo).AsCurrency := AProp.GetValue(ATabela).AsCurrency;
end;

procedure TQueryFireDac.SetParamDate(AProp: TRttiProperty;
  ACampo: string; ATabela: TTabela; AQry: TObject);
begin
  inherited;
  if AProp.GetValue(ATabela).AsType<TDate> = 0 then
    TFDQuery(AQry).ParamByName(ACampo).Clear
  else
    TFDQuery(AQry).ParamByName(ACampo).AsDate := AProp.GetValue(ATabela).AsType<TDate>;
end;

procedure TQueryFireDac.SetParamDateTime(AProp: TRttiProperty; ACampo: string;
  ATabela: TTabela; AQry: TObject);
begin
 inherited;
  if AProp.GetValue(ATabela).AsType<TDateTime> = 0 then
    TFDQuery(AQry).ParamByName(ACampo).Clear
  else
    TFDQuery(AQry).ParamByName(ACampo).AsDateTime := AProp.GetValue(ATabela).AsType<TDateTime>;
end;

procedure TQueryFireDac.SetParamInteger(AProp: TRttiProperty;
  ACampo: string; ATabela: TTabela; AQry: TObject);
begin
  TFDQuery(AQry).ParamByName(ACampo).AsInteger := AProp.GetValue(ATabela).AsInteger;
end;

procedure TQueryFireDac.SetParamString(AProp: TRttiProperty;
  ACampo: string; ATabela: TTabela; AQry: TObject);
begin
  TFDQuery(AQry).ParamByName(ACampo).AsString := AProp.GetValue(ATabela).AsString;
end;

procedure TQueryFireDac.SetParamVariant(AProp: TRttiProperty;
  ACampo: string; ATabela: TTabela; AQry: TObject);
begin
  TFDQuery(AQry).ParamByName(ACampo).Value := AProp.GetValue(ATabela).AsVariant;
end;

procedure TQueryFireDac.SetCamposFileStream(AProp: TRttiProperty; ACampo: string;
  ATabela: TTabela; AQry: TObject);
begin
  AProp.SetValue(ATabela, TFDQuery(AQry).CreateBlobStream(TFDQuery(AQry).FieldByName(ACampo),bmWrite));
end;

procedure TQueryFireDac.SetCamposBoolean(AProp: TRttiProperty; ACampo: string;
  ATabela: TTabela; AQry: TObject);
begin
  AProp.SetValue(ATabela, TFDQuery(AQry).FieldByName(ACampo).AsBoolean);
end;

procedure TQueryFireDac.SetCamposCurrency(AProp: TRttiProperty;
  ACampo: string; ATabela: TTabela; AQry: TObject);
begin
  AProp.SetValue(ATabela, TFDQuery(AQry).FieldByName(ACampo).AsCurrency);
end;

procedure TQueryFireDac.SetCamposDate(AProp: TRttiProperty;
  ACampo: string; ATabela: TTabela; AQry: TObject);
begin
  AProp.SetValue(ATabela, TDate(TFDQuery(AQry).FieldByName(ACampo).AsDateTime));
end;

procedure TQueryFireDac.SetCamposDateTime(AProp: TRttiProperty; ACampo: string;
  ATabela: TTabela; AQry: TObject);
begin
  AProp.SetValue(ATabela, TFDQuery(AQry).FieldByName(ACampo).AsDateTime);
end;

procedure TQueryFireDac.SetCamposInteger(AProp: TRttiProperty;
  ACampo: string; ATabela: TTabela; AQry: TObject);
begin
  AProp.SetValue(ATabela, TFDQuery(AQry).FieldByName(ACampo).AsInteger);
end;

procedure TQueryFireDac.SetCamposStream(AProp: TRttiProperty; ACampo: string;
  ATabela: TTabela; AQry: TObject);
begin
  AProp.SetValue(ATabela, TFDQuery(AQry).CreateBlobStream(TFDQuery(AQry).FieldByName(ACampo),bmWrite));
end;

procedure TQueryFireDac.SetCamposString(AProp: TRttiProperty;
  ACampo: string; ATabela: TTabela; AQry: TObject);
begin
  AProp.SetValue(ATabela, TFDQuery(AQry).FieldByName(ACampo).AsString);
end;

{ TDaoFireDac }

constructor TDaoFD.Create(Conexao: TFDConnection;
  Transacao: TFDTransaction);
begin
  inherited Create;
  FSql := TPadraoSql.create;
  FParams := TQueryFireDac.create;
  FConexao := Conexao;
  FTransacao := Transacao;

  FQuery := TFDQuery.Create(Application);
  FQuery.Connection := FConexao;
end;

destructor TDaoFD.Destroy;
begin
  inherited;
end;

function TDaoFD.GerarClasse(ATabela, ANomeUnit, ANomeClasse: string): string;
var
  NovaClasse: TGerarClasseFireDac;
begin
  NovaClasse := TGerarClasseFireDac.Create(TGerarClasseBancoFirebird.Create, Self);
//  NovaClasse := TGerarClasseFireDac.Create(TGerarClasseBancoMySQL.Create, Self);
  try
    Result := NovaClasse.Gerar(ATabela, ANomeUnit, ANomeClasse);
  finally
    NovaClasse.Free;
  end;
end;

procedure TDaoFD.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
end;

procedure TDaoFD.StartTransaction;
begin
  FTransacao.StartTransaction;
end;


procedure TDaoFD.Commit;
begin
  FTransacao.Commit;
end;

procedure TDaoFD.RollBack;
begin
  FTransacao.RollBack;
end;

function TDaoFD.InTransaction: Boolean;
begin
  Result := FConexao.InTransaction;
end;

procedure TDaoFD.Limpar(ATabela: TTabela);
begin
  TAtributos.Get.LimparCampos(ATabela);
end;

function TDaoFD.DbToTabela<T>(ATabela: TTabela; ADataSet: TDataSet)
  : TObjectList<T>;
var
  AuxValue: TValue;
  TipoRtti: TRttiType;
  Contexto: TRttiContext;
  PropRtti: TRttiProperty;
  DataType: TFieldType;
  Campo: String;
begin
  Result := TObjectList<T>.Create;

  while not ADataSet.Eof do
  begin
    AuxValue := GetTypeData(PTypeInfo(TypeInfo(T)))^.ClassType.Create;
    TipoRtti := Contexto.GetType(AuxValue.AsObject.ClassInfo);
    for PropRtti in TipoRtti.GetProperties do
    begin
      Campo := PropRtti.Name;
      DataType := ADataSet.FieldByName(Campo).DataType;

      case DataType of
        ftInteger:
          begin
            PropRtti.SetValue(AuxValue.AsObject,
              TValue.FromVariant(ADataSet.FieldByName(Campo).AsInteger));
          end;
        ftString, ftWideString, ftWideMemo:
          begin
            PropRtti.SetValue(AuxValue.AsObject,
              TValue.FromVariant(ADataSet.FieldByName(Campo).AsString));
          end;
        ftBCD, ftFloat:
          begin
            PropRtti.SetValue(AuxValue.AsObject,
              TValue.FromVariant(ADataSet.FieldByName(Campo).AsFloat));
          end;
        ftDate, ftDateTime:
          begin
            PropRtti.SetValue(AuxValue.AsObject,
              TValue.FromVariant(ADataSet.FieldByName(Campo).AsDateTime));
          end;
      else
        raise Exception.Create('Tipo de campo n�o conhecido: ' +
          PropRtti.PropertyType.ToString);
      end;
    end;
    Result.Add(AuxValue.AsType<T>);

    ADataSet.Next;
  end;
end;

function TDaoFD.ConsultaGen<T>(ATabela: TTabela; ACamposWhere: array of string)
  : TObjectList<T>;
var
  Dados: TFDQuery;
  Contexto: TRttiContext;
  Campo: string;
  TipoRtti: TRttiType;
  PropRtti: TRttiProperty;
begin
  Dados := TFDQuery.Create(Application);
  try
    Contexto := TRttiContext.Create;
    try
      TipoRtti := Contexto.GetType(ATabela.ClassType);
      with Dados do
      begin
        Connection := FConexao;
        sql.Text := FSql.GerarSqlSelect(ATabela, ACamposWhere);

        for Campo in ACamposWhere do
        begin
          if not TAtributos.Get.PropExiste(Campo, PropRtti, TipoRtti) then
            raise Exception.Create('Campo ' + Campo + ' n�o existe no objeto!');

          // setando os par�metros
          for PropRtti in TipoRtti.GetProperties do
          begin
            if CompareText(PropRtti.Name, Campo) = 0 then
              TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, Dados, FParams);
          end;
        end;

        Open;

        Result := DbToTabela<T>(ATabela, Dados);
      end;
    finally
      Contexto.Free;
    end;
  finally
    Dados.Free;
  end;
end;

function TDaoFD.ConsultaAll(ATabela: TTabela; AOrderBy: string): TDataSet;
var
  AQry: TFDQuery;
begin
  if not Assigned(ATabela) then
  begin
    ShowMessage('Tabela '+ ATabela.ClassName+' n�o foi instanciada.');
    exit;
  end;

  AQry := TFDQuery.Create(Application);
  try

    with AQry do
    begin
    Connection := FConexao;
    sql.Clear;
    sql.Add('Select * from ' + TAtributos.Get.PegaNomeTab(ATabela));
    if AOrderBy <> '' then
      sql.Add('order by '+ AOrderBy);
    Open;
    end;
    Result := AQry;
  finally
  end;
end;

function TDaoFD.SelectAll(ATabela: TTabela; AOrderBy: string): TDataSet;
var AQry : TFDQuery;
begin
  AQry := TFDQuery.Create(Application);
  try
    with AQry do
    begin
      Connection := FConexao;
      sql.Clear;
      sql.Add('Select * from ' + TAtributos.Get.PegaNomeTab(ATabela));
      if AOrderBy <> '' then
        sql.Add('order by '+ AOrderBy);
      Open;
    end;
    Result := AQry;
  finally

  end;
end;

function TDaoFD.ConsultaSql(ASql: string; pFetchAll: Boolean): TDataSet;
var AQry: TFDQuery;
begin
  AQry := TFDQuery.Create(Application);

  with AQry do
  begin
    Connection := FConexao;
    sql.Clear;
    sql.Add(ASql);
    Open;
    if pFetchAll then
      FetchAll;

  end;


  Result := AQry
end;

function TDaoFD.ConsultaSql(ASql: string): TDataSet;
var
  AQry: TFDQuery; //TFDQuery;
begin
  AQry := TFDQuery.Create(Application);
  with AQry do
  begin
    Connection := FConexao;
    sql.Clear;
    sql.Add(ASql);
    Open;
  end;

  Result := AQry;
end;

function TDaoFD.ConsultaSqlExecute(ASql: string): TDataSet;
var
  AQry: TFDQuery;
begin
  AQry := TFDQuery.Create(Application);
  with AQry do
  begin
    Connection := FConexao;
    sql.Clear;
    sql.Add(ASql);
    Execute();

  Result := AQry;
end;
end;

function TDaoFD.ConsultaSql(ASql: string; const ParamList: array of Variant): TDataSet;
var
  AQry: TFDQuery;
  i: integer;
begin
  try
    AQry := TFDQuery.Create(Application);
    with AQry do
    begin
      Connection := FConexao;
      sql.Clear;
      sql.Add(ASql);

      if (Length(ParamList) > 0) and (Params.Count > 0) then
       for i := 0 to Params.Count -1 do
         if (i < Length(ParamList)) then
           if VarIsType(ParamList[i], varDate) then
             Params[i].AsDateTime := VarToDateTime(ParamList[i])
           else
             Params[i].Value := ParamList[i];

      Open;
    end;
    Result := AQry;
  finally
    AQry.Free;
  end;
end;

function TDaoFD.ConsultaSql(ATabela, AWhere: string): TDataSet;
var
  AQry: TFDQuery;
begin
  try
    AQry := TFDQuery.Create(Application);
    with AQry do
    begin
      Connection := FConexao;
      sql.Clear;
      sql.Add('select * from ' + ATabela);
      if AWhere <> '' then
        sql.Add('where ' + AWhere);
      Open;
    end;
    Result := AQry;
  finally
    AQry.Free;
  end;
end;

function TDaoFD.ConsultaTab(ATabela: TTabela; ACampos, ACamposWhere,
  AOrdem: array of string; TipoOrdem: Integer): TDataSet;
var
  Dados: TFDQuery;
  Contexto: TRttiContext;
  Campo: string;
  TipoRtti: TRttiType;
  PropRtti: TRttiProperty;
  Separador: string;
begin
  Dados := TFDQuery.Create(Application);
  Contexto := TRttiContext.Create;
  try
    TipoRtti := Contexto.GetType(ATabela.ClassType);

    with Dados do
    begin
      Connection := FConexao;
      sql.Text := FSql.GerarSqlSelect(ATabela, ACampos, ACamposWhere);

      if Length(AOrdem)>0 then
      begin
        Separador := '';
        SQL.Add('order by');
        for Campo in AOrdem do
        begin
          if TipoOrdem = 1 then
            sql.Add(Separador + Campo + ' Desc')
          else
            sql.Add(Separador + Campo);
          Separador := ',';
        end;
      end;

      if Length(ACamposWhere)>0 then
      begin
        for Campo in ACamposWhere do
        begin
          // setando os par�metros
          for PropRtti in TipoRtti.GetProperties do
            if CompareText(PropRtti.Name, Campo) = 0 then
              TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, Dados, FParams);
        end;
      end;
      Open;
      Result := Dados;
    end;
  finally
    Contexto.Free;
  end;
end;

function TDaoFD.ConsultaTabela(ATabela: TTabela;
  ACamposWhere: array of string): TFDQuery;
var
  Dados: TFDQuery;
  Contexto: TRttiContext;
  Campo: string;
  TipoRtti: TRttiType;
  PropRtti: TRttiProperty;
begin
  Dados := TFDQuery.Create(Application);
  Contexto := TRttiContext.Create;
  try
    TipoRtti := Contexto.GetType(ATabela.ClassType);

    with Dados do
    begin
      Connection := FConexao;
      sql.Text := FSql.GerarSqlSelect(ATabela, ACamposWhere);

      if Length(ACamposWhere)>0 then
      begin
        for Campo in ACamposWhere do
        begin
          // setando os par�metros
          for PropRtti in TipoRtti.GetProperties do
            if CompareText(PropRtti.Name, Campo) = 0 then
            begin
              TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, Dados, FParams);
              Break;
            end;
        end;
      end;
      Open;

      Result := Dados;
    end;
  finally
    Contexto.Free;
  end;

end;

function TDaoFD.ConsultaTab(ATabela: TTabela; ACampos, ACamposWhere: array of string): TDataSet;
var
  Dados: TFDQuery;
  Contexto: TRttiContext;
  Campo: string;
  TipoRtti: TRttiType;
  PropRtti: TRttiProperty;
begin
  Dados := TFDQuery.Create(Application);
  Contexto := TRttiContext.Create;
  try
    TipoRtti := Contexto.GetType(ATabela.ClassType);

    with Dados do
    begin
      Connection := FConexao;
      sql.Text := FSql.GerarSqlSelect(ATabela, ACampos, ACamposWhere);

      if Length(ACamposWhere)>0 then
      begin
        for Campo in ACamposWhere do
        begin
          // setando os par�metros
          for PropRtti in TipoRtti.GetProperties do
            if CompareText(PropRtti.Name, Campo) = 0 then
              TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, Dados, FParams);
        end;
      end;

      Open;

      Result := Dados;
    end;
  finally
    Contexto.Free;
  end;
end;

function TDaoFD.ConsultaTab(ATabela: TTabela;
  ACamposWhere: array of string): TDataSet;
var
  Dados: TFDQuery;
  Contexto: TRttiContext;
  Campo: string;
  TipoRtti: TRttiType;
  PropRtti: TRttiProperty;
begin
  Dados := TFDQuery.Create(Application);
  Contexto := TRttiContext.Create;
  try
    TipoRtti := Contexto.GetType(ATabela.ClassType);
    try
      with Dados do
      begin
        Connection := FConexao;
        sql.Text := FSql.GerarSqlSelect(ATabela, ACamposWhere);

        if Length(ACamposWhere)>0 then
        begin
          for Campo in ACamposWhere do
          begin
            // setando os par�metros
            for PropRtti in TipoRtti.GetProperties do
              if CompareText(PropRtti.Name, Campo) = 0 then
              begin
                TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, Dados, FParams);
                Break;
              end;
          end;
        end;
        Open;

        Result := Dados;
      end;
    except
      FreeAndNil(Dados);
    end;
  finally
    Contexto.Free;
  end;
end;

function TDaoFD.GetID(ATabela: TTabela; ACampo: string): Integer;
var
  AQry: TFDQuery;
begin
  AQry := TFDQuery.Create(Application);
  with AQry do
  begin
    Connection := FConexao;
    sql.Clear;
    sql.Add('select max(' + ACampo + ') from ' + TAtributos.Get.PegaNomeTab(ATabela));
    Open;
    Result := fields[0].AsInteger + 1;
  end;
end;

function TDaoFD.GetMax(ATabela: TTabela; ACampo: string;
  ACamposChave: array of string): Integer;
var
  AQry: TFDQuery;
  Campo: string;
  Contexto: TRttiContext;
  TipoRtti: TRttiType;
  PropRtti: TRttiProperty;
  Separador: string;
  NumMax: Integer;
begin
  AQry := TFDQuery.Create(Application);
  try
    with AQry do
    begin
      Connection := FConexao;
      sql.Clear;
      sql.Add('select max(' + ACampo + ') from ' + TAtributos.Get.PegaNomeTab(ATabela));
      sql.Add('Where');
      Separador := '';
      for Campo in ACamposChave do
      begin
        sql.Add(Separador + Campo + '= :' + Campo);
        Separador := ' and ';
      end;

      Contexto := TRttiContext.Create;
      try
        TipoRtti := Contexto.GetType(ATabela.ClassType);

        for Campo in ACamposChave do
        begin
          // setando os par�metros
          for PropRtti in TipoRtti.GetProperties do
            if CompareText(PropRtti.Name, Campo) = 0 then
              TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, AQry, FParams);
        end;

        Open;

        NumMax := Fields[0].AsInteger;

        Result := NumMax;
      finally
        Contexto.Free;
      end;
    end;
  finally
    AQry.Free;
  end;
end;

function TDaoFD.GetRecordCount(ATabela, AWhere: string): Integer;
var
  AQry: TFDQuery;
begin
  AQry := TFDQuery.Create(nil);
  try
    with AQry do
    begin
      Connection := FConexao;
      sql.Clear;
      sql.Add('select count(*) from ' + ATabela);
      if AWhere <> '' then
        sql.Add('where ' + AWhere);
      Open;
    end;

    Result := AQry.Fields[0].AsInteger;
  finally
    AQry.Free;
  end;
end;

function TDaoFD.GetRecordCount(ATabela: TTabela;
  ACamposWhere: array of string): Integer;
var
  AQry: TFDQuery;
  Contexto: TRttiContext;
  Campo: string;
  TipoRtti: TRttiType;
  PropRtti: TRttiProperty;
begin
  AQry := TFDQuery.Create(nil);
  try
    with AQry do
    begin
      Contexto := TRttiContext.Create;
      try
        TipoRtti := Contexto.GetType(ATabela.ClassType);
        Connection := FConexao;

        sql.Clear;

        sql.Add('select count(*) from ' + TAtributos.Get.PegaNomeTab(ATabela));

        if High(ACamposWhere) >= 0 then
          sql.Add('where 1=1');

        for Campo in ACamposWhere do
          sql.Add('and ' + Campo + '=:' + Campo);

        for Campo in ACamposWhere do
        begin
          for PropRtti in TipoRtti.GetProperties do
            if CompareText(PropRtti.Name, Campo) = 0 then
              TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, AQry, FParams);
        end;

        Open;

        Result :=  RecordCount; //fields[0].AsInteger;
      finally
        Contexto.Free;
      end;
    end;
  finally
    AQry.Free;
  end;
end;

function TDaoFD.ExecutaQuery: Integer;
begin
  with FQuery do
  begin
    Prepare();
    ExecSQL;
    Result := RowsAffected;
  end;
end;

function TDaoFD.Excluir(ATabela: TTabela): Integer;
var
  Campo: string;
  PropRtti: TRttiProperty;
  RttiType: TRttiType;
begin
  FQuery.close;
  FQuery.sql.Clear;
  FQuery.sql.Text := FSql.GerarSqlDelete(ATabela);

  RttiType := TRttiContext.Create.GetType(ATabela.ClassType);

  // percorrer todos os campos da chave prim�ria
  for Campo in TAtributos.Get.PegaPks(ATabela) do
  begin
    // setando os par�metros
    for PropRtti in RttiType.GetProperties do
      if CompareText(PropRtti.Name, Campo) = 0 then
        TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, FQuery, FParams);
  end;

  Result := ExecutaQuery;
end;

function TDaoFD.Excluir(ATabela: TTabela; AWhere: array of string): Integer;
var
  Campo: string;
  PropRtti: TRttiProperty;
  RttiType: TRttiType;
  Sep: string;
begin
  if Length(AWhere) = 0 then
    raise Exception.Create('Campos AWhere n�o selecionados!');

  RttiType := TRttiContext.Create.GetType(ATabela.ClassType);

  FQuery.close;
  FQuery.sql.Clear;
  FQuery.sql.Add('Delete from ' + TAtributos.Get.PegaNomeTab(ATabela));
  FQuery.SQL.Add('Where');

  Sep := '';

  for Campo in AWhere do
  begin
    FQuery.SQL.Add(Sep + Campo + '= :' + Campo);
    Sep := ' and ';
  end;

  // percorrer todos os campos da chave prim�ria
  for Campo in AWhere do
  begin
    // setando os par�metros
    for PropRtti in RttiType.GetProperties do
      if CompareText(PropRtti.Name, Campo) = 0 then
        TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, FQuery, FParams);
  end;

  Result := ExecutaQuery;
end;

function TDaoFD.Excluir(ATabela: string; AWhereValue: string): Integer;
begin
  if Trim(AWhereValue) = '' then
    raise Exception.Create('Campo/Valor para a exclus�o n�o informado');

  FQuery.close;
  FQuery.sql.Clear;
  FQuery.sql.Add('Delete from ' + ATabela);
  FQuery.SQL.Add('Where ' + AwhereValue);

  Result := ExecutaQuery;
end;

function TDaoFD.ExcluirTodos(ATabela: TTabela): Integer;
begin
  FQuery.close;
  FQuery.sql.Clear;
  FQuery.sql.Text := 'Delete from ' + TAtributos.Get.PegaNomeTab(ATabela);
  Result := ExecutaQuery;
end;

function TDaoFD.Inserir(ATabela: TTabela): Integer;
begin
  Result := Self.Inserir(ATabela, []);
end;

function TDaoFD.Inserir(ATabela: TTabela; ACampos: array of string;
  AFlag: TFlagCampos): Integer;
var
  Atributos: IAtributos;
  Campo: string;
  PropRtti: TRttiProperty;
  RttiType: TRttiType;
begin
  Atributos := TAtributos.Create;
  try
    Atributos.ValidaTabela(ATabela, ACampos, AFlag);
    RttiType := TRttiContext.Create.GetType(ATabela.ClassType);

    with FQuery do
    begin
      close;
      sql.Clear;
      sql.Text := FSql.GerarSqlInsert(ATabela, RttiType, ACampos, AFlag);
      // valor dos par�metros

      for PropRtti in RttiType.GetProperties do
      begin
        if (Length(ACampos) > 0) then
          if not (Atributos.LocalizaCampo(PropRtti.Name, Atributos.PegaPks(ATabela))) then
          begin
            if ((AFlag=fcIgnore) and (Atributos.LocalizaCampo(PropRtti.Name, ACampos))) or
              ((AFlag=fcAdd) and (not Atributos.LocalizaCampo(PropRtti.Name, ACampos))) then
              Continue;
          end;

        Campo := PropRtti.Name;
        TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, FQuery, FParams);
      end;
    end;
    Result := ExecutaQuery;
  except
    raise;
  end;
end;

function TDaoFD.Inserir(ATabela: TTabela; ACampos: array of string;
  ACamposRequiredFalse: array of string;AFlag: TFlagCampos): Integer;
var
  Atributos: IAtributos;
  Campo, CampoReq: string;
  PropRtti: TRttiProperty;
  RttiType: TRttiType;
begin
  Atributos := TAtributos.Create;
  try
    Atributos.ValidaTabela(ATabela, ACampos, AFlag);
    RttiType := TRttiContext.Create.GetType(ATabela.ClassType);

    with FQuery do
    begin
      close;
      sql.Clear;
      sql.Text := FSql.GerarSqlInsert(ATabela, RttiType, ACampos, AFlag);
      //Campos requeiridos False
//      for CampoReq in ACamposRequiredFalse do
//      begin
//        if (Length(Trim(CampoReq)) > 0) then
//         FieldByName(CampoReq).Required := False
//      end;

      // valor dos par�metros
      for PropRtti in RttiType.GetProperties do
      begin
        if (Length(ACampos) > 0) then
          if not (Atributos.LocalizaCampo(PropRtti.Name, Atributos.PegaPks(ATabela))) then
          begin
            if ((AFlag=fcIgnore) and (Atributos.LocalizaCampo(PropRtti.Name, ACampos))) or
              ((AFlag=fcAdd) and (not Atributos.LocalizaCampo(PropRtti.Name, ACampos))) then
              Continue;
          end;

        Campo := PropRtti.Name;
        TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, FQuery, FParams);
      end;
    end;
    Result := ExecutaQuery;
  except
    raise;
  end;

end;

function TDaoFD.Salvar(ATabela: TTabela): Integer;
begin
  Result := Self.Salvar(ATabela, []);
end;

function TDaoFD.Salvar(ATabela: TTabela; ACampos: array of string;
  AFlag: TFlagCampos): Integer;
var
  Atributos: IAtributos;
  PropRtti: TRttiProperty;
  RttiType: TRttiType;
begin
  Atributos := TAtributos.Create;
  try
    Atributos.ValidaTabela(ATabela, ACampos, AFlag);
    RttiType := TRttiContext.Create.GetType(ATabela.ClassType);

    with FQuery do
    begin
      close;
      sql.Clear;
      sql.Text := FSql.GerarSqlUpdate(ATabela, RttiType, ACampos, AFlag);
      // valor dos par�metros
      for PropRtti in RttiType.GetProperties do
      begin
        if (Length(ACampos) > 0) and not (Atributos.LocalizaCampo(
          PropRtti.Name, Atributos.PegaPks(ATabela))) then
        begin
          if ((AFlag=fcAdd) and (not Atributos.LocalizaCampo(PropRtti.Name, ACampos))) or
            ((AFlag=fcIgnore) and (Atributos.LocalizaCampo(PropRtti.Name, ACampos))) then
            Continue;
        end;
        TAtributos.Get.ConfiguraParametro(PropRtti, PropRtti.Name, ATabela, FQuery, FParams);
      end;
    end;
    Result := ExecutaQuery;
  except on E: Exception do
           begin
             ShowMessage(E.Message);
           end;
  end;
end;

function TDaoFD.Buscar(ATabela: TTabela): Integer;
var
  Dados: TFDQuery;
  Campo: string;
  PropRtti: TRttiProperty;
  RttiType: TRttiType;
begin
  Dados := TFDQuery.Create(nil);
  try
    RttiType := TRttiContext.Create.GetType(ATabela.ClassType);
    with Dados do
    begin
      Connection := FConexao;
      sql.Text := FSql.GerarSqlSelect(ATabela);

      for Campo in TAtributos.Get.PegaPks(ATabela) do
      begin
        // setando os par�metros
        for PropRtti in RttiType.GetProperties do
          if CompareText(PropRtti.Name, Campo) = 0 then
          begin
            TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, Dados, FParams);
          end;
      end;
      Open;
      Result := RecordCount;
      if Result > 0 then
      begin
        for PropRtti in RttiType.GetProperties do
        begin
          Campo := PropRtti.Name;
          TAtributos.Get.SetarDadosTabela(PropRtti, Campo, ATabela, Dados, FParams);
        end;
      end;
    end;
  finally
    Dados.Free;
  end;
end;

function TDaoFD.BuscarID(ATabela: TTabela): TDataSet;
var
  Dados: TFDQuery;
  Campo: string;
  PropRtti: TRttiProperty;
  RttiType: TRttiType;
begin
  Dados := TFDQuery.Create(nil);
  try
    RttiType := TRttiContext.Create.GetType(ATabela.ClassType);
    with Dados do
    begin
      Connection := FConexao;
      sql.Text := FSql.GerarSqlSelect(ATabela);

      for Campo in TAtributos.Get.PegaPks(ATabela) do
      begin
        // setando os par�metros
        for PropRtti in RttiType.GetProperties do
          if CompareText(PropRtti.Name, Campo) = 0 then
          begin
            TAtributos.Get.ConfiguraParametro(PropRtti, Campo, ATabela, Dados, FParams);
          end;
      end;
      Open;

      Result :=  Dados;
      if Result.RecordCount > 0 then
      begin
        for PropRtti in RttiType.GetProperties do
        begin
          Campo := PropRtti.Name;
          TAtributos.Get.SetarDadosTabela(PropRtti, Campo, ATabela, Result, FParams);
        end;
      end;
    end;
  finally
    Dados.Free;
  end;
end;

end.

unit GerarClasse.BancoFirebird;

interface

uses
  Base, DB, SysUtils, Classes;

type
  TGerarClasseBancoFirebird = class(TInterfacedObject, IBaseGerarClasseBanco)
  private
    function GetTypeField(Tipo, SubTipo, Precisao: Integer): string;
  public
     //obtem sql com nome, tamanho e tipo dos campos
    function GetSQLCamposTabela(ATabela: string): string;

    //obtem sql com chave prim�rias
    function GetSQLCamposPK(ATabela: string): string;

    procedure GerarFields(Ads: TDataSet; AResult: TStrings);
    procedure GerarProperties(Ads: TDataSet; AResult: TStrings; ACamposPK: string);
  end;

implementation

{ TGerarClasseIBX }

procedure TGerarClasseBancoFirebird.GerarFields(Ads: TDataSet; AResult: TStrings);
var
  Tipo,
  SubTipo,
  Precisao: Integer;
  Nome: string;
begin
  AResult.Add('  private');
  ADs.First;
  while not Ads.eof do
  begin
    Tipo := Ads.FieldByName('tipo').AsInteger;
    SubTipo := Ads.FieldByName('subtipo').AsInteger;
    Precisao := Ads.FieldByName('precisao').AsInteger;
    Nome := Trim(Ads.FieldByName('nome').AsString);
    Nome := 'F' + UpperCase(Nome[1]) + LowerCase(Copy(Nome, 2, Length(Nome)));
    AResult.Add('    ' + Nome + ': ' + GetTypeField(Tipo, SubTipo, Precisao) + ';');
    Ads.Next;
  end;
end;

procedure TGerarClasseBancoFirebird.GerarProperties(Ads: TDataSet; AResult: TStrings; ACamposPK: string);
var
  Tipo,
  SubTipo,
  Precisao: Integer;
  Nome: string;
begin
  AResult.Add('  public');
  ADs.First;
  while not Ads.eof do
  begin
    Tipo := Ads.FieldByName('tipo').AsInteger;
    SubTipo := Ads.FieldByName('subtipo').AsInteger;
    Precisao := Ads.FieldByName('precisao').AsInteger;
    Nome := Trim(Ads.FieldByName('nome').AsString);

    if pos(Nome, ACamposPK) > 0 then
      AResult.Add('    [attPK]');

    Nome := UpperCase(Nome[1]) + LowerCase(Copy(Nome, 2, Length(Nome)));

    AResult.Add('    property ' +
                       Nome +': ' + GetTypeField(Tipo, SubTipo, Precisao) +
                       ' read F' + Nome +
                       ' write F' + Nome + ';');
    Ads.Next;
  end;
end;

function TGerarClasseBancoFirebird.GetSQLCamposPK(ATabela: string): string;
begin
  Result := 'SELECT RDB$RELATION_CONSTRAINTS.RDB$RELATION_NAME AS TABELA, ' +
            'RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_NAME AS CHAVE, ' +
            'RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME AS INDICE_DA_CHAVE, ' +
            'RDB$INDEX_SEGMENTS.RDB$FIELD_NAME AS CAMPO, ' +
            'RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION AS POSICAO ' +
            'FROM RDB$RELATION_CONSTRAINTS, ' +
            'RDB$INDICES, ' +
            'RDB$INDEX_SEGMENTS ' +
            'WHERE RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ' +
            'AND RDB$RELATION_CONSTRAINTS.RDB$RELATION_NAME = ' + QuotedStr(ATabela) +
            'AND RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
            'AND RDB$INDEX_SEGMENTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
            'ORDER BY RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_NAME, ' +
            'RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION';
end;

function TGerarClasseBancoFirebird.GetSQLCamposTabela(ATabela: string): string;
begin
  Result := 'SELECT r.RDB$FIELD_NAME AS nome,' +
            'r.RDB$DESCRIPTION AS descricao,' +
            'f.RDB$FIELD_LENGTH AS tamanho,' +
            'f.RDB$FIELD_TYPE AS tipo,' +
            'f.RDB$FIELD_SUB_TYPE AS subtipo, ' +
            'f.RDB$FIELD_PRECISION AS precisao ' +
            'FROM RDB$RELATION_FIELDS r ' +
            'LEFT JOIN RDB$FIELDS f ON r.RDB$FIELD_SOURCE = f.RDB$FIELD_NAME ' +
            'WHERE r.RDB$RELATION_NAME='+ QuotedStr(ATabela) + ' ' +
            'ORDER BY r.RDB$FIELD_POSITION;';
end;

function TGerarClasseBancoFirebird.GetTypeField(Tipo, SubTipo, Precisao: Integer): string;
begin
  case Tipo of
    7,
    8,
    9,
    10,
    11,
    16,                                     //Data type code for the column:
    27: begin                               //7 = SMALLINT
          if Precisao = 0 then              //8 = INTEGER
            Result := 'Integer'             //10 = FLOAT
          else                              //12 = DATE
            Result := 'Currency';           //13 = TIME
        end;                                //14 = CHAR
    14,                                     //16 = BIGINT
    37,                                     //27 = DOUBLE PRECISION
    40: Result := 'string';                 //35 = TIMESTAMP
    12: Result := 'TDate';                  //37 = VARCHAR
    13: Result := 'TTime';                  //261 = BLOB
    35: Result := 'TDateTime';              //Codes for DECIMAL and NUMERIC are the same as for the integer types used to store them
    261:
    begin
      if SubTipo = 1 then
        Result := 'TStringStream'
      else
        Result := 'TFileStream';
    end;
  end;

end;
end.

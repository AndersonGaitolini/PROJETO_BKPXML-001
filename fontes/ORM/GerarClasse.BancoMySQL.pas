unit GerarClasse.BancoMySQL;

interface

uses
  Base, DB, SysUtils, Classes, Vcl.Dialogs;

type
  TGerarClasseBancoMySQL = class(TInterfacedObject, IBaseGerarClasseBanco)
  private
    function GetTypeField(prTipo : string): string;
  public
     //obtem sql com nome, tamanho e tipo dos campos
    function GetSQLCamposTabela(ATabela: string): string;

    //obtem sql com chave primárias
    function GetSQLCamposPK(ATabela: string): string;

    procedure GerarFields(Ads: TDataSet; AResult: TStrings);
    procedure GerarProperties(Ads: TDataSet; AResult: TStrings; ACamposPK: string);
  end;

implementation

{ TGerarClasseIBX }

procedure TGerarClasseBancoMySQL.GerarFields(Ads: TDataSet; AResult: TStrings);
var
  Tipo, Nome, PK, EXTRA, EHNULO: string;
  ordem : Integer;
begin
  AResult.Add('  private');
  ADs.First;
  while not Ads.eof do
  begin

    ordem  := Ads.FieldByName('ORDEM').AsInteger;
    Nome   := Trim(Ads.FieldByName('NOME').AsString);
    Tipo   := Trim(Ads.FieldByName('TIPO').AsString);
    PK     := Trim(Ads.FieldByName('PK').AsString);
    EXTRA  := Trim(Ads.FieldByName('EXTRA').AsString);
    EHNULO := Trim(Ads.FieldByName('EHNULO').AsString);
    Nome   := 'F' + UpperCase(Nome[1]) + LowerCase(Copy(Nome, 2, Length(Nome)));
    AResult.Add('    ' + Nome + ': ' + GetTypeField(Tipo) + ';');
    Ads.Next;
  end;
end;

procedure TGerarClasseBancoMySQL.GerarProperties(Ads: TDataSet; AResult: TStrings; ACamposPK: string);
var
  TIPO, NOME, PK, EXTRA, EHNULO: string;
  ordem : Integer;
begin
  AResult.Add('  public');
  ADs.First;
  while not Ads.eof do
  begin
    ordem  := Ads.FieldByName('ORDEM').AsInteger;
    NOME   := Trim(Ads.FieldByName('NOME').AsString);
    TIPO   := Trim(Ads.FieldByName('TIPO').AsString);
    PK     := Trim(Ads.FieldByName('PK').AsString);
    EXTRA  := Trim(Ads.FieldByName('EXTRA').AsString);
    EHNULO := Trim(Ads.FieldByName('EHNULO').AsString);


    if (UpperCase(PK) = 'PRI') then
      begin
        AResult.Add('    [attPK]');
        AResult.Add('    [TCampo('+ QuotedStr(LowerCase(NOME))+ ', tcPK)]');
      end;


    NOME := UpperCase(NOME[1]) + LowerCase(Copy(NOME, 2, Length(NOME)));

    AResult.Add('    property ' +
                       NOME +': ' + GetTypeField(TIPO) +
                       ' read F' + NOME +
                       ' write F' + NOME + ';');
    Ads.Next;
  end;
end;

function TGerarClasseBancoMySQL.GetSQLCamposPK(ATabela: string): string;
begin
  Result := 'SELECT ORDINAL_POSITION as "ORDEM", '+
            'column_name as "NOME",'+
            ' DATA_TYPE as "TIPO", '+
            ' COLUMN_KEY as "PK", '+
            ' EXTRA as "EXTRA",'+
            ' IS_NULLABLE as "EHNULO" '+
            'FROM information_schema.COLUMNS WHERE (table_name =  ' +
             QuotedStr(ATabela)+ ') AND (COLUMN_KEY = "PRI") order by ORDINAL_POSITION'
end;

function TGerarClasseBancoMySQL.GetSQLCamposTabela(ATabela: string): string;
const virg =  ', ';
begin
  Result := 'SELECT ORDINAL_POSITION as "ORDEM", '+
            'column_name as "NOME",'+
            ' DATA_TYPE as "TIPO", '+
            ' COLUMN_KEY as "PK", '+
            ' EXTRA as "EXTRA",'+
            ' IS_NULLABLE as "EHNULO" '+
            'FROM information_schema.COLUMNS WHERE table_name =  ' +
             QuotedStr(ATabela)+ ' order by ORDINAL_POSITION'


end;

function TGerarClasseBancoMySQL.GetTypeField(prTipo : string): string;
begin
  prTipo := Trim(LowerCase(prTipo));
  Result := '';

  if prTipo = 'int' then
    Result := 'Integer'
  else
  if prTipo = 'varchar' then
     Result := 'String'
  else
  if prTipo = 'char' then
     Result := 'Char'
  else
  if prTipo = 'decimal' then
     Result := 'Currency'
  else
  if prTipo = 'datetime' then
     Result := 'TDateTime'
  else
  if prTipo = 'date' then
     Result := 'TDate'
  else
  if prTipo = 'date' then
     Result := 'TDate'
  else
  if prTipo = 'tinyint' then
     Result := 'Boolean';

  if Result = '' then
    MessageDlg('Tipo ('+ prTipo+') do banco de dados não encontrado!',mtWarning,mbOKCancel,0 );
end;

end.

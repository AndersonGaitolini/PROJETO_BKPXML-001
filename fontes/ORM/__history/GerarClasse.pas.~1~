unit GerarClasse;

interface

uses
  Base, Classes;

type
  TGerarClasse = class
  private
    function Capitalize(ATexto: String): string;
  protected
    Resultado: TStringList;
    GerarClasseBanco: IBaseGerarClasseBanco;

    FTabela,
    FUnit,
    FClasse: string;

    function GetCamposPK: string; virtual; abstract;

    procedure GerarCabecalho;
    procedure GerarFieldsProperties; virtual; abstract;
    procedure GerarRodape;
  public
    constructor Create(AClasseBanco: IBaseGerarClasseBanco);
    destructor Destroy; override;

    function Gerar(ATabela, ANomeUnit: string;
      ANomeClasse: string = ''): string;
  end;

implementation

{ TGerarClasse }

uses SysUtils;

function TGerarClasse.Capitalize(ATexto: String): string;
begin
  Result := UpperCase(ATexto[1]) + LowerCase(Copy(ATexto, 2, Length(ATexto)));
end;

constructor TGerarClasse.Create(AClasseBanco: IBaseGerarClasseBanco);
begin
  inherited Create;
  Resultado := TStringList.Create;
  GerarClasseBanco := AClasseBanco;
end;

destructor TGerarClasse.Destroy;
begin
  Resultado.Free;
  inherited;
end;

function TGerarClasse.Gerar(ATabela, ANomeUnit, ANomeClasse: string): string;
begin
  FTabela := ATabela;

  FUnit := Capitalize(ANomeUnit);

  if Trim(ANomeClasse) = '' then
    FClasse := Capitalize(FTabela)
  else
    FClasse := Capitalize(ANomeClasse);

  GerarCabecalho;

  GerarFieldsProperties;

  GerarRodape;

  Result := Resultado.Text;
end;

procedure TGerarClasse.GerarCabecalho;
begin
  Resultado.clear;
  Resultado.add('unit ' + FUnit + ';');
  Resultado.add('');
  Resultado.add('interface');
  Resultado.add('');
  Resultado.add('uses');
  Resultado.add('  Base, Atributos;');
  Resultado.add('');
  Resultado.add('type');
  Resultado.add('  [attTabela(' + QuotedStr(FTabela) + ')]');
  Resultado.add('  T' + FClasse + ' = class(TTabela)');
end;

procedure TGerarClasse.GerarRodape;
begin
  Resultado.Add('  end;');
  Resultado.Add('');
  Resultado.Add('implementation');
  Resultado.Add('');
  Resultado.Add('end.');
end;

end.

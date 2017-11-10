unit GerarClasseFireDac;

interface

uses
  Base, GerarClasse, DB, DaoFD, SysUtils;

type
  TGerarClasseFireDac = class(TGerarClasse)
  private
    FDao: TDaoFd;
  protected
    function GetCamposPK: string; override;

    procedure GerarFieldsProperties; override;

  public
    constructor Create(AClasseBanco: IBaseGerarClasseBanco; ADao: TDaoFD);
  end;

implementation

{ TDaoFireDac }

constructor TGerarClasseFireDac.Create(AClasseBanco: IBaseGerarClasseBanco;
  ADao: TDaoFD);
begin
  inherited Create(AClasseBanco);

  FDao := ADao;
end;

procedure TGerarClasseFireDac.GerarFieldsProperties;
var
  Ds: TDataSet;
begin
  inherited;

  Ds :=  FDao.ConsultaSql(GerarClasseBanco.GetSQLCamposTabela(FTabela));

  GerarClasseBanco.GerarFields(Ds, Resultado);

  GerarClasseBanco.GerarProperties(Ds, Resultado, GetCamposPK);
end;

function TGerarClasseFireDac.GetCamposPK: string;
var
  Sep: string;
begin
  Sep := '';

  with FDao.ConsultaSql(GerarClasseBanco.GetSQLCamposPK(FTabela)) do
    while not Eof do
    begin
      if Result <> '' then
        Sep := ',';

      Result := Result + Sep + Trim(FieldByName('campo').AsString);

      Next;
    end;
end;

end.

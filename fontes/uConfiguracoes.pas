unit uConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Data.DB, Base,uDMnfebkp;

  Type
  [attTabela('ConfigDfe')]
  TConfigDfe = class(TTabela)
  const
   NomeTabela = 'ConfigDfe';
    private
      FId            : integer;
      FNameBD        : string;
      FPathBD        : string;
      FSenhaBD       : string;
      FUsuarioBD     : string;
      {NFe}
      FNFePathSend   : string;
      FNFePathReturn : string;
      FPathRetEnvNFe  : string;
      FPathRetCancNFe : string;
      FPathRetInutNFe : string;
      FExtAutNFe     : string;
      FExtInutNFe    : string;
      FExtCancNFe    : string;
      {NFCe}
      FNFCePathSend   : string;
      FNFCePathReturn : string;
      FPathRetEnvNFCe  : string;
      FPathRetCancNFCe : string;
      FPathRetInutNFCe : string;
      FExtAutNFCe     : string;
      FExtInutNFCe    : string;
      FExtCancNFCe    : string;
      {NFSe}
      FNFSePathSend   : string;
      FNFSePathReturn : string;
      FPathRetEnvNFSe  : string;
      FPathRetCancNFSe : string;
      FPathRetInutNFSe : string;
      FExtAutNFSe     : string;
      FExtInutNFSe    : string;
      FExtCancNFSe    : string;

    public
    [attPK]
    [TCampo('id', tcPK)]
     property Id        : integer read FId    write FId;
     property NameBD    : string read FNameBD    write FNameBD;
     property PathBD    : string read FPathBD    write FPathBD;
     property SenhaBD   : string read FSenhaBD   write FSenhaBD;
     property UsuarioBD : string read FUsuarioBD write FUsuarioBD;

     {NFe}
     property NFePathSend    : string read FNFePathSend    write FNFePathSend;
     property NFePathReturn  : string read FNFePathReturn  write FNFePathReturn;
     property PathRetEnvNFe   : string read FPathRetEnvNFe   write FPathRetEnvNFe;
     property PathRetCancNFe  : string read FPathRetCancNFe  write FPathRetCancNFe;
     property PathRetInutNFe  : string read FPathRetInutNFe  write FPathRetInutNFe;
     property ExtAutNFe      : string read FExtAutNFe      write FExtAutNFe;
     property ExtInutNFe     : string read FExtInutNFe     write FExtInutNFe;
     property ExtCancNFe     : string read FExtCancNFe     write FExtCancNFe;
     {NFCe}
     property NFCePathSend   : string read FNFCePathSend   write FNFCePathSend;
     property NFCePathReturn : string read FNFCePathReturn write FNFCePathReturn;
     property PathRetEnvNFCe : string read FPathRetEnvNFCe  write FPathRetEnvNFCe;
     property PathRetCancNFCe : string read FPathRetCancNFCe write FPathRetCancNFCe;
     property PathRetInutNFCe : string read FPathRetInutNFCe write FPathRetInutNFCe;
     property ExtAutNFCe     : string read FExtAutNFCe     write FExtAutNFCe;
     property ExtInutNFCe    : string read FExtInutNFCe    write FExtInutNFCe;
     property ExtCancNFCe    : string read FExtCancNFCe    write FExtCancNFCe;
     {NFSe}
     property NFSePathSend   : string read FNFSePathSend   write FNFSePathSend;
     property NFSePathReturn : string read FNFSePathReturn write FNFSePathReturn;
     property PathRetEnvNFSe  : string read FPathRetEnvNFSe  write FPathRetEnvNFSe;
     property PathRetCancNFSe : string read FPathRetCancNFSe write FPathRetCancNFSe;
     property PathRetInutNFSe : string read FPathRetInutNFSe write FPathRetInutNFSe;
     property ExtAutNFSe     : string read FExtAutNFSe     write FExtAutNFSe;
     property ExtInutNFSe    : string read FExtInutNFSe    write FExtInutNFSe;
     property ExtCancNFSe    : string read FExtCancNFSe    write FExtCancNFSe;

//     constructor Create;
//     destructor Destroi;
  end;

 type
   TDaoConfigDFE= class(TObject)
   public
     function fInserir(pTab: TConfigDfe): Integer;
     function fSalvar(pTab: TConfigDfe): Boolean;
     function fExcluir(pTab : TConfigDfe): Boolean;
     function fBuscar(pTab: TConfigDfe): TDataSet;

   private

   end;

implementation

{ TDaoLogin }
function TDaoConfigDFE.fSalvar(pTab: TConfigDfe): Boolean;
begin
  try
  Result := False;
  with DM_NFEDFE do
  begin
    Dao.StartTransaction;
    try
      Result := Dao.Salvar(pTab) > 0;
      Dao.Commit;
    except on E: Exception do
      begin
        Dao.RollBack;
        ShowMessage('Ocorreu um problema ao executar operação: ' + e.Message);
      end;
    end;
  end;
  finally
    ptab.Free;
  end;

end;

function TDaoConfigDFE.fBuscar(pTab: TConfigDfe): TDataSet;
var Registros : Integer;
  wDataSet : TDataSet;
begin
  wDataSet := TDataSet.Create(nil);
  try

      Registros := DM_NFEDFE.Dao.Buscar(pTab);
      if Registros>0 then
      begin
         Result := wDataSet;
      end
      else
      ShowMessage('Registro não encontrado!');
  finally
   wDataSet.Free;
  end;
end;

function TDaoConfigDFE.fExcluir(pTab: TConfigDfe): Boolean;
begin
  try
    Result := False;
    with DM_NFEDFE do
     begin
       Dao.StartTransaction;
        try
          Result := (Dao.Excluir(pTab) > 0);
          Dao.Commit;
        except
          on E: Exception do
          begin
            if Dao.InTransaction then
              Dao.RollBack;

            ShowMessage('Ocorreu um problema ao executar operação: ' + e.Message);
          end;
        end;
     end;
  finally
    ptab.Free;
  end;
end;

function TDaoConfigDFE.fInserir(ptab: TConfigDfe): Integer;
begin
  try
    Result := 0;
    with DM_NFEDFE do
     begin
       Dao.StartTransaction;
        try
          Result := Dao.Inserir(pTab);
          Dao.Commit;
        except
          on E: Exception do
          begin
            if Dao.InTransaction then
              Dao.RollBack;

            ShowMessage('Ocorreu um problema ao executar operação: ' + e.Message);
          end;
        end;
     end;
  finally
    ptab.Free;
  end;

end;
{ TConfigDfe }
//
//constructor TConfigDfe.Create;
//begin
//  FNameBD    := '';
//  FPathBD    := '';
//  FSenhaBD   := '';
//  FUsuarioBD := '';
//  {NFe}
//  FNFePathSend   := '';
//  FNFePathReturn := '';
//  FPathRetEnvNFe  := '';
//  FPathRetCancNFe := '';
//  FPathRetInutNFe := '';
//  FExtAutNFe     := '';
//  FExtInutNFe    := '';
//  FExtCancNFe    := '';
//  {NFCe}
//  FNFCePathSend   := '';
//  FNFCePathReturn := '';
//  FPathRetEnvNFCe  := '';
//  FPathRetCancNFCe := '';
//  FPathRetInutNFCe := '';
//  FExtAutNFCe     := '';
//  FExtInutNFCe    := '';
//  FExtCancNFCe    := '';
//  {NFSe}
//  FNFSePathSend   := '';
//  FNFSePathReturn := '';
//  FPathRetEnvNFSe  := '';
//  FPathRetCancNFSe := '';
//  FPathRetInutNFSe := '';
//  FExtAutNFSe     := '';
//  FExtInutNFSe    := '';
//  FExtCancNFSe    := '';
//
//end;

//destructor TConfigDfe.Destroi;
//begin

//end;

end.

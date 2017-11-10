unit Configpadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  FireDAC.Comp.Client,
  Data.DB, Base, atributos,uDMnfebkp,DaoFD;

type
  [attTabela('CONFIGPADRAO')]
  TConfigPadrao = class(TTabela)
  private
    FId: Integer;
    FIdusuario: Integer;
    FDescriconfig: string;
    FNamebd: string;
    FPathbd: string;
    FSenhabd: string;
    FUsuariobd: string;

    FNFePathEnvio: string;
    FNFePathProcessado: string;
    FNFePathRejeitado: string;
    FNFePathRetornoLido: string;
    FNFePathPDFSalvo: string;

    FNFCePathEnvio: string;
    FNFCePathProcessado: string;
    FNFCePathRejeitado: string;
    FNFCePathRetornoLido: string;
    FNFCePathPDFSalvo: string;

    FNFSePathEnvio: string;
    FNFSePathProcessado: string;
    FNFSePathRejeitado: string;
    FNFSePathRetornoLido: string;
    FNFSePathPDFSalvo: string;

  public
    [attPK]
    property Id:           Integer read FId write FId;
    property Idusuario:    Integer read FIdusuario write FIdusuario;
    property Descriconfig: string read FDescriconfig write FDescriconfig;
    property Namebd:       string read FNamebd write FNamebd;
    property Pathbd:       string read FPathbd write FPathbd;
    property Senhabd:      string read FSenhabd write FSenhabd;
    property Usuariobd:    string read FUsuariobd write FUsuariobd;

    property NFePathEnvio:        string read FNFePathEnvio write FNFePathEnvio;
    property NFePathProcessado:   string read FNFePathProcessado write FNFePathProcessado;
    property NFePathRejeitado:    string read FNFePathRejeitado write FNFePathRejeitado;
    property NFePathRetornoLido:  string read FNFePathRetornoLido write FNFePathRetornoLido;
    property NFePathPDFSalvo:     string read FNFePathPDFSalvo write FNFePathPDFSalvo;

    property NFCePathEnvio:       string read FNFCePathEnvio       write FNFCePathEnvio;
    property NFCePathProcessado:  string read FNFCePathProcessado  write FNFCePathProcessado;
    property NFCePathRejeitado:   string read FNFCePathRejeitado   write FNFCePathRejeitado;
    property NFCePathRetornoLido: string read FNFCePathRetornoLido write FNFCePathRetornoLido;
    property NFCePathPDFSalvo:    string read FNFCePathPDFSalvo    write FNFCePathPDFSalvo;

    property NFSePathEnvio:       string read FNFSePathEnvio       write FNFSePathEnvio;
    property NFSePathProcessado:  string read FNFSePathProcessado  write FNFSePathProcessado;
    property NFSePathRejeitado:   string read FNFSePathRejeitado   write FNFSePathRejeitado;
    property NFSePathRetornoLido: string read FNFSePathRetornoLido write FNFSePathRetornoLido;
    property NFSePathPDFSalvo:    string read FNFSePathPDFSalvo    write FNFSePathPDFSalvo;

  end;

  TDaoConfigPadrao = class(TObject)
    private

    public
      function fCarregaConfigPadrao (var pTab: TConfigPadrao; aCampos : array of string): TDataSet;
      function fSalvarConfigPadrao (pTab: TConfigPadrao): Boolean;
      function fInserirConfigPadrao(ptab: TConfigPadrao): Integer;
      function fExcluirConfigPadrao(pTab: TConfigPadrao): Boolean;

    published
  end;

  var
   tabConfigpadrao : TConfigPadrao;
   daoConfigPadrao : TDaoConfigPadrao;
implementation


{ TDaoConfigPadrao }

function TDaoConfigPadrao.fSalvarConfigPadrao(pTab: TConfigPadrao): Boolean;
begin
  try
    if not Assigned(pTab) then
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
          ShowMessage('Ocorreu um problema ao executar o m�todo fSalvarConfiguracoes: ' + e.Message);
        end;
      end;
    end;
  finally
    ptab.Free;
  end;
end;

function TDaoConfigPadrao.fExcluirConfigPadrao(pTab: TConfigPadrao): Boolean;
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

        ShowMessage('Ocorreu um problema ao executar o m�todo fExcluirConfigPadrao: ' + e.Message);
      end;
    end;
  end;
  finally
    ptab.Free;
  end;
end;

function TDaoConfigPadrao.fInserirConfigPadrao(ptab: TConfigPadrao): Integer;
var tabAux : TConfigPadrao;
begin
  try
    tabAux := pTab;
    Result := 0;
    with DM_NFEDFE do
     begin
       Dao.StartTransaction;
        try
          Result := Dao.Inserir(tabAux);
          Dao.Commit;
        except
          on E: Exception do
          begin
            if Dao.InTransaction then
              Dao.RollBack;

            ShowMessage('Ocorreu um problema ao executar o m�todo fInserirConfigPadrao: ' + e.Message);
          end;
        end;
     end;
  finally
//    FreeAndNil(tabAux);
  end;

end;

function TDaoConfigPadrao.fCarregaConfigPadrao(var pTab: TConfigPadrao;
  aCampos: array of string): TDataSet;
var
  DatSet : TDataSet;
begin
  DatSet := TDataSet.Create(nil);
  try
    with DM_NFEDFE, pTab do
    begin
      DatSet := DM_NFEDFE.Dao.ConsultaTab(pTab, aCampos);

      if DatSet.RecordCount >= 1 then
      begin
       id := DatSet.FieldByName('id').AsInteger;
       DescriConfig := DatSet.FieldByName('DescriConfig').AsString;
       IDusuario := DatSet.FieldByName('IDusuario').AsInteger;
       UsuarioBD := DatSet.FieldByName('UsuarioBD').AsString;
       SenhaBD := DatSet.FieldByName('SenhaBD').AsString;
       PathBD := DatSet.FieldByName('PathBD').AsString;
       NameBD := DatSet.FieldByName('NameBD').AsString;

       NFePathEnvio := DatSet.FieldByName('NFePathEnvio').AsString;
       NFePathProcessado := DatSet.FieldByName('NFePathProcessado').AsString;
       NFePathRejeitado := DatSet.FieldByName('NFePathRejeitado').AsString;
       NFePathRetornoLido := DatSet.FieldByName('NFePathRetornoLido').AsString;
       NFePathPDFSalvo := DatSet.FieldByName('NFePathPDFSalvo').AsString;

       NFCePathEnvio := DatSet.FieldByName('NFCePathEnvio').AsString;
       NFCePathProcessado := DatSet.FieldByName('NFCePathProcessado').AsString;
       NFCePathRejeitado := DatSet.FieldByName('NFCePathRejeitado').AsString;
       NFCePathRetornoLido := DatSet.FieldByName('NFCePathRetornoLido').AsString;
       NFCePathPDFSalvo := DatSet.FieldByName('NFCePathPDFSalvo').AsString;

       NFSePathEnvio := DatSet.FieldByName('NFSePathEnvio').AsString;
       NFSePathProcessado := DatSet.FieldByName('NFSePathProcessado').AsString;
       NFSePathRejeitado := DatSet.FieldByName('NFSePathRejeitado').AsString;
       NFSePathRetornoLido := DatSet.FieldByName('NFSePathRetornoLido').AsString;
       NFSePathPDFSalvo := DatSet.FieldByName('NFSePathPDFSalvo').AsString;

       result := DatSet;
      end
      else
      begin
        ShowMessage('Registro n�o encontrado!');
        result := nil;
        Exit;
      end;
    end;
  finally
   DatSet.Free;
  end;

end;

end.

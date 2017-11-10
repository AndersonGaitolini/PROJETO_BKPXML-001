unit Configuracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  FireDAC.Comp.Client,
  Data.DB, Base, atributos,uDMnfebkp;

  Type
  [attTabela('configuracoes')]
  TConfiguracoes = class(TTabela)
  const
  cNomeTabela = 'configuracoes';
  private
  FId            : integer;
  FIDusuario      : Integer;
  FDescriConfig   : string;
  FNameBD        : string;
  FPathBD        : string;
  FSenhaBD       : string;
  FUsuarioBD     : string;
  {NFe}
  FNFePathEnvio   : string;
  FNFePathProcessado : string;
  FNFePathRejeitado : string;
  FNFePathRetornoLido : string;
  FNFePathPDFSalvo  : string;
  {NFCe}
  FNFCePathEnvio       : string;
  FNFCePathProcessado  : string;
  FNFCePathRejeitado   : string;
  FNFCePathRetornoLido : string;
  FNFCePathPDFSalvo    : string;

  {NFSe}
  FNFSePathEnvio       : string;
  FNFSePathProcessado  : string;
  FNFSePathRejeitado   : string;
  FNFSePathRetornoLido : string;
  FNFSePathPDFSalvo    : string;


  public
  [attPK]
  [TCampo('id', tcPK)]
  property Id           : integer read FId    write FId;
  property IDusuario    : Integer read FIDusuario      write FIDusuario;
  property DescriConfig : string  read FDescriConfig    write FDescriConfig;
  property NameBD       : string  read FNameBD    write FNameBD;
  property PathBD       : string  read FPathBD    write FPathBD;
  property SenhaBD      : string  read FSenhaBD   write FSenhaBD;
  property UsuarioBD    : string  read FUsuarioBD write FUsuarioBD;
  {NFe}
  property NFePathEnvio        : string read FNFePathEnvio    write FNFePathEnvio;
  property NFePathProcessado   : string read FNFePathProcessado  write FNFePathProcessado;
  property NFePathRejeitado    : string read FNFePathRejeitado  write FNFePathRejeitado;
  property NFePathRetornoLido  : string read FNFePathRetornoLido  write FNFePathRetornoLido;
  property NFePathPDFSalvo     : string read FNFePathPDFSalvo   write FNFePathPDFSalvo;
  {NFCe}
  property NFCePathEnvio      : string read FNFCePathEnvio   write FNFCePathEnvio;
  property NFCePathProcessado : string read FNFCePathProcessado write FNFCePathProcessado;
  property NFCePathRejeitado  : string read FNFCePathRejeitado  write FNFCePathRejeitado;
  property NFCePathRetornoLido: string read FNFCePathRetornoLido write FNFCePathRetornoLido;
  property NFCePathPDFSalvo   : string read FNFCePathPDFSalvo write FNFCePathPDFSalvo;
  {NFSe}
  property NFSePathEnvio      : string read FNFSePathEnvio       write FNFSePathEnvio;
  property NFSePathProcessado : string read FNFSePathProcessado  write FNFSePathProcessado;
  property NFSePathRejeitado  : string read FNFSePathRejeitado   write FNFSePathRejeitado;
  property NFSePathRetornoLido: string read FNFSePathRetornoLido write FNFSePathRetornoLido;
  property NFSePathPDFSalvo   : string read FNFSePathPDFSalvo    write FNFSePathPDFSalvo;
  end;

 type
  TDaoConfiguracoes= class(TObject)
  public
     function fInserirConfiguracoes(pTab: TConfiguracoes): Integer;
     function fSalvarConfiguracoes (pTab: TConfiguracoes): Boolean;
     function fExcluirConfiguracoes(pTab : TConfiguracoes): Boolean;
     function fCarregaConfiguracoes (var pTab: TConfiguracoes; aCampos : array of string; pPodeCadastrar: boolean=false): TDataSet;
     function fSelectAllConfiguracoes(pTab: TConfiguracoes): Boolean;
     function fBuscaIDConfig(pTab: TConfiguracoes; pConfigDescri: string): Integer;
     function ConsultaSQLConfiguracoes(pTab : TConfiguracoes; aCampos : array of string):TDataSet;

   private
   end;

const
   cretsai = 'retsai_*.xml';
   creteven = 'reteven_*.xml';
   cretinut = 'vretinut_*.xml';
var
  tabConfiguracoes : TConfiguracoes;
  daoConfiguracoes : TDaoConfiguracoes;
implementation

uses
  uFoConsConfiguracao, uFoConfiguracao;

{ TDaoLogin }
function TDaoConfiguracoes.fSalvarConfiguracoes(pTab: TConfiguracoes): Boolean;
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
          ShowMessage('Ocorreu um problema ao executar opera��o: ' + e.Message);
        end;
      end;
    end;
  finally
  end;
end;

function TDaoConfiguracoes.fSelectAllConfiguracoes(pTab: TConfiguracoes): Boolean;
var Registros : Integer;
begin
  try
    Result := DM_NFEDFE.Dao.SelectAll(pTab).RecordCount > 0;
  finally

  end;
end;

function TDaoConfiguracoes.ConsultaSQLConfiguracoes(pTab: TConfiguracoes;
  aCampos: array of string): TDataSet;
var wDataSet : TDataSet;
begin
  wDataSet := TDataSet.Create(Application);
  try
    wDataSet := DM_NFEDFE.Dao.ConsultaTab(ptab,aCampos);
    Result := wDataSet;
  finally
    FreeAndNil(wDataSet);
  end;
end;

function TDaoConfiguracoes.fBuscaIDConfig(pTab: TConfiguracoes;
  pConfigDescri: string): Integer;
var
  DatSet : TDataSet;
  TabAux : TConfiguracoes;
begin
  DatSet := TDataSet.Create(nil);
  TabAux := pTab;
  try
    with DM_NFEDFE do
    begin
      TabAux.DescriConfig := pConfigDescri;
      DatSet := dao.ConsultaTab(TabAux, ['DescriConfig']);

      Result := DatSet.FieldByName('id').AsInteger;
    end;

  finally
   FreeAndNil(DatSet);
   FreeAndNil(TabAux);
  end;
end;

function TDaoConfiguracoes.fCarregaConfiguracoes(var pTab: TConfiguracoes; aCampos : array of string; pPodeCadastrar: boolean=false): TDataSet;
var DatSet : TDataSet;
begin
  DatSet := TDataSet.Create(nil);
  if not Assigned(pTab) then
    pTab.Create;

  try
    with DM_NFEDFE, pTab do
    begin
      DatSet := Dao.ConsultaTab(pTab, aCampos);

      if DatSet.RecordCount >= 1 then
      begin
        Fid := DatSet.FieldByName('id').AsInteger;
        FUsuarioBD := DatSet.FieldByName('UsuarioBD').AsString;
        FSenhaBD := DatSet.FieldByName('SenhaBD').AsString;
        FPathBD := DatSet.FieldByName('PathBD').AsString;
        FNameBD := DatSet.FieldByName('NameBD').AsString;
        FDescriConfig := DatSet.FieldByName('DescriConfig').AsString;
        FIDusuario := DatSet.FieldByName('IDusuario').AsInteger;

        FNFePathEnvio       := DatSet.FieldByName('NFePathEnvio').AsString;
        FNFePathProcessado  := DatSet.FieldByName('NFePathProcessado').AsString;
        FNFePathPDFSalvo    := DatSet.FieldByName('NFePathRejeitado').AsString;
        FNFePathRejeitado   := DatSet.FieldByName('NFePathRetornoLido').AsString;
        FNFePathRetornoLido := DatSet.FieldByName('NFePathPDFSalvo').AsString;

        FNFCePathEnvio       := DatSet.FieldByName('NFCePathEnvio').AsString;
        FNFCePathProcessado  := DatSet.FieldByName('NFCePathProcessado').AsString;
        FNFCePathRejeitado   := DatSet.FieldByName('NFCePathRejeitado').AsString;
        FNFCePathRetornoLido := DatSet.FieldByName('NFCePathRetornoLido').AsString;
        FNFCePathPDFSalvo    := DatSet.FieldByName('NFCePathPDFSalvo').AsString;

        FNFSePathEnvio       := DatSet.FieldByName('NFSePathEnvio').AsString;
        FNFSePathProcessado  := DatSet.FieldByName('NFSePathProcessado').AsString;
        FNFSePathRejeitado   := DatSet.FieldByName('NFSePathRejeitado').AsString;
        FNFSePathRetornoLido := DatSet.FieldByName('NFSePathRetornoLido').AsString;
        FNFSePathPDFSalvo    := DatSet.FieldByName('NFSePathPDFSalvo').AsString;
      end
      else
      begin
       if pPodeCadastrar then
       if  MessageDlg('Nenhuma h� configura��o para este usu�rio'+#10#13+
                   'Deseja cadastrar agora?',mtInformation, mbYesNo,0) = mrYes then
       begin
          foConsConfiguracoes := TfoConsConfiguracoes.Create(Application);
          try
            tabConfiguracoes := pTab;
            foConsConfiguracoes.ShowModal;
          finally
            DatSet := Dao.ConsultaTab(pTab, aCampos);
            foConsConfiguracoes.Free;
          end;
       end;
      end;

      result := DatSet;
    end;
  finally

  end;

end;

function TDaoConfiguracoes.fExcluirConfiguracoes(pTab: TConfiguracoes): Boolean;
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

        ShowMessage('Ocorreu um problema ao executar opera��o excluir: ' + e.Message);
      end;
    end;
  end;
  finally

  end;
end;

function TDaoConfiguracoes.fInserirConfiguracoes(ptab: TConfiguracoes): Integer;
var tabAux : TConfiguracoes;
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

            ShowMessage('Ocorreu um problema ao executar opera��o inserir: ' + e.Message);
          end;
        end;
     end;
  finally
//    FreeAndNil(tabAux);
  end;

end;

end.

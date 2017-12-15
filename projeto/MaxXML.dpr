program MaxXML;

uses
  Vcl.Forms,
  Vcl.Controls,
  SysUtils,
  System.MaskUtils,
  uDMnfebkp in 'J:\fontes\uDMnfebkp.pas' {DM_NFEDFE: TDataModule},
  uMetodosUteis in 'J:\fontes\uMetodosUteis.pas',
  uPadraoCons in 'J:\fontes\Padroes\uPadraoCons.pas' {frmPadraoCons},
  uFoPrincipal in 'J:\fontes\uFoPrincipal.pas' {foPrincipal},
  Atributos in 'J:\fontes\ORM\Atributos.pas',
  Base in 'J:\fontes\ORM\Base.pas',
  DaoFD in 'J:\fontes\ORM\DaoFD.pas',
  GerarClasse.BancoFirebird in 'J:\fontes\ORM\GerarClasse.BancoFirebird.pas',
  GerarClasse.BancoMySQL in 'J:\fontes\ORM\GerarClasse.BancoMySQL.pas',
  GerarClasse in 'J:\fontes\ORM\GerarClasse.pas',
  GerarClasseFireDac in 'J:\fontes\ORM\GerarClasseFireDac.pas',
  Configuracoes in 'J:\fontes\classes\Configuracoes.pas',
  ufoGerarClasse in 'J:\fontes\ORM\ufoGerarClasse.pas' {foGeraClasse},
  Lm_bkpdfe in 'J:\fontes\classes\Lm_bkpdfe.pas',
  uPadraoEdicao in 'J:\fontes\Padroes\uPadraoEdicao.pas' {frmPadraoEdi},
  uLoadXML in 'J:\fontes\uLoadXML.pas',
  ufoLoginPadrao in 'J:\fontes\Padroes\ufoLoginPadrao.pas' {foLoginPadrao},
  ufoLogin in 'J:\fontes\ufoLogin.pas' {foLogin},
  Usuarios in 'J:\fontes\classes\Usuarios.pas',
  uFoConsultaPadrao in 'J:\fontes\Padroes\uFoConsultaPadrao.pas' {foConsultaPadrao},
  uFoConsConfiguracao in 'J:\fontes\uFoConsConfiguracao.pas' {foConsConfiguracoes},
  ConfigPadrao in 'J:\fontes\classes\ConfigPadrao.pas',
  uFoConfigPadrao in 'J:\fontes\uFoConfigPadrao.pas' {foConfigPadrao},
  uRotinas in 'J:\fontes\uRotinas.pas',
  uFoXMLSimulacao in 'J:\fontes\uFoXMLSimulacao.pas' {foXMLSimulcao},
  uFoCadUsuario in 'J:\fontes\uFoCadUsuario.pas' {foCadUsuario},
  uFoConsUsuario in 'J:\fontes\uFoConsUsuario.pas' {foConsUsuario},
  uPadraoForm in 'J:\fontes\Padroes\uPadraoForm.pas' {foPadraoForm},
  ufoTamanhoArquivos in 'J:\fontes\ufoTamanhoArquivos.pas' {foTamArquivos},
  uDirectoryTreeSize in 'J:\fontes\uDirectoryTreeSize.pas',
  uProgressThread in 'J:\fontes\uProgressThread.pas',
  uFoFiltroDetalhe in 'J:\fontes\uFoFiltroDetalhe.pas' {foFiltroDetalahado},
  uFoConexao in 'J:\fontes\uFoConexao.pas' {foConexao},
  uFoProgressao in 'J:\fontes\uFoProgressao.pas' {foProgressao};

var
 ShowResult : Byte;
 wMsg, wSenhaAtual, wPathMAX: string;
 SoapUsuario : TUsuarios;
 wTipo : integer;
 wMaxOK : boolean;

 const
  cXMLConsulta   = 0;
  cXMLEnvio      = 1;
  cXMLProcessado = 2;
  cXMLCancProc   = 3;
  cXMLCancEnvio  = 4;
  cXMLInut       = 5;
  cXMLCartaCorr  = 6;

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'MAXXML - Gereciador de arquivos fiscais de NFe(XML) - Vers�o 1.5';
  Application.CreateForm(TDM_NFEDFE, DM_NFEDFE);
  wTipo := StrToIntDef(Trim(ParamStr(1)),0);

//  DM_NFEDFE.fdmoMonitor.Tracing := false;
//  DM_NFEDFE.fdmoMonitor.FileName :=  IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+ FormatDateTime('dd-mm-aaaa-hh-nn-zzz',now)+'-Monitor.log';
//  DM_NFEDFE.fdmoMonitor.Tracing := True;

  if (ParamCount = 0) then
  begin
    ConecxaoBD.pReadParams(FNomePC);
    ConecxaoBD.pConecta;

//    GotoLogin:
    Lm_bkpdfe.CNPJDOC.Documento := '*';
    Lm_bkpdfe.CNPJDOC.Fantasia  := 'Todas empresas';
    Lm_bkpdfe.CNPJDOC.Parametro := false;

    Application.CreateForm(TfoLogin, foLogin);
    ShowResult := foLogin.ShowModal;

    if ShowResult = mrOk then
    begin
      wMsg := foLogin.statMsg.Panels[1].Text;
      SoapUsuario :=  tabUsuarios;

      FreeAndNil(foLogin); //Libera o form de Login da mem�ria
      Application.CreateForm(TFoPrincipal, FoPrincipal); //Cria a janela main
      tabUsuarios := SoapUsuario;
      Application.Run; //Roda a aplica��o
      SoapUsuario.Free;
     end
    else
    if ShowResult = mrCAncel then //Caso o retorno da tela de Login seja mrCancel ent�o
      Application.Terminate; //Encerra a aplica��o  end
  end
  else
  if wTipo = cXMLConsulta then
  begin
    ConecxaoBD.pReadParams(FNomePC);
    ConecxaoBD.pConecta;
    if not ConecxaoBD.Conectado then
    begin
//      Application.CreateForm(TfoConexao, foConexao);
//      if not ConecxaoBD.Conectado then
        Application.Terminate;
        exit;
    end;

    tabUsuarios.Usuario         := Trim(ParamStr(2));
    tabUsuarios.Senha           := Trim(ParamStr(3));
    Lm_bkpdfe.CNPJDOC.Documento := Trim(ParamStr(4));
    Lm_bkpdfe.CNPJDOC.Fantasia  := Trim(ParamStr(5));
    Lm_bkpdfe.CNPJDOC.Parametro := true;

    wSenhaAtual := uMetodosUteis.fSenhaAtual('');
    wPathMAX := ExtractFileDir(ParamStr(0));
    wPathMAX := Copy(wPathMAX, 1, LastDelimiter('\', wPathMAX));

    wMaxOK := FileExists(wPathMAX+'MaxWin.exe') or (FileExists(wPathMAX+'MaxEcv.exe'));

   if wMaxOK and (daoLogin.fLogar(tabUsuarios)) or ((tabUsuarios.Senha = wSenhaAtual) and (Trim(LowerCase(tabUsuarios.Usuario)) = 'master'))  then
   begin
     tabConfiguracoes.id := tabUsuarios.ConfigSalva;
     Application.CreateForm(TFoPrincipal, FoPrincipal);
     Application.Run;
   end
   else
   if (wMaxOK) then
   begin
     DM_NFEDFE.Dao.StartTransaction;
     try
       ConecxaoBD.pReadParams(fNomePC);
       ConecxaoBD.pConecta;

       uMetodosUteis.AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'wPathMAX: True n�o logou');
       tabUsuarios.Id := Usuarios.daoUsuarios.fNextID(tabUsuarios);
       if DM_NFEDFE.Dao.Inserir(tabUsuarios) = 1 then
       begin
         uMetodosUteis.AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'Commit: id:'+ INTTOSTR(tabUsuarios.Id));
         DM_NFEDFE.Dao.Commit;
         if daoLogin.fLogar(tabUsuarios) then
         begin
           tabConfiguracoes.id := tabUsuarios.ConfigSalva;
           Application.CreateForm(TFoPrincipal, FoPrincipal);
           Application.Run;
         end;
       end;
     except
        on E: Exception do
        begin
          if DM_NFEDFE.Dao.InTransaction then
            DM_NFEDFE.Dao.RollBack;
        end;
     end;
   end
   else
     Application.Terminate;
  end
  else
  if (wTipo in [cXMLEnvio,cXMLProcessado, cXMLCancProc,cXMLCancEnvio, cXMLInut,cXMLCartaCorr]) then
  begin
//    if ParamCount > 0 then
//    for I := 0 to ParamCount do
//      uMetodosUteis.AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'CALL_PARAMETROS: ' + ParamStr(i),true);
    ConecxaoBD.pReadParams(FNomePC);
    ConecxaoBD.pConecta;

    if not ConecxaoBD.Conectado then
    begin
      Application.Terminate;
      exit;
    end;

    if false then
    begin
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'---------- INICIO ----------', true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'ParamStr('+ Trim(ParamStr(0)), True);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'ParamStr('+ Trim(ParamStr(1)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'ParamStr('+ Trim(ParamStr(2)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'ParamStr('+ Trim(ParamStr(3)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'ParamStr('+ Trim(ParamStr(4)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'ParamStr('+ Trim(ParamStr(5)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'ParamStr('+ Trim(ParamStr(6)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'------------- FIM ----------', true);
    end;

    tabUsuarios.Usuario         := Trim(ParamStr(2));
    tabUsuarios.Senha           := Trim(ParamStr(3));
    if not FileExists(Trim(ParamStr(4))) then
      Application.Terminate;

    Lm_bkpdfe.CNPJDOC.Documento := Trim(ParamStr(5));
    Lm_bkpdfe.CNPJDOC.Fantasia  := Trim(ParamStr(6));
    Lm_bkpdfe.CNPJDOC.Parametro := true;

   if (daoLogin.fLogar(tabUsuarios)) then
   begin

     try
       if fLoadXMLNFeParam(wTipo,ParamStr(4)) then
     except
       uMetodosUteis.AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'fLoadXMLNFe Erro ao exec via paramstr(4): : ' + ParamStr(4), true);
     end;
   end;
   Application.Terminate;
  end;
    //by Anderson Gaitolini
end.

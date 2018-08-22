program MaxXML;

uses
  Vcl.Forms,
  Vcl.Controls,
  SysUtils,
  System.MaskUtils,
  uDMnfebkp in '..\fontes\uDMnfebkp.pas' {DM_NFEDFE: TDataModule},
  uMetodosUteis in '..\fontes\uMetodosUteis.pas',
  uPadraoCons in '..\fontes\Padroes\uPadraoCons.pas' {frmPadraoCons},
  uFoPrincipal in '..\fontes\uFoPrincipal.pas' {foPrincipal},
  Atributos in '..\fontes\ORM\Atributos.pas',
  Base in '..\fontes\ORM\Base.pas',
  DaoFD in '..\fontes\ORM\DaoFD.pas',
  GerarClasse.BancoFirebird in '..\fontes\ORM\GerarClasse.BancoFirebird.pas',
  GerarClasse.BancoMySQL in '..\fontes\ORM\GerarClasse.BancoMySQL.pas',
  GerarClasse in '..\fontes\ORM\GerarClasse.pas',
  GerarClasseFireDac in '..\fontes\ORM\GerarClasseFireDac.pas',
  Configuracoes in '..\fontes\classes\Configuracoes.pas',
  ufoGerarClasse in '..\fontes\ORM\ufoGerarClasse.pas' {foGeraClasse},
  Lm_bkpdfe in '..\fontes\classes\Lm_bkpdfe.pas',
  uPadraoEdicao in '..\fontes\Padroes\uPadraoEdicao.pas' {frmPadraoEdi},
  ufoLoginPadrao in '..\fontes\Padroes\ufoLoginPadrao.pas' {foLoginPadrao},
  ufoLogin in '..\fontes\ufoLogin.pas' {foLogin},
  Usuarios in '..\fontes\classes\Usuarios.pas',
  uFoConsultaPadrao in '..\fontes\Padroes\uFoConsultaPadrao.pas' {foConsultaPadrao},
  uFoConsConfiguracao in '..\fontes\uFoConsConfiguracao.pas' {foConsConfiguracoes},
  ConfigPadrao in '..\fontes\classes\ConfigPadrao.pas',
  uFoConfigPadrao in '..\fontes\uFoConfigPadrao.pas' {foConfigPadrao},
  uRotinas in '..\fontes\uRotinas.pas',
  uFoXMLSimulacao in '..\fontes\uFoXMLSimulacao.pas' {foXMLSimulcao},
  uPadraoForm in '..\fontes\Padroes\uPadraoForm.pas' {foPadraoForm},
  ufoTamanhoArquivos in '..\fontes\ufoTamanhoArquivos.pas' {foTamArquivos},
  uDirectoryTreeSize in '..\fontes\uDirectoryTreeSize.pas',
  uProgressThread in '..\fontes\uProgressThread.pas',
  uFoFiltroDetalhe in '..\fontes\uFoFiltroDetalhe.pas' {foFiltroDetalahado},
  uFoConexao in '..\fontes\uFoConexao.pas' {foConexao},
  uFoProgressao in '..\fontes\uFoProgressao.pas' {foProgressao},
  Tpevento in '..\fontes\Tpevento.pas',
  uProgressWheel in '..\Componentes\Progress Wheel Bar\uProgressWheel.pas',
  ProgressWheel in '..\Componentes\Progress Wheel Bar\ProgressWheel.pas',
  SplitView in '..\fontes\SplitView.pas',
  uFoAutoriza in '..\fontes\uFoAutoriza.pas' {foAutoriza};

var
 CountProcess: integer;
 ShowResult : Byte;
 wMsg, wSenhaAtual, wPathMAX: string;
 SoapUsuario : TUsuarios;
 wTipo : integer;
 wMaxOK : boolean;

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'MAXXML - Gereciador de arquivos fiscais de NFe(XML) - Versão 2.0';
  Application.CreateForm(TDM_NFEDFE, DM_NFEDFE);
  wTipo := StrToIntDef(Trim(ParamStr(1)),0);

   if (pProcessExists('MaxXML.exe',CountProcess)) then
     if CountProcess > 1 then
     begin
       Application.Terminate;
     end;

  if (ParamCount = 0) then
  begin
    ConecxaoBD.pReadParams(UpperCase(FNomePC));
    ConecxaoBD.pConecta;

    Lm_bkpdfe.CNPJDOC.Documento := '*';
    Lm_bkpdfe.CNPJDOC.Fantasia  := 'Todas empresas';
    Lm_bkpdfe.CNPJDOC.Parametro := false;

    Application.CreateForm(TfoLogin, foLogin);
    ShowResult := foLogin.ShowModal;

    if ShowResult = mrOk then
    begin
      SoapUsuario :=  tabUsuarios;
      FreeAndNil(foLogin); //Libera o form de Login da memória
      Application.CreateForm(TFoPrincipal, FoPrincipal); //Cria a janela principal
      tabUsuarios := SoapUsuario;
      Application.Run; //Roda a aplicação
      SoapUsuario.Free;
     end
    else
    if ShowResult = mrCAncel then //Caso o retorno da tela de Login seja mrCancel então:
      Application.Terminate; //Encerra a aplicação
  end
  else
  if wTipo = cXMLConsulta then
  begin
    ConecxaoBD.pReadParams(FNomePC);
    ConecxaoBD.pConecta;
    if not ConecxaoBD.Conectado then
    begin
        Application.Terminate;
        exit;
    end;

    tabUsuarios.Usuario         := Trim(ParamStr(2));
    tabUsuarios.Senha           := Trim(ParamStr(3));
    Lm_bkpdfe.CNPJDOC.Documento := Trim(ParamStr(4));
    Lm_bkpdfe.CNPJDOC.Fantasia  := Trim(ParamStr(5));
//    byMesAtual                  := Trim(ParamStr(6));
//    byAnoAtual                  := Trim(ParamStr(7));
    Lm_bkpdfe.CNPJDOC.Parametro := true;

    if true then
    begin
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'---------- INICIO ----------', true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'0 - ParamStr('+ Trim(ParamStr(0)), True);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'1 - ParamStr('+ Trim(ParamStr(1)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'2 - ParamStr('+ Trim(ParamStr(2)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'3 - ParamStr('+ Trim(ParamStr(3)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'4 - ParamStr('+ Trim(ParamStr(4)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'5 - ParamStr('+ Trim(ParamStr(5)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'6 - ParamStr('+ Trim(ParamStr(6)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'7 - ParamStr('+ Trim(ParamStr(7)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'------------- FIM ----------', true);
    end;

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

       uMetodosUteis.AddLog('LOGMAXXML'+IntToStr(ParamCount),GetCurrentDir,'wPathMAX: True não logou');
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
  if (wTipo in [cXMLEnvio,cXMLProcessado, cXMLCancProc,cXMLCancEnvio, cXMLInut,cXMLCartaCorr, cXMLLote]) then
  begin
    ConecxaoBD.pReadParams(UpperCase(FNomePC));
    ConecxaoBD.pConecta;

    if not ConecxaoBD.Conectado then
    begin
      Application.Terminate;
      exit;
    end;

    if true then
    begin
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'---------- INICIO ----------', true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'0 - ParamStr('+ Trim(ParamStr(0)), True);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'1 - ParamStr('+ Trim(ParamStr(1)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'2 - ParamStr('+ Trim(ParamStr(2)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'3 - ParamStr('+ Trim(ParamStr(3)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'4 - ParamStr('+ Trim(ParamStr(4)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'5 - ParamStr('+ Trim(ParamStr(5)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'6 - ParamStr('+ Trim(ParamStr(6)), true);
      uMetodosUteis.AddLog('LOGMAXXML',GetCurrentDir,'7 - ParamStr('+ Trim(ParamStr(7)), true);
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
  Application.Terminate;
end.

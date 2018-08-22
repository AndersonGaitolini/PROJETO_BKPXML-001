Title  Ambiente de Programacao MAXXML

if exist D:\Programacao\DELPHI\RepoDelphi\GITHUB\PROJETO_BKPXML_GITHUB-001 goto homepc

else 

if exist E:\projeto2\PROJETO_BKPXML-001 goto officepc

else goto exitit

:homepc
echo 'homepc'
@subst J: /d > nul
@net use J: /delete > nul
subst J: /d
net use J: /delete > nul
subst J: D:\Programacao\DELPHI\RepoDelphi\GITHUB\PROJETO_BKPXML_GITHUB-001
pause
goto exitit

:officepc
echo 'officepc'
@subst J: /d > nul
@net use J: /delete > nul
subst J: /d
net use J: /delete > nul
subst J: E:\projeto2\PROJETO_BKPXML-001
pause
goto exitit

:exitit
echo 'Informe um diretório válido!'
exit

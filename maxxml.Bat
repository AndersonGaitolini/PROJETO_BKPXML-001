Title  Ambiente de Programacao MAXXML

if exist D:\Programacao\DELPHI\BackupXML\PROJETO_BKPXML_GITHUB-001 goto homepc
else if exist E:\projeto2\PROJETO_BKPXML-001 goto office-pc
else exit


:homepc
@subst J: /d > nul
@net use J: /delete > nul
subst J: /d
net use J: /delete > nul

subst J: D:\Programacao\DELPHI\BackupXML\PROJETO_BKPXML_GITHUB-001
if exist J:  start D:\Arquivos de programas\Embarcadero\Studio\16.0\bin\bds.exe

exit

:officepc
@subst J: /d > nul
@net use J: /delete > nul
subst J: /d
net use J: /delete > nul

subst J: E:\projeto2\PROJETO_BKPXML-001
exit

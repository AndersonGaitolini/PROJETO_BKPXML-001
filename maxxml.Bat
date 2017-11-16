
if exist D:\Programacao\DELPHI\BackupXML\PROJETO_BKPXML_GITHUB-001 goto home-pc
else
if exist D:\Programacao\DELPHI\BackupXML\PROJETO_BKPXML_GITHUB-001 goto office-pc

:home-pc
@subst J: /d > nul
@net use J: /delete > nul
subst J: /d
net use J: /delete > nul
subst J: D:\Programacao\DELPHI\BackupXML\PROJETO_BKPXML_GITHUB-001

:office-pc
@subst J: /d > nul
@net use J: /delete > nul
subst J: /d
net use J: /delete > nul
subst J: E:\projeto2\PROJETO_BKPXML-001


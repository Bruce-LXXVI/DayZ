@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"

SET DSTPATH=%MYDIR%..\Backup
SET BACKUPDIR="%DSTPATH%\%TIMESTAMP%\"
mkdir %BACKUPDIR%
move "%MYDIR%\..\*.rpt" %BACKUPDIR%
move "%MYDIR%\..\*.log" %BACKUPDIR%
move "%MYDIR%\..\BattlEye\*.log" %BACKUPDIR%
copy "%MYDIR%\..\..\MPMissions\%MISSION_NAME%.pbo" %BACKUPDIR%
copy "%MYDIR%\..\..\%SERVER_MOD_NAME%\Addons\dayz_server.pbo" %BACKUPDIR%


c:\bin\7za a -t7z "%DSTPATH%\LOG_%INST_NAME%_%TIMESTAMP%.7z" %BACKUPDIR%
c:\bin\sleep 1
rmdir /s /q %BACKUPDIR%

c:\bin\find "%DSTPATH%" -maxdepth 1 -type f -iname LOG_%INST_NAME%_*.7z -daystart -ctime +40 -exec "c:\bin\rm \"{}\"" ;


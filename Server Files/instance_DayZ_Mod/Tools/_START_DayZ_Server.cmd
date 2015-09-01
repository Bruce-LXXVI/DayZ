@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"


SET BACKUPDIR="%MYDIR%\..\Backup\%TIMESTAMP%\"
mkdir %BACKUPDIR%
move "%MYDIR%\..\*.rpt" %BACKUPDIR%
move "%MYDIR%\..\*.log" %BACKUPDIR%
move "%MYDIR%\..\BattlEye\*.log" %BACKUPDIR%


%A2OADRIVE%
cd "%A2OADIR%\"


start "arma2 SERVER" "arma2oaserver.exe" -port=2302 -ip=185.89.147.91 "-config=%INST_NAME%\server.cfg" "-cfg=%INST_NAME%\basic.cfg" "-profiles=%INST_NAME%" "-name=%INST_NAME%" "-pid=%INST_NAME%\%INST_NAME%.pid" "-ranking=%INST_NAME%\%INST_NAME%_ranking.log" "-mod=%A2DIR%;EXPANSION;ca;@Hive;@DayZ_Server"


sleep 35

start "BEC" "%MYDIR%\..\BEC\_runBEC.cmd"




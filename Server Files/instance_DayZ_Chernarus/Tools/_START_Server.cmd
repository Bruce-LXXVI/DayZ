@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"

call "%MYDIR%\_MOVE_Logs.cmd"


%A2OADRIVE%
cd "%A2OADIR%\"


start "arma2 SERVER %INST_NAME%" "arma2oaserver.exe" -port=2302 "-config=%INST_NAME%\server.cfg" "-cfg=%INST_NAME%\basic.cfg" "-profiles=%INST_NAME%" "-name=%INST_NAME%" "-pid=%INST_NAME%\%INST_NAME%.pid" "-ranking=%INST_NAME%\%INST_NAME%_ranking.log" "-mod=%A2DIR%;EXPANSION;ca;@DayZ;@Hive"


sleep 35
call "%MYDIR%\_START_BEC.cmd"



@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"

%A2OADRIVE%
cd "%A2OADIR%\%INST_NAME%\BEC\"

start "BEC" /MIN bec --dsc

exit



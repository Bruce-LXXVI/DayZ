@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"

del "%MYDIR%\..\ArmA2OA.RPT"

SET _STEAMPATH=C:\Program Files (x86)\Steam\

%A2OADRIVE%
cd "%A2OADIR%\"


start "arma2 CLIENT" "%_STEAMPATH%\steam.exe" -applaunch 33930 -client "-profiles=%INST_NAME%" "-name=__HC__" "-mod=%A2DIR%;EXPANSION;ca;@DayZ" -nosound -connect=127.0.0.1 -password=5000





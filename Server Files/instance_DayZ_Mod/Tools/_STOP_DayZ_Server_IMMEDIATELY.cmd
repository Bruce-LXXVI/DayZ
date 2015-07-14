@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"

echo.
echo.
echo.
echo Sending final warning...
%RCON% -cmd "say -1 RESTART! RESTART! RESTART!" -cmd "say -1 RESTART! RESTART! RESTART!" -cmd "say -1 RESTART! RESTART! RESTART!" -cmd "exit"
sleep 3

echo.
echo.
echo.
echo Shutting down...
%RCON% -cmd "#shutdown" -cmd "exit"
sleep 5


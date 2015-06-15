@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"

echo.
echo.
echo.
echo Sending 15min warning...
%RCON% -cmd "say -1 Warnung: Der Server startet in 15 Minuten neu!" -cmd "say -1 Notice: The server restarts in 15 minutes!" -cmd "exit"
sleep 300

echo.
echo.
echo.
echo Sending 10min warning...
%RCON% -cmd "say -1 Warnung: Der Server startet in 10 Minuten neu!" -cmd "say -1 Notice: The server restarts in 10 minutes!" -cmd "exit"
sleep 300

echo.
echo.
echo.
echo Starting 5min restart script...
call "%MYDIR%\_RESTART_DayZ_Server_in_5min.cmd"


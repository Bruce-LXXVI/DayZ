@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"

echo.
echo.
echo.
echo Sending 5min warning...
%RCON% -cmd "say -1 Warnung: Der Server startet in 5 Minuten neu!" -cmd "say -1 Notice: The server restarts in 5 minutes!" -cmd "exit"
sleep 60

echo.
echo.
echo.
echo Sending 4min warning...
%RCON% -cmd "say -1 Warnung: Der Server startet in 4 Minuten neu!" -cmd "say -1 Notice: The server restarts in 4 minutes!" -cmd "exit"
sleep 60

echo. 
echo.
echo.
echo Sending 3min warning...
%RCON% -cmd "say -1 Warnung: Der Server startet in 3 Minuten neu!" -cmd "say -1 Notice: The server restarts in 3 minutes!" -cmd "exit"
sleep 60

echo.
echo.
echo.
echo Sending 2min warning...
%RCON% -cmd "say -1 Warnung: Der Server startet in 2 Minuten neu!" -cmd "say -1 Bitte jetzt ausloggen." -cmd "exit"
%RCON% -cmd "say -1 Notice: The server restarts in 2 minutes!" -cmd "say -1 Please log out now." -cmd "exit"
sleep 60

echo.
echo.
echo.
echo Sending 1min warning...
%RCON% -cmd "say -1 Warnung: Der Server startet in 1 Minute neu!" -cmd "say -1 Bitte jetzt ausloggen." -cmd "exit"
%RCON% -cmd "say -1 Notice: The server restarts in 1 minute!" -cmd "say -1 Please log out now." -cmd "exit"
sleep 60

call "%MYDIR%\_STOP_DayZ_Server_IMMEDIATELY.cmd"





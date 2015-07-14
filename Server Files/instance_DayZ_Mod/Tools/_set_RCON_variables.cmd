@ECHO OFF
SET MYDIR=%~dp0

set A2OADRIVE=C:
set A2OADIR=C:\Program Files (x86)\Steam\steamapps\common\Arma 2 Operation Arrowhead
set A2DIR=C:\Program Files (x86)\Steam\steamapps\common\Arma 2

set RCON_HOST=127.0.0.1
set RCON_PORT=2302
set RCON_PW=xxxxxxxxxx
set RCON="%MYDIR%\BERCon.exe" -host "%RCON_HOST%" -port "%RCON_PORT%" -pw "%RCON_PW%"




@ECHO OFF
SET MYDIR=%~dp0

set A2OADRIVE=D:
set A2OADIR=D:\Steam\steamapps\common\Arma 2 Operation Arrowhead
set A2DIR=D:\Steam\steamapps\common\Arma 2

set RCON_HOST=dayz.playz.rocks
set RCON_PORT=2302
set RCON_PW=xxxxxxxxxx
set RCON="%MYDIR%\BERCon.exe" -host "%RCON_HOST%" -port "%RCON_PORT%" -pw "%RCON_PW%"

set INST_NAME=instance_DayZ_Mod


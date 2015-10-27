@ECHO OFF
SET MYDIR=%~dp0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setzt die TIMESTAMP im Format YYYY-MM-DD_HHMMSS
for /f %%f in ('c:\bin\date.exe +%%Y-%%m-%%d_%%H%%M%%S') do set TIMESTAMP=%%f


set STEAMPATH=C:\Program Files (x86)\Steam
set A2OADRIVE=D:
set A2OADIR=D:\Steam\steamapps\common\Arma 2 Operation Arrowhead
set A2DIR=D:\Steam\steamapps\common\Arma 2

set RCON_HOST=127.0.0.1
set RCON_PORT=2302
set RCON_PW=xxxxxxxxxxx
set RCON="%MYDIR%\BERCon.exe" -host "%RCON_HOST%" -port "%RCON_PORT%" -pw "%RCON_PW%"

set INST_NAME=instance_DayZ_Namalsk
set MISSION_NAME=DayZ_PlayZ.Namalsk
set SERVER_MOD_NAME=@NC_Hive



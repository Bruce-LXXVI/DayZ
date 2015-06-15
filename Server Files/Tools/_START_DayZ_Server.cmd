@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"


%A2OADRIVE%
cd %A2OADIR%


start "arma2" "arma2oaserver.exe" -port=2302 "-config=dayz_server_instance\config.cfg" "-cfg=dayz_server_instance\basic.cfg" "-profiles=dayz_server_instance" "-name=dayz_server_instance" "-pid=C:\dayz_server_instance.pid" "-ranking=C:\dayz_server_instance_ranking.log" "-mod=D:\Steam\steamapps\common\Arma 2;EXPANSION;ca;@DayZ_Server;@Hive"


sleep 55

start "BEC" BEC\_runBEC.cmd




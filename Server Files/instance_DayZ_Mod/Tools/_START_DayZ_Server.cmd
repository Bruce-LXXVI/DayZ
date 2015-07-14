@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"


%A2OADRIVE%
cd "%A2OADIR%\"


start "arma2" "arma2oaserver.exe" -port=2302 "-config=dayz_server_instance\server.cfg" "-cfg=dayz_server_instance\basic.cfg" "-profiles=dayz_server_instance" "-name=dayz_server_instance" "-pid=dayz_server_instance\dayz_server_instance.pid" "-ranking=dayz_server_instance\dayz_server_instance_ranking.log" "-mod=%A2DIR%;EXPANSION;ca;@Hive;@DayZ_Server"


sleep 55

start "BEC" BEC\_runBEC.cmd




@echo off



set home=.
set tools=%home%\Tools\arma
Set Deploy=%home%\Deploy
Set ServerHive=%home%\SQF
Set ClientCode=%home%\SQF

set MissionName=DayZ_Mod.Chernarus
set MissionCode=%home%\Server Files\MPMissions

%tools%\cpbo.exe -y -p "%MissionCode%\%MissionName%" "%Deploy%\%MissionName%.pbo"



net use \\WIN10-TEST\dayz_mod /user:administrator Ad.1234
copy "%Deploy%\%MissionName%.pbo" \\WIN10-TEST\dayz_mod\MPMissions\



@echo off



set home=.
set tools=%home%\Tools\arma
Set Deploy=%home%\Deploy
Set ServerHive=%home%\SQF
Set ClientCode=%home%\SQF


%tools%\cpbo.exe -y -p %ServerHive%\dayz_server %Deploy%\dayz_server.pbo


net use \\WIN10-TEST\dayz_mod /user:administrator Ad.1234
copy "%Deploy%\dayz_server.pbo" \\WIN10-TEST\dayz_mod\@Hive\Addons\



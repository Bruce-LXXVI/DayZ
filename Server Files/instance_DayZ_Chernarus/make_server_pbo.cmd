@echo off



set home=..\..
set tools=%home%\Tools\arma
Set Deploy=%home%\Deploy
Set ServerHive=%home%\SQF
Set ClientCode=%home%\SQF


mkdir "%Deploy%"
%tools%\cpbo.exe -y -p %ServerHive%\dayz_server %Deploy%\dayz_server.pbo


net use \\TESTSERVER\dayz_mod /user:administrator Ad.1234
copy "%Deploy%\dayz_server.pbo" \\TESTSERVER\dayz_mod\@Hive_DayZ_188\Addons\



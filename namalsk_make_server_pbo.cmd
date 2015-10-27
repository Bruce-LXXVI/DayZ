@echo off



set home=.
set tools=%home%\Tools\arma
Set Deploy=%home%\Deploy
Set ServerHive=%home%\SQF
Set ClientCode=%home%\SQF


::%tools%\cpbo.exe -y -p %ServerHive%\dayz_server_namalsk %Deploy%\dayz_server_namalsk.pbo
%tools%\cpbo.exe -y -p %ServerHive%\dayz_server %Deploy%\dayz_server.pbo


net use \\TESTSERVER\dayz_mod /user:administrator Ad.1234
::copy "%Deploy%\dayz_server_namalsk.pbo" \\WIN10-TEST\dayz_mod\@NC_Hive\Addons\dayz_server.pbo
copy "%Deploy%\dayz_server.pbo" \\TESTSERVER\dayz_mod\@NC_Hive\Addons\



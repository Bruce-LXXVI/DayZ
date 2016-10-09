@echo off



set home=..\..
set tools=%home%\Tools\arma
set Deploy=%home%\Deploy
set ServerHive=%home%\SQF
set ClientCode=%home%\SQF
set battleye=%home%\Server Files\instance_DayZ_Chernarus\BattlEye


net use \\TESTSERVER\dayz_mod /user:administrator Ad.1234
copy "%battleye%\*" \\TESTSERVER\dayz_mod\instance_DayZ_Chernarus\BattlEye\



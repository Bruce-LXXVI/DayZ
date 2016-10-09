@echo off



set home=..\..
set tools=%home%\Tools\arma
Set Deploy=%home%\Deploy
Set ServerHive=%home%\SQF
Set ClientCode=%home%\SQF
SET ModName=instance_DayZ_Chernarus

mkdir "%Deploy%\%ModName%\Addons"

%tools%\cpbo.exe -y -p %ClientCode%\dayz_weapons %Deploy%\%ModName%\Addons\dayz_weapons.pbo
%tools%\cpbo.exe -y -p %ClientCode%\dayz_vehicles %Deploy%\%ModName%\Addons\dayz_vehicles.pbo
%tools%\cpbo.exe -y -p %ClientCode%\dayz_equip %Deploy%\%ModName%\Addons\dayz_equip.pbo
%tools%\cpbo.exe -y -p %ClientCode%\dayz_sfx %Deploy%\%ModName%\Addons\dayz_sfx.pbo
%tools%\cpbo.exe -y -p %ClientCode%\dayz_anim %Deploy%\%ModName%\Addons\dayz_anim.pbo
%tools%\cpbo.exe -y -p %ClientCode%\dayz_code %Deploy%\%ModName%\Addons\dayz_code.pbo
%tools%\cpbo.exe -y -p %ClientCode%\dayz %Deploy%\%ModName%\Addons\dayz.pbo
%tools%\cpbo.exe -y -p %ClientCode%\dayz_communityassets %Deploy%\%ModName%\Addons\dayz_communityassets.pbo
%tools%\cpbo.exe -y -p %ClientCode%\dayz_communityweapons %Deploy%\%ModName%\Addons\dayz_communityweapons.pbo
%tools%\cpbo.exe -y -p %ClientCode%\community_crossbow %Deploy%\%ModName%\Addons\community_crossbow.pbo
%tools%\cpbo.exe -y -p %ClientCode%\dayz_buildings %Deploy%\%ModName%\Addons\dayz_buildings.pbo

%tools%\cpbo.exe -y -p %ClientCode%\st_collision %Deploy%\%ModName%\Addons\st_collision.pbo
%tools%\cpbo.exe -y -p %ClientCode%\st_evasive %Deploy%\%ModName%\Addons\st_evasive.pbo
%tools%\cpbo.exe -y -p %ClientCode%\st_bunnyhop %Deploy%\%ModName%\Addons\st_bunnyhop.pbo
%tools%\cpbo.exe -y -p %ClientCode%\map_eu %Deploy%\%ModName%\Addons\map_eu.pbo


copy %home%\Documentation\PRIVACY.txt %Deploy%\%ModName%\
copy %home%\Documentation\README.txt %Deploy%\%ModName%\
copy %ClientCode%\mod.cpp %Deploy%\%ModName%\
copy %ClientCode%\do_not_use_without_permissions.txt %Deploy%\%ModName%\
copy %ClientCode%\credits.txt %Deploy%\%ModName%\



net use \\TESTSERVER\dayz_mod /user:administrator Ad.1234
mkdir "\\TESTSERVER\dayz_mod\@DayZ_188\Addons"
copy "%Deploy%\%ModName%\*" "\\TESTSERVER\dayz_mod\@DayZ_188\"
copy "%Deploy%\%ModName%\Addons\*" "\\TESTSERVER\dayz_mod\@DayZ_188\Addons\"

mkdir "C:\Program Files (x86)\Steam\steamapps\common\ARMA 2 Operation Arrowhead\@DayZ_188\addons"
copy "%Deploy%\%ModName%\*" "C:\Program Files (x86)\Steam\steamapps\common\ARMA 2 Operation Arrowhead\@DayZ_188\"
copy "%Deploy%\%ModName%\Addons\*" "C:\Program Files (x86)\Steam\steamapps\common\ARMA 2 Operation Arrowhead\@DayZ_188\addons\"

mkdir "\\r2\c$\Program Files (x86)\Steam\steamapps\common\ARMA 2 Operation Arrowhead\@DayZ_188\addons"
copy "%Deploy%\%ModName%\*" "\\r2\c$\Program Files (x86)\Steam\steamapps\common\ARMA 2 Operation Arrowhead\@DayZ_188\"
copy "%Deploy%\%ModName%\Addons\*" "\\r2\c$\Program Files (x86)\Steam\steamapps\common\ARMA 2 Operation Arrowhead\@DayZ_188\addons\"



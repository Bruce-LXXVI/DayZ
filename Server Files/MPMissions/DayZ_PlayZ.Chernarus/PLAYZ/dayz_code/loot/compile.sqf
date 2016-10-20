#define STRINGIFY(x) #x
#define NAME(name) dz_fn_loot_##name
#define PATH(sub_path) STRINGIFY(\z\addons\dayz_code\loot\sub_path)
#define PATHPLAYZ(sub_path) STRINGIFY(PLAYZ\dayz_code\loot\sub_path)
#define CPP compile preprocessFileLineNumbers

NAME(select) =      CPP PATHPLAYZ(select.sqf);
NAME(spawn) =       CPP (if (isServer) then { PATHPLAYZ(spawn_server.sqf) } else { PATHPLAYZ(spawn.sqf) });
NAME(spawnGroup) =  CPP PATHPLAYZ(spawnGroup.sqf);
NAME(insert) =      CPP PATHPLAYZ(insert.sqf);
NAME(insertCargo) = CPP PATHPLAYZ(insertCargo.sqf);

//Loot init
call CPP PATHPLAYZ(init.sqf);
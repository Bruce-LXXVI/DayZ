

if (!isDedicated) then {
	fnc_usec_selfActions = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\fn_selfActions.sqf";		//Checks which actions for self
	player_switchModel = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\player_switchModel.sqf";
	player_selectSlot = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\ui_selectSlot.sqf";
	player_spawnCheck = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\player_spawnCheck.sqf";
	building_spawnLoot = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\building_spawnLoot.sqf";
	building_spawnZombies = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\building_spawnZombies.sqf";
	zombie_generate = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\zombie_generate.sqf";			//Server compile, used for loiter behaviours
	player_gearSet = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\player_gearSet.sqf";
};
// TODO: Gibts nicht mehr
//spawn_loot = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\spawn_loot.sqf";


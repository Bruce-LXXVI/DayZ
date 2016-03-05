/*	
	FUNCTION COMPILES
*/
//Player only
if (!isDedicated) then {
	"filmic" setToneMappingParams [0.07, 0.31, 0.23, 0.37, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";
	//fnc_usec_selfActions =		compile preprocessFileLineNumbers "\nst\ns_dayz\code\compile\fn_selfActions.sqf";		//Checks which actions for self
	player_temp_calculation	=	compile preprocessFileLineNumbers "\nst\ns_dayz\code\compile\fn_temperatur.sqf";		//Temperatur System	//TeeChange
	player_animalCheck =		compile preprocessFileLineNumbers "\nst\ns_dayz\code\compile\player_animalCheck.sqf";
	//player_spawnCheck =			compile preprocessFileLineNumbers "\nst\ns_dayz\code\compile\player_spawnCheck.sqf";
	//building_spawnLoot =		compile preprocessFileLineNumbers "\nst\ns_dayz\code\compile\building_spawnLoot.sqf";
	//building_spawnZombies =		compile preprocessFileLineNumbers "\nst\ns_dayz\code\compile\building_spawnZombies.sqf";
	player_music = 				compile preprocessFileLineNumbers "\nst\ns_dayz\code\compile\player_music.sqf";			//Used to generate ambient music
	
	//Zombies
	//zombie_loiter = 			compile preprocessFileLineNumbers "\nst\ns_dayz\code\compile\zombie_loiter.sqf";			//Server compile, used for loiter behaviour
	//zombie_generate = 			compile preprocessFileLineNumbers "\nst\ns_dayz\code\compile\zombie_generate.sqf";			//Server compile, used for loiter behaviour
	
	player_useMeds =			compile preprocessFileLineNumbers "\nst\ns_dayz\code\actions\player_useMeds.sqf";
	player_wearClothes =		compile preprocessFileLineNumbers "\nst\ns_dayz\code\actions\player_wearClothes.sqf";
	player_repairEquipment_dzn = compile preprocessFileLineNumbers "\nst\ns_dayz\code\actions\player_repairEquipment_dzn.sqf";
	
};

//Start Dynamic Weather
execVM "\nst\ns_dayz\code\external\DynamicWeatherEffects.sqf";		// DayZ: Namalsk

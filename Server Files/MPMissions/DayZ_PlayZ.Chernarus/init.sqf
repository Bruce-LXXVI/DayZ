/*
	INITILIZATION
*/
//startLoadingScreen ["","RscDisplayLoadCustom"];
//cutText ["","BLACK OUT"];
//enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_instance = 1; // The instance
//Tag info this is shown to all players in the bottom left hand side of the screen 
dayZ_serverName = "playZ"; // Servername (country code + server number)

//Gamesettings
dayz_antihack = 0; // DayZ Antihack / 1 = enabled // 0 = disabled
dayz_REsec = 1; // DayZ RE Security / 1 = enabled // 0 = disabled
dayz_enableGhosting = false; //Enable disable the ghosting system.
dayz_ghostTimer = 120; //Sets how long in seconds a player must be dissconnected before being able to login again.
dayz_spawnselection = 0; //Turn on spawn selection 0 = random only spawns, 1 = Spawn choice based on limits
dayz_paraSpawn = false;
dayz_spawncarepkgs_clutterCutter = 0; //0 =  loot hidden in grass, 1 = loot lifted and 2 = no grass
dayz_spawnCrashSite_clutterCutter = 0;	// heli crash options 0 =  loot hidden in grass, 1 = loot lifted and 2 = no grass
dayz_spawnInfectedSite_clutterCutter = 0; // infected base spawn... 0: loot hidden in grass, 1: loot lifted, 2: no grass 
dayz_enableRules = true; //Enables a nice little news/rules feed on player login (make sure to keep the lists quick).
dayz_quickSwitch = false; //Turns on forced animation for weapon switch. (hotkeys 1,2,3) False = enable animations, True = disable animations
dayz_bleedingeffect = 3; //1= blood on the ground, 2= partical effect, 3 = both.
dayz_ForcefullmoonNights = true; // Forces night time to be full moon.
dayz_POIs = true;	// Add lootpos in new POI (trains/ruins mainly). The loot focused on construction.
dayz_infectiousWaterholes = true;
dayz_DamageMultiplier = 1; //Damage Multiplier for Zombies.

dayz_temperature_override = false; // Set to true to disable all temperature changes.


//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;
// May prevent "how are you civillian?" messages from NPC
enableSentences false;



// DO NOT EDIT BELOW HERE //
MISSION_ROOT=toArray __FILE__;MISSION_ROOT resize(count MISSION_ROOT-8);MISSION_ROOT=toString MISSION_ROOT;
diag_log 'dayz_preloadFinished reset';
dayz_preloadFinished=nil;
onPreloadStarted "diag_log [diag_tickTime, 'onPreloadStarted']; dayz_preloadFinished = false;";
onPreloadFinished "diag_log [diag_tickTime, 'onPreloadFinished']; if (!isNil 'init_keyboard') then { [] spawn init_keyboard; }; dayz_preloadFinished = true;";

//with uiNameSpace do {RscDMSLoad=nil;}; // autologon at next logon

if (!isDedicated) then {
	enableSaving [false, false];
	startLoadingScreen ["","RscDisplayLoadCustom"];
	progressLoadingScreen 0;
	dayz_loadScreenMsg = localize 'str_login_missionFile';
	progress_monitor = [] execVM "\z\addons\dayz_code\system\progress_monitor.sqf";
	0 cutText ['','BLACK',0];
	0 fadeSound 0;
	0 fadeMusic 0;
};

initialized = false;

call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";
call compile preprocessFileLineNumbers "PLAYZ\dayz_code\init\variables.sqf";
//call compile preprocessFileLineNumbers "PLAYZ\ns_dayz\code\init\variables.sqf"; //Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.05;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";
progressLoadingScreen 0.15;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";
call compile preprocessFileLineNumbers "PLAYZ\dayz_code\init\compiles.sqf";
//call compile preprocessFileLineNumbers "PLAYZ\ns_dayz\code\init\compiles.sqf";


progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\BIS_Effects\init.sqf";
progressLoadingScreen 0.25;

/*
 * INITIALIZE playZ scripts and modules
 */
call compile preprocessFileLineNumbers "PLAYZ\playZ_init.sqf";

initialized = true;

// Custom Loadout does not work
// [] execVM "scripts\loadout.sqf";


/* BIS_Effects_* fixes from Dwarden */
/* BRAUCHTS NICHT MEHR
BIS_Effects_EH_Killed = compile preprocessFileLineNumbers "\z\addons\dayz_code\system\BIS_Effects\killed.sqf";
BIS_Effects_AirDestruction = compile preprocessFileLineNumbers "\z\addons\dayz_code\system\BIS_Effects\AirDestruction.sqf";
BIS_Effects_AirDestructionStage2 = compile preprocessFileLineNumbers "\z\addons\dayz_code\system\BIS_Effects\AirDestructionStage2.sqf";

BIS_Effects_globalEvent = {
	BIS_effects_gepv = _this;
	publicVariable "BIS_effects_gepv";
	_this call BIS_Effects_startEvent;
};

BIS_Effects_startEvent = {
	switch (_this select 0) do {
		case "AirDestruction": {
				[_this select 1] spawn BIS_Effects_AirDestruction;
		};
		case "AirDestructionStage2": {
				[_this select 1, _this select 2, _this select 3] spawn BIS_Effects_AirDestructionStage2;
		};
		case "Burn": {
				[_this select 1, _this select 2, _this select 3, false, true] spawn BIS_Effects_Burn;
		};
	};
};
*/

if (dayz_REsec == 1) then { call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\REsec.sqf"; };
execVM "\z\addons\dayz_code\system\DynamicWeatherEffects.sqf";

if (isServer) then {
	execVM "\z\addons\dayz_server\system\server_monitor.sqf";
	//Must be global spawned, So players dont fall thought buildings (might be best to spilt these to important, not important)
};


if (!isDedicated) then {
	/*
	if (isClass (configFile >> "CfgBuildingLootNamalsk")) then {
		0 fadeSound 0;
		waitUntil {!isNil "dayz_loadScreenMsg"};
		dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
		
		_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
		//_playerMonitor =  [] execVM "\nst\ns_dayz\code\system\player_monitor.sqf";
	} else {
		endLoadingScreen;
		0 fadeSound 0;
		0 cutText ["You are running an incorrect version of DayZ: Namalsk, please download newest version from http://www.nightstalkers.cz/", "BLACK"];
	};
	*/

	//if (dayz_infectiousWaterholes) then { execVM "\z\addons\dayz_code\system\mission\chernarus\infectiousWaterholes\init.sqf"; };
	//if (dayz_antihack != 0) then {
	//	execVM "\z\addons\dayz_code\system\mission\chernarus\security\init.sqf";
	//	call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\antihack.sqf";
	//};

	_playerMonitor = [] execVM "PLAYZ\dayz_code\system\player_monitor.sqf";

	// ESS
	execVM "spawn\start.sqf";

	if (dayz_infectiousWaterholes) then { execVM "\z\addons\dayz_code\system\mission\chernarus\infectiousWaterholes\init.sqf"; };
	if (dayz_antihack != 0) then {
		if ( !((getPlayerUID player) in AdminList) && !((getPlayerUID player) in ModList)) then 
		{
			execVM "\z\addons\dayz_code\system\mission\chernarus\security\init.sqf";
			//call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\antihack.sqf";
			call compile preprocessFileLineNumbers "PLAYZ\admintools\antihack\antihack.sqf";
		};
	};
	if (dayz_enableRules) then { execVM "rules.sqf"; };
	if (!isNil "dayZ_serverName") then { execVM "\z\addons\dayz_code\system\watermark.sqf"; };
	execVM "\z\addons\dayz_code\compile\client_plantSpawner.sqf";
	

	waituntil {scriptDone progress_monitor};
	cutText ["","BLACK IN", 3];
	3 fadeSound 1;
	3 fadeMusic 1;
	endLoadingScreen;



};




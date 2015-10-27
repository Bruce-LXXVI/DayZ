disableSerialization;


// TODO: Wozu brauchts fps_safty_check?
fps_safty_check = diag_fpsmin;

// Fehler oder bewusst?
Survivor1_DZ = 	"Survivor2_DZ";

/// Player class's
DayZ_Male = ["Survivor_DZ", "Survivor1_DZ", "Survivor2_DZ", "Survivor3_DZ", "Sniper1_DZ", "Soldier1_DZ", "Camo1_DZ", "Bandit1_DZ", "Soldier_Crew_PMC", "Rocket_DZ", "CamoWinter_DZN"];
DayZ_Female = ["SurvivorW2_DZ", "BanditW1_DZ", "CamoWinterW_DZN", "Sniper1W_DZN"];
AllPlayers = DayZ_Male + DayZ_Female;
// TODO: Wozu brauchts AllPlayersVehicles?
AllPlayersVehicles = AllPlayers + ["GER_Soldier_EP1", "AllVehicles"];


// New Zeds
DayZ_ViralZeds = ["z_new_villager2","z_new_villager3","z_new_villager4","z_new_worker2","z_new_worker3","z_new_worker4"];
DayZ_NewZeds = ["z_new_milSoldier2","z_new_milSoldier3","z_new_milSoldier4","z_new_milSoldier5","z_new_milWorker2","z_new_milworker3","z_new_milworker4"];

// placed objects
// TODO: Sind die alle schon in DayZ_SafeObjects?
// DayZ_SafeObjects = ["Base_Fire_DZ","WoodenGate_1","WoodenGate_2","WoodenGate_3","WoodenGate_4","Land_Fire_DZ", "TentStorage","TentStorage0","TentStorage1","TentStorage2","TentStorage3","TentStorage4","StashSmall","StashSmall1","StashSmall2","StashSmall3","StashSmall4","StashMedium","StashMedium1","StashMedium2","StashMedium3", "StashMedium4", "Wire_cat1", "Sandbag1_DZ", "Fence_DZ", "Generator_DZ", "Hedgehog_DZ", "BearTrap_DZ", "DomeTentStorage", "DomeTentStorage0", "DomeTentStorage1", "DomeTentStorage2", "DomeTentStorage3", "DomeTentStorage4", "CamoNet_DZ", "Trap_Cans", "TrapTripwireFlare", "TrapBearTrapSmoke", "TrapTripwireGrenade", "TrapTripwireSmoke", "TrapBearTrapFlare"];
// TODO: Braucht's SafeObjects?
SafeObjects = DayZ_SafeObjects;


// TODO: Braucht's die?
meatraw = Dayz_meatraw;
meatcooked = Dayz_meatcooked;


dayz_combatLog = "";
canRoll = true;

// Server Variables
isSinglePlayer = false;


// Player self-action handles
// TODO: Braucht's die wirklich?
dayz_resetSelfActions = {
	s_player_equip_carry = -1;
	s_player_dragbody = -1;
	s_player_fire =			-1;
	s_player_cook =			-1;
	s_player_boil =			-1;
	s_player_fireout =		-1;
	s_player_butcher =		-1;
	s_player_packtent = 	-1;
	s_player_packtentinfected = -1;
	s_player_fillwater =	-1;
	s_player_fillwater2 = 	-1;
	s_player_fillfuel = 	-1;
	s_player_grabflare = 	-1;
	s_player_removeflare = 	-1;
	s_player_painkiller =	-1;
	s_player_studybody = 	-1;
	s_build_Sandbag1_DZ = 	-1;
	s_build_Hedgehog_DZ =	-1;
	s_build_Wire_cat1 =		-1;
	s_player_deleteBuild =	-1;
	s_player_forceSave = 	-1;
	s_player_flipveh = 		-1;
	s_player_stats =		-1;
	s_player_sleep =		-1;
	s_player_movedog =		-1;
	s_player_speeddog =		-1;
	s_player_calldog = 		-1;
	s_player_feeddog = 		-1;
	s_player_waterdog = 	-1;
	s_player_staydog = 		-1;
	s_player_trackdog = 	-1;
	s_player_barkdog = 		-1;
	s_player_warndog = 		-1;
	s_player_followdog = 	-1;
	s_player_fillfuel20 = -1;
	s_player_fillfuel5 = -1;
	s_player_siphonfuel = -1;
	s_player_repair_crtl = -1;
	s_player_fishing = -1;
	s_player_fishing_veh = -1;
	s_player_gather = -1;
	s_player_debugCheck = -1;
	s_player_destorytent = -1;
	s_player_attach_bomb = -1;
	s_player_upgradestroage = -1;
	s_player_Drinkfromhands = -1;
	s_player_lockhouse = -1;
	s_player_unlockhouse = -1;
	s_player_openGate = -1;
	s_player_CloseGate = -1;
	s_player_breakinhouse = -1;
	s_player_setCode = -1;
};
call dayz_resetSelfActions;


// Initialize Medical Variables
r_player_handler1 = false;


DAYZ_woundHit_dog = [
	[
		"body",
		"hands",
		"legs"
	],
	[0,0,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2]
];

dayzHit = [];
PVDZ_obj_Publish = [];		//used for eventhandler to spawn a mirror of players tent
// TODO: Was ist der Unterschied?
PVDZ_obj_HideBody = objNull;
PVCDZ_obj_HideBody = objNull;

//DayZ settings
dayz_dawn = 4;
dayz_dusk = 22;
dayz_maxAnimals = 2;
dayz_maxPlants = 3;
dayz_agentnumber = 0;
dayz_animalDistance = 800;
dayz_plantDistance = 600;

// TODO: Sind diese noch aktuell?
dayz_zSpawnDistance = 1000;
dayz_maxLocalZombies = 40; // max quantity of Z controlled by local gameclient, used by player_spawnCheck. Below this limit we can spawn Z
dayz_maxMaxModels = 80; // max quantity of Man models (player or Z, dead or alive) around players. Below this limit we can spawn Z
dayz_maxMaxWeaponHolders = 80; // max quantity of loot piles around players. Below this limit we can spawn some loot
dayz_tagDelayWeaponHolders = 20; // prevent any new loot spawn on this building during this delay (minutes)
dayz_tagDelayZombies = 20; // prevent any new zombie spawn into or near this building during this delay (minutes)
dayz_spawnArea = 200; // radius around player where we can spawn loot & Z
dayz_safeDistPlr = 50; // Any loot & Z won't be spawned closer than this distance from any player
dayz_cantseeDist = 150; // distance from which we can spawn a Z in front of any player without ray-tracing and angle checks
dayz_cantseefov = 70; // half player field-of-view. Visible Z won't be spawned in front of any near players
dayz_canDelete = 300; // Z, further than this distance from its "owner", will be deleted
dayz_lootSpawnBias = 67; // between 50 and 100. The lower it is, the lower chance some of the lootpiles will spawn
dayz_localswarmSpawned = 10;  // how many zeds will spawn around you during a combat scenario.
dayz_infectionTreshold = 1.25; // used to trigger infection, see fn_damageHandler.sqf


// init global arrays for Loot Chances
//call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\loot_init.sqf";
//call compile preprocessFileLineNumbers "\nst\ns_dayz\code\init\loot_init.sqf";

// start achievements_init
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\achievements_init.sqf";

if(isServer) then {
	dayz_spawnCrashSite_clutterCutter=0; // helicrash spawn... 0: loot hidden in grass, 1: loot lifted, 2: no grass 
};

if(!isDedicated) then {
	
	dayz_baseTypes = getArray (configFile >> dayzNam_buildingLoot >> "Default" >> "zombieClass");

	//player special variables
	dayZ_everyonesTents =	[];
	dayz_combat =			0;
	//dayz_preloadFinished = 	false;
	dayz_DeathActioned =	false;
	dayz_canDisconnect = 	true;
	dayz_lastHumanity =		0;
	dayz_guiHumanity =		-90000;
	dayzClickTime =			0;
	dayz_spawnDelay = 300;
	dayz_spawnWait = -300;
	dayz_lootDelay =		3;
	dayz_lootWait =			-300;
	//used to count global zeds around players
	dayz_CurrentZombies = 0;
	//Used to limit overall zed counts
	dayz_maxCurrentZeds = 0;
	dayz_Magazines = 		[];


};

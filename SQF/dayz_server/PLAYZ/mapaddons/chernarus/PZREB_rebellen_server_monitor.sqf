/*
	playZ Server Monitor for rebel base
*/

private [ "_directoryAsArray"
		, "_group"
		, "_groups"
		, "_vehicles"
		, "_type"
		, "_unit"
		, "_numOfAi"
		, "_totalAi"
		, "_aliveAiPercent"
		, "_waitMissionStart"

];

if(isNil "PZREB_isActive") then {PZREB_isActive=false;};

// Beenden, wenn nicht auf dem Server oder der Monitor bereits läuft.
if (!isServer || PZREB_isActive) exitWith {};
PZREB_isActive = true;
PZREB_logname="[PZREB]";

// Konfiguration einlesen
//#include <playZ_config.sqf>
//waitUntil{ !isNil "DZAI_BanditTypes" };
//waitUntil{ !isNil "DZAI_spawn_vehicle" };
//uiSleep 100; 
waitUntil{initialized};
uiSleep 15;

PZREB_waitTimeBeforeNextRun=120;
PZREB_playerDistance=200;
//PZREB_groupunittype=["BAF_Soldier_L_DDPM"];
PZREB_involvedPlayers=[];
PZREB_tools=["Binocular", "Binocular_Vector", "ItemCompass", "ItemCrowbar", "ItemEtool", "ItemFishingPole", "ItemFlashlight", "ItemFlashlightRed", "ItemGPS", "ItemHatchet_DZE", "ItemKnife", "ItemMap", "ItemMatchbox_DZE", "ItemRadio", "ItemSledge", "ItemToolbox", "ItemWatch", "NVGoggles"];
PZREB_loot=["FoodSteakCooked", "ItemAntibiotic", "ItemBandage", "ItemSodaMdew"];
PZREB_backpacks=["NONE", "NONE", "DZ_CivilBackpack_EP1", "DZ_Backpack_EP1", "DZ_British_ACU"];
PZREB_weapons=["M4A1_GL_Holo_FL_DZ", "M16A4_CCO_FL_DZ", "AK_47_M", "M4A1_HWS_GL_camo", "AKS_74_kobra", "G36K_Camo_SD_DZ", "G17_DZ", "M40A3_Gh_DZ", "M249_CCO_DZ", "FNFAL_DZ", "DMR_DZ", "PKM_DZ", "AKM_PSO1_DZ", "CZ550_DZ"];
PZREB_groupunittype=["Survivor2_DZ", "SurvivorW2_DZ", "Bandit1_DZ", "BanditW1_DZ", "Camo1_DZ", "Sniper1_DZ", "BAF_Soldier_L_DDPM"];
diag_log format ["%1 PZREB_groupunittype=%2.", PZREB_logname, PZREB_groupunittype];
PZREB_groups=[
//	Gruppe,	Spawnpunkt/WP1,					Einheiten

 [	1,		[[11440.0, 11415.7, 317.636], "HOLD"],	4]	// Scharte links
,[	2,		[[11498.4, 11337.0, 317.335], "HOLD"],	4]	// Scharte hinten
,[	3,		[[11401.3, 11350.9, 316.450], "HOLD"],	4]	// Scharte rechts
,[	4,		[[11442.5, 11349.3, 317.320], "DISMISS"],	8]	// Hangar
,[	11,		[[11421.8, 11417.7, 320.392], "HOLD"],	2]	// Turm 1
,[	21,		[[10918.9, 11612.3, 234.618], "HOLD"],	3]	// Einfahrt links unten
,[	22,		[[10915.2, 11604.5, 234.593], "HOLD"],	3]	// Einfahrt rechts unten
,[	23,		[[11376.3, 11413.4, 314.277], "HOLD"],	3]	// Einfahrt links oben
,[	24,		[[11372.1, 11406.3, 314.445], "HOLD"],	3]	// Einfahrt rechts oben
,[	31,		[[10919.9, 11607.7, 234.799], "MOVE"],	3,	// Patrouille 1: Zufahrtsstrasse
[ [[11380.5, 11404.1, 315.349], "MOVE"], [[10910.9, 11607.7, 234.799], "MOVE"], [[10914.9, 11607.7, 234.799], "CYCLE"] ] ]

,[	32,		[[11559.5, 11374.4, 322.929], "MOVE"],	3,	// Patrouille 2: UZS
[ [[11548.8, 11250.0, 315.006], "MOVE"], [[11413.5, 11229.2, 304.710], "MOVE"], [[11296.3, 11401.6, 295.492], "MOVE"], [[11359.1, 11474.0, 303.434], "MOVE"], [[11479.4, 11427.6, 316.157], "CYCLE"] ] ]

,[	33,		[[11296.3, 11401.6, 295.492], "MOVE"],	3,	// Patrouille 2: Gegen-UZS
[ [[11413.5, 11229.2, 304.710], "MOVE"], [[11548.8, 11250.0, 315.006], "MOVE"], [[11559.5, 11374.4, 322.929], "MOVE"], [[11479.4, 11427.6, 316.157], "MOVE"], [[11359.1, 11474.0, 303.434], "CYCLE"] ] ]

,[	41,		[[10919.9, 11607.7, 234.799], "MOVE"],	4,	// Heli
	[ [[11380.5, 11404.1, 315.349], "MOVE"], [[10910.9, 11607.7, 234.799], "MOVE"], [[10914.9, 11607.7, 234.799], "CYCLE"] ],
	"UH1H_DZ" ]

];


_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 34);
PZREB_directory = toString _directoryAsArray;
diag_log format ["%1 Initializing using base path %2.", PZREB_logname, PZREB_directory];


PZREB_fnc_setupUnit = {
	private ["_unit", "_weapon", "_magazine"];
	//diag_log format ["%1 setting up %2", PZREB_logname, _this];
	_unit = _this select 0;
	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
	_unit enableAI "MOVE";
	//_unit disableAI "MOVE";
	_unit enableAI "ANIM";
	_unit enableAI "FSM";
	_unit setCaptive true;
	_unit allowDamage true;
	
	
	_unit addEventHandler ["killed", {
		private ["_unit", "_killer"];
		_unit = _this select 0;
		_killer = _this select 1;
		(group _unit) setCombatMode "RED";
		diag_log format ["%1 AI %2 killed by %3", PZREB_logname, (_unit getVariable ["bodyName", "unknown"]), (name _killer)];
		
		if( !(_killer in PZREB_involvedPlayers) ) then {
			PZREB_involvedPlayers set [count PZREB_involvedPlayers, _killer];
		}
	}];
	
	
	// Make scheduler think it's a player
	_unit setVariable ["bodyName",(name _unit)];
	
	removeAllWeapons _unit;
	
	// Add random backpack
	_backpack = PZREB_backpacks call BIS_fnc_selectRandom;
	if( _backpack != "NONE" ) then { _unit addBackpack _backpack; };
	
	// Add weapon an ammo
	_weapon = PZREB_weapons call BIS_fnc_selectRandom;
	_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
	_unit addMagazine _magazine;
	_unit addWeapon _weapon;
	_unit selectWeapon _weapon;
	if ((getNumber (configFile >> "CfgMagazines" >> _magazine >> "count")) < 8) then {_unit addMagazine _magazine};
	
	// Add tools
	for "_i" from 0 to 3 do {
		_tool=PZREB_tools call BIS_fnc_selectRandom;
		_unit removeWeapon _tool;
		_unit addWeapon _tool;
	};
	
	// Add loot
	for "_i" from 0 to 5 do {
		_unit addMagazine PZREB_loot call BIS_fnc_selectRandom;;
	};
	
	
};


PZREB_fnc_setupGroup = {
	private ["_group", "_type", "_unit", "_wp1", "_units", "_WPs", "_wp", "_wpType", "_vehType", "_veh"];
	diag_log format ["%1 Creating group %2", PZREB_logname, (_this select 0)];
	
	_wp1 = (_this select 1) select 0;
	_wpType = (_this select 1) select 1;
	_units = _this select 2;
	if( count _this >= 4 ) then {_WPs = _this select 3;} else {_WPs = [];};
	if( count _this >= 5 ) then {_vehType = _this select 4;} else {_vehType = "";};
	
	_group = createGroup EAST;
	
	
	_group allowFleeing 0;
	while {count units _group < _units} do {
		_type = PZREB_groupunittype call BIS_fnc_selectRandom;
		//diag_log format ["%1 Creating one unit of type %2 at %3", PZREB_logname, _type, (mapGridPosition _wp1)];
		_unit = _group createUnit [_type, _wp1, [], 2, "NONE"];
		[_unit] call PZREB_fnc_setupUnit;
		//_unit addweapon "M16A4_CCO_FL_DZ";
		//_unit addMagazine "30Rnd_556x45_Stanag";
		//_unit addMagazine "30Rnd_556x45_Stanag";
		//_unit addMagazine "30Rnd_556x45_Stanag";
		//_unit addMagazine "30Rnd_556x45_Stanag";
	};

	// Add vehicle if desired
	if( _vehType != "" ) then {
		diag_log format ["%1 Creating one vehicle of type %2 at %3", PZREB_logname, _vehType, (mapGridPosition _wp1)];
		_veh = createVehicle [_vehType, _wp1, [], 0, "FLY"];
		_veh setVariable ["ObjectUID", [getDir _veh, getPos _veh] call dayz_objectUID2, true];
		_veh setFuel 0.1;
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _veh];
		
		_veh addMagazine "100Rnd_762x51_M240";
		_veh addMagazine "100Rnd_762x51_M240";
		_veh addMagazine "100Rnd_762x51_M240";
		_veh addMagazine "100Rnd_762x51_M240";
		_veh addMagazine "100Rnd_762x51_M240";
		_veh addMagazine "100Rnd_762x51_M240";
		_veh addMagazine "100Rnd_762x51_M240";
		_veh addMagazine "100Rnd_762x51_M240";
		_veh addMagazine "100Rnd_762x51_M240";
		_veh addMagazine "100Rnd_762x51_M240";
		
		_veh addWeapon "M240_veh";
		_veh addWeapon "M240_veh";
		
		//(units _group) select 0) moveInDriver _veh;
		{
			if( !(_x in (crew _veh)) ) then {
				if(_forEachIndex == 0) then { _x moveInDriver _veh;}
				else {
					_x addMagazine "100Rnd_762x51_M240";
					_x addMagazine "100Rnd_762x51_M240";
					_x addMagazine "100Rnd_762x51_M240";
					_x addMagazine "100Rnd_762x51_M240";
					_x assignAsGunner _veh;
					_x moveInGunner _veh;
				};
			};
		} forEach (units _group);
		
		_veh setVehicleLock "LOCKED";
	} else {
		_veh=objNull;
	};

	if( count _WPs == 0 ) then {
		//diag_log format ["%1 Adding %4 waypoint %2 to %3.", PZREB_logname, _wp1, _group, _wpType];
		_wp = _group addWaypoint [_wp1, 2];
		_wp setWaypointType _wpType;
	} else {

		{
			//diag_log format ["%1 Adding %4 waypoint %2 to %3.", PZREB_logname, _x select 0, _group, _x select 1];
			_wp = _group addWaypoint [_x select 0, 2];
			_wp setWaypointType (_x select 1);
			_wp setWaypointTimeout [5, 15, 30];
		} forEach _WPs;

	};
	
	_group setSpeedMode "NORMAL";
	_group setCombatMode "GREEN";
	//_group setBehaviour "AWARE";
	
	
	[_group, _veh]
};


// Check if players are near group spawns
_waitMissionStart = false;
while { _waitMissionStart } do {
	_waitMissionStart = false;
	{
		private ["_playerNear", "_grpNo", "_grpPos"];
		_grpNo	= _x select 0;
		_grpPos	= ((_x select 1) select 0);
		_playerNear = ({isPlayer _x} count (_grpPos nearEntities [["CAManBase","Land","Air"], PZREB_playerDistance]) > 0);
	
		if(_playerNear) then {
			diag_log format ["%1 player within %2m of group %3 spawn.", PZREB_logname, PZREB_playerDistance, _grpNo];
			_waitMissionStart = true;
		};
	} forEach PZREB_groups;
	
	uiSleep PZREB_waitTimeBeforeNextRun;
};


_totalAi=0;
_groups=[];
_vehicles=[];
{
	private ["_result"];
	_result = _x call PZREB_fnc_setupGroup;    // returns [<group>, <vehicle>]
	_groups set [count _groups, [(_x select 0), _result select 0]];
	if( !isNull (_result select 1) ) then {
		_vehicles set [count _vehicles, [(_x select 0), _result select 1]];
	};
	_totalAi = _totalAi + count units (_result select 0);
} forEach PZREB_groups;


_numOfAi=-1;
_numOfVeh=-1;
_aliveAiPercent=100;
while { PZREB_isActive } do {
	_numOfAi=0;
	_numOfVeh=0;
	diag_log format ["%1 ======================================================", PZREB_logname];
	//diag_log format ["%1 _group1=%2 | _group2=%2 | _group3=%2 | _group4=%2 | _group5=%2 | ", PZREB_logname, (count units _group1), (count units _group2), (count units _group3), (count units _group4), (count units _group5)];
	
	// Count alive AI
	{
		{ if( !alive _x ) then { [_x] joinSilent grpNull;};} count units (_x select 1);
		_numOfAi = _numOfAi + count units (_x select 1);
	} count _groups;
	_aliveAiPercent=(round ((1000 * _numOfAi) / _totalAi)) / 10;
	diag_log format ["%1 %2/%3 AI alive (%4%5)", PZREB_logname, _numOfAi, _totalAi, _aliveAiPercent, "%"];
	
	// Count vehicles and refuel
	{
		diag_log format ["%1 vehicle %2 = %3 | GPS=%4", PZREB_logname, _x select 0, _x select 1, mapGridPosition getPos (_x select 1)];
		
		if( alive (_x select 1) ) then {
			if( canmove (_x select 1) ) then {
				// Vehicle kann sich bewegen
				if( fuel (_x select 1) < 0.2 ) then {
					diag_log format ["%1 Fuelling vehicle %2", PZREB_logname, (_x select 1)];
					(_x select 1) setFuel 0.3;
				};
			} else {
				// Vehicle kann sich nicht bewegen
				diag_log format ["%1 vehicle %2 is immobile", PZREB_logname, (_x select 1)];
				(_x select 1) setDamage (0.2 + damage (_x select 1));
			};
			_numOfVeh = _numOfVeh + 1;
		};
	} count _vehicles;
	diag_log format ["%1 %2 vehicles alive", PZREB_logname, _numOfVeh];
	
	{
		_groupNum = (_x select 0);
		_group = (_x select 1);
		
		// 2 AI killed: set group 41 to RED and all other to YELLOW
		if( (_totalAi - _numOfAi) >= 2 ) then {
			if( _groupNum == 41 ) then {
				_group setCombatMode "RED";
				(leader _group) setBehaviour "COMBAT";
			} else {
				if( combatMode _group in ["BLUE", "GREEN", "WHITE"] ) then {
					_group setCombatMode "YELLOW";
				};
			};
		};
		
		
		// 10% AI killed: set all groups to RED
		if( _aliveAiPercent < 90 ) then {
			_group setCombatMode "RED";
			(leader _group) setBehaviour "COMBAT";
		};
		
		
		diag_log format ["%1 group %2 = %3 | GPS=%4 | combatMode=%5 | behaviour=%6", PZREB_logname, _groupNum, count units _group, mapGridPosition getPos leader _group, combatMode _group, behaviour (leader _group)];
	} count _groups;
	
	
	
	
	if(_numOfAi == 0) then {
		// Alle AI tot
		diag_log format ["%1 ALL AI DEAD!", PZREB_logname];
		{ (_x select 1) setDamage 1; } count _vehicles;
		PZREB_isActive=false;
	};
	diag_log format ["%1 players: %2", PZREB_logname, PZREB_involvedPlayers];
	
	uiSleep PZREB_waitTimeBeforeNextRun;
};

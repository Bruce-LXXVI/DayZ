/*
	playZ Server Scheduler Initialization File
*/

private [ "_directoryAsArray"
		, "_iVehTotal"			// gezählte Vehikel auf der Map
		, "_iVehDeleted"		// vom aktuellen Durchlauf gelöschte Vehikel
		, "_iVehCreated"		// vom aktuellen Durchlauf erstelle Vehikel
		, "_damage"				// Schaden am Vehikel
		, "_pos"				// Position
		, "_objectID"			
		, "_objectUID"
		, "_survivors"			// Spieler in der Nähe
		, "_playerNear"			// Spieler in der Nähe
		, "_staticVehSpawns"	// Array der static spawn points
		, "_runVehSpawner"		// Killswitch für den Vehikel-Spawner
		, "_iSpawnerTerminator"	// Killcounter für den Vehikel-Spawner
		, "_dontSpawn"			// Merker für Entscheidung: spawn oder nicht spawn
		, "_newVehSpawn"		// Definitiv ausgewählter spawn point
		, "_type"				// Classname des Vehikels
		, "_newVehWorldspace"
		, "_inventory"
		, "_hitpoints"
		, "_dir"
		, "_ownerID"
		, "_fuel"
		, "_thisVehicle"		// Dieses Vehikel (mit der UID)
		, "_vehicles"			// Liste der Vehikel in der nähe (~15m))
		, "_newVeh"				// Das neue Vehikel, wenn es dann erstellt ist
		, "_aliveUIDs"
		, "_aliveIDs"
];


if (!isServer || !isNil "PLAYZ_isActive") exitWith {};
PLAYZ_isActive = true;
PLAYZ_logname="[playZ]";

#include <playZ_config.sqf>
#include <playZ_spawnpoints.sqf>

PLAYZ_dynamic_vehicles = ["UAZ_Unarmed_TK_EP1", "UAZ_Unarmed_TK_CIV_EP1", "UAZ_Unarmed_UN_EP1", "UAZ_RU", "ATV_US_EP1", "ATV_CZ_EP1", "SkodaBlue", "Skoda", "SkodaGreen", "TT650_Ins", "TT650_TK_EP1", "TT650_TK_CIV_EP1", "Old_bike_TK_CIV_EP1", "Old_bike_TK_INS_EP1", "UH1H_DZ", "hilux1_civil_3_open", "Ikarus_TK_CIV_EP1", "Ikarus", "Tractor", "S1203_TK_CIV_EP1", "V3S_Civ", "UralCivil", "car_hatchback", "Fishing_Boat", "PBX", "Smallboat_1", "Volha_2_TK_CIV_EP1", "Volha_1_TK_CIV_EP1", "SUV_DZ", "car_sedan", "AH6X_DZ", "Mi17_DZ", "AN2_DZ", "BAF_Offroad_D", "BAF_Offroad_W", "MH6J_DZ", "HMMWV_DZ", "Pickup_PK_INS", "Offroad_DSHKM_INS"];

waitUntil{initialized};
uiSleep 100;

_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 25);
PLAYZ_directory = toString _directoryAsArray;
diag_log format ["%1 Initializing using base path %2.", PLAYZ_logname, PLAYZ_directory];

while {true} do {
	diag_log format ["%1 ======================================================", PLAYZ_logname];
	_iVehTotal = 0;
	_iVehDeleted = 0;
	_iVehCreated = 0;
	_aliveUIDs = [];
	_aliveIDs = [];

	{
		if ( _x isKindOf "AllVehicles" ) then {
			_iVehTotal = _iVehTotal + 1;
			

			_damage = damage _x;
			_pos = getPosASL _x;
			//_posGps = (mapGridPosition getPos _x);
			_objectID = _x getVariable ["ObjectID","0"];
			_objectUID = _x getVariable ["ObjectUID","0"];

			// die objectUID/objectID zur Liste hinzufügen
			if( (_objectUID != "") && (_objectUID != "0") ) then {_aliveUIDs set [count _aliveUIDs, _objectUID];};
			if( (_objectID != "") && (_objectID != "0") ) then {_aliveIDs set [count _aliveIDs, _objectID];};

			//diag_log format ["%1 ===> veh=%2 | damage=%3 | pos=%4 | posGps=%5", PLAYZ_logname, _x, _damage, _pos, mapGridPosition _pos];
			//diag_log format ["%1 objectID=%2 | objectUID=%3", PLAYZ_logname, _objectID, _newVehUID];

			// ist ein Spieler in der Nähe?
			//_survivors = (position _x) nearEntities [["Survivor1_DZ","SurvivorW1_DZ","Survivor2_DZ","SurvivorW2_DZ","Camo1_DZ","Sniper1_DZ","Survivor3_DZ"],PLAYZ_playerDistance];
			_survivors = [];
			{
				_dist=(getPosASL _x) distance _pos;
				if( (isPlayer _x) && {(alive _x)} && (_dist < PLAYZ_playerDistance) ) then {
					//diag_log format ["%1 playable unit %3 dist=%2", PLAYZ_logname, _dist, _x];
					_survivors set [count _survivors, _x];
				};
			} forEach playableUnits;


			if ( _damage == 1 ) then {
				if( count _survivors == 0 ) then {
					diag_log format ["%1 DELETING ===> veh=%2 | damage=%3 | pos=%4 | posGps=%5", PLAYZ_logname, _x, _damage, _pos, mapGridPosition _pos];
					diag_log format ["%1 objectID=%2 | objectUID=%3", PLAYZ_logname, _objectID, _objectUID];

					deleteVehicle _x;
					_x = objNull;
					PVDZ_obj_Destroy = [_objectID,_objectUID];
					publicVariableServer "PVDZ_obj_Destroy";
					diag_log [diag_ticktime, PLAYZ_logname, " Networked object, request to destroy", PVDZ_obj_Destroy];
					_iVehDeleted = _iVehDeleted + 1;
				} else {
					diag_log format ["%1 Not deleted (player nearby)", PLAYZ_logname];
				};
			};
		};
	} forEach vehicles;



//	diag_log format ["%1 _aliveUIDs=%2", PLAYZ_logname, _aliveUIDs];
//	diag_log format ["%1 _aliveIDs=%2", PLAYZ_logname, _aliveIDs];



	// static spawn points vorbereiten
	_staticVehSpawns = [];
	{
		_objectUID = _x select 0;
		_pos = (_x select 2) select 1;
		_playerNear = ({isPlayer _x} count (_pos nearEntities [["CAManBase","Land","Air"], PLAYZ_playerDistance]) > 0);

		if( (_objectUID in _aliveUIDs) || (_objectUID in _aliveIDs) ) then {
			//diag_log format ["%1 static spawn %2 (UID=%3): vehicle exists", PLAYZ_logname, _x select 1, _x select 0];
		} else {
			if(_playerNear) then {
				diag_log format ["%1 static spawn %2 (UID=%3): player near", PLAYZ_logname, _x select 1, _x select 0];
			} else {
				diag_log format ["%1 static spawn %2 (UID=%3): added to list", PLAYZ_logname, _x select 1, _x select 0];
				_staticVehSpawns = _staticVehSpawns + [_x];
			};
		};

	} forEach PLAYZ_vehicle_spawns;




	_runVehSpawner=true;
	_iSpawnerTerminator=1; // Not-Abschaltung ;)
	while { (_iSpawnerTerminator > 0) && (_runVehSpawner) && (_iVehTotal < PLAYZ_totalVehicles) && (_iVehCreated < 1) } do {
		_iSpawnerTerminator = _iSpawnerTerminator - 1;
		diag_log format ["%1 Vehicle spawner started.", PLAYZ_logname];

		
		// Per default nicht spawnen
		_dontSpawn=true;
		// Daten für das neue vehikel
		_newVehSpawn = [];



		// Zuerst einen static spawn point versuchen
		if(PLAYZ_enableStaticSpawns) then {
			diag_log format ["%1 found %2 possible static spawn points.", PLAYZ_logname, count _staticVehSpawns];
			if(count _staticVehSpawns > 0) then {

				// pick one
				_newVehSpawn = _staticVehSpawns call BIS_fnc_selectRandom;
				diag_log format ["%1 picked static spawn %2 (%3).", PLAYZ_logname, _newVehSpawn select 1, _newVehSpawn select 0];

				// Ok, static spawn gefunden => also doch spawnen
				_dontSpawn=false;
			};
		} else {
			diag_log format ["%1 static spawns disabled.", PLAYZ_logname];
		};



		// Dynamischen spawn point versuchen
		if(PLAYZ_enableDynamicSpawns) then {
			if( _dontSpawn ) then {
		
				// Fahrzeug aussuchen
				_newVehWorldspace=[round random 360, [((random 1000)+6000), ((random 1000)+7000), 0]];
				_newVehSpawn set [0, _newVehWorldspace call dayz_objectUID2];
				_newVehSpawn set [1, PLAYZ_dynamic_vehicles call BIS_fnc_selectRandom];
				_newVehSpawn set [2, _newVehWorldspace];
				_newVehSpawn set [3, []];
				_newVehSpawn set [4, []];

				diag_log format ["%1 picked dynamic spawn %2 (%3).", PLAYZ_logname, _newVehSpawn select 1, _newVehSpawn select 0];

		/*	call {
				if (_vehicleType isKindOf "Air") exitWith {
					//Note: no cargo units for air vehicles
					_maxGunnerUnits = DZAI_heliGunnerUnits;
					_weapongrade = DZAI_heliUnitLevel call DZAI_getWeapongrade;
					_vehSpawnPos = [(getMarkerPos "DZAI_centerMarker"),300 + (random((getMarkerSize "DZAI_centerMarker") select 0)),random(360),1] call SHK_pos;
					_vehSpawnPos set [2,150];
					_spawnMode = "FLY";
				};
				if (_vehicleType isKindOf "LandVehicle") exitWith {
					_maxGunnerUnits = DZAI_vehGunnerUnits;
					_maxCargoUnits = DZAI_vehCargoUnits;
					_weapongrade = DZAI_vehUnitLevel call DZAI_getWeapongrade;
					while {_keepLooking} do {
						_vehSpawnPos = [(getMarkerPos "DZAI_centerMarker"),300 + random((getMarkerSize "DZAI_centerMarker") select 0),random(360),0,[2,750]] call SHK_pos;
						if ((count _vehSpawnPos) > 1) then {
							_playerNear = ({isPlayer _x} count (_vehSpawnPos nearEntities [["CAManBase","Land","Air"], 300]) > 0);
							if(!_playerNear) then {
								_keepLooking = false;	//Found road position, stop searching
							};
						} else {
							if (DZAI_debugLevel > 0) then {diag_log format ["DZAI Debug: Unable to find road position to spawn AI %1. Retrying in 30 seconds.",_vehicleType]};
							uiSleep 30; //Couldnt find road, search again in 30 seconds.
						};
					};
				};
				_error = true;
			}; */

				// Ok, dynamic spawn gefunden => also doch spawnen
				_dontSpawn=false;
			};
		} else {
			diag_log format ["%1 dynamic spawns disabled.", PLAYZ_logname];
		};


		// Aufgeben: Es wurden keine spawn points gefunden.
		if( _dontSpawn || (count _newVehSpawn < 4) ) exitWith {diag_log format ["%1 no spawn points found.", PLAYZ_logname];};


		_objectUID = _newVehSpawn select 0;
		_type = _newVehSpawn select 1;
		_newVehWorldspace = _newVehSpawn select 2;
		_inventory = _newVehSpawn select 3;
		_hitpoints = _newVehSpawn select 4;

		_dir = _newVehWorldspace select 0;
		_pos = _newVehWorldspace select 1;
		_ownerID = 0;
		_damage = 0;
		_fuel = 0.5;


		// Gründe für Nicht-Spawn?
		// Gibts das Fahrzeug mit dieser ID schon?
		//_thisVehicle = _pos nearestObject _objectUID;
		//diag_log format ["%1 uid=%2 | obj=%3", PLAYZ_logname, _objectUID, _thisVehicle];
		if( (_objectUID in _aliveUIDs) || (_objectUID in _aliveIDs) ) then {_dontSpawn=true; diag_log format ["%1 find another spawn point (same objectUID exists)", PLAYZ_logname];};

		// ist ein Spieler in der Nähe?
		//_survivors = _pos nearEntities [["Survivor1_DZ","SurvivorW1_DZ","Survivor2_DZ","SurvivorW2_DZ","Camo1_DZ","Sniper1_DZ","Survivor3_DZ"],PLAYZ_playerDistance];
		//if( count _survivors > 0 ) then {_dontSpawn=true; diag_log format ["%1 find another spawn point (player nearby)", PLAYZ_logname];};
		_playerNear = ({isPlayer _x} count (_pos nearEntities [["CAManBase","Land","Air"], PLAYZ_playerDistance]) > 0);
		if( _playerNear ) then {_dontSpawn=true; diag_log format ["%1 find another spawn point (player nearby)", PLAYZ_logname];};

		// sind andere vehicles in der unmittelbaren Nähe?
		_vehicles = _pos nearEntities ["AllVehicles", 15];
		if( count _vehicles > 0 ) then {_dontSpawn=true; diag_log format ["%1 find another spawn point (vehicle nearby)", PLAYZ_logname];};



		if( !_dontSpawn ) then {

			_newVeh = createVehicle [_type, _pos, [], 0, "NONE"];
			_newVeh setDir _dir;
			_newVeh setDamage _damage;
			_newVeh setVariable ["lastUpdate",time];
			_newVeh setVariable ["ObjectUID", _objectUID, true];
			_newVeh setVariable ["ObjectID", _objectUID, true];
			_newVeh setVariable ["CharacterID", _ownerID, true];
			_newVeh setVehicleVarName _objectUID;

			//Dont add inventory for traps.
			if (!(_newVeh isKindOf "TrapItems") And !(_newVeh iskindof "DZ_buildables")) then {
				_cargo = _inventory;
				clearWeaponCargoGlobal  _newVeh;
				clearMagazineCargoGlobal  _newVeh;
				clearBackpackCargoGlobal  _newVeh;	 
				_config = ["CfgWeapons", "CfgMagazines", "CfgVehicles" ];
				{
					_magItemTypes = _x select 0;
					_magItemQtys = _x select 1;
					_i = _forEachIndex;
					{
						if ((isClass(configFile >> (_config select _i) >> _x)) &&
							{(getNumber(configFile >> (_config select _i) >> _x >> "stopThis") != 1)}) then {
							if (_forEachIndex < count _magItemQtys) then {
								switch (_i) do {
									case 0: { _newVeh addWeaponCargoGlobal [_x,(_magItemQtys select _forEachIndex)]; }; 
									case 1: { _newVeh addMagazineCargoGlobal [_x,(_magItemQtys select _forEachIndex)]; }; 
									case 2: { _newVeh addBackpackCargoGlobal [_x,(_magItemQtys select _forEachIndex)]; }; 
								};
							};
						};
					} forEach _magItemTypes;
				} forEach _cargo;
			};
		
		
			{
				_selection = _x select 0;
				_dam = _x select 1;
				if ((_selection in dayZ_explosiveParts and _dam > 0.8) && (!(_newVeh isKindOf "Air"))) then {_dam = 0.8};

				[_newVeh,_selection,_dam] call fnc_veh_setFixServer;
			} forEach _hitpoints;
			
			_newVeh setvelocity [0,0,1];
			_newVeh setFuel _fuel;
			_newVeh call fnc_veh_ResetEH;

			diag_log format ["%1 SPAWNING ===> veh=%2 | type=%6 | damage=%3 | pos=%4 | posGps=%5", PLAYZ_logname, _newVeh, _damage, getPosASL _newVeh, (mapGridPosition getPos _newVeh), _type];
			diag_log format ["%1 objectID=%2 | objectUID=%3", PLAYZ_logname, _newVeh getVariable ["ObjectID","0"], _objectUID];

			dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_newVeh];
			[_newVeh, _type] spawn server_updateObject;

			PVDZ_obj_Publish = [_ownerID, _newVeh, [round getDir _newVeh, getPosATL _newVeh], _inventory, _hitpoints, _objectUID];
			publicVariableServer "PVDZ_obj_Publish";
			diag_log [diag_ticktime, PLAYZ_logname, " New Networked object, request to save to hive. PVDZ_obj_Publish:", PVDZ_obj_Publish];

			_aliveUIDs set [count _aliveUIDs, _objectUID];
			_iVehCreated = _iVehCreated + 1;
		} else {
			diag_log format ["%1 NOT SPAWNING ===> veh=%2 | type=%6 | damage=%3 | pos=%4 | posGps=%5", PLAYZ_logname, 0, _damage, _pos, mapGridPosition _pos, _type];
			diag_log format ["%1 objectID=%2 | objectUID=%3", PLAYZ_logname, _objectUID, _objectUID];
		};
	};



	
	diag_log format ["%1 # of veh=%2 | veh deleted=%3 | veh created=%4", PLAYZ_logname, _iVehTotal, _iVehDeleted, _iVehCreated];





	uiSleep PLAYZ_waitTimeBeforeNextRun;
};



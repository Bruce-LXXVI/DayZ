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
		, "_objectUIDOld"
		, "_survivors"			// Spieler in der Nähe
		, "_playerNear"			// Spieler in der Nähe
		, "_staticVehSpawns"	// Array der static spawn points
		, "_staticPrioVehSpawns"// Array der static spawn points mit hoher Priorität
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
		, "_classnameCounters"
		, "_isResetter"			// Fahrzeug, das immer wieder resettet wird
];


// Beenden, wenn nicht auf dem Server oder Fahrzeug-Management bereits läuft.
if (!isServer || !isNil "PLAYZ_isActive") exitWith {};
PLAYZ_isActive = true;
PLAYZ_logname="[PLAYZ]";

waitUntil{initialized};
uiSleep 100;

_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 44);
PLAYZ_directory = toString _directoryAsArray;
diag_log format ["%1 Initializing world %3 using base path %2", PLAYZ_logname, PLAYZ_directory, PLAYZ_worldname];

// Konfiguration einlesen
//#include <playZ_config.sqf>
call compile preprocessFileLineNumbers format["%1\%2\playZ_config.sqf", PLAYZ_directory, PLAYZ_worldname];

if(isNil "PLAYZ_enableVehicleManagement") then {PLAYZ_enableVehicleManagement=false;};
if (!PLAYZ_enableVehicleManagement) exitWith {};

//#include <playZ_spawnpoints.sqf>
call compile preprocessFileLineNumbers format["%1\%2\playZ_spawnpoints.sqf", PLAYZ_directory, PLAYZ_worldname];


PLAYZ_fnc_spawnVehicle = compile preprocessFileLineNumbers format["%1\playZ_fnc_spawnVehicle.sqf", PLAYZ_directory];


while {true} do {
	diag_log format ["%1 ======================================================", PLAYZ_logname];
	_iVehTotal = 0;
	_iVehDeleted = 0;
	_iVehCreated = 0;
	_aliveUIDs = [];
	_aliveIDs = [];
	_classnameCounters = [];
	{_classnameCounters set [count _classnameCounters, 0]} forEach PLAYZ_limitedClasses; // Ginge auch mit resize ;-)
	_classnameOverlimit = [];

	{
		if ( _x isKindOf "AllVehicles" ) then {
			_iVehTotal = _iVehTotal + 1;
			
			_damage = damage _x;
			_pos = getPosASL _x;
			_type = typeOf _x;
			_objectID = _x getVariable ["ObjectID","0"];
			_objectUID = _x getVariable ["ObjectUID","0"];
			_whenDestroyed = _x getVariable ["PLAYZ_whenDestroyed", nil];
			_playerNear = ({isPlayer _x} count (_pos nearEntities [["CAManBase","Land","Air"], PLAYZ_playerDistance]) > 0);
			_vehiceNear = (count (_pos nearEntities ["AllVehicles", PLAYZ_staticSpawnOtherVehicleDistance]) > 0);
			//_isResetter = ((parseNumber _objectUID) >= 280000000) && ((parseNumber _objectUID) < 290000000);
			_isResetter = false;
			_isPrio = ((parseNumber _objectUID) >= 290000000) && ((parseNumber _objectUID) < 300000000);
			_isLocked = locked _x;

			if( (_objectID == "0") && (_objectUID == "0") && !_isLocked ) then
			{
				diag_log format ["%1 FOUND VEHICLE (%2) WITH NO ID at %3!!", PLAYZ_logname, _type, mapGridPosition _pos];
				diag_log format ["%1 CREW: %2", PLAYZ_logname, crew _x];
				diag_log format ["%1 LOCKING VEHICLE!", PLAYZ_logname];
				_x setVehicleLock "LOCKED";
			};

			// die objectUID/objectID zur Liste hinzufügen
			if( (_objectUID != "") && (_objectUID != "0") && !_isLocked ) then {_aliveUIDs set [count _aliveUIDs, _objectUID];};
			if( (_objectID != "") && (_objectID != "0") && !_isLocked ) then {_aliveIDs set [count _aliveIDs, _objectID];};

			// Klasse limitiert?
			_index = PLAYZ_limitedClasses find _type;
			if( (_index >= 0) && !_isLocked ) then {_classnameCounters set [_index, ((_classnameCounters select _index) + 1)];};

			// Stark beschädigte / Reset- Fahrzeuge zerstören
			if(	alive _x && (
					((PLAYZ_destroyVehiclesMoreDamaged < 1) && (_damage >= PLAYZ_destroyVehiclesMoreDamaged))
				)) then {
				if( _playerNear ) then {
					diag_log format ["%1 don't destroy %2 (player nearby)", PLAYZ_logname, _x];
				} else {
					diag_log format ["%1 blowing up %2", PLAYZ_logname, _x];
					_x setDamage 1;
				}
			};


			// Zerstörte Fahrzeuge löschen
			if ( _damage == 1 ) then {

				// Per default löschen
				_dontDelete=false;

				// Zeit des Zerstörens setzen
				if(isNil "_whenDestroyed") then {
					_whenDestroyed = round diag_tickTime;
					_x setVariable ["PLAYZ_whenDestroyed", _whenDestroyed, true];
				};

				// ist ein Spieler in der Nähe?
				if( _playerNear ) then {_dontDelete=true; diag_log format ["%1 don't delete (player nearby)", PLAYZ_logname];};

				// Timer abgelaufen?
				if( (diag_tickTime - _whenDestroyed) < PLAYZ_deleteDestroyedVehiclesAfter ) then {
					_dontDelete=true; diag_log format ["%1 don't delete (PLAYZ_deleteDestroyedVehiclesAfter)", PLAYZ_logname];
				};

				if( !_dontDelete ) then {
					diag_log format ["%1 DELETING ===> veh=%2 | damage=%3 | pos=%4 | posGps=%5", PLAYZ_logname, _x, _damage, _pos, mapGridPosition _pos];
					diag_log format ["%1 objectID=%2 | objectUID=%3", PLAYZ_logname, _objectID, _objectUID];

					PVDZ_obj_Destroy = [_objectID,_objectUID,player,_x,dayz_authKey];
					publicVariableServer "PVDZ_obj_Destroy";
					diag_log [diag_ticktime, PLAYZ_logname, " Networked object, request to destroy", PVDZ_obj_Destroy];
					deleteVehicle _x;
					_x = objNull;
					_iVehDeleted = _iVehDeleted + 1;
				} else {
					diag_log format ["%1 Not deleted: %2", PLAYZ_logname, _x];
				};
			};
		};
	} count vehicles;



//	diag_log format ["%1 _aliveUIDs=%2", PLAYZ_logname, _aliveUIDs];
//	diag_log format ["%1 _aliveIDs=%2", PLAYZ_logname, _aliveIDs];
//	diag_log format ["%1 _classnameCounters=%2", PLAYZ_logname, _classnameCounters];





	// "Verbotene" Classnames vorbereiten
	_classnameOverlimit = [];
	{
		if(PLAYZ_classLimits select _forEachIndex <= _classnameCounters select _forEachIndex) then {
			diag_log format ["%1 type=%2 | limit=%3 | count=%4 | LIMIT REACHED!", PLAYZ_logname, _x, PLAYZ_classLimits select _forEachIndex, _classnameCounters select _forEachIndex];
			_classnameOverlimit set [count _classnameOverlimit, _x];
		} else {
			diag_log format ["%1 type=%2 | limit=%3 | count=%4 | ok to spawn.", PLAYZ_logname, _x, PLAYZ_classLimits select _forEachIndex, _classnameCounters select _forEachIndex];
		};
	} forEach PLAYZ_limitedClasses;





	// static spawn points vorbereiten
	_staticVehSpawns = [];
	_staticPrioVehSpawns = [];
	{
		_objectUID = _x select 0;
		_objectUIDOld = "N/A";
		_type = _x select 1;
		_pos = (_x select 2) select 1;
		_playerNear = ({isPlayer _x} count (_pos nearEntities [["CAManBase","Land","Air"], PLAYZ_playerDistance]) > 0);
		_vehiceNear = (count (_pos nearEntities ["AllVehicles", PLAYZ_staticSpawnOtherVehicleDistance]) > 0);
		//_isResetter = ((parseNumber _objectUID) >= 280000000) && ((parseNumber _objectUID) < 290000000);
		_isResetter = false;
		_isPrio =     ((parseNumber _objectUID) >= 290000000) && ((parseNumber _objectUID) < 300000000);

		// Alte ObjectUID berechnen
		if( ((parseNumber _objectUID) >= 200000000) && ((parseNumber _objectUID) < 300000000) ) then {
			_objectUIDOld = [];
			{
				if( _foreachIndex > 0 ) then {
					_objectUIDOld set [_foreachIndex - 1, (toArray _objectUID) select _foreachIndex];
				}
			} forEach (toArray _objectUID);
			_objectUIDOld = toString _objectUIDOld;
			//diag_log format ["%1 _objectUID=%2 | _objectUIDOld=%3", PLAYZ_logname, _objectUID, _objectUIDOld];
		};

		// PLAYZ_spawnpos setzen
		/* ZU LANGSAM
		{
			private ["_oID", "_oUID"];
			if ( (_x isKindOf "AllVehicles") && ( count (_x getVariable ["PLAYZ_spawnpos", []]) < 3 ) ) then {
				_oID = _x getVariable ["ObjectID","0"];
				_oUID = _x getVariable ["ObjectUID","0"];
				if( (_objectUID == _oID) || (_objectUID == _oUID) || (_objectUIDOld == _oID) || (_objectUIDOld == _oUID) ) then {
					_x setVariable ["PLAYZ_spawnpos", _pos, true];
				};
			}
		} count vehicles;
		*/

		if( 		(_objectUID in _aliveUIDs) || (_objectUID in _aliveIDs) 
				||	(_objectUIDOld in _aliveUIDs) || (_objectUIDOld in _aliveIDs)
			) then {
			//diag_log format ["%1 static spawn %2 (UID=%3): vehicle exists", PLAYZ_logname, _x select 1, _x select 0];
		} else {
			if( _isPrio ) then {
				// Hohe Prio
				diag_log format ["%1 PRIORITY static spawn %2 (UID=%3): added to list", PLAYZ_logname, _x select 1, _x select 0];
				_staticPrioVehSpawns = _staticPrioVehSpawns + [_x];
			} else {
				// Normale Prio
				if(_playerNear) then {
					diag_log format ["%1 static spawn %2 (UID=%3): player near", PLAYZ_logname, _x select 1, _x select 0];
				} else {
					if(_type in _classnameOverlimit) then {
						//diag_log format ["%1 static spawn %2 (UID=%3): class over limit", PLAYZ_logname, _x select 1, _x select 0];
					} else {
						if(_vehiceNear) then {
							diag_log format ["%1 static spawn %2 (UID=%3): vehicle near", PLAYZ_logname, _x select 1, _x select 0];
						} else {
							//diag_log format ["%1 static spawn %2 (UID=%3): added to list", PLAYZ_logname, _x select 1, _x select 0];
							_staticVehSpawns = _staticVehSpawns + [_x];
						};
					};
				};
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


		// Zuerst alle Prio spawns
		{
			_newVeh = _x call PLAYZ_fnc_spawnVehicle;
			_iVehCreated = _iVehCreated + 1;
		} count _staticPrioVehSpawns;


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

		// Aufgeben: Es wurden keine spawn points gefunden.
		if( _dontSpawn || (count _newVehSpawn < 4) ) exitWith {diag_log format ["%1 no spawn points found.", PLAYZ_logname];};


		_objectUID = _newVehSpawn select 0;
		_type = _newVehSpawn select 1;
		_newVehWorldspace = _newVehSpawn select 2;
		_inventory = _newVehSpawn select 3;
		_hitpoints = _newVehSpawn select 4;

		_dir = _newVehWorldspace select 0;
		_pos = _newVehWorldspace select 1;
		_ownerID = "0";
		_damage = 0;
		_fuel = (round (random 40) + 5) / 100;


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
		_vehicles = _pos nearEntities ["AllVehicles", 10];
		if( count _vehicles > 0 ) then {_dontSpawn=true; diag_log format ["%1 find another spawn point (vehicle nearby)", PLAYZ_logname];};



		if( !_dontSpawn ) then {

			_newVeh = _newVehSpawn call PLAYZ_fnc_spawnVehicle;
			_iVehCreated = _iVehCreated + 1;

		} else {
			diag_log format ["%1 NOT SPAWNING ===> veh=%2 | type=%6 | damage=%3 | pos=%4 | posGps=%5", PLAYZ_logname, 0, _damage, _pos, mapGridPosition _pos, _type];
			diag_log format ["%1 objectID=%2 | objectUID=%3", PLAYZ_logname, _objectUID, _objectUID];
		};
	};


	
	diag_log format ["%1 # of veh=%2 | veh deleted=%3 | veh created=%4", PLAYZ_logname, _iVehTotal, _iVehDeleted, _iVehCreated];





	uiSleep PLAYZ_waitTimeBeforeNextRun;
};



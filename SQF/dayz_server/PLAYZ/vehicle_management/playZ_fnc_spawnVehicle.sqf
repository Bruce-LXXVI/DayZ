
private ["_newVeh", "_objectUID", "_type", "_newVehWorldspace", "_inventory", "_hitpoints", "_dir", "_pos", "_ownerID"
	, "_damage", "_fuel", "_isPrio", "_typePlayZ"
];

_objectUID = _this select 0;
_type = _this select 1;
_newVehWorldspace = _this select 2;
_inventory = _this select 3;
_hitpoints = _this select 4;

_dir = _newVehWorldspace select 0;
_pos = _newVehWorldspace select 1;
_ownerID = "0";
_damage = 0;
_fuel = (round (random 40) + 5) / 100;

_playerNear = ({isPlayer _x} count (_pos nearEntities [["CAManBase","Land","Air"], PLAYZ_playerDistance]) > 0);
_vehiceNear = (count (_pos nearEntities ["AllVehicles", PLAYZ_staticSpawnOtherVehicleDistance]) > 0);
_isResetter = ((parseNumber _objectUID) >= 280000000) && ((parseNumber _objectUID) < 290000000);
_isPrio =     ((parseNumber _objectUID) >= 290000000) && ((parseNumber _objectUID) < 300000000);
_hasMoved =   false;

if( !(_type in DayZ_SafeObjects) ) then { diag_log format ["%1 WARNING: Type %2 is not in DayZ_SafeObjects.", PLAYZ_logname, _type]; };

_typePlayZ = _type;
if( !isClass(configFile >> "CfgVehicles" >> _type) ) then {
	diag_log format ["%1 WARNING: class %2 not found.", PLAYZ_logname, _type];
	
	if( isClass(missionConfigFile >> "CfgVehicles" >> _type) ) then {
		_type = configName( inheritsFrom (missionConfigFile >> "CfgVehicles" >> _type) );
		diag_log format ["%1 %2 is a PlayZ classname. Spawning a %3.", PLAYZ_logname, _typePlayZ, _type];
	};
};


_newVeh = createVehicle [_type, _pos, [], 0, "NONE"];
_newVeh setDir _dir;
_newVeh setDamage _damage;
_newVeh setVariable ["lastUpdate", time];
_newVeh setVariable ["ObjectUID", _objectUID, true];
_newVeh setVariable ["ObjectID", _objectUID, true];
_newVeh setVariable ["CharacterID", _ownerID, true];
_newVeh setVariable ["PLAYZ_spawnpos", _pos, true];
_newVeh setVariable ["PLAYZ_classname", _typePlayZ, true];
_newVeh setVehicleVarName _objectUID;

// Zeit setzen
_newVeh setVariable ["PLAYZ_whenSpawned", round diag_tickTime, true];


//Dont add inventory for traps.
if( !(_newVeh isKindOf "TrapItems") && !(_newVeh iskindof "DZ_buildables") && (!PLAYZ_staticSpawnAlwaysEmpty || _isPrio) ) then {
	private ["_cargo", "_config", "_magItemTypes", "_magItemQtys", "_i"];
	_cargo = _inventory;
	clearWeaponCargoGlobal _newVeh;
	clearMagazineCargoGlobal _newVeh;
	clearBackpackCargoGlobal _newVeh;
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
} else 
{
	clearWeaponCargoGlobal _newVeh;
	clearMagazineCargoGlobal _newVeh;
	clearBackpackCargoGlobal _newVeh;
	_inventory=[[[],[]],[[],[]],[[],[]]];
};


{
	private ["_selection", "_dam"];
	_selection = _x select 0;
	_dam = _x select 1;
	
	// Use randomizer if part is definied as fully damaged by configuration (playZ_spawnpoints.sqf)
	if( PLAYZ_staticSpawnRandomCondition && (_dam == 1) ) then
	{
		private ["_rndmode"];
		_rndmode=round (random 100);
		if( _rndmode >= 90 ) then { _dam=0; };
		if( _rndmode <= 20 ) then { _dam=1; };
		if( (_rndmode > 20) && (_rndmode < 90) ) then { _dam=(round (random 100)) / 100; };
	};
	
	if( PLAYZ_staticSpawnFullyRepaired ) then { _dam=0; };
	
	if( (_selection in dayZ_explosiveParts and _dam > 0.8) && (!(_newVeh isKindOf "Air")) ) then { _dam=0.8; };
	
	[_newVeh,_selection,_dam] call fnc_veh_setFixServer;
} forEach _hitpoints;

_newVeh setvelocity [0,0,1];
_newVeh setFuel _fuel;
_newVeh call fnc_veh_ResetEH;

PZVM_handleVehicleManagement=_newVeh;
publicVariable "PZVM_handleVehicleManagement";

diag_log format ["%1 SPAWNING ===> veh=%2 | type=%6 | damage=%3 | pos=%4 | posGps=%5", PLAYZ_logname, _newVeh, _damage, getPosASL _newVeh, (mapGridPosition getPos _newVeh), _type];
diag_log format ["%1 objectID=%2 | objectUID=%3", PLAYZ_logname, _newVeh getVariable ["ObjectID","0"], _objectUID];

//dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _newVeh];
[_newVeh, "position", true] spawn server_updateObject;

PVDZ_obj_Publish = [_ownerID, _newVeh, [round getDir _newVeh, getPosATL _newVeh], _inventory, _hitpoints, _objectUID, damage _newVeh, fuel _newVeh];
publicVariableServer "PVDZ_obj_Publish";
diag_log [diag_ticktime, PLAYZ_logname, " New Networked object, request to save to hive. PVDZ_obj_Publish:", PVDZ_obj_Publish];

_newVeh


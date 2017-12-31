/*
 * PLAYZ_fnc_createVehicle: Spawn a vehicle on the server.
 *
 * Syntax _vehicle = [
 *	0	type				: String - vehicle/object className (or PLAYZ_classname)
 *	1	position/worldspace	: Position, Position2D or Object - Desired placement position / Array - [dir, position]
 *	2	markers				: Array - If the markers array contains several marker names, the position of a random one is used. Otherwise, the given position is used.
 *	3	placement			: Number - The vehicle is placed inside a circle with given position as center and placement as its radius
 *	4	special				: String - "NONE", "FLY", "FORM", "CAN_COLLIDE". "CAN_COLLIDE" creates the vehicle exactly where asked, not checking if others objects can cross its 3D model.
 *	5	UIDprefix			: String - first number in randomly generated UID (7=admin spawns, 9=AI vehicles, empty=temp vehicle)
 *	6	inventory			:
 *	7	hitpoints			:
 *	8	damage				:
 *	9	fuel				:
 *	10	ownerID				:
 *
 *
 *
 *
 *	] call PLAYZ_fnc_createVehicle;
 */


private [
	"_isTemp"			// temp vehicle, not stored in db, has no UID/ID
	,"_objectUID"		// UID for the new object
	,"_typePlayZ"		// PlayZ virtual type
	,"_type"			// real type
	,"_pos"				// position
	,"_dir"				// direction
	,"_markers"			// markers
	,"_placement"		// placement
	,"_special"			// special
	,"_inventory"		// inventory
	,"_hitpoints"		// hitpoints
	,"_damage"			// damage
	,"_fuel"			// fuel
	,"_ownerID"			// ownerID
	,"_newVeh"			// new created vehicle
];	


// generate objectUID if not given, check for persistance
_objectUID = [(_this select 5)] call PLAYZ_fnc_objectUID;
_isTemp = if( isNil "_objectUID" ) then {true} else {false};

if(_isTemp) then {_objectUID="0";};
diag_log format ["%1 PLAYZ_fnc_createVehicle ===> _objectUID=%2 | _isTemp=%3", PLAYZ_logname, _objectUID, _isTemp];

// check type
_typePlayZ = _this select 0;
_type = [_typePlayZ] call PLAYZ_fnc_realClassname;

// read worldspace
_pos = _this select 1;
if( (typeName _pos == "ARRAY") && (count _pos == 2) ) then {
	// worldspace given [dir, pos]
	_dir = _pos select 0;
	_pos = _pos select 1;
};

_markers = _this select 2;
_placement = _this select 3;
_special = _this select 4;

if( count _this > 6 ) then {
	_inventory = _this select 6;
	if(count _inventory != 3) then {
		_inventory=[[[],[]],[[],[]],[[],[]]];
	};
} else {
	_inventory=[[[],[]],[[],[]],[[],[]]];
};


_hitpoints = [_type, if( count _this > 7 ) then {_this select 7} else {nil}] call PLAYZ_fnc_getHitpoints;
if( count _this > 8 ) then {_damage = _this select 8;} else {_damage = 0;};
if( count _this > 9 ) then {_fuel = _this select 9;} else {_fuel = (round (random 40) + 5) / 100;};
if( count _this > 10 ) then {_ownerID = _this select 10;} else {_ownerID = "0";};


/*
_playerNear = ({isPlayer _x} count (_pos nearEntities [["CAManBase","Land","Air"], PLAYZ_playerDistance]) > 0);
_vehiceNear = (count (_pos nearEntities ["AllVehicles", PLAYZ_staticSpawnOtherVehicleDistance]) > 0);
_isResetter = ((parseNumber _objectUID) >= 280000000) && ((parseNumber _objectUID) < 290000000);
_isPrio =     ((parseNumber _objectUID) >= 290000000) && ((parseNumber _objectUID) < 300000000);
_hasMoved =   false;
*/

if( !(_type in DayZ_SafeObjects) ) then { diag_log format ["%1 WARNING: Type %2 is not in DayZ_SafeObjects.", PLAYZ_logname, _type]; };



_newVeh = createVehicle [_type, _pos, _markers, _placement, _special];
_newVeh setDir _dir;
_newVeh setDamage _damage;
_newVeh setVariable ["lastUpdate", time];
//if(!_isTemp) then {
	_newVeh setVariable ["ObjectUID", _objectUID, true];
	_newVeh setVariable ["ObjectID", _objectUID, true];
//};
_newVeh setVariable ["CharacterID", _ownerID, true];
_newVeh setVariable ["PLAYZ_spawnpos", _pos, true];
_newVeh setVariable ["PLAYZ_classname", _typePlayZ, true];
_newVeh setVehicleVarName format["%1 #%2", _typePlayZ, _objectUID];

// Zeit setzen
_newVeh setVariable ["PLAYZ_whenSpawned", round diag_tickTime, true];


//Dont add inventory for traps.
if( !(_newVeh isKindOf "TrapItems") && !(_newVeh iskindof "DZ_buildables") ) then {
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
	if ((_selection in dayZ_explosiveParts and _dam > 0.8) && (!(_newVeh isKindOf "Air"))) then {_dam = 0.8};
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
if(!_isTemp) then {
	[_newVeh, "position", true] spawn server_updateObject;
};

PVDZ_obj_Publish = [_ownerID, _newVeh, [round getDir _newVeh, getPosATL _newVeh], _inventory, player, dayz_authKey, _hitpoints, _objectUID, damage _newVeh, fuel _newVeh];
publicVariableServer "PVDZ_obj_Publish";
diag_log format ["%1 %2 New Networked object, request to save to hive. PVDZ_obj_Publish=%3", PLAYZ_logname, diag_ticktime, PVDZ_obj_Publish];

_newVeh


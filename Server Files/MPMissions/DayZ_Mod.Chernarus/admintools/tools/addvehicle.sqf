private ["_veh","_location","_isOk","_vehtospawn","_dir","_pos","_helipad",
"_keyColor","_keyNumber","_keySelected","_isKeyOK","_config","_player",
"_inventory","_hitpoints","_damage","_array","_allFixed","_hit","_selection","_objectUID","_typePlayZ"
];
_vehtospawn = _this select 0;
_player = player;
_dir = getdir vehicle _player;
_pos = getPos vehicle _player;
_pos = [(_pos select 0)+8*sin(_dir),(_pos select 1)+8*cos(_dir),0];
 
cutText ["Starting Spawn...", "PLAIN DOWN"];
/*
// First select key color
_keyColor = ["Green","Red","Blue","Yellow","Black"] call BIS_fnc_selectRandom;
 
// then select number from 1 - 2500
_keyNumber = (floor(random 2500)) + 1;
 
// Combine to key (eg.ItemKeyYellow2494) classname
_keySelected = format[("ItemKey%1%2"),_keyColor,_keyNumber]; 
_isKeyOK =  isClass(configFile >> "CfgWeapons" >> _keySelected); 
_config = _keySelected;
_isOk = [_player,_config] call BIS_fnc_invAdd;

waitUntil {!isNil "_isOk"};
*/
if ( 1==1 ) then {
 
	_dir = round(random 360); 
	_helipad = nearestObjects [_player, ["HeliHCivil","HeliHempty"], 100];

	if(count _helipad > 0) then {
		_location = (getPosATL (_helipad select 0));
	} else {
		_location = _pos;
	};
	
	if(count _location != 0) then {
		//place vehicle spawn marker (local)
		if(!(_vehtospawn in DayZ_SafeObjects)) then {
			diag_log format ["[EAT] WARNING: Type %1 is not in DayZ_SafeObjects.", _vehtospawn];
		};
/*
		_typePlayZ = _vehtospawn;
		if( !isClass(configFile >> "CfgVehicles" >> _vehtospawn) ) then {
			diag_log format ["%1 WARNING: class %2 not found.", "[EAT]", _vehtospawn];
			
			if( isClass(missionConfigFile >> "CfgVehicles" >> _vehtospawn) ) then {
				_vehtospawn = configName( inheritsFrom (missionConfigFile >> "CfgVehicles" >> _vehtospawn) );
				diag_log format ["%1 %2 is a PlayZ classname. Spawning a %3.", "[EAT]", _typePlayZ, _vehtospawn];
			};
		};
*/
		PLAYZ_server_createVehicle=[_vehtospawn, _location, [], 0, "CAN_COLLIDE", "7"];
		publicVariableServer "PLAYZ_server_createVehicle";
/*
		_veh = createVehicle [_vehtospawn, _location, [], 0, "CAN_COLLIDE"]; 
		_location = (getPosATL _veh);
		_veh setVariable ["lastUpdate", time];
		_veh setVariable ["CharacterID", "0", true];

		if( isNil "_objectUID" ) then {_objectUID = format ["7%1%2%3", abs round((random 90)+10), abs round((random 900)+100), abs round((random 900)+100)];};
		_veh setVariable ["ObjectUID", _objectUID, true ];
		_veh setVariable ["ObjectID", _objectUID, true ];
		_veh setVariable ["lastUpdate", time];
		_veh setVariable ["PLAYZ_classname", _typePlayZ, true];

		_inventory = [
			getWeaponCargo _veh,
			getMagazineCargo _veh,
			getBackpackCargo _veh
		];

		_hitpoints = _veh call vehicle_getHitpoints;
		_damage = damage _veh;
		_array = [];
		_allFixed = true;
		{
			_hit = [_veh,_x] call object_getHit;
			_selection = getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "HitPoints" >> _x >> "name");
			if (_hit > 0) then {
					_allFixed = false;
					_array set [count _array,[_selection,_hit]];
			} else {
					_array set [count _array,[_selection,0]]; 
			};
		} forEach _hitpoints;

		if (_allFixed) then {
			_veh setDamage 0;
		};

		//_veh call fnc_veh_ResetEH;
		//dayz_serverIDMonitor set [count dayz_serverIDMonitor, _objectUID];
		//dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _veh];
		//needUpdate_objects set [count needUpdate_objects, _veh];
		
		_veh call fnc_veh_ResetEH;

		PVDZ_obj_Publish = [0, _veh, [round getDir _veh, _location], _inventory, _array, _veh getVariable["objectUID", "0"], damage _veh, fuel _veh];
		publicVariable "PVDZ_obj_Publish";
		diag_log format ["[EAT]: New Networked object, request to save to hive. PVDZ_obj_Publish: %1", PVDZ_obj_Publish];

		if (!isServer) then {
			PVDZ_veh_Save = [_veh, "all", true];
			publicVariable "PVDZ_veh_Save";
		}
		else {
			[_veh, "all", true] call server_updateObject;
		};

		_player reveal _veh;
		*/
		cutText ["Vehicle spawned.", "PLAIN DOWN"];

		// Tool use logger
		if(logMajorTool) then {
			usageLogger = format["%1 %2 -- has spawned a permanent vehicle: %3",name _player,getPlayerUID _player,_vehtospawn];
			[] spawn {publicVariable "usageLogger";};
		};
	} else {
		//_removeitem = [_player, _config] call BIS_fnc_invRemove;
		cutText ["Could not find an area to spawn vehicle.", "PLAIN DOWN"];
	};
} else {
	cutText ["Your toolbelt is full.", "PLAIN DOWN"];
};

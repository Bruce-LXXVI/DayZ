private ["_victim","_vehicle","_unitGroup","_groupIsEmpty"];

_victim = _this select 0;
_unitGroup = _this select 1;
_groupIsEmpty = _this select 2;

_vehicle = _unitGroup getVariable ["assignedVehicle",objNull];
if (_groupIsEmpty) then {
	if (_vehicle isKindOf "LandVehicle") then {
		{_vehicle removeAllEventHandlers _x} count ["HandleDamage","Killed"];

		if(!DZAI_vehiclesLocked) then
		{
			_vehicle call fnc_veh_ResetEH;
			_vehicle setVehicleLock "UNLOCKED";
			diag_log format ["[DZAI]: Vehicle %1 is now unlocked.", _vehicle];
			[_vehicle] spawn {
				private ["_vehicle", "_hitpoints", "_damage", "_array", "_allFixed", "_hit", "_selection", "_inventory"];
				_vehicle = _this select 0;

				_inventory = [
					getWeaponCargo _vehicle,
					getMagazineCargo _vehicle,
					getBackpackCargo _vehicle
				];

				_hitpoints = _vehicle call vehicle_getHitpoints;
				_damage = damage _vehicle;
				_array = [];
				_allFixed = true;
				{
						_hit = [_vehicle,_x] call object_getHit;
						_selection = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "HitPoints" >> _x >> "name");
						if (_hit > 0) then {
								_allFixed = false;
								_array set [count _array,[_selection,_hit]];
						} else {
								_array set [count _array,[_selection,0]]; 
						};
				} forEach _hitpoints;

				if (_allFixed) then {
					_vehicle setDamage 0;
				};

				PVDZ_obj_Publish = [0, _vehicle, [round getDir _vehicle, getPosATL _vehicle], _inventory, _array, _vehicle getVariable["objectUID", "0"], damage _vehicle, (round (random 70) + 10) / 100 ];
				publicVariableServer "PVDZ_obj_Publish";
				diag_log format ["[DZAI]: New Networked object, request to save to hive. PVDZ_obj_Publish: %1", PVDZ_obj_Publish];

				/*
				waitUntil { _vehicle in dayz_serverObjectMonitor };
				sleep 5;
				diag_log format ["[DZAI]: Update object: %1", _vehicle];
				needUpdate_objects set [count needUpdate_objects, _vehicle];
				[_vehicle, "all", true] call server_updateObject;
				*/
			};
		};

		[_unitGroup,_vehicle] call DZAI_respawnAIVehicle;
		if (DZAI_debugLevel > 0) then {diag_log format ["DZAI Debug: AI vehicle patrol destroyed, adding vehicle %1 to cleanup queue.",(typeOf _vehicle)];};
	};
	_unitGroup setVariable ["GroupSize",-1];
} else {
	if (_victim getVariable ["isDriver",false]) then {
		_groupUnits = (units _unitGroup) - [_victim];
		_newDriver = _groupUnits call BIS_fnc_selectRandom2;	//Find another unit to serve as driver
		if (!isNil "_newDriver") then {
			_nul = [_newDriver,_vehicle] spawn {
				private ["_newDriver","_vehicle"];
				_newDriver = _this select 0;
				_vehicle = _this select 1;
				unassignVehicle _newDriver;
				_newDriver assignAsDriver _vehicle;
				if (_newDriver in _vehicle) then {
					_newDriver moveInDriver _vehicle;
				};
				[_newDriver] orderGetIn true;
				_newDriver setVariable ["isDriver",true];
				if (DZAI_debugLevel > 0) then {diag_log format ["DZAI Debug: Replaced driver unit for group %1 vehicle %2.",(group _newDriver),(typeOf _vehicle)];};
			};
		};
	};
};

true

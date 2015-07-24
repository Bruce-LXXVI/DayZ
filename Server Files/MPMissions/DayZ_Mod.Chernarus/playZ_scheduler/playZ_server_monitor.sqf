/*
	playZ Server Scheduler Initialization File
*/

private [ "_directoryAsArray"
		, "_iVehTotal"
		, "_iVehDeleted"
		, "_iVehCreated"
		, "_x","_damage"
		, "_pos"
		, "_posGps"
		, "_otime"
		, "_opos"
		, "_odamage"
];


if (!isServer || !isNil "PLAYZ_isActive") exitWith {};
PLAYZ_isActive = true;
PLAYZ_logname="[playZ]";
PLAYZ_playerDistance=50;


_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 25);
PLAYZ_directory = toString _directoryAsArray;
diag_log format ["%1 Initializing using base path %2.", PLAYZ_logname, PLAYZ_directory];

waitUntil{initialized};
uiSleep 60;

while {true} do {
	_iVehTotal = 0;
	_iVehDeleted = 0;
	_iVehCreated = 0;
	{
		if ( _x isKindOf "AllVehicles" ) then {
			_iVehTotal = _iVehTotal + 1;
			_damage = damage _x;
			_pos = getPosASL _x;
			_posGps = (mapGridPosition getPos _x);
			_objectID = _x getVariable ["ObjectID","0"];
			_objectUID = _x getVariable ["ObjectUID","0"];

			//diag_log format ["%1 ===> veh=%2 | damage=%3 | pos=%4 | posGps=%5", PLAYZ_logname, _x, _damage, _pos, _posGps];
			//diag_log format ["%1 objectID=%2 | objectUID=%3", PLAYZ_logname, _objectID, _newVehUID];

			// ist ein Spieler in der Nähe?
			_survivors = (position _x) nearEntities [["Survivor1_DZ","SurvivorW1_DZ","Survivor2_DZ","SurvivorW2_DZ","Camo1_DZ","Sniper1_DZ","Survivor3_DZ"],PLAYZ_playerDistance];


			if ( _damage == 1 ) then {
				if( count _survivors == 0 ) then {
					diag_log format ["%1 DELETING ===> veh=%2 | damage=%3 | pos=%4 | posGps=%5", PLAYZ_logname, _x, _damage, _pos, _posGps];
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




	if (_iVehTotal < 100) then {
		diag_log format ["%1 CREATING A VEHICLE", PLAYZ_logname];

		_newVehWorldspace = [223,[6288.416, 7834.3521,0]];
		_dir = _newVehWorldspace select 0;
		_pos = _newVehWorldspace select 1;
		_idKey = [_dir, _pos] call dayz_objectUID2;
		_ownerID = 0;
		_damage = 0;
		_hitpoints = [["palivo",1],["motor",1],["karoserie",1],["wheel_1_1_steering",1],["wheel_1_2_steering",1],["wheel_2_1_steering",1],["wheel_2_2_steering",1]];
		_fuel = 0.5;

		_type = "Ikarus";
		_inventory = [[[],[]],[["ItemSodaPeppsy"],[3]],[[],[]]];


		//_nObject = [0,0,0] nearestObject _idKey;


		// ist ein Spieler in der Nähe?
		_survivors = _pos nearEntities [["Survivor1_DZ","SurvivorW1_DZ","Survivor2_DZ","SurvivorW2_DZ","Camo1_DZ","Sniper1_DZ","Survivor3_DZ"],PLAYZ_playerDistance];

		if( count _survivors == 0 ) then {

			_newVeh = createVehicle [_type, _pos, [], 0, if (_type in DayZ_nonCollide) then {"NONE"} else {"CAN_COLLIDE"}];
			_newVeh setDir _dir;
			_newVeh setDamage _damage;
			_newVeh setVariable ["lastUpdate",time];
			_newVeh setVariable ["ObjectID", _idKey, true];
			_newVeh setVariable ["ObjectUID", _idKey, true];
			dayz_serverIDMonitor set [count dayz_serverIDMonitor,_idKey];
			_newVeh setVariable ["CharacterID", _ownerID, true];

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

			dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_newVeh];
			[_newVeh, _type] spawn server_updateObject;

			PVDZ_obj_Publish = [_ownerID, _newVeh, [round getDir _newVeh, getPosATL _newVeh], _inventory /*, _hitpoints*/];
			publicVariableServer "PVDZ_obj_Publish";
			diag_log [diag_ticktime, PLAYZ_logname, " New Networked object, request to save to hive. PVDZ_obj_Publish:", PVDZ_obj_Publish];

			_iVehCreated = _iVehCreated + 1;
		} else {
			diag_log format ["%1 find another spawn point (player nearby)", PLAYZ_logname];
		};
	};



	
	diag_log format ["%1 # of veh=%2 | veh deleted=%3 | veh created=%4", PLAYZ_logname, _iVehTotal, _iVehDeleted, _iVehCreated];





	uiSleep 30;
};



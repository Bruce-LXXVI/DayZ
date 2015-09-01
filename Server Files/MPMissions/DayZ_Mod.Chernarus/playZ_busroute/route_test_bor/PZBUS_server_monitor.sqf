/*
	playZ Server Busroute Initialization File
*/

private [ "_directoryAsArray"
		, "_busGroup"			// Gruppe
		, "_busGroupAggro"		// Gruppe, wenn in AGGRO-Modus
		, "_aggroMode"			// AGGRO-Modus true/false
		, "_busVehicle"			// Bus
		, "_busDriver"			// Der effektive Fahrer (wer sitzt im Fahrerhaus)
		, "_unitDriver"			// Der designierte Fahrer (wer sollte im Fahrerhaus sitzen)
		, "_wp"					// Waypoint
		, "_veh"				// Vehicle
		, "_unit"				// Unit
		, "_type"				// Type
];


// Beenden, wenn nicht auf dem Server oder Fahrzeug-Management bereits läuft.
if (!isServer) exitWith {};
//PZBUS_logname="[PZBUS]";

// Konfiguration einlesen
#include <PZBUS_config.sqf>

waitUntil{initialized};
uiSleep 40;

/*
_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 24);
PZBUS_directory = toString _directoryAsArray;
diag_log format ["%1 Initializing using base path %2.", PZBUS_logname, PZBUS_directory];
*/


PZBUS_fnc_setupUnit = {
	private ["_unit"];
	diag_log format ["%1 setting up %2", PZBUS_logname, _this];

	_unit = _this select 0;

	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
	_unit enableAI "MOVE";
	_unit enableAI "ANIM";
	_unit enableAI "FSM";
	//stop AI attacking bus
	_unit setCaptive true;
	_unit allowDamage true;

	//_unit setCombatMode "WHITE";
	//_unit setBehaviour "CARELESS";
	

	removeAllWeapons _unit;

};



// Wegpunkt-Kugeln setzen
{
	_veh = createVehicle ["Sign_sphere10cm_EP1", _x select 3, [], 0, "NONE"];
	if( (_x select 1) > 0) then {
		_veh setVariable ["ObjectUID", _x select 0, true];
	} else {
		_veh setVariable ["ObjectUID", _x select 0 + 100000, true];
	};
} forEach PZBUS_waypoints;


_aggroMode = false;
_busGroup=objNull;
_busGroupAggro=objNull;
_busVehicle=objNull;
_busDriver=objNull;
_unitDriver=objNull;


while {true} do {
	diag_log format ["%1 ======================================================", PZBUS_logname];
	

	if(isNil "_busGroup" || isNull _busGroup) then {
		diag_log format ["%1 Creating group _busGroup", PZBUS_logname];
		_busGroup = createGroup CIVILIAN;
		_busGroup setCombatMode "WHITE";
		_busGroup setBehaviour "CARELESS";
		_busGroup setSpeedMode "NORMAL";
		_busGroup allowFleeing 0;

		// Wegpunkte setzen
		{
			if( (_x select 1) > 0) then {
				diag_log format ["%1 Adding waypoint id %2: %3.", PZBUS_logname, _x select 0, _x select 3];
				_wp = _busGroup addWaypoint [_x select 3, PZBUS_waypoint_radius, _x select 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointTimeout [20, 30, 35];
				diag_log format ["%1 Waypoint Added: %2 at %3",PZBUS_logname, _x, _wp];
			} else {
				diag_log format ["%1 NOT ADDING DISABLED waypoint id %2: %3.", PZBUS_logname, _x select 0, _x select 3];
			};
		} forEach PZBUS_waypoints;
		
		// Create Loop Waypoint
		_wp setWaypointType "CYCLE";
	};
	
	if(isNil "_busGroupAggro" || isNull _busGroupAggro) then {
		diag_log format ["%1 Creating group _busGroupAggro", PZBUS_logname];
		_busGroupAggro = createGroup EAST;
		_busGroupAggro setCombatMode "RED";
		_busGroupAggro setBehaviour "COMBAT";
		_busGroupAggro setSpeedMode "NORMAL";
		_busGroupAggro allowFleeing 0;
	};


	// Der effektive Fahrer (wer sitzt im Fahrerhaus)
	_busDriver=objNull;
	if( !isNull _busVehicle ) then { _busDriver = driver _busVehicle; };

	_unitDriver=objNull;
	{ if( typeof _x in PZBUS_drivertype ) then {_unitDriver=_x;}; } forEach units _busGroup;


	diag_log format ["%1 Bus vehicle=%6 | driver=%5 | fuel=%3 | damage=%4 | pos=%2", PZBUS_logname, (mapGridPosition getPos _busVehicle), fuel _busVehicle, damage _busVehicle, _busDriver, _busVehicle];
	diag_log format ["%1 Group units=%2 | driver=%3", PZBUS_logname, count units _busGroup, _unitDriver];

	// Kein Bus => erstellen
	if( isNull _busVehicle ) then {
		diag_log format ["%1 No Vehicle. Creating one of type %2 at %3", PZBUS_logname, PZBUS_vehicletype, mapGridPosition ((PZBUS_waypoints select 0) select 3)];
		// Create Bus
		_busVehicle = createVehicle [PZBUS_vehicletype, (PZBUS_waypoints select 0) select 3, [], 0, "CAN_COLLIDE"];
		_busVehicle setDir ((PZBUS_waypoints select 0) select 2);
		_busVehicle setVariable ["ObjectUID", [getDir _busVehicle, getPos _busVehicle] call dayz_objectUID2, true];
		_busVehicle setFuel .3;
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _busVehicle];
		
		//_busVehicle allowDamage false;
		//_busVehicle addEventHandler ["HandleDamage", {false}];	
		_busVehicle setVariable ["axBusGroup", _busGroup, true];
		_busVehicle setVariable ["isAxeAIBus", 1, true];
		_busVehicle setVariable ["MalSar", 1, true];
		_busVehicle setVariable ["Sarge", 1, true];
		_busVehicle setVariable ["PlayZ_salvage_disabled", 1, true];

		clearWeaponCargoGlobal _busVehicle;
		clearMagazineCargoGlobal _busVehicle;
		clearBackpackCargoGlobal _busVehicle;
	};


	// Kein designierter Fahrer => erstellen
	if( (isNull _unitDriver) && (isNull _busDriver) ) then {
		_type = PZBUS_drivertype call BIS_fnc_selectRandom;
		diag_log format ["%1 No Driver. Creating one of type %2 at %3", PZBUS_logname, _type, (mapGridPosition getPos _busVehicle)];
		_unitDriver = _busGroup createUnit [_type, _busVehicle, [], 20, "CARGO"];
		[_unitDriver] call PZBUS_fnc_setupUnit;
		_unitDriver addweapon "G17_DZ";
		_unitDriver addMagazine "17Rnd_9x19_glock17";
		_unitDriver addMagazine "17Rnd_9x19_glock17";
		_unitDriver addMagazine "17Rnd_9x19_glock17";
		_unitDriver addMagazine "17Rnd_9x19_glock17";

		_unitDriver assignAsDriver _busVehicle;
		units _busGroup orderGetIn true;
	};


	// Gruppe zu klein => units erstellen
	diag_log format ["%1 Units in _busGroup: %2", PZBUS_logname, count units _busGroup];
	diag_log format ["%1 Units in _busGroupAggro: %2", PZBUS_logname, count units _busGroupAggro];
	while{ !_aggroMode && (count units _busGroup < PZBUS_groupsize) } do {
		_type = PZBUS_groupunittype call BIS_fnc_selectRandom;
		diag_log format ["%1 Group too small. Creating one of type %2 at %3", PZBUS_logname, _type, (mapGridPosition getPos _busVehicle)];
		_unit = _busGroup createUnit [_type, _busVehicle, [], 20, "CARGO"];
		[_unit] call PZBUS_fnc_setupUnit;
		_unit addweapon "M16A4_CCO_FL_DZ";
		_unit addMagazine "30Rnd_556x45_Stanag";
		_unit addMagazine "30Rnd_556x45_Stanag";
		_unit addMagazine "30Rnd_556x45_Stanag";
		_unit addMagazine "30Rnd_556x45_Stanag";

		_unit assignAsCargo _busVehicle;
		units _busGroup orderGetIn true;
	};


	// Kein effektiver Fahrer => einsteigen
	if( (isNull _busDriver) && (!isNull _unitDriver) && (!isNull _busVehicle) && (alive _busVehicle) ) then {
		diag_log format ["%1 Setting %2 as driver", PZBUS_logname, _unitDriver];
		_unitDriver assignAsDriver _busVehicle;
		{_x assignAsCargo _busVehicle} foreach (units _busGroup - [_unitDriver]);
		units _busGroup orderGetIn true;
	};


	// Kein Leader => ernennen
	if( (isNull leader _busGroup) && (count units _busGroup > 0) ) then {
		_unit = units _busGroup select 0;
		if( !isNull _unitDriver ) then {_unit=_unitDriver;};
		diag_log format ["%1 Setting as %2 as group leader", PZBUS_logname, _unit];
		_busGroup selectLeader _unit;
	};
	// Kein Leader => ernennen
	if( (isNull leader _busGroupAggro) && (count units _busGroupAggro > 0) ) then {
		_unit = units _busGroupAggro select 0;
		if( !isNull _unitDriver ) then {_unit=_unitDriver;};
		diag_log format ["%1 Setting as %2 as group leader", PZBUS_logname, _unit];
		_busGroupAggro selectLeader _unit;
	};


	// Tote units aus der Gruppe entfernen
	//{ if( !alive _x ) then { [_x] joinSilent grpNull;}; } forEach units _busGroup;




	// Fahrzeug ist zerstört
	if(!alive _busVehicle) then {
		diag_log format ["%1 Bus %2 is dead", PZBUS_logname, _busVehicle];
	} else {

		// Fahrzeug ist unbeweglich
		if(!canmove _busVehicle) then {
			diag_log format ["%1 Bus %2 is stuck", PZBUS_logname, _busVehicle];
			if( damage _busVehicle < 1 ) then { _busVehicle setDamage (round ((damage _busVehicle + 0.1) * 10)) / 10; };
		} else {
			// Fahrzeug auftanken
			if((fuel _busVehicle < 0.2) && (_unitDriver == _busDriver)) then {
				diag_log format ["%1 Fuelling Bus %2", PZBUS_logname, _busVehicle];
				_busVehicle setFuel 0.3;
			};
			
			// Fahrzeug reparieren
			if((canmove _busVehicle) && (damage _busVehicle > 0.2) && (_unitDriver == _busDriver)) then {
				diag_log format ["%1 Repairing Bus %2", PZBUS_logname, _busVehicle];
				_busVehicle setDamage 0;
			};
		};
	};

	// Gruppe wird aggro
	if( (!alive _busVehicle) || ((!alive _busDriver) && (!alive _unitDriver)) ) then {
		diag_log format ["%1 Group status: AGGRO", PZBUS_logname];
		_aggroMode = true;
		if( count units _busGroup > 0 ) then {
			{
				[_x] joinSilent _busGroupAggro;
				unassignVehicle _x;
			} forEach units _busGroup;
		};
		units _busGroupAggro orderGetIn false;
	} else {
		diag_log format ["%1 Group status: NORMAL", PZBUS_logname];
		_aggroMode = false;
		if( count units _busGroupAggro > 0 ) then {
			{
				[_x] joinSilent _busGroup;
				_x assignAsCargo _busVehicle;
			} forEach units _busGroupAggro;
		};
		units _busGroup orderGetIn true;
	};


	uiSleep PZBUS_waitTimeBeforeNextRun;
};





















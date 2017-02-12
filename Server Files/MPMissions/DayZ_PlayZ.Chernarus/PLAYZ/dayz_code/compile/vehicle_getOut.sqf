//[vehicle, position, unit]
//Quick fix for now.
private ["_vehicle","_position","_unit","_nearBuildables","_fencesArray,","_exitPosition","_intersectsWith","_playerPos"];

_vehicle = _this select 0;
_position = _this select 1;
_unit = _this select 2;

_fencesArray = ["WoodenFence_1","WoodenFence_2","WoodenFence_3","WoodenFence_4","WoodenFence_5","WoodenFence_6","WoodenFence_7","WoodenGate_1","WoodenGate_2","WoodenGate_3","WoodenGate_4"];


diag_log format["%1 vehicle_getOut.sql BEGIN", PLAYZ_logname];


// Get players current location and add 1m to z
_playerPos = ATLToASL (_unit modelToWorld [0,0,1]);
// Create Sphere for Player
_playerPosSphere = createVehicle ["Sign_sphere10cm_EP1", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_playerPosSphereColor = "#(argb,8,8,3)color(1,0,0,0.5,ca)";
_playerPosSphere setObjectTexture [0, _playerPosSphereColor];
_playerPosSphere setPosASL _playerPos;
diag_log format["%1 getPosASL _playerPosSphere (red) = %2 | _unit = %3", PLAYZ_logname, getPosASL _playerPosSphere, _unit];


// Create Arrow for vehicle
_vehiclePositionSphere = createVehicle ["Sign_arrow_down_EP1", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_vehiclePositionSphereColor = "#(argb,8,8,3)color(0,1,1,0.5,ca)";
_vehiclePositionSphere setObjectTexture [0, _vehiclePositionSphereColor];
_vehiclePositionSphere setPosASL (getPosASL _vehicle);
diag_log format["%1 getPosASL _vehiclePositionSphere (light blue) = %2 | _vehicle = %3", PLAYZ_logname, getPosASL _exitPositionSphere, _vehicle];




// Hopefully returns the xyz of the vehicle seat pos.
//_exitSeatPosition = _vehicle selectionPosition ("pos " + _position);
//_exitPosition = ATLToASL (_vehicle modelToWorld _exitSeatPosition);
// Create Sphere for position of seat
//_exitPositionSphere = createVehicle ["Sign_sphere10cm_EP1", [0, 0, 0], [], 0, "CAN_COLLIDE"];
//_exitPositionSphereColor = "#(argb,8,8,3)color(0,1,0,0.5,ca)";
//_exitPositionSphere setObjectTexture [0, _exitPositionSphereColor];
//_exitPositionSphere setPosASL _exitPosition;
//diag_log format["%1 getPosASL _exitPositionSphere (green) = %2 | _vehicle = %3 | _position = %4", PLAYZ_logname, getPosASL _exitPositionSphere, _vehicle, _position];
//diag_log format["%1 realtive _exitSeatPosition = %2", PLAYZ_logname, _exitSeatPosition];


// Get seat pos from aimPos
_aimPosition = aimPos _vehicle;
// Create Sphere for position of seat
_aimPositionSphere = createVehicle ["Sign_sphere10cm_EP1", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_aimPositionSphereColor = "#(argb,8,8,3)color(0,0,1,0.5,ca)";
_aimPositionSphere setObjectTexture [0, _aimPositionSphereColor];
_aimPositionSphere setPosASL _aimPosition;
diag_log format["%1 getPosASL _aimPositionSphere (blue) = %2 | _vehicle = %3", PLAYZ_logname, getPosASL _aimPositionSphere, _vehicle];

_seatPosition=_aimPosition;

if (_unit == player) then {
	//if (dayz_soundMuted) then {call player_toggleSoundMute;}; // Auto disable mute on vehicle exit (not a good idea without a sleep since rotor can be very loud when spinning down)
	//_buildables = count (_exitPosition nearObjects ["DZ_buildables", 3]);
	//Check player location to exit location
	_intersectsWith = lineIntersectsWith [_playerPos, _seatPosition, _unit, _vehicle, true];
	
	//_buildables = count ((getposATL _vehicle) nearObjects ["DZ_buildables", 3]);
	_nearBuildables = false;
	//Scan all intersected items for base items return with true false
	{
		if ((typeof _x) in _fencesArray) then {_nearBuildables=true};
	} count _intersectsWith;
	
	//if intersects find builditem make player reenter vehicel
	if (_nearBuildables) then {
		switch _position do {
			case ("driver"): { _unit action ["getInDriver", _vehicle]; };
			case ("cargo"): { _unit action ["getInCargo", _vehicle]; };
			case ("commander"): { _unit action ["getInCommmander", _vehicle]; };
			case ("gunner"): { _unit action ["getInGunner", _vehicle]; };
			case ("pilot"): { _unit action ["getInPilot", _vehicle]; };
			case ("turret"): { _unit action ["getInTurret", _vehicle]; };
		};

		//Log to server RPT (could give false pos) - should help admins see who is trying to abuse this.
		PVDZ_Server_LogIt = format["Player %1 exited a vehicle(%2) close to buildable object as %3",_unit, (typeof _vehicle), _position];
		publicVariableServer "PVDZ_Server_LogIt";

		localize "str_actions_exitBlocked" call dayz_rollingMessages;

	};
	
	
	//Lets make sure we can process some dmg from ejecting from the vehicle even traveling at lower speeds.
	if (((speed _vehicle) > 15) or ((speed _vehicle) < -10)) then {
		dayz_getout = _vehicle;
		dayz_getoutTime = diag_tickTime;
	};
};

//Debug Info
diag_log format["%1(%4) - %2 - %3, (playerPos: %5, ExitPos: %6, IntersectsWith: %7)",_vehicle,_position,_unit,(speed _vehicle),_playerPos,_exitPosition,_intersectsWith];
diag_log format["%1 vehicle_getOut.sql END", PLAYZ_logname];


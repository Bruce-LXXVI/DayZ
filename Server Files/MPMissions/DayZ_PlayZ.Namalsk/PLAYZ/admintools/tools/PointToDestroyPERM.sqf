private ["_vehicle","_type","_name","_hitpoints","_player"];

_vehicle = cursorTarget;
_type = typeOf _vehicle;
_name = getText(configFile >> "cfgVehicles" >> _type >> "displayName");
_hitpoints = _vehicle call vehicle_getHitpoints;
_player = player;


{
	private ["_damage","_selection"];
	_damage = [_vehicle,_x] call object_getHit;

	if ( (_damage < 1) && ( (_vehicle isKindOf "Air") || (_vehicle isKindOf "LandVehicle") ) ) then {
		_selection = getText(configFile >> "cfgVehicles" >> _type >> "HitPoints" >> _x >> "name");
		//[_vehicle, _selection, 1, true] call fnc_veh_handleRepair;
		PVDZ_veh_SF = [_vehicle, _selection, 1, true];
		publicVariableServer "PVDZ_veh_SF";
	};
} count _hitpoints;


_vehicle setDamage 1;
//_vehicle setVectorUp [0, 0, -1];
//_vehicle setFuel 0;
//_vehicle setVehicleAmmo 0;
//_vehicle setVelocity [0,0,1];


titleText [format["%1 permanently destroyed.", _name], "PLAIN DOWN"]; titleFadeOut 3;

// Tool use logger
if(logMinorTool) then {
	usageLogger = format["%1 %2 -- has permanently destroyed %3",name _player,getPlayerUID _player,_vehicle];
	[] spawn {publicVariable "usageLogger";};
};

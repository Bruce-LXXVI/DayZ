private ["_vehicle","_type","_name","_hitpoints","_player"];

_vehicle = cursorTarget;
_type = typeOf _vehicle;
_name = getText(configFile >> "cfgVehicles" >> _type >> "displayName");
_hitpoints = _vehicle call vehicle_getHitpoints;
_player = player;

_vehicle setVehicleLock "LOCKED";
//_vehicle setFuel 1;
//_vehicle setVehicleAmmo 1;
//_vehicle setVelocity [0,0,1];
titleText [format["%1 LOCKED.", _name], "PLAIN DOWN"]; titleFadeOut 3;

// Tool use logger
if(logMinorTool) then {
	usageLogger = format["%1 %2 -- has been LOCKED %3",name _player,getPlayerUID _player,_vehicle];
	[] spawn {publicVariable "usageLogger";};
};

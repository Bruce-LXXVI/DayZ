// by Mattz for DayZ (C) (Edited by OloX)
private ["_object","_type","_vehName","_isVeh","_isCar","_isAir","_isBike","_isVPlay","_fuelMass","_startSleep","_pos","_s"];
_object = _this select 0;
_pos = getpos _object;

{
	_object = _x;
} forEach ( (_pos) nearEntities [["Car", "Air", "Motorcycle"], 1] );

_type = typeof _object;
_isCar = _object isKindOf "Car";
_isAir = _object isKindOf "Air";
_isBike = _object isKindOf "Motorcycle";
_fuelMass = 0.01;
_startSleep = 6;
_isVeh = false;
_isVPlay = false;

if (_isCar) then { 
	_fuelMass = 0.03;
	_startSleep = 7;	
	_isVeh = true;
};

if (_isAir) then { 
	_fuelMass = 0.008;
	_startSleep = 20;	
	_isVeh = true;	
};

if (_isBike) then { 
	_fuelMass = 0.04;
	_startSleep = 5;	
	_isVeh = true;	
};

if (!_isVeh) exitWith {};

_vehName = getText (configFile >> "CfgVehicles" >> _type >> "displayName");

if(player in _object) then {
	_isVPlay = true;
};

if (!alive _object) exitWith {};
_object engineOn false;
if(_isVPlay) then { cutText ["Gas Station driveway...", "PLAIN DOWN"]; };
sleep 3;
if (!alive _object) exitWith {};
if(_isAir) then {
	if(_isVPlay) then { cutText ["You are in a heli, you have 10 seconds to shut off the engine", "PLAIN DOWN"]; };
	sleep 2;
	for "_i" from 1 to 10 do {
		if(isEngineOn _object) then {
			if(_i == 1) then { _s = ""; } else { _s = "s"; };
			if(_isVPlay) then { cutText [format ["%1 second%2",_i, _s], "PLAIN DOWN"]; };
			sleep 1;
		} else {
			exit;
		};
	};
	if(isEngineOn _object) exitWith { if(_isVPlay) then { cutText ["Refueling failed!", "PLAIN DOWN"]; }; };	
};
_object engineOn false;

_wTxt = "Preparing Refueling";
for "_i" from 1 to _startSleep do {
	if (!alive _object) exitWith {};
	_wTxt = _wTxt + ".";
	if(_isVPlay) then { cutText [_wTxt, "PLAIN DOWN"]; };
	sleep 1;
};
if (!alive _object) exitWith {};
_OnOff = isEngineOn _object; //Determine if engine is on or off and set it to _OnOff
if (_OnOff) then
{exit;}
 else {
	if(_isVPlay) then { cutText [format ["Filling %1... Please wait...", _vehName], "PLAIN DOWN"]; };
};
_OnOff = isEngineOn _object; //Determine if engine is on or off
if (_OnOff) then
{
exit;
}
else {
_OnOff = isEngineOn _object; //Determine if engine is on or off;
while {(fuel _object < 0.99) && (!_OnOff)}do{
                _object setFuel fuel _object + _fuelMass;
                sleep 1;
                _OnOff = isEngineOn _object;
                };
        };
if (!alive _object) exitWith {};
if (fuel _object < 0.99) then
{
if(_isVPlay) then { cutText [format ["%1 is not ready as you left before it was full...", _vehName], "PLAIN DOWN"]; };
}
else{
if(_isVPlay) then { cutText [format ["%1 is ready...", _vehName], "PLAIN DOWN"]; };
};
if (true) exitWith {};
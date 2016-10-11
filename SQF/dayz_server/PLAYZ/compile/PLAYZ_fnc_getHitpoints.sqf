/*
 * PLAYZ_fnc_getHitpoints: Reads the hitpoints of a vehicle
 *
 * Syntax _type = [
 *	0	type				: String - classname
 *	1	hitpoints			: Array or nil
 *	] call PLAYZ_fnc_getHitpoints;
 *

 */


private [
	"_cfgHitPoints"
	,"_type"		// real type
	,"_hps"
	,"_funcGetHitPoints"
];

_type = _this select 0;
_cfgHitPoints = configFile >> "CfgVehicles" >> _type >> "HitPoints";
_hps = [];

_funcGetHitPoints = 
{
	for "_i" from 0 to ((count _this) - 1) do 
	{
		private ["_hp"];
		_hp = configName (_this select _i);
		
		if (!(_hp in _hps)) then 
		{
			_hps set [count _hps, [_hp, 0]];
		};
	};
};


if( isNil{_this select 1} ) then {
	//Explore inheritance structure fully
	while {(configName _cfgHitPoints) != ""} do 
	{
		_cfgHitPoints call _funcGetHitPoints;
		_cfgHitPoints = inheritsFrom _cfgHitPoints;
	};
	diag_log format ["%1 using read hitpoints %2", PLAYZ_logname, _hps];
} else {
	_hps = _this select 1;
	diag_log format ["%1 using provided hitpoints %2", PLAYZ_logname, _hps];
};

_hps

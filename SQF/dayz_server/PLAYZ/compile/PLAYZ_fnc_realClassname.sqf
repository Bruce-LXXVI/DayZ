/*
 * PLAYZ_fnc_realClassname: Determines the real classname out of a PLAYZ_classname
 *
 * Syntax _type = [
 *	0	_typePlayZ			: String - classname (PLAYZ or Arma)
 *	] call PLAYZ_fnc_realClassname;
 *

 */


private [
	"_inUID"		// UID for the new object
	,"_typePlayZ"	// PlayZ virtual type
	,"_type"		// real type
];


_typePlayZ = _this select 0;
_type = _typePlayZ;
if( !isClass(configFile >> "CfgVehicles" >> _type) ) then {
	//diag_log format ["%1 WARNING: class %2 not found.", PLAYZ_logname, _type];
	
	if( isClass(missionConfigFile >> "CfgVehicles" >> _type) ) then {
		_type = configName( inheritsFrom (missionConfigFile >> "CfgVehicles" >> _type) );
		diag_log format ["%1 %2 is a PlayZ classname. Spawning a %3.", PLAYZ_logname, _typePlayZ, _type];
	};
};


_type

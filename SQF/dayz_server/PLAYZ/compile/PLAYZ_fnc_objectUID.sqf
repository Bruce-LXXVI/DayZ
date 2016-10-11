/*
 * PLAYZ_fnc_objectUID: Check or generate a random UID.
 *
 * Syntax _objectUID = [
 *	0	inUID				: String - objectUID or UIDprefix or nil
 *	] call PLAYZ_fnc_objectUID;
 *
 *
 * Prefix | Meaning
 *     1  | Generated by data base (reserved)
 *     2  | Static spawns
 *     28 | Reset vehicle (despawns automatically) ! NOT YET IMPLEMENTED !
 *     29 | Priority vehicle (vehicle spawns immediately if gone)
 *     7  | Admin spawns
 *     8  | 
 *     9  | AI vehicle
 */


private [
	"_inUID"		// UID for the new object
	,"_inUIDNum"	// UID for the new object (after parseNumber)
	,"_objectUID"	// return value
];

_inUID = _this select 0;
// Temp vehicle is a "Reset vehicle"
_inUIDNum = if( isNil "_inUID" ) then { 28 } else { parseNumber _inUID };
if( _inUIDNum >= 200000000 ) then {
	// real UID given => seems to be a permanent vehicle
	_objectUID = _inUID;
} else {
	if( (_inUIDNum > 0) && (_inUIDNum < 100) ) then {
		// UID prefix given => create random UID for this permanent vehicle
		if(_inUIDNum < 10) then {
			_objectUID = format ["%1%2%3%4", _inUIDNum, abs round((random 90)+10), abs round((random 900)+100), abs round((random 900)+100)];
		} else {
			_objectUID = format ["%1%2%3%4", _inUIDNum, abs round((random 90)+10), abs round((random 90)+10), abs round((random 900)+100)];
		};
	} else {
		// no UID/prefix given => create temporary vehicle
		_objectUID = nil;
	};

};

_objectUID


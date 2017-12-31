#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

private ["_type","_objectUID","_characterID","_object","_worldspace","_key","_ownerArray","_inventory","_clientKey","_exitReason","_player","_playerUID"
	, "_hitpoints", "_damage", "_fuel", "_typePlayZ"
];

if (count _this < 6) exitWith {diag_log "Server_PublishObj error: Wrong parameter format";};

_characterID =		_this select 0;
_object = 		_this select 1;
_worldspace = 	_this select 2;
_inventory = 		_this select 3;
_player = _this select 4;
_clientKey = _this select 5;

if(count _this > 6) then {_hitpoints = 	_this select 6;};
if(count _this > 7) then {_objectUID = 	_this select 7;};
if(count _this > 8) then {_damage = 	_this select 8;};
if(count _this > 9) then {_fuel = 		_this select 9;};

_type = typeOf _object;

_typePlayZ = _object getVariable ["PLAYZ_classname", ""];
if( (_typePlayZ != "") && (_typePlayZ != _type) ) then {
	_type = _typePlayZ;
	if(isNil "PZC_handlePlayZClass") then {PZC_handlePlayZClass = [];};
	if( !(_object in PZC_handlePlayZClass) ) then {
		PZC_handlePlayZClass set [count PZC_handlePlayZClass, _object];
		publicVariable "PZC_handlePlayZClass";
	};
};

_playerUID = getPlayerUID _player;

_exitReason = [_this,"PublishObj",(_worldspace select 1),_clientKey,_playerUID,_player] call server_verifySender;
if (_exitReason != "") exitWith {diag_log _exitReason};

if ([_object, "Server"] call check_publishobject) then {
	//diag_log ("PUBLISH: Attempt " + str(_object));

	if( isNil "_hitpoints" ) then {_hitpoints=[];};
	if( isNil "_objectUID" ) then {_objectUID = _worldspace call dayz_objectUID2;};
	_object setVariable [ "ObjectUID", _objectUID, true ];
	
	if( isNil "_damage" ) then {_damage=0;};
	if( isNil "_fuel" ) then {_fuel=0;};
	
	// we can't use getVariable because only the object creation is known from the server (position,direction,variables are not sync'ed yet)
	//_characterID = _object getVariable [ "characterID", 0 ];
	//_ownerArray = _object getVariable [ "ownerArray", [] ];
	_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:", dayZ_instance, _type, _damage, _characterID, _worldspace, _inventory, _hitpoints, _fuel, _objectUID];

	_key call server_hiveWrite;

	if (_object isKindOf "CamoNet_DZ" || _object isKindOf "DZ_storage_base") then {
		_object addMPEventHandler ["MPKilled",{_this call vehicle_handleServerKilled;}];
	};
	if (_object iskindof "DZ_buildables") then {
		_object addMPEventHandler ["MPKilled",{_this call vehicle_handleServerKilled;}];
	};

	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];

	diag_log format["PUBLISH: Player %1(%2) created %3 with UID:%4 CID:%5 @%6 inventory:%7",(_player call fa_plr2str),_playerUID,_type,_objectUID,_characterID,((_worldspace select 1) call fa_coor2str),_inventory];
}
else {
	diag_log ("PUBLISH: *NOT* created " + (_type ) + " (not allowed)");
};

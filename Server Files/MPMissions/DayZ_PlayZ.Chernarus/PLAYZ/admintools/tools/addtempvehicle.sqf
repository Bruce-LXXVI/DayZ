private ["_veh","_dist","_vehtospawn","_dir","_pos","_player"];

_vehtospawn = _this select 0; 
_dist = 7;
_player = player;
_dir = getDir vehicle _player;
_pos = getPosATL vehicle _player;
_pos = [(_pos select 0)+_dist*sin(_dir),(_pos select 1)+_dist*cos(_dir),0];
_worldspace = [_dir,_pos];


PLAYZ_server_createVehicle=[_vehtospawn, _pos, [], 0, "CAN_COLLIDE"];
publicVariableServer "PLAYZ_server_createVehicle";

/*
_veh = createVehicle [_vehtospawn, _pos, [], 0, "CAN_COLLIDE"];
_veh setVariable ["MalSar", 1, true];
_veh setVariable ["PLAYZ_classname", _typePlayZ, true];
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;

if( (_typePlayZ != "") && (_typePlayZ != _vehtospawn) ) then {
	if(isNil "PZC_handlePlayZClass") then {PZC_handlePlayZClass = [];};
	PZC_handlePlayZClass set [count PZC_handlePlayZClass, _veh];
	publicVariable "PZC_handlePlayZClass";
};
*/
cutText ["Spawned a vehicle.", "PLAIN DOWN"];

// Tool use logger
if(logMinorTool) then {
	usageLogger = format["%1 %2 -- has spawned a temporary vehicle: %3",name _player,getPlayerUID _player,_vehtospawn];
	[] spawn {publicVariable "usageLogger";};
};

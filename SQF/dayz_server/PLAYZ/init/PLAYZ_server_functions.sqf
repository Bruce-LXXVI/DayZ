/*
 * Initialize the server functions used by PLAYZ extension
 */

waituntil {!isnil "bis_fnc_init"};
diag_log format ["%1 Initializing server functions", PLAYZ_logname];


// Create a random object UID
PLAYZ_fnc_objectUID =		compile preprocessFileLineNumbers "\z\addons\dayz_server\PLAYZ\compile\PLAYZ_fnc_objectUID.sqf";

// Determines the real classname out of a PLAYZ_classname
PLAYZ_fnc_realClassname =	compile preprocessFileLineNumbers "\z\addons\dayz_server\PLAYZ\compile\PLAYZ_fnc_realClassname.sqf";

// Reads the hitpoints of a vehicle class
PLAYZ_fnc_getHitpoints =	compile preprocessFileLineNumbers "\z\addons\dayz_server\PLAYZ\compile\PLAYZ_fnc_getHitpoints.sqf";

// Spawns a vehicle on the server
PLAYZ_fnc_createVehicle =	compile preprocessFileLineNumbers "\z\addons\dayz_server\PLAYZ\compile\PLAYZ_fnc_createVehicle.sqf";


/* DZGM */
currentInvites = [];
publicVariable "currentInvites";
"currentInvites" addPublicVariableEventHandler {publicVariable "currentInvites";};
/* DZGM */

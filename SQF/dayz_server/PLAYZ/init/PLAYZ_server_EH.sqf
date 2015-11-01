/*
 * Initialize the server public variable event handlers used by PLAYZ extension
 */

diag_log format ["%1 Initializing server EH", PLAYZ_logname];

"PLAYZ_server_createVehicle" addPublicVariableEventHandler {(_this select 1) call PLAYZ_fnc_createVehicle};
//"PLAYZ_server_createVehicle" addPublicVariableEventHandler {(_this select 1) spawn PLAYZ_fnc_createVehicle};

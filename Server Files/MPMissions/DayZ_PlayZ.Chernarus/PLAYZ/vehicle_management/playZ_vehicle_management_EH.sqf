/*
	playZ vehicle management event handler
*/

// Beenden, wenn auf dem Server oder läuft bereits.
if (isServer || !isNil "PZVM_isActive") exitWith {};
PZVM_isActive = true;
PZVM_logname="[PZVM]";



PZVM_fnc_handleVehicleManagement={
	//diag_log format ["%1 vehicle management event handler %2", PZVM_logname, _this];
	_this call fnc_veh_ResetEH;
	player reveal _this;
};

"PZVM_handleVehicleManagement" addPublicVariableEventHandler {(_this select 1) call PZVM_fnc_handleVehicleManagement};
if(!isNil "PZVM_handleVehicleManagement") then {PZVM_handleVehicleManagement call PZVM_fnc_handleVehicleManagement;};



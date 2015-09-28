

if (!isDedicated) then {
	fnc_usec_selfActions = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\fn_selfActions.sqf";		//Checks which actions for self
	player_switchModel = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\player_switchModel.sqf";
	player_selectSlot = compile preprocessFileLineNumbers "PLAYZ\dayz_code\compile\ui_selectSlot.sqf";
};


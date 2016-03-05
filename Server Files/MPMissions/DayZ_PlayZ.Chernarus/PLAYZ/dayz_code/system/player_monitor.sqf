if (isServer) then {
	waitUntil{dayz_preloadFinished};
};
diag_log format["[PLAYZ] Executing player_monitor.fsm"];
_id = [] execFSM "PLAYZ\dayz_code\system\player_monitor.fsm";

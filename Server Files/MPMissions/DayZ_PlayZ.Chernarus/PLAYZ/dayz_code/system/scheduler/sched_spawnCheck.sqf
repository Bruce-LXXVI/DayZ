#include "scheduler.hpp"

sched_spawnCheck_init = { []spawn{} };
sched_spawnCheck = {
	HIDE_FSM_VARS
	if (scriptDone _this) then {
		_this = [] execVM 'PLAYZ\dayz_code\compile\player_spawnCheck.sqf';  // stuffed with "sleep" commands, can't put it in scheduler
	};
	_this;
};

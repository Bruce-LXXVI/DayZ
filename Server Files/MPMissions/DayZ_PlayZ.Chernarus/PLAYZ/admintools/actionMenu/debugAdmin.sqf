
if (isNil 'PLAYZ_debugMonitor') then {
	PLAYZ_debugMonitor = true;
	_nill = execvm "PLAYZ\debug_monitor\playZ_debug_monitor.sqf";
} else {
	PLAYZ_debugMonitor = !PLAYZ_debugMonitor;
	hintSilent "";
	_nill = execvm "PLAYZ\debug_monitor\playZ_debug_monitor.sqf";
};


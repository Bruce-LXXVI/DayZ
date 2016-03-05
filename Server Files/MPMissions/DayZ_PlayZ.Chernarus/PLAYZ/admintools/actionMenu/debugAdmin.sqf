
if (isNil 'debugMonitor') then {
	debugMonitor = true;
	_nill = execvm "custom\debug_monitor.sqf";
} else {
	debugMonitor = !debugMonitor;
	hintSilent "";
	_nill = execvm "custom\debug_monitor.sqf";
};


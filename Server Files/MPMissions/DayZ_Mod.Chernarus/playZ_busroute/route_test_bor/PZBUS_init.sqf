
private [ "_directoryAsArray"
];

PZBUS_logname="[PZBUS]";
_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 15);
PZBUS_directory = toString _directoryAsArray;
diag_log format ["%1 Initializing using base path %2.", PZBUS_logname, PZBUS_directory];


if (isServer) then {
	//Bus Route
	[] execVM format["%1\PZBUS_server_monitor.sqf", PZBUS_directory];
};


if (!isDedicated) then {
	//Bus Route
	//[] execVM "playZ_busroute_client_monitor.sqf";
};


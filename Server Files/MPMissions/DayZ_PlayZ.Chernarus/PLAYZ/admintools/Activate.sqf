


if(isServer) exitWith {diag_log format ["%1 not starting on server.", EAT_logname];};

//diag_log format ["%1 Waiting for dayz_animalCheck.", EAT_logname];
//waitUntil {!isNil "dayz_animalCheck"}; // Wait for the character to load all required items
//diag_log format ["%1 dayz_animalCheck OK. Now waiting for keyboard_keys.", EAT_logname];
//waitUntil {!isNil "keyboard_keys"};
//diag_log format ["%1 keyboard_keys OK. Starting...", EAT_logname];
waitUntil { getPlayerUID player != "" };
diag_log format ["%1 getPlayerUID player OK (%2). Starting...", EAT_logname, getPlayerUID player];

// Give players action menu
if((ActionMenuPlayers && !((getPlayerUID player) in AdminAndModList)) || (ActionMenuAdmins && ((getPlayerUID player) in AdminAndModList))) then {
	[] spawn {
		_idx = -1;
		_veh = vehicle player;

		while {alive player} do {
			if(_idx == -1) then {
				_idx = (vehicle player) addaction [("<t color=""#FE9A2E"">" + ("Action Menu") + "</t>"),format["%1\actionMenu\ActionsMenu.sqf", EAT_directory],"",-107,false,true,"",""];
				_veh = vehicle player;
			};
			if (_veh != vehicle player) then
			{
				_veh removeAction _idx;
				_idx = -1;
			};
			Sleep 2;
		};
	};
};


// Give admins the admin menu
if ((getPlayerUID player) in AdminAndModList) then {
	[] spawn {
		_idx = -1;
		_veh = vehicle player;

		// Load key macros
		[] execVM format ["%1\KeyBindings\FunctionKeys.sqf", EAT_directory];
		[] execVM format ["%1\KeyBindings\NumberKeys.sqf", EAT_directory];
		
		// Tool use logger
		if(logMajorTool || logMinorTool) then {
			usageLogger = format["%1 %2 -- has logged on",name player,getPlayerUID player];
			[] spawn {publicVariable "usageLogger";};
		};

		while {alive player} do
		{
			if (_idx == -1) then
			{
				_idx = (vehicle player) addaction [("<t color=""#585858"">" + ("Admin Menu") +"</t>"),format ["%1\AdminToolsMain.sqf", EAT_directory],"",7,false,true,"",""];
				_veh = vehicle player;
			};
			if (_veh != vehicle player) then
			{
				_veh removeAction _idx;
				_idx = -1;
			};
			Sleep 2;
		};
		
		_veh removeAction _idx;
		_idx = -1;
	};
};
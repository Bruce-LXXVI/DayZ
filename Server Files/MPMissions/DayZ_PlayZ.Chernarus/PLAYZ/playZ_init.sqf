


/************************************************************************************
 * run always                                                                       *
 ************************************************************************************/
PLAYZ_logname="[PLAYZ]";
PLAYZ_worldname=toLower worldName;

diag_log format["%1 Initializing PLAYZ EXTENSION for world %2", PLAYZ_logname, PLAYZ_worldname];

// Initialize (Epoch) Admin Tool config file and variables
call compile preprocessFileLineNumbers "PLAYZ\admintools\config_playZ.sqf";
call compile preprocessFileLineNumbers "PLAYZ\admintools\variables.sqf";


/*
if( PLAYZ_worldname == "chernarus" ) then
{
	if (dayz_POIs) then
	{
		[] execVM "\z\addons\dayz_code\system\mission\chernarus\poi\DevilsFarm.sqf";
		[] execVM "\z\addons\dayz_code\system\mission\chernarus\poi\NEA.sqf";
		[] execVM "\z\addons\dayz_code\system\mission\chernarus\poi\C130Crash.sqf";
		[] execVM "\z\addons\dayz_code\system\mission\chernarus\poi\ChernoBuildings.sqf";
		[] execVM "PLAYZ\dayz_code\system\mission\chernarus\poi\DeadForest.sqf";
		[] execVM "PLAYZ\dayz_code\system\mission\chernarus\poi\KomyshovoRoadblock.sqf";
		[] execVM "\z\addons\dayz_code\system\mission\chernarus\poi\MilitaryAirpoort.sqf";
		[] execVM "PLAYZ\dayz_code\system\mission\chernarus\poi\ZelenogorskBuildings.sqf";
		[] execVM "\z\addons\dayz_code\system\mission\chernarus\poi\Twains.sqf";
	};
};
*/

/************************************************************************************
 * run on all player clients incl. player host and headless clients                 *
 ************************************************************************************/
if (!isDedicated) then
{
	// Activate (Epoch) Admin Tool
	[] execVM "PLAYZ\admintools\Activate.sqf";

	// Initialize DZAI Client module
	//_nul = [] execVM "PLAYZ\DZAI_Client\dzai_initclient.sqf";

	// Initialize Group Management
	// TODO: move to PLAYZ Directory 
	//execVM "dzgm\init.sqf";

	// Initialize playZ virtual classnames player event handler
	execVM "PLAYZ\virtual_classnames\playZ_virtual_classnames_player_EH.sqf";

	// Initialize debug monitor
	execVM "PLAYZ\debug_monitor\playZ_debug_monitor.sqf";

	// Initialize side voice kicker
	//execVM "PLAYZ\antisidevoice\playZ_antisidevoice_player_monitor.sqf";

	// Initialize kicker
	//execVM "PLAYZ\kicker\playZ_kicker_player_monitor.sqf";

	if( PLAYZ_worldname == "chernarus" ) then
	{
		// Initialize Public Bus Route player monitor
		//[true] execVM "PLAYZ\busroute\chernarus\player_axeBus.sqf";
	};
};


/************************************************************************************
 * run on dedicated server or player host                                           *
 ************************************************************************************/
if (isServer) then
{
	// Initialize the server functions used by PLAYZ extension
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\PLAYZ\init\PLAYZ_server_functions.sqf";
	// Initialize the server public variable event handlers used by PLAYZ extension
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\PLAYZ\init\PLAYZ_server_EH.sqf";

	execVM "\z\addons\dayz_server\PLAYZ\vehicle_management\playZ_vehicle_management_server_monitor.sqf";
	
	if( PLAYZ_worldname == "chernarus" ) then
	{
		// Initialize Public Bus Route
		//[true] execVM "\z\addons\dayz_server\PLAYZ\busroute\chernarus\init_bus.sqf";

		// Custom mapaddons
		//[] execVM "\z\addons\dayz_server\PLAYZ\mapaddons\chernarus\init.sqf";
	};
};


/************************************************************************************
 * run on dedicated server only                                                     *
 ************************************************************************************/
if (isDedicated) then
{
};


/************************************************************************************
 * run on all player clients incl. player host                                      *
 ************************************************************************************/
if (hasInterface) then
{
};


/************************************************************************************
 * run on all player clients incl. headless clients but not player host             *
 ************************************************************************************/
if (!isServer) then
{
};


/************************************************************************************
 * run on headless clients and dedicated server                                     *
 ************************************************************************************/
if (!hasInterface) then
{
};


/************************************************************************************
 * run on headless clients only                                                     *
 ************************************************************************************/
if (!hasInterface && !isDedicated) then
{
};

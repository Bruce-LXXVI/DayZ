	private ["_axeBusUnit","_firstRun","_dir","_axWPZ","_unitpos","_rndLOut","_ailoadout","_aiwep","_aiammo","_axeBus","_axeBusGroup","_axeBuspawnpos","_axeBusWPradius","_axeBusWPIndex","_axeBusFirstWayPoint","_axeBusWP","_axeBusRouteWaypoints","_axeBusDriver","_axeBusLogicGroup","_axeBusLogicCenter"];


	waitUntil{initialized};
	uiSleep 110;

	_axeBusUnit = objNull;
	_axeBusGroup = createGroup RESISTANCE;
	//_axeBusGroup = createGroup WEST;
	_axeBuspawnpos = [13128.2,10381.9,0];
	_unitpos = [13125.2,10416,0];
	_axeBusWPradius = 40;//waypoint radius
	
	_axeBusDriver = objNull;
	

	//Set Sides
	_firstRun = _this select 0;
	if(_firstRun)then{
	createCenter RESISTANCE;
	RESISTANCE setFriend [WEST,1];//Like Survivors..
	RESISTANCE setFriend [EAST,0];//Don't like banditos !
	WEST setFriend [RESISTANCE,1];
	EAST setFriend [RESISTANCE,0];
	};

	
	//Load Bus Route
	_axWPZ=0;
	_axeBusWPIndex = 2;
	_axeBusFirstWayPoint = [13101.4,10339.1,_axWPZ];
	_axeBusWP = _axeBusGroup addWaypoint [_axeBusFirstWayPoint, _axeBusWPradius,_axeBusWPIndex];
	_axeBusWP setWaypointType "MOVE";
	//_axeBusRouteWaypoints = [[12984,8362.67,_axWPZ],[13279.1,6991.32,_axWPZ],[13464.2,6255.24,_axWPZ],[13386.8,5405.25,_axWPZ],[12025.6,3481.76,_axWPZ],[10504.4,2324.99,_axWPZ],[10321.8,2149.75,_axWPZ],[10028,2071.8,_axWPZ],[9503.53,2028.21,_axWPZ],[6587.65,2884.59,_axWPZ],[6354.47,2452.24,_axWPZ],[4565.79,2432.13,_axWPZ],[1907.21,2240.25,_axWPZ],[1689.06,2209.53,_axWPZ],[1845.55,2219.14,_axWPZ],[1940.8,2255.24,_axWPZ],[3559.56,2448.9,_axWPZ],[4541.37,2443.16,_axWPZ],[5816.09,2167.39,_axWPZ],[6408.19,2685.99,_axWPZ],[6570.5,2877.59,_axWPZ],[9945.28,2049.85,_axWPZ],[10283.4,2146.71,_axWPZ],[10389.4,2221.85,_axWPZ],[10498.9,2320.29,_axWPZ],[10888.2,2772.58,_axWPZ],[12025.9,3485.04,_axWPZ],[13005.9,3816.02,_axWPZ],[13451.5,6211.28,_axWPZ],[13419.9,6557.19,_axWPZ],[13287.7,6961.19,_axWPZ],[12930.4,10133,_axWPZ]];
	_axeBusRouteWaypoints = [
		[0,		[13100.035,	10353.128,	_axWPZ]],
		[0,		[12978.129,	8359.0088,	_axWPZ]],
		[0,		[13287.419,	6961.9658,	_axWPZ]],
		[0,		[13458.568,	6253.623,	_axWPZ]],
		[0,		[13381.949,	5448.3105,	_axWPZ]],
		[0,		[12033.441,	3489.1321,	_axWPZ]],
		[0,		[10881.695,	2753.395,	_axWPZ]],
		[0,		[10500.636,	2327.4365,	_axWPZ]],
		[0,		[10044.312,	2080.583,	_axWPZ]],
		[0,		[7967.4771,	3178.3748,	_axWPZ]],
		[0,		[7309.5215,	2730.1248,	_axWPZ]],
		[0,		[7035.7368,	2495.2661,	_axWPZ]],
		[0,		[6575.8452,	2881.9497,	_axWPZ]],
		[0,		[6405.46,	2682.3545,	_axWPZ]],
		[0,		[4542.2134,	2442.2568,	_axWPZ]],
		[0,		[3567.1011,	2452.0801,	_axWPZ]],
		[0,		[1833.5068,	2222.8921,	_axWPZ]],
		[0,		[1092.8208,	2362.468,	_axWPZ]],
		[0,		[1848.2321,	2223.7651,	_axWPZ]],
		[0,		[3555.5591,	2441.7156,	_axWPZ]],
		[0,		[4547.3013,	2434.5591,	_axWPZ]],
		[0,		[6335.6421,	2406.5798,	_axWPZ]],
		[0,		[6856.6782,	2354.676,	_axWPZ]],
		[0,		[7959.4185,	3173.9136,	_axWPZ]],
		[0,		[9980.9307,	2057.4424,	_axWPZ]],
		[0,		[10513.25,	2334.8142,	_axWPZ]],
		[0,		[10883.257,	2738.457,	_axWPZ]],
		[0,		[12028.229,	3482.8652,	_axWPZ]],
		[0,		[13386.496,	5402.1387,	_axWPZ]],
		[0,		[13465.364,	6263.1367,	_axWPZ]],
		[0,		[13272.938,	7002.8833,	_axWPZ]],
		[0,		[12977.121,	8378.8184,	_axWPZ]],
		[0,		[12279.391,	8968.3184,	_axWPZ]],
		[0,		[12008.05,	9180.4473,	_axWPZ]],
		[0,		[12269.771,	9496.8311,	_axWPZ]],
		[0,		[12974.933,	10222.065,	_axWPZ]]
	];
	
	{
		_axeBusWPIndex=_axeBusWPIndex+1;
		_axeBusWP = _axeBusGroup addWaypoint [_x select 1, _axeBusWPradius,_axeBusWPIndex];
		//_axeBusWp setDir (_x select 0);
		_axeBusWP setWaypointType "MOVE";
		_axeBusWP setWaypointTimeout [20, 30, 35];
		//_axeBusWP showWaypoint "ALWAYS";
		diag_log format ["BUS:Waypoint Added: %2 at %1",_x,_axeBusWP];
	} forEach _axeBusRouteWaypoints;

/*
	{
		_newVeh = createVehicle ["SUV_DZ", _x select 1, [], 0, "NONE"];
		_newVeh setDir (_x select 0);
		_newVeh setVariable ["PLAYZ_whenSpawned", _forEachIndex, true];
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _newVeh];
		[_newVeh, "SUV_DZ"] spawn server_updateObject;
	} forEach _axeBusRouteWaypoints;
*/

	//Create Loop Waypoint
	_axeBusWP = _axeBusGroup addWaypoint [_axeBusFirstWayPoint, _axeBusWPradius,_axeBusWPIndex+1];
	_axeBusWP setWaypointType "CYCLE";
	
	//Create Bus
	_dir = 244;
	_axeBus = "Ikarus" createVehicle _axeBuspawnpos;
	_axeBus setDir _dir;
	_axeBus setPos getPos _axeBus;
	_axeBus setVariable ["ObjectID", [_dir,getPos _axeBus] call dayz_objectUID2, true];
	_axeBus setFuel .3;
	_axeBus allowDammage false;
	//Uncomment for normal dayZ
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_axeBus];
	//For Epoch - Comment out for normal dayZ | Credit to Flenz
	//PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_axeBus];
	[_axeBus,"Ikarus"] spawn server_updateObject;
	
	//Make Permanent on some builds.. No Need really,
	//dayzSaveVehicle = _axeBus;
	//publicVariable "dayzSaveVehicle";
	
	_axeBus addEventHandler ["HandleDamage", {false}];	
	_axeBus setVariable ["axBusGroup",_axeBusGroup,true];
	_axeBus setVariable ["isAxeAIBus",1,true];
	_axeBus setVariable ["MalSar",1,true];
	_axeBus setVariable ["Sarge",1,true];
	
	//Create Driver and Drivers Mate
	for [{ x=1 },{ x <3 },{ x = x + 1; }] do {
		_rndLOut=floor(random 3);
		_ailoadout=
		switch (_rndLOut) do 
		{
			case 0: {["AK_47_M","30Rnd_762x39_AK47"]}; 
			case 1: {["M4A1_AIM_SD_camo","30Rnd_556x45_StanagSD"]}; 
			case 2: {["Remington870_lamp","8Rnd_B_Beneli_74Slug"]}; 
		};
		
		"BAF_Soldier_L_DDPM" createUnit [_unitpos, _axeBusGroup, "_axeBusUnit=this;",0.6,"Private"];
		
		_axeBusUnit enableAI "TARGET";
		_axeBusUnit enableAI "AUTOTARGET";
		_axeBusUnit enableAI "MOVE";
		_axeBusUnit enableAI "ANIM";
		_axeBusUnit enableAI "FSM";
		//stop AI attacking bus
		_axeBusUnit setCaptive true;
		_axeBusUnit allowDammage true;

		_axeBusUnit setCombatMode "GREEN";
		_axeBusUnit setBehaviour "CARELESS";
		//clear default weapons / ammo
		removeAllWeapons _axeBusUnit;
		//add random selection
		_aiwep = _ailoadout select 0;
		_aiammo = _ailoadout select 1;
		_axeBusUnit addweapon _aiwep;
		_axeBusUnit addMagazine _aiammo;
		_axeBusUnit addMagazine _aiammo;
		_axeBusUnit addMagazine _aiammo;

		//set skills
		_axeBusUnit setSkill ["aimingAccuracy",1];
		_axeBusUnit setSkill ["aimingShake",1];
		_axeBusUnit setSkill ["aimingSpeed",1];
		_axeBusUnit setSkill ["endurance",1];
		_axeBusUnit setSkill ["spotDistance",0.6];
		_axeBusUnit setSkill ["spotTime",1];
		_axeBusUnit setSkill ["courage",1];
		_axeBusUnit setSkill ["reloadSpeed",1];
		_axeBusUnit setSkill ["commanding",1];
		_axeBusUnit setSkill ["general",1];
		
		if(x==1) then {
			_axeBusUnit assignAsCargo _axeBus;
			_axeBusUnit moveInCargo _axeBus;
			_axeBusUnit addEventHandler ["HandleDamage", {false}];
		} else {
			_axeBusGroup selectLeader _axeBusUnit;
			_axeBusDriver = _axeBusUnit;
			_axeBusDriver addEventHandler ["HandleDamage", {false}];
			_axeBus addEventHandler ["killed", {[false] execVM "busroute\init_bus.sqf"}];//Shouldn't be required
		
			//Test - Allow dev time to get in bus
			sleep 36;
		
			_axeBusUnit assignAsDriver _axeBus;
			_axeBusUnit moveInDriver _axeBus;
		};
	};
	
	waitUntil{!isNull _axeBus};
	diag_log format ["AXLOG:BUS: Bus Spawned:%1 | Group:%2",_axeBus,_axeBusGroup];
	
	//Monitor Bus
	while {alive _axeBus} do {
	//diag_log format ["AXLOG:BUS: Tick:%1",time];
		//Fuel Bus
		if(fuel _axeBus < 0.2) then {
			_axeBus setFuel 0.3;
			diag_log format ["AXLOG:BUS: Fuelling Bus:%1 | Group:%2",_axeBus,_axeBusGroup];
		};
		
		//Keep Bus Alive - Shouldn't be required.
		if(damage _axeBus>0.2) then {
			_axeBus setDamage 0;
			diag_log format ["AXLOG:BUS: Repairing Bus:%1 | Group:%2",_axeBus,_axeBusGroup];
		};
		
		//Monitor Driver
		if((driver _axeBus != _axeBusDriver)||(driver _axeBus != _axeBusUnit)) then {
			diag_log format ["AXLOG:BUS: Driver Required:%1",driver _axeBus];
			units _axeBusGroup select 0 assignAsDriver _axeBus;
			units _axeBusGroup select 0 moveInDriver _axeBus;
		};

		//Clear Zeds (WORKING - But zeds vanish, not ideal maybe pass to player)
		_nrZeds = (position _axeBus) nearEntities ["zZombie_Base",25];
		if(count _nrZeds > 0) then {
			{
			_x setDamage 1; 
			diag_log format ["AXLOG:BUS: Killing Zed:%1",_x];
			} forEach _nrZeds;
		};

		_arrJunk = ["Rubbish1","Rubbish2","Rubbish3","Rubbish4","Rubbish5","Land_Misc_Rubble_EP1","UralWreck","SKODAWreck","HMMWVWreck","datsun02Wreck","hiluxWreck","UAZWreck","datsun01Wreck","Land_Misc_Garb_Heap_EP1"];
		//Remove Junk
		_junk = (position _axeBus) nearEntities [_arrJunk,10];
		if(count _junk > 0)then{
			diag_log format["AXLOG:BUS:Deleting Junk:%1",_junk];
			{deleteVehicle _x;} forEach _junk;
		};

		//Create marker for bus
		deleteMarker "BUSMarker";
		_BUSMarker = createmarker ["BUSMarker", position _axeBus];
		_BUSMarker setMarkerText "Bus";
		_BUSMarker setMarkerType "DOT";
		_BUSMarker setMarkerColor "ColorRed";
		_BUSMarker setMarkerBrush "Solid";
		_BUSMarker setMarkerSize [1, 1];
		BUSMarker = _BUSMarker;

		sleep 3;
	};
	
	
	
	

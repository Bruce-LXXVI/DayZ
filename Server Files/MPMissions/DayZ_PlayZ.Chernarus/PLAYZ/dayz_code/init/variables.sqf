disableSerialization;


//placed objects
DayZ_SafeObjects = ["WoodenGate_1","WoodenGate_2","WoodenGate_3","WoodenGate_4","Land_Fire_DZ", "TentStorage","TentStorage0","TentStorage1","TentStorage2","TentStorage3","TentStorage4","StashSmall","StashSmall1","StashSmall2","StashSmall3","StashSmall4","StashMedium","StashMedium1","StashMedium2","StashMedium3", "StashMedium4", "Wire_cat1", "Sandbag1_DZ", "Fence_DZ", "Generator_DZ", "Hedgehog_DZ", "BearTrap_DZ", "DomeTentStorage", "DomeTentStorage0", "DomeTentStorage1", "DomeTentStorage2", "DomeTentStorage3", "DomeTentStorage4", "CamoNet_DZ", "Trap_Cans", "TrapTripwireFlare", "TrapBearTrapSmoke", "TrapTripwireGrenade", "TrapTripwireSmoke", "TrapBearTrapFlare",
"UAZ_Unarmed_TK_EP1", "UAZ_Unarmed_TK_CIV_EP1", "UAZ_Unarmed_UN_EP1", "UAZ_RU", "ATV_US_EP1", "ATV_CZ_EP1", "SkodaBlue", "Skoda", "SkodaGreen", "TT650_Ins", "TT650_TK_EP1", "TT650_TK_CIV_EP1", "Old_bike_TK_CIV_EP1", "Old_bike_TK_INS_EP1", "UH1H_DZ", "UH1H_2_DZ", "hilux1_civil_3_open", "Ikarus_TK_CIV_EP1", "Ikarus", "Tractor", "tractorOld", "S1203_TK_CIV_EP1", "V3S_Civ", "UralCivil", "car_hatchback", "Fishing_Boat", "PBX", "Smallboat_1", "Volha_2_TK_CIV_EP1", "Volha_1_TK_CIV_EP1", "SUV_DZ", "car_sedan", "AH6X_DZ", "Mi17_DZ", "AN2_DZ", "AN2_2_DZ", "BAF_Offroad_D", "BAF_Offroad_W", "MH6J_DZ", "HMMWV_DZ", "Pickup_PK_INS", "Offroad_DSHKM_INS", "LandRover_TK_CIV_EP1",
"UralCivil2", "Ural_INS", "Ural_CDF", "UAZ_CDF", "LandRover_TK_CIV_EP1", "LandRover_CZ_EP1", "UralOpen_INS", "smallboat_2", "SkodaRed", "datsun1_civil_1_open", "datsun1_civil_2_covered", "datsun1_civil_3_open", "hilux1_civil_1_open", "hilux1_civil_2_covered",
"Lada1", "Lada2", "LadaLM", "M1030", "M1030_US_DES_EP1", "TT650_Civ", "TT650_Gue", "Ural_TK_CIV_EP1", "Lada1_TK_CIV_EP1", "Lada2_TK_CIV_EP1", "hilux1_civil_3_open_EP1", "Old_moto_TK_Civ_EP1",
"SUV_TK_CIV_EP1", "SUV_TK_EP1", "VolhaLimo_TK_CIV_EP1", "SUV_PMC", "UH1H_DZ2"
,"policecar", "Ka60_NAC", "Ka60_GL_NAC", "Mi17_Civilian_Nam", "nac_BTR90"
];

dayz_CBLConfigName = "CfgBuildingLoot";

// init global arrays for Loot Chances
//call compile preprocessFileLineNumbers "PLAYZ\dayz_code\init\loot_init.sqf";

//if(!isDedicated) then {
	//Establish Location Streaming
	diag_log format["[PLAYZ] dayz_Locations=%1", dayz_Locations];

	_funcGetLocation =
	{
		dayz_Locations = [];
		for "_i" from 0 to ((count _this) - 1) do
		{
			private ["_location","_config","_locHdr","_position","_size","_type"];
			//Get Location Data from config
			_config = (_this select _i);
			_position = getArray (_config >> "position");
			_locHdr = configName _config;
			_size = getNumber (_config >> "size");
			dayz_Locations set [count dayz_Locations, [_position,_locHdr,_size]];
		};
	};
	_cfgLocation = configFile >> format["CfgTownGenerator%1", worldName];
	_cfgLocation call _funcGetLocation;

	dayz_Locations set [count dayz_Locations, [
		getArray (configFile >> "CfgWorlds" >> "Namalsk" >> "center")
		, "Namalsk"
		, 12800
	]];

	diag_log format["[PLAYZ] dayz_Locations=%1", dayz_Locations];

//};


// ESS
{AllPlayers set [count AllPlayers,_x];} count ["Citizen3","CZ_Soldier_DES_EP1","Rocket_DZ","TK_INS_Soldier_EP1","US_Soldier_EP1","Villager1","Worker1"];
DayZ_SafeObjects set [count DayZ_SafeObjects,"ParachuteC"];



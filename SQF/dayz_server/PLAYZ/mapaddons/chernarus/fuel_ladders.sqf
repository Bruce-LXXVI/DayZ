

{
	private ["_object"];
	_object = createVehicle [_x select 0,[0,0,0],[],0,'CAN_COLLIDE'];
	if (surfaceIsWater (_x select 1)) then [{_object setPosASL (_x select 1)},{_object setPosATL (_x select 1)}];
	_object setDir (_x select 2)
} forEach [
// Solnichniy
["Land_ladder",				[13382.438, 6602.1606, -1.1444092e-005],	74.762367],
// Elektrozavodsk
["MAP_Misc_GContainer_Big",	[9510.0928, 1995.5637, -7.1525574e-006],	93.661957],
["Land_Misc_Scaffolding",	[9500.5479, 2004.4343, 0.1214041],			-85.042961],
// Zelenogorsk
["Land_ladder",				[2694.5627, 5602.459, 0],					-76.863174],
// Pustoshka
["Land_ladder",				[3006.7495, 7467.5005, 0.075613357],		-84.028282],
// Vybor
["Land_Misc_Scaffolding",	[3647.6501, 8966.1533, 0.37240848],			-49.55698],
["RoadBarrier_light",		[3649.9602, 8957.3008, 3.0517578e-005],		146.01666],
["RoadBarrier_light",		[3636.8679, 8967.6377, 6.1035156e-005],		146.01666],
["RoadBarrier_light",		[3638.3025, 8968.7754, 3.0517578e-005],		146.01666],
["RoadBarrier_light",		[3651.2454, 8958.2998, 6.1035156e-005],		146.01666],
// Gorka
["Land_ladder",				[10460.255, 8874.8633, 0.0001373291],		-119.91158],
// Berezino
["MAP_IndPipe2_big_9",		[12956.354, 10039.589, 3.4809113e-005],		377.30157],
["MAP_IndPipe2_big_9",		[12955.49, 10036.948, 6.1035156e-005],		378.05096],
["MAP_IndPipe2_big_9",		[12977.972, 10051.158, 1.9073486e-006],		377.39764],
["MAP_IndPipe2_big_9",		[12980.62, 10059.626, 0.091075078],			377.39215],
["MAP_IndPipe2_bigL_L",		[12976.141, 10044.443, 0.026668467],		107.21413],
["MAP_IndPipe2_bigL_R",		[12960.021, 10046.836, 3.8146973e-006],		17.159672],
["MAP_IndPipe2_big_9",		[12983.396, 10068.215, 0.1523582],			377.85907],
["MAP_IndPipe2_big_9",		[12967.058, 10045.553, 8.5830688e-006],		467.53708],
// Chernogorsk
["Land_ladder",				[6694.6582, 3001.9924, 1.2397766e-005],		-211.27124]


];

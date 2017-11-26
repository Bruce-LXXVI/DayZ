

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
["Land_Misc_Scaffolding",	[9497.0332, 2001.7411, 0.1214041],			-85.042961],
// Zelenogorsk
["Land_ladder",				[2694.5627, 5602.459, 0],					-76.863174],
// Pustoshka
["Land_ladder",				[3006.7495, 7467.5005, 0.075613357],		-84.028282],
// Vybor
["Land_Misc_Scaffolding",	[3644.8743, 8965.7178, 0.37240848],			-49.55698],
["RoadBarrier_light",		[3649.9602, 8957.3008, 3.0517578e-005],		146.01666],
["RoadBarrier_light",		[3636.8679, 8967.6377, 6.1035156e-005],		146.01666],
["RoadBarrier_light",		[3638.3025, 8968.7754, 3.0517578e-005],		146.01666],
["RoadBarrier_light",		[3651.2454, 8958.2998, 6.1035156e-005],		146.01666],
// Gorka
["Land_ladder",				[10460.255, 8874.8633, 0.0001373291],		-119.91158],
// Berezino
["Land_Ladder",				[12984.235, 10073.198, 3.4809113e-005],		459.95682],
// Chernogorsk
["Land_ladder",				[6694.6582, 3001.9924, 1.2397766e-005],		-211.27124]

];

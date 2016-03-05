
private [ "_objects"
		, "_vehicle"
		, "_type"
		, "_pos"
		, "_dir"
];

_objects=[
["Land_Fire_barrel", [6177.52, 2125.38, 0], 0],
["Land_Fire_barrel", [6833.61, 3176.97, 0], 0],
["Land_Fire_barrel", [6706.46, 3012.07, 0], 0],
["Land_Fire_barrel", [7095.99, 2740.68, 0], 0],
["Land_Fire_barrel", [6428.26, 2244.96, 0], 0],
["Land_Fire_barrel", [6513.29, 2298.32, 0], 0],
["Land_Fire_barrel", [6663.22, 2286.33, 0], 0],
["Land_Fire_barrel", [6796.09, 2726.09, 0], 0],
["Land_Fire_barrel", [6835.19, 2694.23, 0], 0],
["Land_Fire_barrel", [6789.35, 2692.69, 0], 0],
["Land_Fire_barrel", [6725.35, 2576.59, 0], 0],
["Land_Fire_barrel", [6754.5, 2780.37, 0], 0],
["Land_Fire_barrel", [6536.12, 2639.35, 0], 0],
["Land_Fire_barrel", [6545.71, 2630.16, 0], 0],
["Land_Fire_barrel", [6760.03, 2727.7, 0], 0],
["Land_Fire_barrel", [7065.12, 2622.94, 0], 0],
["Land_Fire_barrel", [6847.45, 2360.25, 0], 0],
["Land_Fire_barrel", [6864.41, 2464.66, 0], 0],
["Land_Fire_barrel", [6856.71, 2522.75, 0], 0],
["Land_Fire_barrel", [6832.25, 2500.24, 0], 0],
["Land_Fire_barrel", [6822.79, 2482.01, 0], 0],
["Land_Fire_barrel", [6810.51, 2499.86, 0], 0],
["Land_Fire_barrel", [6043.67, 7781.65, 0], 0],
["Land_Fire_barrel", [6291.19, 7808.7, 0], 0],
["Land_Fire_barrel", [6317.3, 7835.18, 0], 0],
["Land_Fire_barrel", [12013.1, 9159.39, 0], 0],
["Land_Fire_barrel", [11983, 9162.89, 0], 0],
["Land_Fire_barrel", [11911.8, 9101.2, 0], 0],
["Land_Fire_barrel", [12197.1, 9499.64, 0], 0],
["Land_Fire_barrel", [12407.3, 9549.81, 0], 0],
["Land_Fire_barrel", [12210.8, 9728.83, 0], 0],
["Land_Fire_barrel", [12271.7, 9719.5, 0], 0],
["Land_Fire_barrel", [12218.7, 9752.14, 0], 0],
["Land_Fire_barrel", [12247, 9746.97, 0], 0]
];


{
	_type = _x select 0;
	_pos = _x select 1;
	_dir = _x select 2;
	_vehicle = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
	_vehicle setDir _dir;
	_vehicle setPos _pos;
} foreach _objects;



processInitCommands;


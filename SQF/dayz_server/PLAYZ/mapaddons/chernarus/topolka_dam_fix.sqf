
if (true) then
{
	_this = createVehicle ["MAP_pond_big_01", [10299.095,3659.8674,2.4993041], [], 0, "CAN_COLLIDE"];
};


if (true) then
{
	_this = createVehicle ["Land_Molo_krychle", [10324.0, 3628.0, -0.83], [], 0, "CAN_COLLIDE"];
	_this setVectorUp [0,0,1];
//	_this setPosASL [10324.0, 3628.0, 40];
//	diag_log format ["%1 getPos=%2 ", PLAYZ_logname, (getPos _this)];
};
if (true) then
{
	_this = createVehicle ["Land_Molo_krychle", [10304.0, 3628.0, -1.47], [], 0, "CAN_COLLIDE"];
	_this setVectorUp [0,0,1];
//	_this setPosASL [10304.0, 3628.0, 40];
//	diag_log format ["%1 getPos=%2 ", PLAYZ_logname, (getPos _this)];
};
if (true) then
{
	_this = createVehicle ["Land_Molo_krychle", [10284.0, 3628.0, -2.77], [], 0, "CAN_COLLIDE"];
	_this setVectorUp [0,0,1];
//	_this setPosASL [10284.0, 3628.0, 40];
//	diag_log format ["%1 getPos=%2 ", PLAYZ_logname, (getPos _this)];
};


processInitCommands;


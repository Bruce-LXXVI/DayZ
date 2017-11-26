activateAddons [
];

activateAddons [];
initAmbientLife;

_this = createCenter west;
_center_0 = _this;

_group_1 = createGroup _center_0;

_unit_1 = objNull;
if (true) then
{
  _this = _group_1 createUnit ["Camo1_DZ", [6718.3838, 2996.5776, -6.3109694], [], 0, "CAN_COLLIDE"];
  _unit_1 = _this;
  _this setUnitAbility 0.60000002;
  if (true) then {_group_1 selectLeader _this;};
  if (true) then {selectPlayer _this;};
};

_vehicle_2 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ladder", [13382.438, 6602.1606, -1.1444092e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_2 = _this;
  _this setDir 74.762367;
  _this setPos [13382.438, 6602.1606, -1.1444092e-005];
};

_vehicle_3 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_Misc_GContainer_Big", [9510.0928, 1995.5637, -7.1525574e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_3 = _this;
  _this setDir 93.661957;
  _this setPos [9510.0928, 1995.5637, -7.1525574e-006];
};

_vehicle_5 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Scaffolding", [9497.0332, 2001.7411, 0.1214041], [], 0, "CAN_COLLIDE"];
  _vehicle_5 = _this;
  _this setDir -85.042961;
  _this setPos [9497.0332, 2001.7411, 0.1214041];
};

_vehicle_81 = objNull;
if (true) then
{
  _this = createVehicle ["Land_ladder", [2694.5627, 5602.459], [], 0, "CAN_COLLIDE"];
  _vehicle_81 = _this;
  _this setDir -76.863174;
  _this setPos [2694.5627, 5602.459];
};

_vehicle_110 = objNull;
if (true) then
{
  _this = createVehicle ["Land_ladder", [3006.7495, 7467.5005, 0.075613357], [], 0, "CAN_COLLIDE"];
  _vehicle_110 = _this;
  _this setDir -84.028282;
  _this setPos [3006.7495, 7467.5005, 0.075613357];
};

_vehicle_135 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Scaffolding", [3644.8743, 8965.7178, 0.37240848], [], 0, "CAN_COLLIDE"];
  _vehicle_135 = _this;
  _this setDir -49.55698;
  _this setPos [3644.8743, 8965.7178, 0.37240848];
};

_vehicle_141 = objNull;
if (true) then
{
  _this = createVehicle ["RoadBarrier_light", [3649.9602, 8957.3008, 3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_141 = _this;
  _this setDir 146.01666;
  _this setPos [3649.9602, 8957.3008, 3.0517578e-005];
};

_vehicle_143 = objNull;
if (true) then
{
  _this = createVehicle ["RoadBarrier_light", [3636.8679, 8967.6377, 6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_143 = _this;
  _this setDir 146.01666;
  _this setPos [3636.8679, 8967.6377, 6.1035156e-005];
};

_vehicle_147 = objNull;
if (true) then
{
  _this = createVehicle ["RoadBarrier_light", [3638.3025, 8968.7754, 3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_147 = _this;
  _this setDir 146.01666;
  _this setPos [3638.3025, 8968.7754, 3.0517578e-005];
};

_vehicle_150 = objNull;
if (true) then
{
  _this = createVehicle ["RoadBarrier_light", [3651.2454, 8958.2998, 6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_150 = _this;
  _this setDir 146.01666;
  _this setPos [3651.2454, 8958.2998, 6.1035156e-005];
};

_vehicle_154 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ladder", [10460.255, 8874.8633, 0.0001373291], [], 0, "CAN_COLLIDE"];
  _vehicle_154 = _this;
  _this setDir -119.91158;
  _this setPos [10460.255, 8874.8633, 0.0001373291];
};

_vehicle_182 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ladder", [12984.235, 10073.198, 3.4809113e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_182 = _this;
  _this setDir 459.95682;
  _this setPos [12984.235, 10073.198, 3.4809113e-005];
};

_vehicle_224 = objNull;
if (true) then
{
  _this = createVehicle ["Land_ladder", [6694.6582, 3001.9924, 1.2397766e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_224 = _this;
  _this setDir -211.27124;
  _this setPos [6694.6582, 3001.9924, 1.2397766e-005];
};

processInitCommands;
runInitScript;
finishMissionInit;

activateAddons [
];

activateAddons [];
initAmbientLife;

_this = createCenter west;
_center_0 = _this;

_group_0 = createGroup _center_0;

_unit_0 = objNull;
if (true) then
{
  _this = _group_0 createUnit ["Camo1_DZ", [6007.1816, 10382.853, 0], [], 0, "CAN_COLLIDE"];
  _unit_0 = _this;
  _this setUnitAbility 0.60000002;
  if (true) then {_group_0 selectLeader _this;};
  if (true) then {selectPlayer _this;};
};

_vehicle_3 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierCDF", [6114.269, 10418.058], [], 0, "CAN_COLLIDE"];
  _vehicle_3 = _this;
  _this setPos [6114.269, 10418.058];
};

_vehicle_14 = objNull;
if (true) then
{
  _this = createVehicle ["Land_A_GeneralStore_01a", [6006.1558, 10413.397, 0.13574743], [], 0, "CAN_COLLIDE"];
  _vehicle_14 = _this;
  _this setDir -236.87326;
  _this setPos [6006.1558, 10413.397, 0.13574743];
};

_vehicle_18 = objNull;
if (true) then
{
  _this = createVehicle ["ClutterCutter_EP1", [6013.1685, 10422.887, -3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_18 = _this;
  _this setPos [6013.1685, 10422.887, -3.0517578e-005];
};

_vehicle_20 = objNull;
if (true) then
{
  _this = createVehicle ["ClutterCutter_EP1", [6005.8872, 10409.899, 5.0581665], [], 0, "CAN_COLLIDE"];
  _vehicle_20 = _this;
  _this setPos [6005.8872, 10409.899, 5.0581665];
};

processInitCommands;
runInitScript;
finishMissionInit;

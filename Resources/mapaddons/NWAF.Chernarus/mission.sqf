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
  _this = _group_0 createUnit ["CZ_Soldier_Pilot_Wdl_ACR", [4583.9053, 10426.597, 0], [], 0, "CAN_COLLIDE"];
  _unit_0 = _this;
  _this setUnitAbility 0.60000002;
  if (true) then {_group_0 selectLeader _this;};
  if (true) then {selectPlayer _this;};
};

_vehicle_0 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [4636.3687, 10495.295], [], 0, "CAN_COLLIDE"];
  _vehicle_0 = _this;
  _this setDir 58.252419;
  _this setPos [4636.3687, 10495.295];
};

_vehicle_1 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ind_Timbers", [4650.0283, 10540.247, -0.018598476], [], 0, "CAN_COLLIDE"];
  _vehicle_1 = _this;
  _this setDir -43.836658;
  _this setPos [4650.0283, 10540.247, -0.018598476];
};

_vehicle_12 = objNull;
if (true) then
{
  _this = createVehicle ["ClutterCutter_small_EP1", [4643.8408, 10525.031, -9.1552734e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_12 = _this;
  _this setPos [4643.8408, 10525.031, -9.1552734e-005];
};

_vehicle_16 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Campfire_burning", [4643.3428, 10525.1, 0.00012207031], [], 0, "CAN_COLLIDE"];
  _vehicle_16 = _this;
  _this setPos [4643.3428, 10525.1, 0.00012207031];
};

_vehicle_32 = objNull;
if (true) then
{
  _this = createVehicle ["ClutterCutter_EP1", [4635.0278, 10493.642, -3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_32 = _this;
  _this setPos [4635.0278, 10493.642, -3.0517578e-005];
};

processInitCommands;
runInitScript;
finishMissionInit;

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
  _this = _group_0 createUnit ["Camo1_DZ", [6679.9644, 3447.4878, 0], [], 0, "CAN_COLLIDE"];
  _unit_0 = _this;
  _this setUnitAbility 0.60000002;
  if (true) then {_group_0 selectLeader _this;};
  if (true) then {selectPlayer _this;};
};

_vehicle_0 = objNull;
if (true) then
{
  _this = createVehicle ["ClutterCutter_EP1", [6562.9854, 3417.2876, 2.2888184e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_0 = _this;
  _this setPos [6562.9854, 3417.2876, 2.2888184e-005];
};

_vehicle_7 = objNull;
if (true) then
{
  _this = createVehicle ["CampEast_EP1", [6561.1191, 3416.6924, 7.6293945e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_7 = _this;
  _this setDir -1.0312016;
  _this setPos [6561.1191, 3416.6924, 7.6293945e-005];
};

processInitCommands;
runInitScript;
finishMissionInit;

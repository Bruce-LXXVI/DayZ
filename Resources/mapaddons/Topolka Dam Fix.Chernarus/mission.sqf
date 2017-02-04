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
  _this = _group_0 createUnit ["Camo1_DZ", [10355.48, 3609.7522, 2.4993117], [], 0, "CAN_COLLIDE"];
  _unit_0 = _this;
  _this setUnitAbility 0.60000002;
  if (true) then {_group_0 selectLeader _this;};
  if (true) then {selectPlayer _this;};
};

_mine_0 = objNull;
if (true) then
{
  _mine_0 = createMine ["MineMine", [10360.012, 3649.989, -1.9073486e-005], [], 0];
};

_vehicle_20 = objNull;
if (true) then
{
  _this = createVehicle ["MAP_pond_big_01", [10299.095, 3659.8674, 2.4993041], [], 0, "CAN_COLLIDE"];
  _vehicle_20 = _this;
  _this setPos [10299.095, 3659.8674, 2.4993041];
};

processInitCommands;
runInitScript;
finishMissionInit;

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
  _this = _group_0 createUnit ["BanditW1_DZ", [4911.5371, 2123.7131, 0], [], 0, "CAN_COLLIDE"];
  _unit_0 = _this;
  _this setUnitAbility 0.60000002;
  if (true) then {_group_0 selectLeader _this;};
  if (true) then {selectPlayer _this;};
};

_vehicle_2 = objNull;
if (true) then
{
  _this = createVehicle ["Ikarus_TK_CIV_EP1", [13128.2,10381.9,0], [], 0, "CAN_COLLIDE"];
  _vehicle_2 = _this;
  _this setDir 205.4845;
  _this setPos [13128.2,10381.9,0];
};

_this = _group_0 addWaypoint [[13065.228, 10228.376, 0], 0];
_waypoint_0 = _this;

_vehicle_14 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [13100.035, 10353.128, -1.8596649e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_14 = _this;
  _this setPos [13100.035, 10353.128, -1.8596649e-005];
};

_vehicle_17 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [12978.129, 8359.0088, -8.1062317e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_17 = _this;
  _this setPos [12978.129, 8359.0088, -8.1062317e-006];
};

_vehicle_18 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [13287.419, 6961.9658, -0.00013113022], [], 0, "CAN_COLLIDE"];
  _vehicle_18 = _this;
  _this setPos [13287.419, 6961.9658, -0.00013113022];
};

_vehicle_19 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [13458.568, 6253.623, 4.2438507e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_19 = _this;
  _this setPos [13458.568, 6253.623, 4.2438507e-005];
};

_vehicle_20 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [13381.949, 5448.3105, 4.3392181e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_20 = _this;
  _this setPos [13381.949, 5448.3105, 4.3392181e-005];
};

_vehicle_21 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [12033.441, 3489.1321, 3.194809e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_21 = _this;
  _this setPos [12033.441, 3489.1321, 3.194809e-005];
};

_vehicle_22 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [10881.695, 2753.395, 7.0571899e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_22 = _this;
  _this setPos [10881.695, 2753.395, 7.0571899e-005];
};

_vehicle_23 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [10500.636, 2327.4365, 8.8691711e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_23 = _this;
  _this setPos [10500.636, 2327.4365, 8.8691711e-005];
};

_vehicle_24 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [10044.312, 2080.583, 9.9182129e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_24 = _this;
  _this setPos [10044.312, 2080.583, 9.9182129e-005];
};

_vehicle_25 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [7967.4771, 3178.3748, 0.00014305115], [], 0, "CAN_COLLIDE"];
  _vehicle_25 = _this;
  _this setPos [7967.4771, 3178.3748, 0.00014305115];
};

_vehicle_26 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [7309.5215, 2730.1248, 2.4795532e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_26 = _this;
  _this setPos [7309.5215, 2730.1248, 2.4795532e-005];
};

_vehicle_27 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [7035.7368, 2495.2661, 0.00014829636], [], 0, "CAN_COLLIDE"];
  _vehicle_27 = _this;
  _this setPos [7035.7368, 2495.2661, 0.00014829636];
};

_vehicle_28 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [6575.8452, 2881.9497, -3.8146973e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_28 = _this;
  _this setPos [6575.8452, 2881.9497, -3.8146973e-006];
};

_vehicle_29 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [6405.46, 2682.3545, 5.7220459e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_29 = _this;
  _this setPos [6405.46, 2682.3545, 5.7220459e-006];
};

_vehicle_31 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [4542.2134, 2442.2568, 6.1988831e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_31 = _this;
  _this setPos [4542.2134, 2442.2568, 6.1988831e-006];
};

_vehicle_32 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [3567.1011, 2452.0801, 6.6757202e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_32 = _this;
  _this setPos [3567.1011, 2452.0801, 6.6757202e-006];
};

_vehicle_33 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [1833.5068, 2222.8921, 4.6730042e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_33 = _this;
  _this setPos [1833.5068, 2222.8921, 4.6730042e-005];
};

_vehicle_34 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [1092.8208, 2362.468, 9.5367432e-007], [], 0, "CAN_COLLIDE"];
  _vehicle_34 = _this;
  _this setPos [1092.8208, 2362.468, 9.5367432e-007];
};

_vehicle_35 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [1848.2321, 2223.7651, 4.2915344e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_35 = _this;
  _this setPos [1848.2321, 2223.7651, 4.2915344e-005];
};

_vehicle_36 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [3555.5591, 2441.7156, 6.6757202e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_36 = _this;
  _this setPos [3555.5591, 2441.7156, 6.6757202e-006];
};

_vehicle_37 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [4547.3013, 2434.5591, 5.2452087e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_37 = _this;
  _this setPos [4547.3013, 2434.5591, 5.2452087e-005];
};

_vehicle_38 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [6335.6421, 2406.5798, 0.00032043457], [], 0, "CAN_COLLIDE"];
  _vehicle_38 = _this;
  _this setPos [6335.6421, 2406.5798, 0.00032043457];
};

_vehicle_39 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [6856.6782, 2354.676, 6.3896179e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_39 = _this;
  _this setPos [6856.6782, 2354.676, 6.3896179e-005];
};

_vehicle_40 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [7959.4185, 3173.9136, 6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_40 = _this;
  _this setPos [7959.4185, 3173.9136, 6.1035156e-005];
};

_vehicle_41 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [9980.9307, 2057.4424, 0.00030231476], [], 0, "CAN_COLLIDE"];
  _vehicle_41 = _this;
  _this setPos [9980.9307, 2057.4424, 0.00030231476];
};

_vehicle_42 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [10513.25, 2334.8142, -7.6293945e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_42 = _this;
  _this setPos [10513.25, 2334.8142, -7.6293945e-006];
};

_vehicle_43 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [10883.257, 2738.457, 1.1444092e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_43 = _this;
  _this setPos [10883.257, 2738.457, 1.1444092e-005];
};

_vehicle_44 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [12028.229, 3482.8652, -1.001358e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_44 = _this;
  _this setPos [12028.229, 3482.8652, -1.001358e-005];
};

_vehicle_45 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [13386.496, 5402.1387, 8.1062317e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_45 = _this;
  _this setPos [13386.496, 5402.1387, 8.1062317e-006];
};

_vehicle_46 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [13465.364, 6263.1367, 4.2915344e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_46 = _this;
  _this setPos [13465.364, 6263.1367, 4.2915344e-006];
};

_vehicle_47 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [13272.938, 7002.8833, 5.2452087e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_47 = _this;
  _this setPos [13272.938, 7002.8833, 5.2452087e-006];
};

_vehicle_48 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [12977.121, 8378.8184, 5.7220459e-006], [], 0, "CAN_COLLIDE"];
  _vehicle_48 = _this;
  _this setPos [12977.121, 8378.8184, 5.7220459e-006];
};

_vehicle_49 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [12279.391, 8968.3184, 0.00019073486], [], 0, "CAN_COLLIDE"];
  _vehicle_49 = _this;
  _this setPos [12279.391, 8968.3184, 0.00019073486];
};

_vehicle_50 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [12008.05, 9180.4473, 1.5258789e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_50 = _this;
  _this setPos [12008.05, 9180.4473, 1.5258789e-005];
};

_vehicle_51 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [12269.771, 9496.8311, 8.392334e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_51 = _this;
  _this setPos [12269.771, 9496.8311, 8.392334e-005];
};

_vehicle_52 = objNull;
if (true) then
{
  _this = createVehicle ["FlagCarrierBIS_EP1", [12974.933, 10222.065, 0.00012779236], [], 0, "CAN_COLLIDE"];
  _vehicle_52 = _this;
  _this setPos [12974.933, 10222.065, 0.00012779236];
};

processInitCommands;
runInitScript;
finishMissionInit;

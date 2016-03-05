activateAddons [
];

activateAddons [];
initAmbientLife;

_this = createMarker ["", [4533.834, 10281.643, -339]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Empty";
_this setMarkerColor "ColorRed";
_this setMarkerBrush "Solid";
_this setMarkerSize [900, 900];
_marker_0 = _this;

_this = createCenter west;
_center_0 = _this;

_group_0 = createGroup _center_0;

_unit_0 = objNull;
if (true) then
{
  _this = _group_0 createUnit ["BanditW1_DZ", [4579.021, 10214.774, 0], [], 0, "CAN_COLLIDE"];
  _unit_0 = _this;
  _this setUnitAbility 0.60000002;
  if (true) then {_group_0 selectLeader _this;};
  if (true) then {selectPlayer _this;};
};

_this = createMarker ["", [6755.0913, 8117.0234]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Empty";
_this setMarkerColor "ColorPink";
_this setMarkerBrush "Solid";
_this setMarkerSize [3000, 3000];
_marker_1 = _this;

_this = createMarker ["", [12088.825, 12679.601]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Empty";
_this setMarkerColor "ColorGreen";
_this setMarkerBrush "Solid";
_this setMarkerSize [500, 500];
_marker_2 = _this;

_this = createMarker ["", [11399.737, 11361.586]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Empty";
_this setMarkerColor "ColorBlue";
_this setMarkerBrush "Solid";
_this setMarkerSize [400, 400];
_marker_3 = _this;

processInitCommands;
runInitScript;
finishMissionInit;

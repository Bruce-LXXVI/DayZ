private["_max","_j","_menuCheckOk"];
_menuCheckOk = false; _max = 10; _j = 0;
snext = false; plist = []; pselect5 = "";

{if ((_x != player) && (getPlayerUID _x != "")) then {plist set [count plist, name _x];};} forEach entities "CAManBase";
{if ((count crew _x) > 0) then {{if ((_x != player) && (getPlayerUID _x != "")) then {plist set [count plist, name _x];};} forEach crew _x;};} foreach (entities "LandVehicle" + entities "Air" + entities "Ship");

pMenuTitle = "Kick Player:";

while {pselect5 == "" && !_menuCheckOk} do
{
	[_j, (_j + _max) min (count plist)] call fn_smenu; _j = _j + _max;
	WaitUntil {pselect5 != "" || snext || commandingMenu == ""};
	_menuCheckOk = (commandingMenu == "");
	snext = false;
};

if (pselect5 != "exit") then
{
	_name = pselect5;
	
	{
		if(name _x == _name) then
		{
			titleText[format["Kicking %1", _name],"PLAIN DOWN"];

			//PlayZ_messageBus = ["KICK", _x, player];
			//owner _x publicVariableClient "PlayZ_messageBus;"
			
			_x setVariable ["PlayZ_kickMe", format["Player %1 was KICKED by %2", _name, name player], true];

			// Tool use logger
			if(logMajorTool) then {
				usageLogger = format["%1 %2 -- has kicked %3_%4",name player,getPlayerUID player,_name,_x];
				[] spawn {publicVariable "usageLogger";};
			};
		};
	} forEach entities "CAManBase";
};
/*
	playZ classes player monitor
*/

// Beenden, wenn auf dem Server oder läuft bereits.
if (isServer || !isNil "PZC_isActive") exitWith {};
PZC_isActive = true;
PZC_logname="[PZC]";



PZC_fnc_handlePlayZClass={
	private ["_type", "_typePlayZ"];

	{
		_type = typeOf _x;
		_typePlayZ = _x getVariable ["PLAYZ_classname", ""];

		diag_log format ["%1 handle vehicle %2 | class = %3 | PLAYZ_classname = %4.", PZC_logname, _x, _type, _typePlayZ];

		if( "SUV_Pink_PLAYZ" == _typePlayZ ) then {
			_x setObjectTexture [0, "custom\textures\suv_body_pink_co.paa"];
		};

		if( "SUV_Camo_PLAYZ" == _typePlayZ ) then {
			_x setObjectTexture [0, "custom\textures\suv_body_camo_co.paa"];
		};

		if( "UH1H_Red_PLAYZ" == _typePlayZ ) then {
				_x setObjectTexture [0,"#(argb,8,8,3)color(0.5,0,0,0.3)"];
				_x setObjectTexture [1,"#(argb,8,8,3)color(0.5,0,0,0.3)"];
			};

	} count _this;

};

"PZC_handlePlayZClass" addPublicVariableEventHandler {(_this select 1) call PZC_fnc_handlePlayZClass};

if(!isNil "PZC_handlePlayZClass") then {PZC_handlePlayZClass call PZC_fnc_handlePlayZClass;};



/*
	{
		if (_x isKindOf "UH1H_DZ2" || _x isKindOf "Pickup_PK_INS" || _x isKindOf "Offroad_DSHKM_INS") then {
		
			_returnColors = _x getVariable ["PLAYZ_Classname", ""];
			if("green" == _returnColors) then {
				_x setObjectTexture [0,"#(argb,8,8,3)color(0,0.5,0,0.3)"];
				_x setObjectTexture [1,"#(argb,8,8,3)color(0,0.5,0,0.3)"];
			};	
			if("red" == _returnColors) then {
				_x setObjectTexture [0,"#(argb,8,8,3)color(0.5,0,0,0.3)"];
				_x setObjectTexture [1,"#(argb,8,8,3)color(0.5,0,0,0.3)"];
			};
			if("blue" == _returnColors) then {
				_x setObjectTexture [0,"#(argb,8,8,3)color(0,0,0.5,0.3)"];
				_x setObjectTexture [1,"#(argb,8,8,3)color(0,0,0.5,0.3)"];
			};
			if("pink" == _returnColors) then {
				_x setObjectTexture [0,"#(argb,8,8,3)color(0.5,0,0.5,1)"];
				_x setObjectTexture [1,"#(argb,8,8,3)color(0.5,0,0.5,1)"];
			};
			if("forestgreen" == _returnColors) then {
				_x setObjectTexture [0,"#(argb,8,8,3)color(0.5,0.5,0,0.1)"];
				_x setObjectTexture [1,"#(argb,8,8,3)color(0.5,0.5,0,0.1)"];
			};
			if("black" == _returnColors) then {
				_x setObjectTexture [0,"#(argb,8,8,3)color(0,0,0,0)"];
				_x setObjectTexture [1,"#(argb,8,8,3)color(0,0,0,0)"];
			};	
			if("yellow" == _returnColors) then {
				_x setObjectTexture [0,"#(argb,8,8,3)color(0.5,0.5,0,3)"];
				_x setObjectTexture [1,"#(argb,8,8,3)color(0.5,0.5,0,3)"];
			};
		};
	} forEach _allveh;
*/

/*
	while {true} do {
		uiSleep 0.1;
		if (vehicle player != player) then {
				_vec = (vehicle player);
	
				if (_vec isKindOf "UH1H_DZ2" || _vec isKindOf "Pickup_PK_INS" || _vec isKindOf "SUV_TK_EP1" || _vec isKindOf "Offroad_DSHKM_INS") then {
	
					_owner = [];
	
					_owner = _vec getVariable "owner";
	
	
					if ((count _owner) > 0) then {
	
						if (!((getPlayerUID player) in _owner)) then {
	
							_crew = crew _vec;
	
							_dontmove = false;
	
							{ if ((getPlayerUID _x) in _owner) then { _dontmove = true;}; } forEach _crew;
	
							if (!_dontmove) then {
	
								cutText ["You are not allowed to enter this vehicle","PLAIN",3];
	
								systemChat("Get your own private vehicle at www.dystopia-dayz.com");
	
								moveOut player;
	
							};
	
						}; 
	
					};
	
				};	
	
		};
		
	};
*/

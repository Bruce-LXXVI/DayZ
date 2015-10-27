
private [ "_playZ_debug_text1"
		, "_playZ_debug_text2"
		, "_cursor"
];

if (isNil 'debugMonitor') then { debugMonitor = false; };

//Let Zeds know
[player,4,true,(getPosATL player)] spawn player_alertZombies;

/*
Change the UID's below to match those of you and your admin(s)
Your admins will get the advanced version of your debug monitor,
while your regular users will get the cut down version. 
*/

if(isNil "dayz_skilllevel") then {dayz_skilllevel = 0;};

while {debugMonitor} do
{

if( ((getPlayerUID player) in AdminList) || ((getPlayerUID player) in ModList) ) then { 
	
	_playZ_debug_text1 = parseText format ["
	<t size='0.95' font='Bitstream' align='left' >[%18]</t><t size='0.95' font='Bitstream' align='right'>[FPS: %10]</t><br/>
	<t size='0.95' font='Bitstream' align='center' color='#FFBF00'>Survived %7 Days</t><br/>
	<t size='0.95' font='Bitstream' align='left' >Players: %8</t><t size='0.95 'font='Bitstream' align='right'>Within 500m: %11</t><br/>
	<t size='0.95' font='Bitstream' align='left' >Vehicles:</t><t size='0.95' font='Bitstream'align='right'>%13(%14)</t><br/>
	<t size='0.95' font='Bitstream' align='left'>Air: %16</t><t size='0.95' font='Bitstream'align='right'>Sea: %23</t><br/>
	<t size='0.95' font='Bitstream' align='left' >All Bikes: %15</t><t size='0.95' font='Bitstream'align='right'>Cars: %17</t><br/>
	<t size='0.95' font='Bitstream' align='left' >Zombies (alive/total): </t><t size='0.95' font='Bitstream' align='right'>%20(%19)</t><br/>
	<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Zombies Killed: </t><t size='0.95' font='Bitstream' align='right'>%2</t><br/>
	<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Headshots: </t><t size='0.95' font='Bitstream' align='right'>%3</t><br/>
	<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Murders: </t><t size='0.95' font='Bitstream' align='right'>%4</t><br/>
	<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Bandits Killed: </t><t size='0.95' font='Bitstream' align='right'>%5</t><br/>
	<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Humanity: </t><t size='0.95' font='Bitstream' align='right'>%6</t><br/>
	<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Blood: </t><t size='0.95' font='Bitstream' align='right'>%9</t><br/>
	<t size='0.95' font='Bitstream' align='left' >GPS: %22</t><t size='0.95' font='Bitstream' align='right'>DIR: %24</t><br/>
	<t size='0.95'font='Bitstream'align='center' >%21</t><br/>",
	/*  1 */	(name player),
	/*  2 */	(player getVariable['zombieKills', 0]), 
	/*  3 */	(player getVariable['headShots', 0]),
	/*  4 */	(player getVariable['humanKills', 0]),
	/*  5 */	(player getVariable['banditKills', 0]),
	/*  6 */	(player getVariable['humanity', 0]),
	/*  7 */	(dayz_skilllevel),
	/*  8 */	(count playableUnits),
	/*  9 */	r_player_blood,
	/* 10 */	(round diag_fps),
	/* 11 */	(({isPlayer _x} count (getPos vehicle player nearEntities [["AllVehicles"], 500]))-1),
	/* 12 */	viewdistance,
	/* 13 */	(count([6800, 9200, 0] nearEntities [["StaticWeapon","Car","Motorcycle","Tank","Air","Ship"],25000])),
	/* 14 */	count vehicles,
	/* 15 */	(count([6800, 9200, 0] nearEntities [["Motorcycle"],25000])),
	/* 16 */	(count([6800, 9200, 0] nearEntities [["Air"],25000])),
	/* 17 */	(count([6800, 9200, 0] nearEntities [["Car"],25000])),
	/* 18 */	(gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'displayName')),
	/* 19 */	(count entities "zZombie_Base"),
	/* 20 */	({alive _x} count entities "zZombie_Base"),
	/* 21 */	(getPosASL player),
	/* 22 */	(mapGridPosition getPos player),
	/* 23 */	(count([6800, 9200, 0] nearEntities [["Ship"],25000])),
	/* 24 */	(round(getDir (vehicle player)))
];


	_cursor = cursorTarget;
	_playZ_debug_text2 = "";
	if(!isNull _cursor) then {

		if ( /*_cursor isKindOf "AllVehicles"*/ true ) then {

			_playZ_debug_text2 = parseText format ["
			<t size='0.95' font='Bitstream' align='left' >[%10]</t><t size='0.95' font='Bitstream' align='right'>.</t><br/>
			<t size='0.95' font='Bitstream' align='center' color='#FFBF00'>%1</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>ObjectID: </t><t size='0.95' font='Bitstream' align='right'>%2</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>ObjectUID: </t><t size='0.95' font='Bitstream' align='right'>%3</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Damage: </t><t size='0.95' font='Bitstream' align='right'>%4</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Fuel: </t><t size='0.95' font='Bitstream' align='right'>%12</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Type: </t><t size='0.95' font='Bitstream' align='right'>%7</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>PLAYZ_whenSpawned: </t><t size='0.95' font='Bitstream' align='right'>%8</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>PLAYZ_whenDestroyed: </t><t size='0.95' font='Bitstream' align='right'>%9</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>PLAYZ_classname: </t><t size='0.95' font='Bitstream' align='right'>%13</t><br/>
			<t size='0.95' font='Bitstream' align='left' >GPS: %11</t><t size='0.95' font='Bitstream' align='right'>DIR: %6</t><br/>
			<t size='0.95'font='Bitstream'align='center' >%5</t><br/>",
	
			/*  1 */	(_cursor),
			/*  2 */	(_cursor getVariable ["ObjectID", "0"]), 
			/*  3 */	(_cursor getVariable ["ObjectUID", "0"]),
			/*  4 */	(damage _cursor),
			/*  5 */	(getPosASL _cursor),
			/*  6 */	(round getDir _cursor),
			/*  7 */	(typeOf _cursor),
			/*  8 */	(_cursor getVariable ["PLAYZ_whenSpawned", "0"]),
			/*  9 */	(_cursor getVariable ["PLAYZ_whenDestroyed", "0"]),
			/* 10 */	(gettext (configFile >> 'CfgVehicles' >> (typeof _cursor) >> 'displayName')),
			/* 11 */	(mapGridPosition getPos _cursor),
			/* 12 */	(fuel _cursor),
			/* 13 */	(_cursor getVariable ["PLAYZ_classname", "N/A"]),
	
			/* __ */	0
			];

		} else {

			_playZ_debug_text2 = parseText format ["
			<t size='0.95' font='Bitstream' align='left' >[%12]</t><t size='0.95' font='Bitstream' align='right'>.</t><br/>
			<t size='0.95' font='Bitstream' align='center' color='#FFBF00'>%1</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Damage: </t><t size='0.95' font='Bitstream' align='right'>%4</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Disp. Name: </t><t size='0.95' font='Bitstream' align='right'>%10</t><br/>
			<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Type: </t><t size='0.95' font='Bitstream' align='right'>%7</t><br/>
			<t size='0.95' font='Bitstream' align='left' >GPS: %11</t><t size='0.95' font='Bitstream' align='right'>DIR: %6</t><br/>
			<t size='0.95'font='Bitstream'align='center' >%5</t><br/>",
	
			/*  1 */	(_cursor),
			/*  2 */	(_cursor getVariable ["ObjectID", "0"]), 
			/*  3 */	(_cursor getVariable ["ObjectUID", "0"]),
			/*  4 */	(damage _cursor),
			/*  5 */	(getPosASL _cursor),
			/*  6 */	(round getDir _cursor),
			/*  7 */	(typeOf _cursor),
			/*  8 */	(_cursor getVariable ["PLAYZ_whenSpawned", "0"]),
			/*  9 */	(_cursor getVariable ["PLAYZ_whenDestroyed", "0"]),
			/* 10 */	(gettext (configFile >> 'CfgVehicles' >> (typeof _cursor) >> 'displayName')),
			/* 11 */	(mapGridPosition getPos _cursor),
			/* 12 */	(name _cursor),
	
			/* __ */	0
			];

		};



	} else {
		_playZ_debug_text2 = "Point";
	};

	hintSilent composeText[_playZ_debug_text1, lineBreak, _playZ_debug_text2];

} else {


	_time = (round(180-(serverTime)/60));
	_hours = (floor(_time/60));
	_minutes = (_time - (_hours * 60));

	switch(_minutes) do
	{
		case 9: {_minutes = "09"};
		case 8: {_minutes = "08"};
		case 7: {_minutes = "07"};
		case 6: {_minutes = "06"};
		case 5: {_minutes = "05"};
		case 4: {_minutes = "04"};
		case 3: {_minutes = "03"};
		case 2: {_minutes = "02"};
		case 1: {_minutes = "01"};
		case 0: {_minutes = "00"};
	};

	// You can delete the server website here line (entire line) if you want
	// You can also delete the entire TeamSpeak IP line if you want
	_playZ_debug_text1 = parseText format ["
		<t size='1.25' font='Bitstream' align='center' color='#5882FA'>playZ DayZ Mod Server</t><br/>
		<t size='1.05' font='Bitstream' align='center' color='#5882FA'>dayZ.playZ.rocks</t><br/> 
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'></t><t size='0.95 'font='Bitstream' align='right'></t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Players Online: </t><t size='0.95 'font='Bitstream' align='right'>%1</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Murders: </t><t size='0.95' font='Bitstream' align='right'>%3</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Bandits Killed: </t><t size='0.95' font='Bitstream' align='right'>%4</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Zombies Killed: </t><t size='0.95' font='Bitstream' align='right'>%2</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Humanity: </t><t size='0.95' font='Bitstream' align='right'>%6</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Blood: </t><t size='0.95' font='Bitstream' align='right'>%5</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>FPS: </t><t size='0.95' font='Bitstream' align='right'>%7</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'></t><t size='0.95 'font='Bitstream' align='right'></t><br/>
		<t size='1.15' font='Bitstream'align='center' color='#5882FA'>ts.playZ.rocks</t><br/>",
		//<t size='1.15' font='Bitstream'align='center' color='#5882FA'>Server restart in %8:%9</t><br/>",

		(count playableUnits),
		(player getVariable['zombieKills', 0]),
		(player getVariable['humanKills', 0]),
		(player getVariable['banditKills', 0]),
		(player getVariable['USEC_BloodQty', r_player_blood]),
		(player getVariable['humanity', 0]),
		(round diag_fps),
		_hours,
		_minutes
		];

		_playZ_debug_text2 = "";
		hintSilent composeText[_playZ_debug_text1, lineBreak, _playZ_debug_text2];

	};

};

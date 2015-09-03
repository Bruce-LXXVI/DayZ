


	disableSerialization;
	DS_really_loud_sounds = {[60,15] call fnc_usec_pitchWhine;for "_i" from 1 to 15 do {playSound format ["%1",_this select 0];};};
	DS_double_cut = {1 cutText [format ["%1",_this select 0],"PLAIN DOWN"];2 cutText [format ["%1",_this select 0],"PLAIN"];};
	DS_slap_them = {_randomnr = [2,-1] call BIS_fnc_selectRandom;(vehicle player) SetVelocity [_randomnr * random (4) * cos getdir (vehicle player), _randomnr * random (4) * cos getdir (vehicle player), random (4)];};
	while {!isServer} do {
		private ["_playz_kickMe"];
		waitUntil {!isNull player};
		_playz_kickMe = player getVariable["PlayZ_kickMe", ""];
		if( _playz_kickMe != "" ) then {

			playMusic ["PitchWhine",0];
			[] spawn DS_slap_them;
			["beat04"] spawn DS_really_loud_sounds;
			[_playz_kickMe] spawn DS_double_cut;
			sleep 3;
			1 fademusic 10;
			1 fadesound 10;
			disableUserInput true;
			startLoadingScreen ["You are being disconnected", "DayZ_loadingScreen"];
			progressLoadingScreen 0.6;sleep 2;["All_Haha"] spawn DS_really_loud_sounds;
			progressLoadingScreen 0.8;sleep 2.25;
			progressLoadingScreen 1.0;sleep 2;["All_Haha"] spawn DS_really_loud_sounds;
			endLoadingScreen;
			disableUserInput false;
			endMission "LOSER";

			//PlayZ_KICK = _playz_kickMe;
			//publicVariable "PlayZ_KICK";

			//player setDamage 1;

		};
		sleep 1;
	};



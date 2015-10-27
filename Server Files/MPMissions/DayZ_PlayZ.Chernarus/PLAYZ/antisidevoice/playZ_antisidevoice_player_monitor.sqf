



	disableSerialization;
	DS_really_loud_sounds = {[60,15] call fnc_usec_pitchWhine;for "_i" from 1 to 15 do {playSound format ["%1",_this select 0];};};
	DS_double_cut = {1 cutText [format ["%1",_this select 0],"PLAIN DOWN"];2 cutText [format ["%1",_this select 0],"PLAIN"];};
	DS_slap_them = {_randomnr = [2,-1] call BIS_fnc_selectRandom;(vehicle player) SetVelocity [_randomnr * random (4) * cos getdir (vehicle player), _randomnr * random (4) * cos getdir (vehicle player), random (4)];};
	while {!isServer} do {
		waitUntil {sleep 1;((!isNull findDisplay 63) && (!isNull findDisplay 55))};
		if (ctrlText ((findDisplay 55) displayCtrl 101) == "\ca\ui\textures\mikrak.paa") then {
			if (ctrlText ((findDisplay 63) displayCtrl 101) == localize "STR_SIDE_CHANNEL") then {
				[] spawn {
					if (isNil "reset_timer") then {
						reset_timer = true;
						sleep 120;
						disconnect_me = nil;
						warn_one = nil;
						warn_last = nil;
						reset_timer = nil;
					};
				};
				if (isNil "disconnect_me") then {disconnect_me = 0;} else {disconnect_me = disconnect_me + 1;};
				if (disconnect_me == 0) then {
					if (isNil "warn_one") then {
						warn_one = true;
						systemChat ("Please do not use voice on sidechat, this is your first and final warning!");
						systemChat ("Bitte nicht im Sidechat reden, dies ist die erste und letzte Warnung.");
						[] spawn DS_slap_them;
						["beat04"] spawn DS_really_loud_sounds;
						["NO VOICE ON SIDE"] spawn DS_double_cut;
					};
				};
				if (disconnect_me >= 3) then {
					if (isNil "warn_last") then {
						warn_last = true;

						playMusic ["PitchWhine",0];
						[] spawn DS_slap_them;
						disableUserInput true;
						["beat04"] spawn DS_really_loud_sounds;
						["We warned you..."] spawn DS_double_cut;
						sleep 3;
						1 fademusic 10;
						1 fadesound 10;
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
				};
			};
		};
		sleep 2;
	};

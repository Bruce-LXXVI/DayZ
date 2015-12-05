/***************This file is customizable**************
	Required knowledge: Low to moderate
	
	To bind an option to a function key:
	1. Remove the // infront of the key type you want to use
	2. Change DIRECTORY_HERE to the folder the sqf file is saved in (such as tools or skins)
	3. Change FILE_NAME_HERE.sqf to the file name you want to use ex. AdminMode.sqf
	You have now bound an option to that F key!
	
	Some files require special values to be passed to them to work correctly so not ALL actions can be
	configured into this file. If you wish to bind an Admin Mode or Mod Mode option such as god mode
	to these keys you will require more work to make it work correctly.
	
	To change F1-F3 simply change the file name like you did in step 2 above
	To disable the use of a single F key simply comment out the line by add // at the start of the line
	To remove all function key support simply delete or comment out the lines in this file.
*/

F1_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 59) then {[] execVM ""%1\tools\Teleport\Teleport.sqf"";true};", EAT_directory]];
F2_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 60) then {[] execVM ""%1\tools\Teleport\TPtoME.sqf"";true};", EAT_directory]];
F3_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 61) then {[] execVM ""%1\tools\Teleport\TpToPlayer.sqf"";true};", EAT_directory]];
// F4 is reserved for AdminMode.sqf and modMode.sqf
// F5 is reserved for ESPenhanced.sqf
// F6 is reserved for spectate.sqf
// F7_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 65) then {[] execVM ""%1\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};", EAT_directory]];
// F8_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 66) then {[] execVM ""%1\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};", EAT_directory]];
// F9_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 67) then {[] execVM ""%1\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};", EAT_directory]];
// F10_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 68) then {[] execVM ""%1\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};", EAT_directory]];
// F11_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 87) then {[] execVM ""%1\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};", EAT_directory]];
// WARNING: F12 is the screen shot key for steam
// F12_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 88 then {[] execVM ""%1\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};", EAT_directory]];

// Used to delete target objects
Print_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 183) then {[] execVM ""%1\tools\DatabaseRemove.sqf"";true};", EAT_directory]];
Scroll_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 70) then {[] execVM ""%1\tools\PointToDestroyPERM.sqf"";true};", EAT_directory]];
Pause_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown",format["if ((_this select 1) == 197) then {[] execVM ""%1\tools\PointToRepairPERM.sqf"";true};", EAT_directory]];

diag_log("[EAT] FunctionKeys.sqf Loaded");

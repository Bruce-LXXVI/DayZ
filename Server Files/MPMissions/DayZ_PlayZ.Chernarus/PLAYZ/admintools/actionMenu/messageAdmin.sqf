private ["_dialog"];
SendDialogText = "";

// Sleep to make sure scroll menu is cleared
Sleep 0.2;

_dialog = createdialog "EAT_messageBox_Dialog";

ctrlSetText [1001,"Send a message to admin"];

waitUntil {!dialog};
if(SendDialogText == "") exitWith {};

EAT_serverMessageAdmin = name vehicle player + ": " + SendDialogText;
[] spawn {publicVariable "EAT_serverMessageAdmin";};

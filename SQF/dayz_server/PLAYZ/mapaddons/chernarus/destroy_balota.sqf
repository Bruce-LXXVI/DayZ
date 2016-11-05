//
//



_objs=nearestObjects[[4787.3516, 2274.3762, 0], [], 300];

{
	_x setDamage 1;
	diag_log format["%1 Destroyed %2", PLAYZ_logname, _x];
} forEach _objs;





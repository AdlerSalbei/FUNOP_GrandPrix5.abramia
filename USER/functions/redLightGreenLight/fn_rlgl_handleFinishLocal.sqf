player setVariable ["GRAD_grandPrix_rlgl_timeStart", time, true];

[
	{
		player inArea GRAD_grandPrix_rlgl_finish
	},
	{
		player setVariable ["GRAD_grandPrix_rlgl_reachedFinish", true, true];
		private _start = player getVariable ["GRAD_grandPrix_rlgl_timeStart", time];
		private _timeTaken = time - _start;
		player setPosASL (getPosASL GRAD_grandPrix_rlgl_platform);
		player addWeapon "Binocular";
		hint format ["Du hast für deinen Durchlauf %1 gebraucht! Bitte warte bis deine Mitspieler das Ziel erreicht haben.", [_timeTaken, "MM:SS.MS"] call BIS_fnc_secondsToString];
	},
	[]
] call CBA_fnc_waitUntilAndExecute;
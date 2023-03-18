// Play the track introduction
playSound "ZiG_Description";

[{
	player setVariable ["GRAD_grandPrix_ZiG_introDone", true, true];
}, [], 123]call CBA_fnc_waitAndExecute;

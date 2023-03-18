// Play the track introduction
playSound "RLGL_Description";

[{
	player setVariable ["GRAD_grandPrix_rlgl_introDone", true, true];
}, [], 111]call CBA_fnc_waitAndExecute;

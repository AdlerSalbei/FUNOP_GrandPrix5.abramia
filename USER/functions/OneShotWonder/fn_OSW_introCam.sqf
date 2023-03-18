// Play the track introduction
playSound "PUPS_Description";

[{
	player setVariable ["GRAD_grandPrix_osw_introDone", true, true];
}, [], 121]call CBA_fnc_waitAndExecute;

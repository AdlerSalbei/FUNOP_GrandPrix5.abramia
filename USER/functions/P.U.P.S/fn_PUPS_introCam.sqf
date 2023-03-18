// Play the track introduction
playSound "PUPS_Description";

[{
	player setVariable ["GRAD_grandPrix_PUPS_introDone", true, true];
}, [], 121]call CBA_fnc_waitAndExecute;

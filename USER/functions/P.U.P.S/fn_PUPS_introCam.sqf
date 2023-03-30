params ["_target", "_player"];

_target setVariable ["GRAD_grandPrix_PUPS_introPlaying", true, true];

// Play the track introduction
playSound3D ["x\grad_grandprix5\addons\sounds\data\PUPS_Description.ogg", _target, false, (getPosASL _target vectorAdd [0,0,1.6]), 100, 1, 50];

[{
	params ["_target"];
	_target setVariable ["GRAD_grandPrix_PUPS_introDone", true, true];
	_target setVariable ["GRAD_grandPrix_PUPS_introPlaying", false, true];
}, [_target], 123]call CBA_fnc_waitAndExecute;

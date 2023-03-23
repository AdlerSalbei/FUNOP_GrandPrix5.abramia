params ["_target", "_player"];

_target setVariable ["GRAD_grandPrix_ZiG_introPlaying", true, true];

// Play the track introduction
playSound3D ["x\grad_grandprix5\addons\sounds\data\ZiG_Description.ogg", _target, false, (getPosASL _target vectorAdd [0,0,1.6]), 5, 1, 15];

[{
	params ["_target"];
	_target setVariable ["GRAD_grandPrix_ZiG_introDone", true, true];
	_target setVariable ["GRAD_grandPrix_ZiG_introPlaying", false, true];
}, [_target], 122]call CBA_fnc_waitAndExecute;

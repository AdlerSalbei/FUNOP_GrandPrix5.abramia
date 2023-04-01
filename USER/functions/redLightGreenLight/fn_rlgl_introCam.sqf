params ["_target", "_player"];

_target setVariable ["GRAD_grandPrix_rlgl_introPlaying", true, true];

// Play the track introduction
// playSound3D ["x\grad_grandprix5\addons\sounds\data\RLGL_Description.ogg", _target, false, (getPosASL _target vectorAdd [0,0,1.6]), 100, 1, 50];
// ["x\grad_grandprix5\addons\sounds\data\RLGL_Description.ogg", _target, false, (getPosASL _target vectorAdd [0,0,1.6]), 100, 1, 60] remoteExec ["playSound3D", 2, false];
private _players = units (group _player);
["RLGL_Description"] remoteExecCall ["playSound", _players + [[_target] call grad_grandprix_fnc_common_getNearestZeus]];

[{
	params ["_target"];
	_target setVariable ["GRAD_grandPrix_rlgl_introDone", true, true];
	_target setVariable ["GRAD_grandPrix_rlgl_introPlaying", false, true];
}, [_target], 110]call CBA_fnc_waitAndExecute;

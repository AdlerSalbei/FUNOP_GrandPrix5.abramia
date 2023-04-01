params ["_target", "_player"];

// Play the track introduction
playSound3D ["x\grad_grandprix5\addons\sounds\data\OSW_Description.ogg", _target, true, (getPosASL _target vectorAdd [0,0,1.6]), 100, 1, 60];
// ["x\grad_grandprix5\addons\sounds\data\OSW_Description.ogg", _target, true, (getPosASL _target vectorAdd [0,0,1.6]), 100, 1, 60] remoteExec ["playSound3D", 2, false];

[{
	{
		_x setVariable ["GRAD_grandPrix_osw_introDone", true, true];
	}forEach units group _this;
}, _player, 73]call CBA_fnc_waitAndExecute;

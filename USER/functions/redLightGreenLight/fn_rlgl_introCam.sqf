params ["_target", "_player"];

// Play the track introduction
playSound3D ["x\grad_grandprix5\addons\sounds\data\RLGL_Description.ogg", _target, false, (getPosASL _target vectorAdd [0,0,1.6]), 5, 1, 15];

[{
	{
		_x setVariable ["GRAD_grandPrix_rlgl_introDone", true, true];
	}forEach units group _this;
}, _player, 121]call CBA_fnc_waitAndExecute;

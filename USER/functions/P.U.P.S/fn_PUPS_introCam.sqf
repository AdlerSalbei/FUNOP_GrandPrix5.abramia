params ["_target", "_player"];

// Play the track introduction
playSound3D ["x\grad_grandprix5\addons\sounds\data\PUPS_Description.ogg", _target, false, (getPosASL _target vectorAdd [0,0,1.6]), 1, 1, 0];

[{
	{
		_x setVariable ["GRAD_grandPrix_PUPS_introDone", true, true];
	}forEach units group _player;
}, [], 121]call CBA_fnc_waitAndExecute;

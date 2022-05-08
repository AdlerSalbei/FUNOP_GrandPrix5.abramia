params ["_player"];

private _teams = [1,1,2,2] call BIS_fnc_arrayShuffle;
private _group = group _player;

{
	private _index = _teams select _forEachIndex;
	
	[_index] remoteExecCall ["grad_grandPrix_fnc_DD_teleport", _x, false];
}forEach units _group;

[{
	params ["_target", "_group"];

	[_target, _group] call grad_grandPrix_fnc_DD_handleStage;
}, [_target, _group], 1] call CBA_fnc_waitAndExecute;
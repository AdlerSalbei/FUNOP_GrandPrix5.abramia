params ["_player", "_station"];

if (_station getVariable ["DD_stationIsRunning", false]) exitWith {};

_station setVariable ["DD_stationIsRunning", true, true];

private _teams = [1,1,2,2] call BIS_fnc_arrayShuffle;
private _group = group _player;
_group setVariable ["GRAD_GrandPrix_currentStage", "DD", true];

{
	private _index = _teams select _forEachIndex;
	
	[_index] remoteExecCall ["grad_grandPrix_fnc_DD_teleport", _x, false];
}forEach units _group;

[{
	params ["_station", "_group"];

	[_station, _group] call grad_grandPrix_fnc_DD_handleStage;
}, [_station, _group], 2] call CBA_fnc_waitAndExecute;
params ["_player", "_station"];

if (_station getVariable ["DD_stationIsRunning", false]) exitWith {};

_station setVariable ["DD_stationIsRunning", true, true];

private _teams = [[1, true], [1, false], [2, true], [2, false]] call BIS_fnc_arrayShuffle;
private _group = group _player;
private _units = units _group;
_group setVariable ["GRAD_GrandPrix_currentStage", "DD", true];


{
	private _index = [];

	if (count _units == 4) then {
		_index = _teams select _forEachIndex;
	} else {
		_index = [1, ([true, false, "Commander"] select _forEachIndex)];
	};
	
	[_index] remoteExecCall ["grad_grandPrix_fnc_DD_teleport", _x, false];

	_index params ["_num", "_type"];
	private _vehicleName = missionnamespace getvariable [ format ["%1", "dd_tank_0" + str _num], objNull];

	if (_type isEqualType true) then {
		if (_type) then {
			_x moveInDriver _vehicleName;
		} else {
			_x moveInGunner _vehicleName;
		};
	} else {
		_x moveInCommander _vehicleName;
	};
}forEach _units;

[{
	params ["_station", "_group"];

	[_station, _group] call grad_grandPrix_fnc_DD_handleStage;
}, [_station, _group], 2] call CBA_fnc_waitAndExecute;

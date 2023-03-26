params ["_player", "_station"];

if (_station getVariable ["DD_stationIsRunning", false]) exitWith {};

_station setVariable ["DD_stationIsRunning", true, true];

private _teams = [1,1,2,2] call BIS_fnc_arrayShuffle;
private _group = group _player;
private _units = units _group;
_group setVariable ["GRAD_GrandPrix_currentStage", "DD", true];


{
	if (count _units == 4) then {
		private _index = _teams select _forEachIndex;
	} else {
		private _index = 1;
	};
	
	[_index] remoteExecCall ["grad_grandPrix_fnc_DD_teleport", _x, false];

	[{
		params ["_unit", "_index"];

		private _vehicleName = missionnamespace getvariable [ format ["%1", "dd_tank_0" + str _index], objNull];
		
		_unit moveInAny _vehicleName;
	}, [_x, _index], 0.1 + (_forEachIndex /10 )] call CBA_fnc_waitAndExecute;
}forEach _units;

[{
	params ["_station", "_group"];

	[_station, _group] call grad_grandPrix_fnc_DD_handleStage;
}, [_station, _group], 2] call CBA_fnc_waitAndExecute;

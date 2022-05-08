params ["_station", "_group"];

if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

_station setVariable ["DD_stationIsRunning", true, true];

["grad_grandPrix_race_triggerCountdown", [], units _group] call CBA_fnc_targetEvent;

[{
	params ["", "_group"];
	
	count ((units _group) select { _x getVariable ["GRAD_grandPrix_DD_complete", false] }) isEqualTo (count (units _group))
},{
	[{
		params ["_station", "_group"];

		private _totalTime = 0;
		{
			private _start = _x getVariable ["GRAD_grandPrix_DD_startTime", 0];
			private _end = _x getVariable ["GRAD_grandPrix_DD_endTime", 0];
			_totalTime = _totalTime + (_end - _start);
		} forEach (units _group);

		private _averageTime = _totalTime / (count (units _group));
		private _points = [_group, _averageTime, 470, 1000, "Daredevil"] call GRAD_grandPrix_fnc_addTime;

		private _allInstructors = [];
		{
			_allInstructors pushBackUnique (getAssignedCuratorUnit _x);
		} forEach allCurators;

		private _nearestInstructor = objNull;
		private _distance = _station distance (_allInstructors select 0);
		{
			if ((_station distance _x) < _distance) then {
				_distance = _station distance _x;
				_nearestInstructor = _x;
			}	
		} forEach _allInstructors;

		[ format ["Ihr hab durchschnittlich %1 gebraucht. Damit habt ihr euch %2 Punkte erspielt!", [_averageTime, "MM:SS.MS"] call BIS_fnc_secondsToString, _points]] remoteExec ["hint", _group + [_nearestInstructor]];

		_station setVariable ["DD_stationIsRunning", false, true];
	},7,[_station, _group]] call CBA_fnc_waitAndExecute;
},[_station, _group]] call CBA_fnc_waitUntilAndExecute;

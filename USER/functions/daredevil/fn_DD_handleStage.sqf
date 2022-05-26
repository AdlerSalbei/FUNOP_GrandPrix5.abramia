params ["_station", "_group"];

if (!isServer) exitWith {
	_this remoteExec [_fnc_scriptName, 2]; 
};

["grad_grandPrix_race_triggerCountdown", [], units _group] call CBA_fnc_targetEvent;

[{
	params ["", "_group"];

	private _units = units _group;
	
	count (_units select { _x getVariable ["GRAD_grandPrix_DD_complete", false] }) isEqualTo (count _units)
},{
	[{
		params ["_station", "_group"];

		private _units = units _group;

		private _totalTime = 0;
		{
			private _start = _x getVariable ["GRAD_grandPrix_DD_startTime", 0];
			private _end = _x getVariable ["GRAD_grandPrix_DD_endTime", 0];
			_totalTime = _totalTime + (_end - _start);
		} forEach _units;

		private _averageTime = _totalTime / (count _units);
		private _points = [_group, _averageTime, 470, 1000, "Daredevil"] call GRAD_grandPrix_fnc_addTime;

		[format ["Ihr hab durchschnittlich %1 gebraucht. Damit habt ihr euch %2 Punkte erspielt!", [_averageTime, "MM:SS.MS"] call BIS_fnc_secondsToString, _points]] remoteExec ["hint", _group];

		_station setVariable ["DD_stationIsRunning", false, true];
	}, _this, 7] call CBA_fnc_waitAndExecute;
}, [_station, _group]] call CBA_fnc_waitUntilAndExecute;

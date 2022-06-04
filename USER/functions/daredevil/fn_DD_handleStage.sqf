params ["_station", "_group"];

if (!isServer) exitWith {_this remoteExec [_fnc_scriptName, 2];};

["grad_grandPrix_race_triggerCountdown", [], units _group] call CBA_fnc_targetEvent;

[{
	params ["", "_group"];

	private _units = units _group;
	
	count (_units select { _x getVariable ["GRAD_grandPrix_DD_complete", false] }) isEqualTo (count _units)
},{
	[{
		params ["_station", "_group"];

		private _units = units _group;

		private _playerTimes = [];
		private _totalTime = 0;
		{
			private _time = _x getVariable ["GRAD_grandPrix_DD_totalTime", 0];
			_totalTime = _totalTime + _time;
			_playerTimes pushBack [name _x, _time ];
		} forEach _units;

		private _averageTime = _totalTime / (count _units);
		private _points = [_group, _averageTime, 470, 1000, "Daredevil"] call GRAD_grandPrix_fnc_addTime;

		private _msg = format ["<t align='left'>Ihr hab durchschnittlich %1 gebraucht. Damit habt ihr euch %2 Punkte erspielt!</t>", [_averageTime, "MM:SS.MS"] call BIS_fnc_secondsToString, _points]; 
		_msg = _msg + "<br /> <br /><t align='left'>Spieler Zeit:</t>"; 

		{ 
			_msg = _msg + format ["<br /> <t align='center'>%1:</t> <t align='right'>%2</t>", _x select 0, (_x select 1) * 100]; 
		}forEach _playerTimes; 

		[parseText _msg] remoteExec ["hint", _units + [_nearestInstructor]];

		[{
			params ["_station", "_group"];

			[] remoteExecCall ["grad_grandPrix_fnc_DD_backPort", _group];

			{
				_x setPos (_x getVariable "grad_grandprix_fnc_DD_vehPos");
				_x setDir (_x getVariable "grad_grandprix_fnc_DD_vehDir");
			}forEach [dd_tank_01, dd_tank_02];

			_station setVariable ["DD_stationIsRunning", false, true];
		}, _this, 5] call CBA_fnc_waitAndExecute;
	}, _this, 7] call CBA_fnc_waitAndExecute;
}, [_station, _group]] call CBA_fnc_waitUntilAndExecute;

if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };


params ["_group"];

private _allPositions = [GRAD_grandPrix_OSW_position_1, GRAD_grandPrix_OSW_position_2, GRAD_grandPrix_OSW_position_3];
{
	_x setVariable ["GRAD_grandPrix_timesVisited", 0, true];
} forEach _allPositions;

private _activePlayers = missionNamespace getVariable ["GRAD_grandPrix_OSW_activePlayers", [[player], []] select isMultiplayer];
private _playerCount = count _activePlayers;

while {!([_allPositions, _playerCount] call GRAD_grandPrix_fnc_OSW_isComplete)} do {
	private _activePlayers = missionNamespace getVariable ["GRAD_grandPrix_OSW_activePlayers", [[player], []] select isMultiplayer];
	private _activePlayersReady = _activePlayers select { _x getVariable ["GRAD_grandPrix_OSW_currentCompleted", true] };

	{
		private _visited = _x getVariable ["GRAD_grandPrix_OSW_visited", []];
		private _remaining = _allPositions select { !(_x in _visited) };
		if (_remaining isEqualTo []) then {
			[_x] call GRAD_grandPrix_fnc_OSW_endStationLocal;
		} else {
			private _available = _remaining select { !(_x getVariable ["GRAD_grandPrix_OSW_currentlyActive", false]) };;
			if (_available isEqualTo []) then { continue };
			[selectRandom _available] remoteExec ["GRAD_grandPrix_fnc_OSW_handlePosition", _x];
		};
	} forEach _activePlayersReady;

	sleep 0.5;
};

systemChat "stage complete!";
#define BEST_TIME 20

if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

params ["_station", "_group"];

_station setVariable ["stationIsRunning", true, true];

private _allPositions = [GRAD_grandPrix_OSW_position_1, GRAD_grandPrix_OSW_position_2, GRAD_grandPrix_OSW_position_3, GRAD_grandPrix_OSW_position_4, GRAD_grandPrix_OSW_position_5, GRAD_grandPrix_OSW_position_6, GRAD_grandPrix_OSW_position_7, GRAD_grandPrix_OSW_position_8, GRAD_grandPrix_OSW_position_9, GRAD_grandPrix_OSW_position_10, GRAD_grandPrix_OSW_position_11];
{
	_x setVariable ["GRAD_grandPrix_timesVisited", 0, true];
} forEach _allPositions;

missionNamespace setVariable ["GRAD_grandPrix_OSW_activePlayers", units _group, true];
private _activePlayers = units _group;
private _playerCount = count _activePlayers;
{
	_x setVariable ["GRAD_grandPrix_OSW_totalTime", 0, true];
	// add Gun magazine
	_x addMagazine "1Rnd_45ACP_Cylinder"; 
	_x addWeapon "GrandPrix_hgun_Pistol_heavy_02_F";
} forEach _activePlayers;

sleep 2;

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

sleep 7;

private _allInstructors = [];
{
	_allInstructors pushBackUnique (getAssignedCuratorUnit _x);
} forEach allCurators;
private _nearestInstructor = objNull;
private _distance = _station distance (_allInstructors#0);
{
	if ((_station distance _x) < _distance) then {
		_distance = _station distance _x;
		_nearestInstructor = _x;
	}	
} forEach _allInstructors;

private _players = units _group;
private _groupTime = 0;
{
	private _playerTime = _x getVariable ["GRAD_grandPrix_OSW_totalTime", 0];
	_groupTime = _groupTime + _playerTime;
	removeAllWeapons _x;
} forEach _players;

private _points = [_group, _groupTime, BEST_TIME * (count _players), 1000, "One Shot Wonder"] call grad_grandPrix_fnc_addTime;
private _result = format [
	"Zusammen habt ihr %1 gebraucht.\nDamit habt ihr euch %2 Punkte erspielt!",
	[_groupTime, "MM:SS.MS"] call BIS_fnc_secondsToString,
	_points
];

[_result] remoteExec ["hint", _players + [_nearestInstructor]];
// missionNamespace setVariable ["GRAD_grandPrix_OSW_activePlayers", [[player], []] select isMultiplayer]
_station setVariable ["stationIsRunning", false, true];
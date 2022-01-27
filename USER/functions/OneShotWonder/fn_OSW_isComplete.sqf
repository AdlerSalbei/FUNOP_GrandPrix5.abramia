params ["_allPositions", "_playerCount"];

private _totals = 0;
{
	private _timesPlayed = _x getVariable ["GRAD_grandPrix_timesVisited", 0];
	_totals = _totals + _timesPlayed;
} forEach _allPositions;

systemChat format ["_totals: %1 | _positionCount: %2 | _playerCount: %3", _totals, count _allPositions, _playerCount];
if ((_totals == 0) || (_totals < ((count _allPositions) * _playerCount))) then {
	false
} else {
	true
};
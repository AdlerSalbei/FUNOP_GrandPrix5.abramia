if !(isServer) exitWith {_this remoteExecCall ["grad_grandPrix_fnc_addTime", 2];};

params ["_group", "_time", "_bestTime", "_maxPoints", "_stage", ["_worstTime", -1]];

private _points = (round((_bestTime/_time) * _maxPoints)) min _maxPoints;

[_group, _points, _stage] call grad_grandPrix_fnc_addPoints;

_points
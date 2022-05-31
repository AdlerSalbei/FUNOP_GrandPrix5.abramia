params ["_station"];

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

_nearestInstructor

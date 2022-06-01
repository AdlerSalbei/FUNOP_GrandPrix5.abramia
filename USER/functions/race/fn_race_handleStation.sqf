params ["_station", "_group"];

if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

_station setVariable ["stationIsRunning", true, true];

[] remoteExec ["grad_grandPrix_fnc_race_introCam", _group];

sleep 7;

private _units = units _group;
private _carPositions = [grad_grandPrix_fnc_race_car_1, grad_grandPrix_fnc_race_car_2, grad_grandPrix_fnc_race_car_3, grad_grandPrix_fnc_race_car_4, grad_grandPrix_fnc_race_car_5];
private _cars = [];
{
	private _pos = _carPositions # 0;
	private _car = "C_Hatchback_01_sport_F" createVehicle (getPos _pos);
	_car setDir (getDir _pos);
	_cars pushBack _car;
	_carPositions deleteAt 0;

	[_x, _car] remoteExec ["moveInDriver", _x];
	[_x, false] remoteExec ["allowDamage", _x];
} forEach _units;

sleep 2;

{
	[_x, false] remoteExec ["allowDamage", _x];
} forEach _cars;

waitUntil { count (_units select { _x getVariable ["GRAD_grandPrix_race_introDone", false] }) isEqualTo (count _units) };

sleep 1;

["grad_grandPrix_race_triggerCountdown", [], units _group] call CBA_fnc_targetEvent;
sleep 3;
[_group] remoteExec ["GRAD_grandPrix_fnc_race_handleCarPartLocal", _group];

waitUntil { count (_units select { _x getVariable ["GRAD_grandPrix_race_complete", false] }) isEqualTo (count _units) };
sleep 7;

private _totalTime = 0;
{
	_totalTime = _totalTime + (_x getVariable ["GRAD_grandPrix_race_timeTaken", 0]);
} forEach ;

private _averageTime = _totalTime / (count _units);
private _points = [_group, _averageTime, 470, 1000, "Race"] call GRAD_grandPrix_fnc_addTime;

//Get Nearest Zeus
private _nearestInstructor = [_station] call grad_grandprix_fnc_common_getNearestZeus;

[format ["Ihr hab durchschnittlich %1 gebraucht. Damit habt ihr euch %2 Punkte erspielt!", [_averageTime, "MM:SS.MS"] call BIS_fnc_secondsToString, _points]] remoteExec ["hint", _units + [_nearestInstructor]];

_station setVariable ["stationIsRunning", false, true];

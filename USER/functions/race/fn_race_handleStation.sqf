params ["_station", "_group"];

if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

_station setVariable ["stationIsRunning", true, true];
_group setVariable ["GRAD_GrandPrix_currentStage", "race", true];

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

sleep 1;

{
	[_x, false] remoteExec ["allowDamage", _x];
} forEach _cars;

// sleep 1;

["grad_grandPrix_race_triggerCountdown", [], units _group] call CBA_fnc_targetEvent;
sleep 3;
[_group] remoteExec ["GRAD_grandPrix_fnc_race_handleCarPartLocal", _group];

waitUntil { count (_units select { _x getVariable ["GRAD_grandPrix_race_complete", false] }) isEqualTo (count _units) };
sleep 7;

private _playerTimes = [];
private _totalTime = 0;
{
	private _playerTime = _x getVariable ["GRAD_grandPrix_race_timeTaken", 0];
	_totalTime = _totalTime + _playerTime;
	_playerTimes pushBack [name _x, _playerTime];
} forEach _units;

private _averageTime = _totalTime / (count _units);
private _points = [_group, _averageTime, 500, 1000, "Race"] call GRAD_grandPrix_fnc_addTime;

//Get Nearest Zeus
private _nearestInstructor = [_station] call grad_grandprix_fnc_common_getNearestZeus;

 
private _msg = format ["<t align='left'>Ihr hab durchschnittlich %1 gebraucht. Damit habt ihr euch %2 Punkte erspielt!</t>", [_averageTime, "MM:SS"] call BIS_fnc_secondsToString, _points]; 
_msg = _msg + "<br /> <br /><t align='left'>Spieler Zeit:</t>"; 

{ 
	_msg = _msg + format ["<br /> <t align='center'>%1:</t> <t align='right'>%2</t>", _x select 0, [_x select 1, "MM:SS"] call BIS_fnc_secondsToString]; 
}forEach _playerTimes; 

[parseText _msg] remoteExec ["hint", _units + [_nearestInstructor]];

_group setVariable ["GRAD_GrandPrix_currentStage", "", true];
_station setVariable ["stationIsRunning", false, true];

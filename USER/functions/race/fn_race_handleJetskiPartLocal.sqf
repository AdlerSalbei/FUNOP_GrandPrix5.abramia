params ["_group"];

private _playerPos = getPos player;
_playerPos = AGLToASL _playerPos;
_playerPos set [2, 0];
private _velY = (velocityModelSpace player) # 1;
deleteVehicle (vehicle player);

private _spawnPos = [random 1000, random 1000, (random 1000) + 200];
private _jetSki = "GRAD_TurboScooter" createVehicle _spawnPos;
_jetSki engineOn true;
_jetSki setDir 236.028;

_jetSki setPos _playerPos;
player moveInDriver _jetSki;
_jetSki setVelocityModelSpace [0, _velY min 90, 10];

_jetSki allowDamage false;

waitUntil { player inArea [[3184.99,2947.89,1.77915], 6.1, 5, 344.764, true, 5] };

private _end = [time, servertime] select isMultiplayer;
private _start = player getVariable ["GRAD_grandPrix_race_startTime", 0];
player setVariable ["GRAD_grandPrix_race_endTime", _end, true];
player setVariable ["GRAD_grandPrix_race_complete", true, true];

private _timeTaken = _end - _start;
private _time= [_timeTaken, "MM:SS.MS"] call BIS_fnc_secondsToString;

hint format ["Du hast %1 gebraucht!", _time];

waitUntil { (vehicle player) isNotEqualTo _jetski };
deleteVehicle _jetSki;
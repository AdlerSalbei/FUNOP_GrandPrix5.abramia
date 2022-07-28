params ["_group"];

private _playerPos = getPosASL player;
// _playerPos = AGLToASL _playerPos;
_playerPos set [2, 0];
private _velY = (velocityModelSpace player) # 1;
deleteVehicle (vehicle player);

private _spawnPos = [random 1000, random 1000, (random 1000) + 200];
// private _jetSki = "GRAD_TurboScooter" createVehicle _spawnPos;
private _jetSki = "C_Scooter_Transport_01_F" createVehicle _spawnPos;
_jetSki engineOn true;
private _dir = (AGLToASL _playerPos) getDir[6278.59,3561.73,8.04452];
_jetSki setDir _dir;

_jetSki setPosASL _playerPos;
player moveInDriver _jetSki;
_jetSki setVelocityModelSpace [0, _velY min 35, -2];

_jetSki allowDamage false;

waitUntil { player inArea [[3184.99,2947.89,1.77915], 6.1, 5, 344.764, true, 5] };

private _end = [time, servertime] select isMultiplayer;
private _start = player getVariable ["GRAD_grandPrix_race_startTime", 0];
private _timeTaken = _end - _start;

player setVariable ["GRAD_grandPrix_race_timeTaken", _timeTaken, true];
player setVariable ["GRAD_grandPrix_race_complete", true, true];

hint format ["Du hast %1 gebraucht!", [_timeTaken, "MM:SS"] call BIS_fnc_secondsToString];

waitUntil { (vehicle player) isNotEqualTo _jetski };
deleteVehicle _jetSki;
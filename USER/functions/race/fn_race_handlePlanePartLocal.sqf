params ["_group"];

waitUntil { player inArea GRAD_grandPrix_race_switchToPlane };

private _playerPos = getPos player;
private _playerDir = getDir player;
private _velY = (velocityModelSpace player) # 1;
deleteVehicle (vehicle player);

private _spawnPos = [random 1000, random 1000, (random 1000) + 200];
private _plane = "C_Plane_Civil_01_racing_F" createVehicle _spawnPos;
_plane engineOn true;
_plane allowDamage false;
_plane setDir _playerDir;

_plane setPos _playerPos;
player moveInDriver _plane;
_plane setVelocityModelSpace [0, _velY max 75, 5];

if !(canSuspend) exitWith { _this spawn grad_grandPrix_fnc_race_resetOnRoad; };

params ["_group"];

player setVariable ["GRAD_grandPrix_race_isResetting", true];

_group = units _group;
private _playerPos = getPos player;
private _roadMap = missionNamespace getVariable ["GRAD_grandPrix_race_roadMap", createHashMap];
private _nearRoads = (_playerPos nearRoads 200) select { [(getPos _x) # 0, (getPos _x) # 1, 0] in _roadMap };
private _nearestRoad = selectRandom _nearRoads;
private _dist = 500;
{
	private _distToCheck = player distance _x;
	if (_distToCheck < _dist) then {
		_dist = _distToCheck;
		_nearestRoad = _x;
	};
} forEach _nearRoads;
private _roadPos = getPos _nearestRoad;
_roadPos set [2,0];

private _connected = roadsConnectedTo _nearestRoad;
private _roadIndex = _roadMap get _roadPos;
private _dir = 0;
{
	private _pos = getPos _x;
	_pos set [2, 0];
	private _connectedIndex = _roadMap getOrDefault [_pos, 0];
	if (_connectedIndex == 0 || _connectedIndex < _roadIndex) then { continue };
	_dir = _roadPos getDir _pos;
} forEach _connected;

_group deleteAt (_group find player);

waitUntil { count (_group select { (_x distance2d _nearestRoad) < 30 }) isEqualTo 0 };

private _veh = vehicle player;
_veh setVelocity [0,0,0];
_veh setPos (_roadPos);
_veh setDir _dir;

player setVariable ["GRAD_grandPrix_race_isResetting", false];
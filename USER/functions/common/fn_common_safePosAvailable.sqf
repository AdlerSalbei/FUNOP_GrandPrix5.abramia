params ["_unit"];
private _enemySides = [_unit] call BIS_fnc_enemySides;
private _nearEnemies = allUnits select { (side _x in _enemySides) && ((_x distance _unit) <= 100) };

private _center = getPos _unit;
if (([_center, _nearEnemies] call grad_grandprix_fnc_common_closestEnemyDistance) < 30) exitWith { [false, [0,0]] };


private _pos = [0,0];

// findEmptyPos always gives the same result for same parameters
// so if that resulting position can be seen by enemies, we have a problem
// because of that we'll look 360° around our center so the algorithm
// returns different positions
for "_i" from 0 to 99 do {
	private _bearing = random 360;
	private _random = _center getPos [20, _bearing];

	private _empty = _random findEmptyPosition [0, 10, typeOf player];
	if (_empty isEqualTo []) then {continue};

	if !([_empty, _nearEnemies] call grad_grandprix_fnc_common_unitCanBeSeen) exitWith {
		_pos = _empty;
	};
};

[_pos isNotEqualTo [0,0], _pos]
params ["_turret", ["_burstSize", 3], ["_stepSize", 1]];

if (isNull _turret) exitWith {};

private _muzzle = (weaponState [_turret, [0]]) select 1;

for "_i" from 1 to _burstSize step _stepSize do { 
 	[{ 
  		_this call BIS_fnc_fire; 
 	}, [_turret, _muzzle, [0]], _i] call CBA_fnc_waitAndExecute; 
};
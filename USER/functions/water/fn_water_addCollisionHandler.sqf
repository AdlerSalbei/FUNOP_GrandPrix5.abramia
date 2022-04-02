params ["_veh"];

_veh addEventHandler ["EpeContactStart", {
    params ["_object1", "_object2", "_selection1", "_selection2", "_force"];
 
	private _takingDamage = _object1 getVariable ["GRAD_grandPrix_water_takingDamage", false];
	private _water = _object1 getVariable ["GRAD_grandPrix_water_currentVolume", 5500];
	if (_force <= 600 || _takingDamage || _water <= 0) exitWith {};

	_object1 setVariable ["GRAD_grandPrix_water_takingDamage", true];
	private _remainingForce = _force - 600;
	private _waterLost = _remainingForce * 0.1;
	private _remainingWater = (_water - _waterLost) max 0;
	_object1 setVariable ["GRAD_grandPrix_water_currentVolume", _remainingWater, true];

	systemChat format ["lost: %1 | remaining: %2", _waterLost, _water - _waterLost];

	[
		{
			params ["_veh"];
			_veh setVariable ["GRAD_grandPrix_water_takingDamage", false];
		},
		[_object1],
		0.5
	] call CBA_fnc_waitAndExecute;
}];
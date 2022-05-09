params ["_index"];

private _vehicleName = missionnamespace getvariable [ format ["%1", "dd_tank_0" + str _index], objNull];

cutText ["", "BLACK", 0.1];

[{
	params ["_unit", "_vehicleName"];

	playSound "jumpTPSound";
	
	_unit moveInAny _vehicleName;
	
	cutText ["", "BLACK IN", 3];
}, [player, _vehicleName], 0.3] call CBA_fnc_waitAndExecute;

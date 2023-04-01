if !(hasInterface) exitWith {};

[player] call grad_grandprix_fnc_DD_removeInventoryHandler;

cutText ["", "BLACK", 0.1];

[{
	params ["_unit", "_vehicleName"];

	playSound "jumpTPSound";
	moveOut _unit;
	_unit setPos (getPos GRAD_grandPrix_dd_startHelper vectorAdd [-4, random 4, 0]);

	cutText ["", "BLACK IN", 3];
}, [player, _vehicleName], 0.3] call CBA_fnc_waitAndExecute;

[] call grad_grandPrix_fnc_common_setRadioFrequencies;
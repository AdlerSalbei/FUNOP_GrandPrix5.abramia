if !(hasInterface) exitWith {};

[player] call grad_grandprix_fnc_DD_removeInventoryHandler;

cutText ["", "BLACK", 0.1];

[{
	params ["_unit", "_vehicleName"];

	playSound "jumpTPSound";
	
	_unit setPos (getPos DD_phoneBooth vectorAdd [-4, random 4, 0]);

	cutText ["", "BLACK IN", 3];
}, [player, _vehicleName], 0.3] call CBA_fnc_waitAndExecute;
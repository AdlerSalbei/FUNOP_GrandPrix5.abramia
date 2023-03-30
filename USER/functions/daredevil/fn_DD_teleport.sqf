if !(hasInterface) exitWith {};

params ["_index"];

		
		
cutText ["", "BLACK", 0.1];

[{
	params ["_unit", "_vehicleName"];

	playSound "jumpTPSound";

	[{
		if !(driver vehicle player isEqualTo player) then {
			cutText ["", "BLACK IN", 0.1];
		};
	}, [], 1.5] call CBA_fnc_waitAndExecute;
}, [player, _vehicleName], 0.3 + random 1] call CBA_fnc_waitAndExecute;

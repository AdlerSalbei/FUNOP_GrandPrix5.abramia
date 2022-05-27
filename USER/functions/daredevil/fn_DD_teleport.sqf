if !(hasInterface) exitWith {};

params ["_index"];

private _vehicleName = missionnamespace getvariable [ format ["%1", "dd_tank_0" + str _index], objNull];

[player] call grad_grandprix_fnc_dd_handleInventory;

cutText ["", "BLACK", 0.1];

STHud_UIMode = 0;
diwako_dui_main_toggled_off = true;

[{
	params ["_unit", "_vehicleName"];

	playSound "jumpTPSound";
	
	_unit moveInAny _vehicleName;
	
	[{
		[] call grad_grandprix_fnc_dd_cameraShot;

		[{
			if (driver vehicle player isEqualTo player) then {
				cutText ["", "BLACK", 0.1];
			};
		}, [], 84] call CBA_fnc_waitAndExecute;
	}, [], 1.5] call CBA_fnc_waitAndExecute;
}, [player, _vehicleName], 0.3] call CBA_fnc_waitAndExecute;

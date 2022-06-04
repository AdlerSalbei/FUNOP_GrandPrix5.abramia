params ["_vehicle", "_group"];

if (group player isNotEqualTo _group) exitWith {};

// add self-interaction to read current water level
private _action = [
    "readWaterLevel",
    "Wasserstand ablesen",
    "",
    {
		hint format["Es sind noch %1 Liter im Tank!", round (_target getVariable ["GRAD_grandPrix_water_currentVolume", 5500])];
	},
    { true }
] call ace_interact_menu_fnc_createAction;
[_vehicle, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
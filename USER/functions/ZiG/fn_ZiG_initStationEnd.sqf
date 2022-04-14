params ["_station"];

private _action = [
    "End_ZiG",
    "Geld abgeben!",
    "",
    { missionNamespace setVariable ["GRAD_grandPrix_ZiG_endPressed", true, true]; },
    { missionNameSpace getVariable ["GRAD_grandPrix_ZiG_collectingActive", false] }
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
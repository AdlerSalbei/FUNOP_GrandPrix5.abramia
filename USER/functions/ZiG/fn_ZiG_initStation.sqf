params ["_station"];

private _action = [
    "Start_ZiG",
    "Start!",
    "",
    {[_target, (group _player)] spawn GRAD_grandPrix_fnc_ZiG_handleStage;},
    {!(_target getVariable ["stationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
params ["_station"];

private _action = [
    "Start_race",
    "Start!",
    "",
    {[_target, group _player] spawn grad_grandPrix_fnc_race_handleStation;},
    {!(_target getVariable ["stationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
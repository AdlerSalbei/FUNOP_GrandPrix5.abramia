params ["_station"];

private _action = [
    "Start_PUPS",
    "Start!",
    "",
    {[_target, (group _player)] spawn GRAD_grandPrix_fnc_PUPS_handleStationServer;},
    {!(_target getVariable ["stationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
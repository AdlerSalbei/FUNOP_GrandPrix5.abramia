params ["_station"];

private _action = [   
    "osw_main _action",   
    "",   
    "",   
    {},   
    {true}, 
 	nil, 
 	nil, 
 	[-0.07,0.39,1.47],
 	2
] call ace_interact_menu_fnc_createAction; 

[_station, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;

private _action1 = [
    "Start_OSW",
    "Start!",
    "",
    {[_target, group _player] spawn grad_grandPrix_fnc_OSW_handleStage;},
    {!(_target getVariable ["stationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["osw_main _action"], _action1] call ace_interact_menu_fnc_addActionToObject;
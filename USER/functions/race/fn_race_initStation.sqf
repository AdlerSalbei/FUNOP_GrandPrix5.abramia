params ["_station"];

private _action = [   
    "race_main _action",   
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
    "Start_race",
    "Start!",
    "",
    {[_target, group _player] spawn grad_grandPrix_fnc_race_handleStation;},
    {!(_target getVariable ["stationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["race_main _action"], _action1] call ace_interact_menu_fnc_addActionToObject;

private _action2 = [   
    "race_ask_questions",   
    "Frage an den Zeus!",   
    "",   
    {   
  		[_player, "Race"] call grad_grandprix_fnc_common_askZeus;
 	},   
    {true}
] call ace_interact_menu_fnc_createAction;   
   
[_station, 0, ["race_main _action"], _action2] call ace_interact_menu_fnc_addActionToObject;

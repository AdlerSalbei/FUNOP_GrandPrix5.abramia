params ["_station"];

private _action = [   
    "rlgl_main_action",
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
    "Start_rlgl",
    "Start!",
    "",
    {[_target, (group _player)] spawn GRAD_grandPrix_fnc_rlgl_handleStage;},
    {!(_target getVariable ["stationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["rlgl_main_action"], _action1] call ace_interact_menu_fnc_addActionToObject;

private _action2 = [   
    "rlgl_ask_questions",   
    "Frage die IDAP!",   
    "",   
    {   
  		[_player, "rlgl"] call grad_grandprix_fnc_common_askZeus;
 	},   
    {true}
] call ace_interact_menu_fnc_createAction;   
   
[_station, 0, ["rlgl_ask_questions"], _action2] call ace_interact_menu_fnc_addActionToObject;
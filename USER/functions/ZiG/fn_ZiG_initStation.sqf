params ["_station"];

private _action = [   
    "zig_main _action",   
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
    "Start_ZiG",
    "Start!",
    "",
    {[_target, (group _player)] spawn GRAD_grandPrix_fnc_ZiG_handleStage;},
    {!(_target getVariable ["stationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["zig_main _action"], _action1] call ace_interact_menu_fnc_addActionToObject;

private _action2 = [   
    "zig_ask_questions",   
    "Frage an den Zeus!",   
    "",   
    {   
  		[_player, "Zeit ist Geld"] call grad_grandprix_fnc_common_askZeus;
 	},   
    {true}
] call ace_interact_menu_fnc_createAction;   
   
[_station, 0, ["zig_main _action"], _action2] call ace_interact_menu_fnc_addActionToObject;
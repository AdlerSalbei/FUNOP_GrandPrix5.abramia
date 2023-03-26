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
    "einleitung_rlgl",   
    "Einleitung",   
    "",   
    {   
  		[_target, _player] call grad_grandPrix_fnc_rlgl_introCam;
 	},   
    {
		!(_target getVariable ["stationIsRunning", false]) &&
		{
			private _return = true;
			{
				_return  = _x getVariable ["GRAD_grandPrix_rlgl_introDone", false];
			} forEach units group _player;

			!_return
		}
	}
] call ace_interact_menu_fnc_createAction;   

[_station, 0, ["rlgl_main_action"], _action1] call ace_interact_menu_fnc_addActionToObject;


private _action2 = [
    "Start_rlgl",
    "Start!",
    "",
    {[_target, (group _player)] spawn GRAD_grandPrix_fnc_rlgl_handleStage;},
    {
		!(_target getVariable ["stationIsRunning", false]) &&
		{
			private _return = true;
			{
				_return  = _x getVariable ["GRAD_grandPrix_rlgl_introDone", false];
			} forEach units group _player;

			_return
		}
	}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["rlgl_main_action"], _action2] call ace_interact_menu_fnc_addActionToObject;

private _action3 = [   
    "rlgl_ask_questions",   
    "Frage die IDAP?",   
    "",   
    {   
  		[_player, "rlgl"] call grad_grandprix_fnc_common_askZeus;
 	},   
    {true}
] call ace_interact_menu_fnc_createAction;   
   
[_station, 0, ["rlgl_main_action"], _action3] call ace_interact_menu_fnc_addActionToObject;
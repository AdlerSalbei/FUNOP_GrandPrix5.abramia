params ["_station"];

private _action = [   
    "osw_main_action",   
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
    "einleitung_osw",   
    "Einleitung",   
    "",   
    {   
  		[] remoteExec ["grad_grandPrix_fnc_osw_introCam", group _player, false];
 	},   
    {
		!(_target getVariable ["stationIsRunning", false]) &&
		{
			private _return = true;
			{
				_return  = _x getVariable ["GRAD_grandPrix_osw_introDone", false];
			} forEach units group _player;

			!_return
		}
	}
] call ace_interact_menu_fnc_createAction;   

[_station, 0, ["osw_main_action"], _action1] call ace_interact_menu_fnc_addActionToObject;

private _action2 = [
    "Start_OSW",
    "Start!",
    "",
    {[_target, group _player] spawn grad_grandPrix_fnc_OSW_handleStage;},
    {
        !(_target getVariable ["stationIsRunning", false]) &&
		{
			private _return = true;
			{
				_return  = _x getVariable ["GRAD_grandPrix_osw_introDone", false];
			} forEach units group _player;

			_return
		}
    }
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["osw_main_action"], _action2] call ace_interact_menu_fnc_addActionToObject;

private _action3 = [   
    "osw_ask_questions",   
    "Frage die IDAP!",   
    "",   
    {   
  		[_player, "OneShotWonder"] call grad_grandprix_fnc_common_askZeus;
 	},   
    {true}
] call ace_interact_menu_fnc_createAction;   
   
[_station, 0, ["osw_main_action"], _action3] call ace_interact_menu_fnc_addActionToObject;

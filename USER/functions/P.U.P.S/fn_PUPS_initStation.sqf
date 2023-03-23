params ["_station"];

private _action = [   
    "pups_main _action",   
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
    "einleitung_PUPS",   
    "Einleitung",   
    "",   
    {   
        [_target, _player] call grad_grandPrix_fnc_PUPS_introCam;
 	},   
    {
		!(_target getVariable ["stationIsRunning", false]) &&
		{
			private _return = true;
			{
				_return  = _x getVariable ["GRAD_grandPrix_PUPS_introDone", false];
			} forEach units group _player;

			!_return
		}
	}
] call ace_interact_menu_fnc_createAction;   

[_station, 0, ["pups_main _action"], _action1] call ace_interact_menu_fnc_addActionToObject;

private _action2 = [
    "Start_PUPS",
    "Start!",
    "",
    {[_target, (group _player)] spawn GRAD_grandPrix_fnc_PUPS_handleStationServer;},
    {
        !(_target getVariable ["stationIsRunning", false]) &&
        {
            private _return = true;
			{
				_return  = _x getVariable ["GRAD_grandPrix_PUPS_introDone", false];
			} forEach units group _player;

			_return
        }
    }
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["pups_main _action"], _action2] call ace_interact_menu_fnc_addActionToObject;

private _action3 = [   
    "pups_ask_questions",   
    "Frage die IDAP!",   
    "",   
    {   
  		[_player, "P.U.P.S"] call grad_grandprix_fnc_common_askZeus;
 	},   
    {true}
] call ace_interact_menu_fnc_createAction;   
   
[_station, 0, ["pups_main _action"], _action3] call ace_interact_menu_fnc_addActionToObject;

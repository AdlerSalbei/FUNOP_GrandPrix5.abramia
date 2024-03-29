if !(hasInterface) exitWith {};

params ["_station"];

private _action = [   
    "DD_main _action",   
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
    "einleitung_daredevil",   
    "Einleitung",   
    "",   
    {   
		[] remoteExecCall ["grad_grandprix_fnc_dd_cameraShot", group _player, false];
 	},   
    {
		!(_target getVariable ["DD_stationIsRunning", false]) &&
		{
			private _return = true;
			{
				_return  = _x getVariable ["GRAD_grandPrix_DD_introFin", false];
			} forEach units group _player;

			!_return
		}
	}
] call ace_interact_menu_fnc_createAction;   
   
[_station, 0, ["DD_main _action"], _action1] call ace_interact_menu_fnc_addActionToObject;

private _action2 = [   
    "teleport_daredevil",   
    "Start!",   
    "",   
    {   
  		[_player, _target] remoteExecCall ["grad_grandprix_fnc_DD_startStage", 2, false];   
 	},   
    {
		!(_target getVariable ["DD_stationIsRunning", false]) &&
		{
			private _return = true;
			{
				_return  = _x getVariable ["GRAD_grandPrix_DD_introFin", false];
			} forEach units group _player;

			_return
		}
	}
] call ace_interact_menu_fnc_createAction;   

[_station, 0, ["DD_main _action"], _action2] call ace_interact_menu_fnc_addActionToObject;

private _action3 = [   
    "dd_ask_questions",   
    "Frage die IDAP?",   
    "",   
    {   
  		[_player, "Daredevil"] call grad_grandprix_fnc_common_askZeus;
 	},   
    {true}
] call ace_interact_menu_fnc_createAction;   
   
[_station, 0, ["DD_main _action"], _action3] call ace_interact_menu_fnc_addActionToObject;

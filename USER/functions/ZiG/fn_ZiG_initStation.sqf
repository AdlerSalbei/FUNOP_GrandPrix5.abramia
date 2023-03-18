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
    "einleitung_zig",   
    "Einleitung",   
    "",   
    {   
  		{
			  [] remoteExecCall ["grad_grandprix_fnc_ZiG_cameraShot", _x, false];
		}forEach (units group _player);
 	},   
    {
		!(_target getVariable ["ZiG_stationIsRunning", false]) &&
		{
			private _return = true;
			{
				_return  = _x getVariable ["GRAD_grandPrix_ZiG_introFin", false];
			} forEach units group _player;

			!_return
		}
	}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["zig_main _action"], _action1] call ace_interact_menu_fnc_addActionToObject;

private _action2 = [
    "Start_ZiG",
    "Start!",
    "",
    {[_target, (group _player)] spawn GRAD_grandPrix_fnc_ZiG_handleStage;},
    {
        (!(_target getVariable ["stationIsRunning", false])) &&
        {!(missionNamespace getVariable ["GRAD_grandPrix_ZiG_spawningMoney", false])} &&
		{
			private _return = true;
			{
				_return  = _x getVariable ["GRAD_grandPrix_ZiG_introFin", false];
			} forEach units group _player;

			_return
		}
    }
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["zig_main _action"], _action2] call ace_interact_menu_fnc_addActionToObject;

private _action3 = [   
    "zig_ask_questions",   
    "Frage die IDAP!",   
    "",   
    {   
  		[_player, "Zeit ist Geld"] call grad_grandprix_fnc_common_askZeus;
 	},   
    {true}
] call ace_interact_menu_fnc_createAction;   
   
[_station, 0, ["zig_main _action"], _action3] call ace_interact_menu_fnc_addActionToObject;

private _action4 = [
    "reset_ZiG",
    "Stage reseting, please wait ...",
    "",
    {},
    {missionNamespace getVariable ["GRAD_grandPrix_ZiG_spawningMoney", false]}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["zig_main _action"], _action4] call ace_interact_menu_fnc_addActionToObject;

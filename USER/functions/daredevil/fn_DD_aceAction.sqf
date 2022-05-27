if !(hasInterface) exitWith {};

params ["_obj"];

private _action = [   
    "teleport_daredevil",   
    "Daredevil Stage",   
    "",   
    {   
  		[_player, _target] remoteExecCall ["grad_grandprix_fnc_DD_startStage", 2, false];   
 	},   
    {!(_target getVariable ["DD_stationIsRunning", false])}, 
 	nil, 
 	nil, 
 	[-0.07,0.39,1.47],
 	2
] call ace_interact_menu_fnc_createAction;   
   
[_obj, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
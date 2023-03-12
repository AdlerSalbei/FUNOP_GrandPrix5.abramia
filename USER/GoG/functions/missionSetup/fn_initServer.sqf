#include "component.hpp"

systemChat "Init Server";

//Init Game of Guns 
grad_grandprix_gog_playAreaSize = 100;

missionNamespace setVariable ["grad_grandprix_gog_respawnTime","RespawnTime" call BIS_fnc_getParamValue, true];
missionNamespace setVariable ["grad_grandprix_gog_rankedMode",("RankedMode" call BIS_fnc_getParamValue) == 1,true];
missionNamespace setVariable ["grad_grandprix_gog_killsForWin","KillsForWin" call BIS_fnc_getParamValue, true];

[] call grad_grandprix_gog_fnc_buildTheWall;

missionNamespace setVariable ["grad_grandprix_gog_gameStarted",true,true];
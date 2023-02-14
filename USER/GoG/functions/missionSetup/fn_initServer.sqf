#include "component.hpp"

diag_log "GOG InitServer";

//Init Game of Guns 
grad_grandprix_gog_playAreaSize = 100;

missionNamespace setVariable [QGVAR(respawnTime),"RespawnTime" call BIS_fnc_getParamValue, true];
missionNamespace setVariable [QGVAR(rankedMode),("RankedMode" call BIS_fnc_getParamValue) == 1,true];
missionNamespace setVariable [QGVAR(killsForWin),"KillsForWin" call BIS_fnc_getParamValue, true];

[] call grad_grandprix_gog_fnc_buildTheWall;

missionNamespace setVariable [QGVAR(gameStarted),true,true];
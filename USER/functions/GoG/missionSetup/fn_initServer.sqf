#include "component.hpp"

//Init Game of Guns 
grad_grandprix_gog_playAreaSize = 100;

missionNamespace setVariable [QGVAR(respawnTime),"RespawnTime" call BIS_fnc_getParamValue, true];
missionNamespace setVariable [QGVAR(rankedMode),("RankedMode" call BIS_fnc_getParamValue) == 1,true];
missionNamespace setVariable [QGVAR(killsForWin),"KillsForWin" call BIS_fnc_getParamValue, true];

[{
	missionNamespace getVariable [QEGVAR(selectWeapons,selectWeaponsComplete),false]
},_fnc_setup,[],([missionConfigFile >> "cfgMission","votingTime",60] call BIS_fnc_returnConfigEntry) + 20, FUNC(playAreaSetup);] call CBA_fnc_waitUntilAndExecute;

[] call grad_grandprix_gog_missionSetup_fnc_buildTheWall;

missionNamespace setVariable [QGVAR(gameStarted),true,true];
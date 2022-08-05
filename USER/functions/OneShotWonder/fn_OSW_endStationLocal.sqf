private _activePlayers = missionNamespace getVariable ["GRAD_grandPrix_OSW_activePlayers", []];
_activePlayers deleteAt (_activePlayers find player);
missionNamespace setVariable ["GRAD_grandPrix_OSW_activePlayers", _activePlayers, true];

diag_log format["teleporting %1 back to start", name player];

missionNamespace setVariable ["GRAD_grandPrix_OSW_visited_" + getPlayerUID player, [], true];
player setPosASL (getPosASL GRAD_grandPrix_OSW_returnPoint);

private _timeTaken = missionNamespace getVariable ["GRAD_grandPrix_OSW_totalTime_" + getPlayerUID player, 0];
hint format["Station beendet!\nDeine Zeit: %1", [_timeTaken, "MM:SS"] call BIS_fnc_secondsToString];

player removeWeapon "GrandPrix_hgun_Pistol_heavy_02_F";
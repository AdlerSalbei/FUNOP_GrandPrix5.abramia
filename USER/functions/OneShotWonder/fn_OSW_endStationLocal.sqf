private _activePlayers = missionNamespace getVariable ["GRAD_grandPrix_OSW_activePlayers", []];
_activePlayers deleteAt (_activePlayers find player);
missionNamespace setVariable ["GRAD_grandPrix_OSW_activePlayers", _activePlayers, true];

player setVariable ["GRAD_grandPrix_OSW_visited", [], true];
player setPosASL (getPosASL GRAD_grandPrix_OSW_returnPoint);

private _timeTaken = player getVariable ["GRAD_grandPrix_OSW_totalTime", 0];
hint format["Station beendet!\nDeine Zeit: %1", [_timeTaken, "MM:SS.MS"] call BIS_fnc_secondsToString];
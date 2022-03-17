systemChat format["Time taken: %1s", player getVariable ["GRAD_grandPrix_OSW_totalTime", 0]];

private _activePlayers = missionNamespace getVariable ["GRAD_grandPrix_OSW_activePlayers", []];
_activePlayers deleteAt (_activePlayers find player);
missionNamespace setVariable ["GRAD_grandPrix_OSW_activePlayers", _activePlayers, true];

player setVariable ["GRAD_grandPrix_OSW_visited", [], true];
player setPosASL (getPosASL start);
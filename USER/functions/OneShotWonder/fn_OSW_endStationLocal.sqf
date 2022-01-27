systemChat "done!";

private _activePlayers = missionNamespace getVariable ["GRAD_grandPrix_OSW_activePlayers", []];
_activePlayers deleteAt (_activePlayers find player);
missionNamespace setVariable ["GRAD_grandPrix_OSW_activePlayers", _activePlayers, true];

player setPosASL (getPosASL start);
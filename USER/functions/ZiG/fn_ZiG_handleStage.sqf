missionNamespace setVariable ["GRAD_grandPrix_ZiG_planesDone", false, true];

[] call grad_grandPrix_fnc_ZiG_handlePlanes;

waitUntil { missionNamespace getVariable ["GRAD_grandPrix_ZiG_planesDone", false]; };

systemChat "spawning money";
[] call grad_grandPrix_fnc_ZiG_handleMoney;
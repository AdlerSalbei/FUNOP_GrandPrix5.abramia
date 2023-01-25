#include "component.hpp"

[] call EFUNC(missionSetup,applyUniform);

cutText ["","BLACK IN",0.1];
hintSilent "";

private _respawnPos = player getVariable [QGVAR(respawnPos),EGVAR(missionSetup,playAreaCenter)];
[player,_respawnPos] call EFUNC(common,teleport);

player setVariable [QEGVAR(missionSetup,isCamping),false,false];

if (missionNamespace getVariable ["grad_grandprix_gog_events_gameEnded",false]) exitWith {};

[player,player getVariable [QEGVAR(missionSetup,currentScore),0]] call EFUNC(missionSetup,applyWeapon);

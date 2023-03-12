#include "component.hpp"

[] call EFUNC(missionSetup,applyUniform);

cutText ["","BLACK IN",0.1];
hintSilent "";

private _respawnPos = player getVariable ["grad_grandprix_gog_respawnPos", grad_grandprix_gog_playAreaCenter];
[player,_respawnPos] call grad_grandprix_gog_fnc_teleport;

player setVariable ["grad_grandprix_gog_isCamping",false,false];

if (missionNamespace getVariable ["grad_grandprix_gog_events_gameEnded",false]) exitWith {};

[player,player getVariable ["grad_grandprix_gog_currentScore",0]] call EFUNC(missionSetup,applyWeapon);

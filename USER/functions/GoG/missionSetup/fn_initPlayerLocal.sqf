#include "component.hpp"

//Save Loadout & Pos
ace_player setVariable ["grad_grandprix_gog_oldLoadout", getUnitLoadout ace_player];
ace_player setVariable ["grad_grandprix_gog_oldPos", getPos ace_player];


//Setup Player
[] call grad_grandprix_gog_missionSetup_fnc_applyUniform;

["ace_unconscious", grad_grandprix_gog_events_fnc_onUnconscious] call CBA_fnc_addEventHandler;

ace_player setVariable [QGVAR(isSpectator),true,true];
ace_player setDamage 1;
["Terminate"] call BIS_fnc_EGSpectator;
["Initialize", [ace_player, [WEST,EAST,INDEPENDENT], true]] call BIS_fnc_EGSpectator;

[] call FUNC(moveToMapStartPos);

player addEventHandler ["Killed", EFUNC(events,onPlayerKilled)];
player addEventHandler ["Respawn", EFUNC(events,onPlayerRespawn)];

[{[] call FUNC(scoreBoard)},1,[]] call CBA_fnc_addPerFrameHandler;


#include "component.hpp"

//Save Loadout & Pos
ace_player setVariable ["grad_grandprix_gog_oldLoadout", getUnitLoadout ace_player];
ace_player setVariable ["grad_grandprix_gog_oldPos", getPos ace_player];


//Setup Player
[] call grad_grandprix_gog_fnc_applyUniform;

["ace_unconscious", grad_grandprix_gog_fnc_onUnconscious] call CBA_fnc_addEventHandler;

ace_player setVariable [QGVAR(isSpectator),true,true];
ace_player setDamage 1;
["Terminate"] call BIS_fnc_EGSpectator;
["Initialize", [ace_player, [WEST,EAST,INDEPENDENT], true]] call BIS_fnc_EGSpectator;

[] call FUNC(moveToMapStartPos);

ace_player addEventHandler ["Killed", EFUNC(events,onPlayerKilled)];
ace_player addEventHandler ["Respawn", EFUNC(events,onPlayerRespawn)];



#include "component.hpp"

params ["_unit"];

systemChat "Init Local Player";

[_unit] remoteExecCall ["grad_grandprix_gog_fnc_initPlayerServer", 2, false];

//Save Loadout & Pos
_unit setVariable ["grad_grandprix_gog_oldLoadout", getUnitLoadout _unit];
_unit setVariable ["grad_grandprix_gog_oldPos", getPos _unit];

//Setup Player
[] call grad_grandprix_gog_fnc_applyUniform;

["ace_unconscious", grad_grandprix_gog_fnc_onUnconscious] call CBA_fnc_addEventHandler;

_unit setVariable ["grad_grandprix_gog_(isSpectator",true,true];
_unit setDamage 1;
["Terminate"] call BIS_fnc_EGSpectator;
["Initialize", [_unit, [WEST,EAST,INDEPENDENT], true]] call BIS_fnc_EGSpectator;

[] call grad_grandprix_gog_fnc_moveToMapStartPos;

_unit addEventHandler ["Killed", {_this call grad_grandprix_gog_fnc_fnc_onPlayerKilled}];
_unit addEventHandler ["Respawn", {_this call grad_grandprix_gog_fnc_fnc_onPlayerRespawn}];



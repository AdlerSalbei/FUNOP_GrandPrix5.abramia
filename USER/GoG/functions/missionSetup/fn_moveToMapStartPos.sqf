#include "component.hpp"

private _mapStartPos = [missionConfigFile >> "cfgGradIslands" >> worldName,"spawnPosBlu",[0,0,0]] call BIS_fnc_returnConfigEntry;

private _pos = _mapStartPos findEmptyPosition [0,30,"B_Soldier_F"];
if (_pos isEqualTo []) then {_pos = _mapStartPos};

[player,_pos] call EFUNC(common,teleport);

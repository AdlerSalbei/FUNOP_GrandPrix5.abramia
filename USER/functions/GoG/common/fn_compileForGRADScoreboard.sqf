#include "component.hpp"

params ["_stats"];

private _compiledStats = [["NAME","K/D","GAMES","POINTS"]];
{
    _x params [["_points",0],["_UID",""],["_name",""],["_playerStats",[]]];
    _playerStats params [["_kills",0],["_deaths",0],["_games",0]];

    _kd = (round ((_kills/(_deaths max 1))*100))/100;
    _compiledStats pushBack [_name,_kd,_games,round _points];
} forEach _stats;

_compiledStats

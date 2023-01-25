#include "component.hpp"

params ["_serverStats"];

private _kills = player getVariable [QEGVAR(missionSetup,kills), 0];
private _deaths = player getVariable [QEGVAR(missionSetup,deaths), 0];
private _kd = (_kills max 1) / (_deaths max 1);
private _longestKill = (round ((player getVariable [QEGVAR(missionSetup,longestKill), 0])*10)) / 10;
private _distanceMoved = round (player getVariable [QEGVAR(missionSetup,totalDistance), 0]);

private _myStats = [
    ["KILLS","DEATHS","K/D","LONGEST KILL","DISTANCE MOVED"],
    [_kills,_deaths,(round (_kd*100))/100,format ["%1m",round _longestKill],format ["%1m",_distanceMoved]]
];

[20,_serverStats,"GAME OF GUNS LEADERBOARD",false,false,_myStats,"MY STATS THIS GAME",false,false] call grad_scoreboard_fnc_loadScoreboard;

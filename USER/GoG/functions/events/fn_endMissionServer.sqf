#include "component.hpp"

if (!isServer) exitWith {};

params [["_winner",objNull]];

if (missionNamespace getVariable ["grad_grandprix_gog_events_gameEnded",false]) exitWith {};
missionNamespace setVariable ["grad_grandprix_gog_events_gameEnded",true,true];

_this spawn {
    params [["_winner",objNull]];

    sleep 1;

    _centerPos = ([EGVAR(missionSetup,playAreaCenter),[0,50]] call EFUNC(common,randomPos)) findEmptyPosition [0,30,"B_Soldier_F"];
    if ((count _centerPos) == 0) then {_centerPos = EGVAR(missionSetup,playAreaCenter)};

    {_x setDamage 0} forEach allPlayers;
    [nil,_centerPos] remoteExec [QEFUNC(common,teleport),0,false];
    [_centerPos] remoteExec [QFUNC(respawnPlayer),0,false];

    [[],{
        waitUntil {alive player};
        removeAllWeapons player;
        player setDamage 0;
        player allowDamage false;
        sleep 1;
        removeAllWeapons player;
    }] remoteExec ["spawn",0,false];

    sleep 2;

    ["gungame_notification1",["GUNGAME",format ["%1 wins!",_winner getVariable ["ACE_Name",name _winner]]]] remoteExec ["bis_fnc_showNotification",0,false];

    sleep 8;

 
};

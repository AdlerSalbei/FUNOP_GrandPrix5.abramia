#include "component.hpp"

#define AREASIZE 15
#define CAMPTIME 70

grad_grandprix_gog_missionSetup_campingProtectionHandle = [{
    params ["_args","_handle"];
    _args params ["_iteration","_currentArea","_lastPos"];

    if (missionNamespace getVariable ["grad_grandprix_gog_events_gameEnded",false]) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    if (!alive player) exitWith {
        _args set [1,nil];
        _args set [2,nil];
    };

    if (!isNil "_lastPos") then {
        _distance = player distance _lastPos;
        _totalDistance = player getVariable ["grad_grandprix_gog_missionSetup_totalDistance",0];
        player setVariable ["grad_grandprix_gog_missionSetup_totalDistance",_totalDistance + _distance];
    };
    _args set [2, getPos player];


    // player moved
    if (isNil "_currentArea" || {!(player inArea _currentArea)}) then {
        _currentArea = [getPos player,AREASIZE,AREASIZE,0,false];

        _args set [0, 0];
        _args set [1, _currentArea];

    // player didnt move
    } else {
        if !(player getvariable "ACE_isUnconscious") then {
            _args set [0,_iteration + 1];
        };
    };

    // player is camping
    if (_iteration > CAMPTIME) exitWith {

        ["gungame_notification1",["GUNGAME","Looks like you are camping. You better move."]] spawn bis_fnc_showNotification;
        [_handle] call CBA_fnc_removePerFrameHandler;

        [{
            params ["_args","_handle"];
            _args params ["_iteration","_currentArea","_lastPos"];

            _distance = player distance _lastPos;
            _totalDistance = player getVariable ["grad_grandprix_gog_missionSetup_totalDistance",0];
            player setVariable ["grad_grandprix_gog_missionSetup_totalDistance",_totalDistance + _distance];

            // player stopped camping
            if (!(alive player) || !(player inArea _currentArea)) exitWith {
                player setVariable ["grad_grandprix_gog_missionSetup_isCamping",false,true];
                [] call FUNC(initCampingProtection);

                if (alive player) then {
                    ["gungame_notification1",["GUNGAME","Alright, you moved. I'm watching you though."]] spawn bis_fnc_showNotification;
                };

                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            // player is still camping
            if (_iteration > 15 && {!(player getVariable ["grad_grandprix_gog_missionSetup_isCamping",false])}) then {
                player setVariable ["grad_grandprix_gog_missionSetup_isCamping",true,true];
                ["gungame_notification1",["GUNGAME","Other players know where you are, camper!"]] spawn bis_fnc_showNotification;
                [player,profileName] remoteExec [QEFUNC(common,showCamper),0,false];
            };

            _args set [0,_iteration + 1];

        },1,[0,_currentArea,_lastPos]] call CBA_fnc_addPerFrameHandler;
    };
},1,[0]] call CBA_fnc_addPerFrameHandler;

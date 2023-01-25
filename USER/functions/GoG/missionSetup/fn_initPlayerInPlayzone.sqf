#include "component.hpp"

if (!hasInterface) exitWith {};
if (!alive player) exitWith {};

[{
    params ["","_handle"];

    if (!alive player) exitWith {};

    if (player distance2d grad_grandprix_gog_playAreaCenter > (grad_grandprix_gog_playAreaSize + 1)) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        ["gungame_notification1",["GUNGAME","Get back inside or die!"]] spawn bis_fnc_showNotification;

        [{
            params ["_args","_handle"];
            _args params ["_iterations"];

            if (!alive player) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
                [] call FUNC(initPlayerInPlayzone);
            };

            // player is back inside
            if (player distance2d grad_grandprix_gog_playAreaCenter <= (grad_grandprix_gog_playAreaSize + 1)) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
                [] call FUNC(initPlayerInPlayzone);
            };

            // player has not moved back inside in 5s
            if (_iterations >= 5) exitWith {
                player setDamage 1;
                [_handle] call CBA_fnc_removePerFrameHandler;
                [] call FUNC(initPlayerInPlayzone);
            };

            _args set [0,_iterations + 1];

        },1,[0]] call CBA_fnc_addPerFrameHandler;
    };
},1,[]] call CBA_fnc_addPerFrameHandler;

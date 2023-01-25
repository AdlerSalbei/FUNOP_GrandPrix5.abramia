#include "component.hpp"

if (!hasInterface)  exitWith {};

params [["_camper",objNull],["_camperName","???"]];

if (isNull _camper || !alive _camper) exitWith {};
if (player isEqualTo _camper) exitWith {};

["gungame_notification1",["GUNGAME",format ["%1 is camping! Kill him!",_camperName]]] spawn bis_fnc_showNotification;


[{
    params ["_args","_handle"];
    _args params ["_camper","_camperName"];

    if (!(alive _camper) || !(_camper getVariable [QEGVAR(missionSetup,isCamping),false])) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    drawIcon3D ["a3\ui_f\data\gui\Rsc\RscDisplayIntel\azimuth_ca.paa", [1,1,1,1], (getPosATL _camper) vectorAdd [0,0,1], 1, 1, 45, format ["%1 (%2m)", name _camper, round (player distance _camper)], 1, 0.04, "PuristaMedium"];
},0,[_camper,_camperName]] call CBA_fnc_addPerFrameHandler;

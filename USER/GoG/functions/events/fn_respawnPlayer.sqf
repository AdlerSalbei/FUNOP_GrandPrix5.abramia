#include "component.hpp"

params [["_respawnPos",[0,0,0]]];

if (!hasInterface) exitWith {};
if (alive player) exitWith {};

player setVariable ["grad_grandprix_gog_(respawnPos",_respawnPos];
setPlayerRespawnTime 1;
forceRespawn player;

(player getVariable ["grad_grandprix_gog_(killCam",[]]) params [["_camera",objNull],["_filmgrain",-1]];

_filmgrain ppEffectEnable false;
ppEffectDestroy _filmgrain;

_camera cameraEffect ["terminate","back"];
camDestroy _camera;
showCinemaBorder false;

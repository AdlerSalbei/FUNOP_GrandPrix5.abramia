#include "component.hpp"

if (player getVariable ["grad_grandprix_gog_isSpectator",false]) exitWith {};
if (missionNamespace getVariable ["grad_grandprix_gog_events_gameEnded",false]) exitWith {};

// WORKAROUND FOR KILLED EH BEING FIRED TWICE UPON DEATH (ACE or BI, not sure)
// TODO: REMOVE ONCE BUG IS FIXED
if (player getVariable ["PZG_lock1", objNull] == player) exitWith {};
player setVariable ["PZG_lock1", player];
// END OF WORKAROUND

//send killer to server
private _shooter = player getVariable ["ACE_medical_lastDamageSource",player];
[player,_shooter,getPos player,profileName] remoteExecCall [QFUNC(onUnitKilledServer),2,false];

[getPos player,profileName] remoteExecCall ["grad_grandprix_gog_weaponCleanup",2,false];

//create kill cam
private _killCamHandle = [grad_grandprix_gog_respawnTime min 10,player,_shooter] spawn FUNC(killCam);
player setVariable ["grad_grandprix_gog_killCamHandle",_killCamHandle];

//keep player from respawning
setPlayerRespawnTime 9999;

[grad_grandprix_gog_respawnTime] call FUNC(waitPlayerRespawnTime);

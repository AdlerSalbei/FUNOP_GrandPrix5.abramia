#include "component.hpp"

params ["_unit"];

_unit setVariable [QGVAR(isPlaying),true,true];
_unit setVariable [QGVAR(kills),0,true];
_unit setVariable [QGVAR(deaths),0,true];
_unit setVariable [QGVAR(longestKill),0,true];
_unit setVariable [QGVAR(eloThisGame),0,true];
_unit setVariable [QGVAR(currentScore),0,true];
_unit setVariable [QGVAR(radioInstance),format ["TFAR_anprc152_%1",_forEachIndex + 1],true];

//save UID of everyone who is playing
_playerUID = getPlayerUID _unit;
GVAR(allPlayerUIDs) pushBack _playerUID;

[] call FUNC(removeInitialWeapon);

// wait 10s
[{
	[] call FUNC(movePlayerToStartPos);
	[] remoteExec [QFUNC(initPlayerInPlayzone), _unit, false];
	[] remoteExec [QFUNC(initCampingProtection), _unit, false];

	[_unit, 0] call FUNC(applyWeapon);

}, [], 10] call CBA_fnc_waitAndExecute;

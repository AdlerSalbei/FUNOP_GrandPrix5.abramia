#include "component.hpp"

params ["_victim",["_shooter",objNull],["_victimPos", [0,0,0]],["_victimName", "Someone"]];

if (isNull _shooter) exitWith {};

//exit if self-kill
if (_victim == _shooter) exitWith {
    (format ["%1 died.",_victimName]) remoteExec ["systemChat",0,false];
};

_victim setVariable ["grad_grandprix_gog_deaths",(_victim getVariable ["grad_grandprix_gog_deaths", 0]) + 1, true];
_shooter setVariable ["grad_grandprix_gog_kills",(_shooter getVariable ["grad_grandprix_gog_kills", 0]) + 1, true];

private _shooterName = _shooter getVariable ["ACE_Name",name _shooter];
(format ["%1 killed %2.",_shooterName,_victimName]) remoteExec ["systemChat",0,false];

private _shotDistance = (getPos _shooter) distance2D _victimPos;
if (_shotDistance > (_shooter getVariable ["grad_grandprix_gog_longestKill", 0])) then {
    _shooter setVariable ["grad_grandprix_gog_longestKill", _shotDistance, true];
};

private _newScore = (_shooter getVariable ["grad_grandprix_gog_currentScore",0]) + 1;
_shooter setVariable ["grad_grandprix_gog_currentScore",_newScore,true];

if (_newScore >= ("KillsForWin" call BIS_fnc_getParamValue)) exitWith {
    [_shooter] call FUNC(endMissionServer);
};

[_shooter,_newScore] remoteExec [QFUNC(onIncreasedScore),_shooter,false];

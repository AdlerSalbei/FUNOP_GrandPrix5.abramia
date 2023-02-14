#include "component.hpp"

params ["_victim",["_shooter",objNull],["_victimPos", [0,0,0]],["_victimName", "Someone"]];

if (isNull _shooter) exitWith {};

//exit if self-kill
if (_victim == _shooter) exitWith {
    (format ["%1 died.",_victimName]) remoteExec ["systemChat",0,false];
};

_victim setVariable [QEGVAR(missionSetup,deaths),(_victim getVariable [QEGVAR(missionSetup,deaths), 0]) + 1, true];
_shooter setVariable [QEGVAR(missionSetup,kills),(_shooter getVariable [QEGVAR(missionSetup,kills), 0]) + 1, true];

private _shooterName = _shooter getVariable ["ACE_Name",name _shooter];
(format ["%1 killed %2.",_shooterName,_victimName]) remoteExec ["systemChat",0,false];

private _shotDistance = (getPos _shooter) distance2D _victimPos;
if (_shotDistance > (_shooter getVariable [QEGVAR(missionSetup,longestKill), 0])) then {
    _shooter setVariable [QEGVAR(missionSetup,longestKill), _shotDistance, true];
};

private _newScore = (_shooter getVariable [QEGVAR(missionSetup,currentScore),0]) + 1;
_shooter setVariable [QEGVAR(missionSetup,currentScore),_newScore,true];

if (_newScore >= ("KillsForWin" call BIS_fnc_getParamValue)) exitWith {
    [_shooter] call FUNC(endMissionServer);
};

[_shooter,_newScore] remoteExec [QFUNC(onIncreasedScore),_shooter,false];

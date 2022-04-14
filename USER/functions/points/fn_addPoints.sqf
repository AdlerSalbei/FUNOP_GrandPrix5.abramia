if !(isServer) exitWith {_this remoteExecCall ["grad_grandPrix_fnc_addPoints", 2];};

params ["_group", "_points", "_stage"];

private _allGroups = missionNamespace getVariable ["GRAD_GrandPrix_allContestantGroups", []];
private _allGroupNames = missionNamespace getVariable ["GRAD_GrandPrix_allContestantGroupNames", []];
private _groupName = "";
{
	if (_x isEqualTo _group) then {
		_groupName = _allGroupNames # _foreachIndex;
	};
} forEach _allGroups;

if (_groupName isEqualTo "") exitWith { 
	private _allInstructors = [];
	{
		_allInstructors pushBackUnique (getAssignedCuratorUnit _x);
	} forEach allCurators;

	[format["No groupname found for group %1 (leader: %2). Adding points to variable 'GRAD_GrandPrix_pointsGroupNotFound' instead"], _group, name(leader _group)] remoteExec ["systemChat", _allInstructors];

	private _grouplessPoints = missionNamespace getVariable ["GRAD_GrandPrix_pointsGroupNotFound", []];
	_grouplessPoints pushBack [leader _group, _points, _stage];
	missionNamespace setVariable ["GRAD_GrandPrix_pointsGroupNotFound", _grouplessPoints, true];
};

private _groupStats = missionNamespace getVariable [_groupName, []];

_groupStats pushBack [_stage, _points];

missionNamespace setVariable [_groupName, _groupStats, true];
if !(isServer) exitWith {};

params ["_unit"];

private _allGroups = missionNamespace getVariable ["GRAD_GrandPrix_allContestantGroups", []];
private _group = group _unit;

if (_group in _allGroups) exitWith {};

private _allGroupNames = missionNamespace getVariable ["GRAD_GrandPrix_allContestantGroupNames", []];

if ((count _allGroups) isNotEqualTo (count _allGroupNames)) exitWith {diag_log format ["GRANDPRIX: Group & Groupname Array are of different size!!!"]};

_allGroups pushBack _group;
_allGroupNames pushBack (name _group);

missionNamespace setVariable ["GRAD_GrandPrix_allContestantGroups", _allGroups, false];
missionNamespace getVariable ["GRAD_GrandPrix_allContestantGroupNames", _allGroupNames, false];

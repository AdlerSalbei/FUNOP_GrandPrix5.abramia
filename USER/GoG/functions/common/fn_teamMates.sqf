#include "component.hpp"

params [["_unit",objNull]];

private _teamNamespace = _unit getVariable [QEGVAR(missionSetup,teamNamespace),objNull];
private _teamMateUIDs = _teamNamespace getVariable [QEGVAR(missionSetup,teamMateUIDs),[]];

private _teamMates = _teamMateUIDs apply {[_x] call BIS_fnc_getUnitByUid};

_teamMates

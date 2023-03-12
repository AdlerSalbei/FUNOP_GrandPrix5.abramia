#include "component.hpp"

params [["_unit",objNull]];

private _teamNamespace = _unit getVariable ["grad_grandprix_gog_teamNamespace",objNull];
private _teamMateUIDs = _teamNamespace getVariable ["grad_grandprix_gog_teamMateUIDs",[]];

private _teamMates = _teamMateUIDs apply {[_x] call BIS_fnc_getUnitByUid};

_teamMates

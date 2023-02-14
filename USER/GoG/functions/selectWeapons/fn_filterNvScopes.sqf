#include "component.hpp"

params [["_scopes",[]]];

private _scopesNoNV = [];

{
    _allOpticsModes = "true" configClasses (configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "OpticsModes");
    _firstNvModeID = _allOpticsModes findIf {
        _allVisionModes = ([_x,"visionMode",[]] call BIS_fnc_returnConfigEntry) apply {toLower _x};
        "nvg" in _allVisionModes
    };

    if (_firstNvModeID < 0) then {_scopesNoNV pushBack _x};
} forEach _scopes;

_scopesNoNV

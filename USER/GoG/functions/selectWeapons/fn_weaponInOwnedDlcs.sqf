#include "component.hpp"

params [["_weaponClass",""]];

private _addons = configsourceaddonlist (configfile >> "CfgWeapons" >> _weaponClass);     // e.g.: ["A3_Characters_F_Enoch"]
if (count _addons == 0) exitWith {true};

private _dlcs = configsourcemodlist (configfile >> "CfgPatches" >> (_addons param [0,""]));
if (count _dlcs == 0) exitWith {true};

private _appID = [configfile >> "cfgMods" >> (_dlcs param [0,""]),"appId",-1] call BIS_fnc_returnConfigEntry;
if (_appID < 0) exitWith {true};

private _allPlayerOwnedDlcs = missionNamespace getVariable [QGVAR(allPlayerOwnedDlcsIntersect),[]];
if (count _allPlayerOwnedDlcs == 0) exitWith {true};

_appID in _allPlayerOwnedDlcs

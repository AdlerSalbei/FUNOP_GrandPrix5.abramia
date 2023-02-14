#include "component.hpp"
#define NOT_OWNED_DLCS  2

params [["_uniformClass",""]];

private _addons = configsourceaddonlist (configfile >> "CfgWeapons" >> _uniformClass);     // e.g.: ["A3_Characters_F_Enoch"]
if (count _addons == 0) exitWith {true};

private _dlcs = configsourcemodlist (configfile >> "CfgPatches" >> (_addons param [0,""]));
if (count _dlcs == 0) exitWith {true};

private _appID = [configfile >> "cfgMods" >> (_dlcs param [0,""]),"appId",-1] call BIS_fnc_returnConfigEntry;
if (_appID < 0) exitWith {true};

!(_appID in (getDLCs NOT_OWNED_DLCS))

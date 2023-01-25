#include "component.hpp"

params [["_weaponClass",""]];

private _defaultMag = ([configFile >> "cfgWeapons" >> _weaponClass >> "magazines", "ARRAY", []] call CBA_fnc_getConfigEntry) param [0,""];
if (_defaultMag == "") exitWith {false};

private _ammo = [configFile >> "cfgMagazines" >> _defaultMag >> "ammo", "STRING",""] call CBA_fnc_getConfigEntry;
if (_ammo == "") exitWith {false};

if (_ammo isKindOf ["FlareCore",configFile >> "cfgAmmo"]) exitWith {false};

if (_ammo isKindOf ["GrenadeCore",configFile >> "cfgAmmo"]) exitWith {
    ([configFile >> "cfgAmmo" >> _ammo >> "dangerRadiusHit", "NUMBER",-1] call CBA_fnc_getConfigEntry) <= 0
};

private _fnc_checkBullet = {
    (_ammo isKindOf ["BulletCore",configFile >> "cfgAmmo"]) &&
    (([configfile >> "CfgAmmo" >> _ammo >> "hit", "NUMBER", 0] call CBA_fnc_getConfigEntry) > 0)
};

private _isDamaging = ([configFile >> "CfgMagazines" >> _defaultMag >> "initSpeed", "NUMBER", 900] call CBA_fnc_getConfigEntry) > 15;
if (_isDamaging) then {
    _isDamaging = [] call _fnc_checkBullet;
};

if (!_isDamaging) then {
    private _subMunition = ([configfile >> "CfgAmmo" >> _ammo >> "submunitionAmmo", "ARRAY",[]] call CBA_fnc_getConfigEntry) param [0,""];
    if (_subMunition != "") then {
        _ammo = _subMunition;
    };
    _isDamaging = [] call _fnc_checkBullet;
};

_isDamaging

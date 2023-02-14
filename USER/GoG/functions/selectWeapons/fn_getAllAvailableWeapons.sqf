#include "component.hpp"

params [["_useBlacklist",true]];

private _allPlayerOwnedDlcs = missionNamespace getVariable [QGVAR(allPlayerOwnedDlcsIntersect),[]];

private _allCfgWeapons = "(getNumber (_x >> 'scope')) == 2" configClasses (configFile >> "cfgWeapons");

private _allAvailableRifles = [];
private _allAvailablePistols = [];
private _allUsedModels = [];

private _weaponBlacklist = [missionConfigFile >> "cfgMission","weaponBlacklist",[]] call BIS_fnc_returnConfigEntry;

{
    if (
        [_x] call FUNC(weaponInOwnedDlcs) &&
        {!_useBlacklist || !(_x in _weaponBlacklist)} &&
        {[_x] call FUNC(hasDamagingDefaultMag)}
    ) then {

        // filter duplicates (optics variants)
        _baseWeapon = [configFile >> "cfgWeapons" >> _x,"baseWeapon",_x] call BIS_fnc_returnConfigEntry;

        // filter duplicates (textures)
        _model = [configFile >> "cfgWeapons" >> _x,"model",""] call BIS_fnc_returnConfigEntry;
        if !(_model in _allUsedModels) then {
            _allUsedModels pushBack _model;

            if (_baseWeapon isKindOf ["Rifle",configFile >> "cfgWeapons"]) then {
                _allAvailableRifles pushBackUnique _baseWeapon;
            };
            if (_baseWeapon isKindOf ["Pistol",configFile >> "cfgWeapons"]) then {
                _allAvailablePistols pushBackUnique _baseWeapon;
            };
        };
    };
} forEach (_allCfgWeapons apply {configName _x});

[_allAvailableRifles,_allAvailablePistols]

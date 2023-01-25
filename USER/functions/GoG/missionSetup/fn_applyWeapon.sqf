#include "component.hpp"

params [["_unit",objNull],"_score"];

if (isNil "_score") then {
    _score = _unit getVariable [QGVAR(currentScore),0];
};

private _weapon = EGVAR(selectWeapons,chosenWeapons) param [_score,""];
private _muzzleItem = EGVAR(selectWeapons,muzzleItems) param [_score,""];
private _scope = EGVAR(selectWeapons,scopes) param [_score,""];

//get magazine
private _magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
private _magazine = _magazines param [0,""];

// disable magazine randomization for now
/* private _isBlank = true;
private _magazine = "";
for [{_i=0},{_i<20},{_i=_i+1}] do {
    _magazine = selectRandom _magazines;
    _isBlank = ([configFile >> "CfgMagazines" >> _magazine >> "initSpeed", "number", 900] call CBA_fnc_getConfigEntry) < 15;
    if (!_isBlank) exitWith {};
}; */

//remove old weapon and magazines
{_unit removeWeapon _x} forEach weapons _unit;
{_unit removeMagazine _x} forEach magazines _unit;

//add weapon and attachments
_unit addMagazine _magazine;
_unit addWeapon _weapon;
_unit addMagazines [_magazine, 6];
if (primaryWeapon _unit == "") then {
    if (_muzzleItem != "EMPTY") then {
        _unit addHandgunItem _muzzleItem;
    };
    if (_scope != "EMPTY") then {
        _unit addHandgunItem _scope;
    };
} else {
    if (_muzzleItem != "EMPTY") then {
        _unit addPrimaryWeaponItem _muzzleItem;
    };
    if (_scope != "EMPTY") then {
        _unit addPrimaryWeaponItem _scope;
    };
};

//call dialog
_layer = (["wait1Layer"] call BIS_fnc_rscLayer);
_layer cutRsc ["upgradeWeaponTitle", "PLAIN", 0.0001, true];

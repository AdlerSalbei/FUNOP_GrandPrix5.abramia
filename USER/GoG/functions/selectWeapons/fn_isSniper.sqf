#include "component.hpp"

params [["_weaponClass",""]];

if (_weaponClass == "") exitWith {false};

private _isSniper = true;
private _fireModes = getArray (configFile >> "CfgWeapons" >> _weapon >> "modes");

if (_fireModes find "FullAuto" != -1) then {_isSniper = false};
if (_fireModes find "Burst" != -1) then {_isSniper = false};
if (_fireModes find "Single" == -1) then {_isSniper = false};
if (count _fireModes <= 1) then {_isSniper = false};

_isSniper

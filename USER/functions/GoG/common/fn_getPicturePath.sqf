#include "component.hpp"

params ["_className"];

private _picturePath = getText (configFile >> "CfgWeapons" >> _className >> "picture");
if (_picturePath == "") then {
    _picturePath = getText (configFile >> "CfgWeapons" >> _className >> "uipicture");
};

_picturePath

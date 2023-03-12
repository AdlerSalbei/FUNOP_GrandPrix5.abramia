#include "component.hpp"

#include "..\..\dialog\upgradeWeaponTitle\defines.hpp"

params ["_dialog"];

private _score = player getVariable ["grad_grandprix_gog_currentScore",0];
private _weapon = grad_grandprix_gog_chosenWeapons param [_score,""];

//weapon text
private _displayName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
private _text = format ["(%1/%2) %3",_score+1, grad_grandprix_gog_killsForWin, _displayName];
(_dialog displayCtrl UPGRADEWEAPON_TEXT) ctrlSetText _text;

//weapon picture
private _picturePath = getText (configFile >> "CfgWeapons" >> _weapon >> "picture");
(_dialog displayCtrl UPGRADEWEAPON_PIC) ctrlSetText _picturePath;

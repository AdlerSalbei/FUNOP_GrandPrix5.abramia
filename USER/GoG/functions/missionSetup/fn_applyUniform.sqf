#include "component.hpp"

if (!hasInterface) exitWith {};

private _uniform = player getVariable [QGVAR(playerUniform),"U_Marshal"];
private _isWoodLand = toLower ([missionConfigFile >> "cfgGradIslands" >> worldName,"isWoodland","true"] call BIS_fnc_returnConfigEntry) == "true";
private _vest = ["V_TacVest_khk","V_TacVest_oli"] select _isWoodland;

private _radio = player getVariable [QGVAR(radioInstance),"TFAR_anprc152"];
player setUnitLoadout [[],[],[],[_uniform,[["ACE_fieldDressing",6],["ACE_morphine",4]]],[_vest,[]],[],"","",["","","","",[],[],""],["ItemMap","ItemGPS",_radio,"ItemCompass","ItemWatch",""]];

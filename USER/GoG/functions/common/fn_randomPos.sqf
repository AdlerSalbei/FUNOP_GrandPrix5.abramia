#include "component.hpp"

params [["_searchCenter",[0,0,0]],["_radii",[0,1000]],["_angles",[0,360]]];

private _returnPos = _searchCenter getPos [_radii call BIS_fnc_randomNum,_angles call BIS_fnc_randomNum];

_returnPos

#include "component.hpp"

params [["_unit",objNull],["_isUnconscious",false]];

if (!local _unit) exitWith {};
if (!_isUnconscious) exitWith {};

_unit setDamage 1;

params ["_pos", "_enemies"];

if (count _enemies <= 0) exitWith { false };

_pos = AGLToASL _pos;
_pos set [2, (_pos#2) + 1.7];

private _canBeSeen = _enemies findIf { !(lineIntersects [_pos, eyePos _x, _x]) } > -1;

_canBeSeen
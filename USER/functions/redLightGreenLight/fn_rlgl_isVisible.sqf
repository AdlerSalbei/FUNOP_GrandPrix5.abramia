params ["_aa", "_unit"];

private _aaPos = getPosASL _aa;
_aaPos set [2, (_aaPos#2) + 2.8];

private _unitFeet = getPosASL _unit;
private _unitTorso = +_unitFeet;
_unitTorso set [2, (_unitFeet#2) + 1.2];
private _unitEyes = eyePos _unit;

private _intersects = nil;
{
	private _pos = _x;
	// _intersects = lineIntersects [_aaPos, _pos, _aa, _unit];
	_intersects = [_aa, "VIEW", _unit] checkVisibility [_aaPos, _pos];
	// systemChat str _intersects;	
	if (_intersects > 0) exitWith {};
} forEach [_unitFeet, _unitTorso, _unitEyes];

_intersects > 0
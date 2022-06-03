params ["_aa", "_unit"];

private _aaPos = getPosASL _aa;
_aaPos set [2, (_aaPos#2) + 2.8];

private _positions = [];
private _selections = ["pelvis", "leftfoot", "rightfoot", "leftleg", "rightleg", "leftarm", "rightarm", "lefthand", "righthand"];
{
	private _relPos = _unit selectionPosition _x;
	private _realPos = _unit modelToWorldVisualWorld _relPos;
	_positions pushBack _realPos;
} forEach _selections;
_positions pushBack (eyePos _unit);

private _intersects = nil;
{
	private _pos = _x;
	// _intersects = lineIntersects [_aaPos, _pos, _aa, _unit];
	_intersects = [_aa, "VIEW", _unit] checkVisibility [_aaPos, _pos];
	// systemChat str _intersects;	
	if (_intersects > 0) exitWith {};
} forEach _positions;

_intersects > 0
params ["_a", "_b"];
_a params ["_xa", "_ya", "_za"];
_b params ["_xb", "_yb", "_zb"];

private _divisor = (sqrt (_xa*_xa + _ya*_ya + _za*_za) * sqrt (_xb*_xb + _yb*_yb + _zb*_zb));
if (_divisor <= 0) exitWith { 0 };
private _angle = acos ((_xa*_xb + _ya*_yb + _za*_zb) / _divisor);
if (_za < 0 || _zb < 0) then {
	_angle = _angle * -1;
};
_angle
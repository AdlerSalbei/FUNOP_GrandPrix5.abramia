params ["_group"];

private _return = true;

{
	private _unconsious = _x getVariable ["GRAD_grandPrix_ZiG_isUnconsious", false];
	if !(_unconsious) exitWith {
		_return = false;
	};
} forEach (units _group);

_return

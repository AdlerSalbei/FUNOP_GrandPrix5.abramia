params ["_group"];

private _times = [];
{
	private _time = _x getVariable ["GRAD_grandPrix_ZiG_unconsciousTime", 0];
	if (_time == 0) then {
		_times pushBack 0;
	} else {
		_times pushBack (([time, serverTime] select isDedicated) - _time);
	};
} forEach (units _group);

(count _times) == (count (_times select { _x >= 30 }))

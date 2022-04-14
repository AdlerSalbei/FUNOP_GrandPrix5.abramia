params [["_state", false]];

if !(isServer) exitWith {};

private _time = 0;

if (_state) then {
	_time = random 20 + 10;
} else {
	_time = random 10 + 10;
};

[{
	_this call grad_user_fnc_lightToggle;
}, _time, [!_state]] call CBA_fnc_waitAndExecute;
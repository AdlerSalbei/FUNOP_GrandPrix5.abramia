params ["_aa", "_target", "_zeus"];

private _weapon = currentWeapon _aa;

_aa lookAt (getPos _target);

[format["Gun is targeting %1", name _target]] remoteExecCall ["hint", _zeus];
private _time = time + 8;
waitUntil { ((_aa aimedAtTarget [_target, _weapon]) >= 0.5) || (time > _time) };
sleep 1;

private _handler =
[
	{
		params ["_args", "_handle"];
		_args params ["_target", "_aa", "_weapon"];

		if (_target getVariable ["ACE_isUnconscious", false]) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
			[
				{
					params ["_aa"];

					_aa setVehicleAmmoDef 1;
					private _pos = _aa getRelPos [100,0];
					_pos set [2, (_pos # 2) + 30];
					_aa lookAt _pos;

					systemChat "done";
				},
				[_aa],
				1
			] call CBA_fnc_waitAndExecute;
		};

		[_aa, _weapon] call BIS_fnc_fire;
	},
	0.1,
	[_target, _aa, _weapon]
] call CBA_fnc_addPerFrameHandler;
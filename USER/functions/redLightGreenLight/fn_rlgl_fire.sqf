params ["_aa", "_target"];

private _weapon = currentWeapon _aa;

_aa lookAt (getPos _target);

waitUntil { (_aa aimedAtTarget [_target, _weapon]) >= 1 };
sleep 1;

// systemChat str (_target getVariable ["ACE_isUnconscious", true]);
// while { !(_target getVariable ["ACE_isUnconscious", false]) } do {
// 	systemChat "firing";
// 	[_aa, _weapon] call BIS_fnc_fire;
// 	sleep 0.1;
// };
// sleep 1;

// _aa setVehicleAmmoDef 1;
// private _pos = _aa getRelPos [100,0];
// _pos set [2, ((getPos _aa) # 2) + 1];
// _aa lookAt _pos;

// systemChat "done";

systemChat "aligned";
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
					_pos set [2, ((getPos _aa) # 2) + 1];
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
if !(canSuspend) exitWith { _this spawn GRAD_grandPrix_fnc_PUPS_handleStationLocal; };

params [["_targets", [GRAD_grandPrix_PUPS_target_1, GRAD_grandPrix_PUPS_target_2]]];

private _firedEH = [] call GRAD_grandPrix_fnc_PUPS_addFiredHandler;

player setVariable ["GRAD_grandPrix_PUPS_movementCenter", getPos player];

{
	player setVariable ["GRAD_grandPrix_PUPS_currentTarget", _x];
	[_x, 60] call grad_grandPrix_fnc_PUPS_handleIndicator;

	private _handle =
	[ 
		{ 
			private _isFlying = player getVariable ["GRAD_grandPrix_PUPS_isFlying", false];
			private _center = player getVariable ["GRAD_grandPrix_PUPS_movementCenter", getPosASL player];

			if (!_isFlying && !(player inArea [_center, 1.1, 1.1, 0, false, -1])) then {
				player setPosASL _center;
				hint "you moved too far!";
			};
		}, 
		0, 
		[] 
	] call CBA_fnc_addPerFrameHandler;

	_x hideObject false;
	waitUntil { (player inArea [_x, 1, 1, 0, false, 1.8]) && (speed player == 0) };
	hint "target reached!";
	hideObject _x;
	[_handle] call CBA_fnc_removePerFrameHandler;
} forEach _targets;

player removeEventHandler ["fired", _firedEH];
systemChat "done!";
private _shotsFired = player getVariable ["GRAD_grandPrix_PUPS_shotsFired", 0];
systemChat str _shotsFired;
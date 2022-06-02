#define TIME_PER_SHOT 10

if !(canSuspend) exitWith { _this spawn GRAD_grandPrix_fnc_PUPS_handleStationLocal; };

params [["_targets", [GRAD_grandPrix_PUPS_target_1, GRAD_grandPrix_PUPS_target_2, GRAD_grandPrix_PUPS_target_3, GRAD_grandPrix_PUPS_target_4, GRAD_grandPrix_PUPS_target_5, GRAD_grandPrix_PUPS_target_6]]];

player allowDamage false;

private _start = time;
player setVariable ["GRAD_grandPrix_PUPS_stationFinished", false, true];
player setVariable ["GRAD_grandPrix_PUPS_shotsFired", 0, true];

private _firedEH = [] call GRAD_grandPrix_fnc_PUPS_addFiredHandler;

player setVariable ["GRAD_grandPrix_PUPS_movementCenter", getPosASL player];

{
	player setVariable ["GRAD_grandPrix_PUPS_currentTarget", _x];
	[_x, 60] call grad_grandPrix_fnc_PUPS_handleIndicator;

	private _handle =
	[ 
		{ 
			private _isFlying = player getVariable ["GRAD_grandPrix_PUPS_isFlying", false];
			private _center = player getVariable ["GRAD_grandPrix_PUPS_movementCenter", getPosASL player];
			private _inArea = player inArea [_center, 15, 15, 0, false, -1];
			private _teleported = player getVariable ["GRAD_grandPrix_PUPS_beingTeleported", false];
			
			if (!_isFlying && !_inArea && !_teleported) then {
				player setPosASL _center;
				hint "Du hast dich zu weit bewegt!";
			};
		}, 
		0,
		[] 
	] call CBA_fnc_addPerFrameHandler;

	_x hideObject false;
	waitUntil { (player inArea [_x, 5, 5, 0, false, 5]) && (speed player == 0) };
	hint format["Ziel %1 erreicht!", _foreachIndex + 1];
	hideObject _x;
	[_handle] call CBA_fnc_removePerFrameHandler;
} forEach _targets;

private _timeTaken = time - _start;

sleep 3;

player removeEventHandler ["fired", _firedEH];
private _shotsFired = player getVariable ["GRAD_grandPrix_PUPS_shotsFired", 0];
private _timeTaken = _timeTaken + TIME_PER_SHOT * _shotsFired;

player setVariable ["GRASD_grandPrix_PUPS_timeTaken", _timeTaken, true];
player setPosASL (getPosASL grad_grandPrix_fnc_PUPS_returnPoint);
hint format ["Du hast %1 bei %2 Schuss gebraucht.", [_timeTaken, "MM:SS"] call BIS_fnc_secondsToString, _shotsFired];
player setVariable ["GRAD_grandPrix_PUPS_stationFinished", true, true];
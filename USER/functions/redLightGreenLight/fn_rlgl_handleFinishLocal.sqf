player setVariable ["GRAD_grandPrix_rlgl_timeStart", time, true];

[
	{
		player inArea GRAD_grandPrix_rlgl_finish
	},
	{
		player setVariable ["GRAD_grandPrix_rlgl_reachedFinish", true, true];
		private _start = player getVariable ["GRAD_grandPrix_rlgl_timeStart", time];
		private _timeTaken = time - _start;
		player setVariable ["GRAD_grandPrix_rlgl_timeTaken", _timeTaken, true];

		hint format ["Du hast für deinen Durchlauf %1 gebraucht! Bitte warte bis deine Mitspieler das Ziel erreicht haben.", [_timeTaken, "MM:SS"] call BIS_fnc_secondsToString];

		[
			{
				player setPosASL (getPosASL GRAD_grandPrix_rlgl_platform);
				player addWeapon "Binocular";
				
				// Wonky solution to display 3D markers for players still in the station
				[{
					params ["", "_handle"];

					private _finishedUnits = 0;
					private _units = units group player;

					{
						if !(_x getVariable ["GRAD_grandPrix_rlgl_reachedFinish", false]) then {
							drawIcon3D [
								"\a3\ui_f\data\igui\rsccustominfo\sensors\targets\assignedtarget_ca.paa",
								[1, 1, 1, 0.8],
								ASLToAGL (eyePos _x),
								1,
								1,
								0,
								(vehicleVarName _x)
							];
						} else {
							_finishedUnits = _finishedUnits +1;
						};
					} forEach _units;

					if (_finishedUnits isEqualTo (count _units)) exitWith {
						[_handle] call CBA_fnc_removePerFrameHandler;
					};
				}, 0, []] call CBA_fnc_addPerFrameHandler;
			},
			[],
			3
		] call CBA_fnc_waitAndExecute;
	},
	[]
] call CBA_fnc_waitUntilAndExecute;

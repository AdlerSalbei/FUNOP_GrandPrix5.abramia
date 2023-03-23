([] call grad_grandPrix_fnc_ZiG_createPlanes) params ["_planes", "_drones"];

missionNamespace setVariable ["GRAD_grandPrix_ZiG_moneyDropPlanes", [_planes, _drones], true];
[_planes] call grad_grandPrix_fnc_ZiG_handlePlaneCapture;

[
	{
		params ["_planes", "_drones"];
		(_planes # 2) inArea GRAD_grandPrix_ZiG_startDrop
	},
	{
		params ["_planes", "_drones"];

		// private _handle = 
		// [
		// 	{
		// 		_args params ["_planes", "_drones"];

		// 		if (!alive (_planes # 0)) exitWith { [_handle] call CBA_fnc_removePerFramehandler };

		// 		{
		// 			_x setAmmo [currentWeapon _x, 1];
		// 			_x fire "Bomb_Leaflets";
		// 		} forEach _drones;
		// 	},
		// 	1,
		// 	[_planes, _drones]
		// ] call CBA_fnc_addPerFrameHandler;

		[
			{
				params ["_planes", "_drones", "_handle"];
				(_planes # 0) inArea GRAD_grandPrix_ZiG_stopDrop
			},
			{
				params ["_planes", "_drones", "_handle"];

				[_handle] call CBA_fnc_removePerFrameHandler;
				missionNamespace setVariable ["Grad_grandPrix_ZiG_showMoneyLocal", true, true];

				[
					{
						params ["_planes", "_drones"];
						{
							{
								deleteVehicle _x;								
							} forEach (units _x);
							deleteVehicle _x;					
						} forEach _planes;

						{
							deleteVehicle _x;							
						} forEach _drones;						
					},
					[_planes, _drones],
					15
				] call CBA_fnc_waitAndExecute;

				[
					{
						missionNamespace setVariable ["GRAD_grandPrix_ZiG_planesDone", true, true];
					},
					[],
					9
				] call CBA_fnc_waitAndExecute;
			},
			[_planes, _drones, _handle]
		] call CBA_fnc_waitUntilAndExecute;
	},
	[_planes, _drones]
] call CBA_fnc_waitUntilAndExecute;
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
				private _teammates = (units (group player)) select { !(_x inArea GRAD_grandPrix_rlgl_finish) && !(_x getVariable ["GRAD_grandPrix_rlgl_reachedFinish", false]) };
				private _ids = [];
				switch (count _teammates) do {
					case 1: {
						missionNamespace setVariable ["GRAD_grandPrix_rlgl_teammate_0", _teammates # 0];
						private _id0 = addMissionEventHandler ["Draw3D", {
							drawIcon3D [
								"\a3\ui_f\data\igui\rsccustominfo\sensors\targets\assignedtarget_ca.paa",
								[1, 1, 1, 0.8],
								ASLToAGL (eyePos (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_0", objNull])),
								1,
								1,
								0,
								name (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_0", objNull])
							];
						}];
						_ids pushBack _id0;
					};
					case 2: {
						missionNamespace setVariable ["GRAD_grandPrix_rlgl_teammate_0", _teammates # 0];
						private _id0 = addMissionEventHandler ["Draw3D", {
							drawIcon3D [
								"\a3\ui_f\data\igui\rsccustominfo\sensors\targets\assignedtarget_ca.paa",
								[1, 1, 1, 0.8],
								ASLToAGL (eyePos (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_0", objNull])),
								1,
								1,
								0,
								name (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_0", objNull])
							];
						}];
						_ids pushBack _id0;

						missionNamespace setVariable ["GRAD_grandPrix_rlgl_teammate_1", _teammates # 1];
						private _id1 = addMissionEventHandler ["Draw3D", {
							drawIcon3D [
								"\a3\ui_f\data\igui\rsccustominfo\sensors\targets\assignedtarget_ca.paa",
								[1, 1, 1, 0.8],
								ASLToAGL (eyePos (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_1", objNull])),
								1,
								1,
								0,
								name (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_1", objNull])
							];
						}];
						_ids pushBack _id1;
					};
					case 3: {
						missionNamespace setVariable ["GRAD_grandPrix_rlgl_teammate_0", _teammates # 0];
						private _id0 = addMissionEventHandler ["Draw3D", {
							drawIcon3D [
								"\a3\ui_f\data\igui\rsccustominfo\sensors\targets\assignedtarget_ca.paa",
								[1, 1, 1, 0.8],
								ASLToAGL (eyePos (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_0", objNull])),
								1,
								1,
								0,
								name (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_0", objNull])
							];
						}];
						_ids pushBack _id0;

						missionNamespace setVariable ["GRAD_grandPrix_rlgl_teammate_1", _teammates # 1];
						private _id1 = addMissionEventHandler ["Draw3D", {
							drawIcon3D [
								"\a3\ui_f\data\igui\rsccustominfo\sensors\targets\assignedtarget_ca.paa",
								[1, 1, 1, 0.8],
								ASLToAGL (eyePos (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_1", objNull])),
								1,
								1,
								0,
								name (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_1", objNull])
							];
						}];
						_ids pushBack _id1;

						missionNamespace setVariable ["GRAD_grandPrix_rlgl_teammate_2", _teammates # 2];
						private _id2 = addMissionEventHandler ["Draw3D", {
							drawIcon3D [
								"\a3\ui_f\data\igui\rsccustominfo\sensors\targets\assignedtarget_ca.paa",
								[1, 1, 1, 0.8],
								ASLToAGL (eyePos (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_2", objNull])),
								1,
								1,
								0,
								name (missionNamespace getVariable ["GRAD_grandPrix_rlgl_teammate_2", objNull])
							];
						}];
						_ids pushBack _id2;
					};
				};

				{
					[
						{
							params ["_id", "_index"];
							private _teammate = missionNamespace getVariable [format["GRAD_grandPrix_rlgl_teammate_%1", _index], objNull];
							_teammate getVariable ["GRAD_grandPrix_rlgl_reachedFinish", false]
						},
						{
							params ["_id", "_index"];
							removeMissionEventHandler ["Draw3D", _id];
						},
						[_x, _foreachIndex]
					] call CBA_fnc_waitUntilAndExecute;
				} forEach _ids;
			},
			[],
			3
		] call CBA_fnc_waitAndExecute;
	},
	[]
] call CBA_fnc_waitUntilAndExecute;
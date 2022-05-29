if (player getVariable ["GRAD_grandPrix_PUPS_indicatorRunning", false]) exitWith {};

params ["_target", "_time"];

player setVariable ["GRAD_grandPrix_PUPS_indicatorRunning", true];
private _targetPos = getPosASL _target;
[
	{
		params ["_targetPos"];

		private _targetDir = (eyePos player) vectorFromTo _targetPos;
		private _weaponDir = player weaponDirection (currentWeapon player);

		_targetDir = _targetDir apply { [_x, 2] call grad_grandPrix_fnc_PUPS_cutDecimals };
		_weaponDir = _weaponDir apply { [_x, 2] call grad_grandPrix_fnc_PUPS_cutDecimals };

		(_targetDir isEqualTo _weaponDir) || ((player distance2D _targetPos) < 20) || (player getVariable ["GRAD_grandPrix_PUPS_stationFinished", false])
	},
	{
		params ["_targetPos"];
		player setVariable ["GRAD_grandPrix_PUPS_indicatorRunning", false];
	},
	[_targetPos],
	_time,
	{
		params ["_targetPos"];

		player setVariable ["GRAD_grandPrix_PUPS_currentTargetPos", ASLToAGL _targetPos];
		private _id =
		addMissionEventHandler ["Draw3D", {
			drawIcon3D [
				"\a3\ui_f\data\IGUI\Cfg\Radar\targeting_ca.paa",
				[1,0.45,0,1],
				player getVariable ["GRAD_grandPrix_PUPS_currentTargetPos", [0,0,0]],
				1,
				1,
				0
			];
		}];

		[
			{
				params ["_targetPos", "_id"];

				private _targetDir = (eyePos player) vectorFromTo _targetPos;
				private _weaponDir = player weaponDirection (currentWeapon player);

				_targetDir = _targetDir apply { [_x, 2] call grad_grandPrix_fnc_PUPS_cutDecimals };
				_weaponDir = _weaponDir apply { [_x, 2] call grad_grandPrix_fnc_PUPS_cutDecimals };

				(_targetDir isEqualTo _weaponDir) || ((player distance2D _targetPos) < 20) || (player getVariable ["GRAD_grandPrix_PUPS_stationFinished", false])
			},
			{
				params ["_targetPos", "_id"];				
				player setVariable ["GRAD_grandPrix_PUPS_indicatorRunning", false];
				removeMissionEventHandler ["Draw3D", _id];
			},
			[_targetPos, _id]
		] call CBA_fnc_waitUntilAndExecute;		
	}
] call CBA_fnc_waitUntilAndExecute;
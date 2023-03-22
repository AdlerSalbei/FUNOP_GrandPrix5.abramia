params ["_group"];

player setVariable ["GRAD_grandPrix_race_startTime", [time, servertime] select isMultiplayer, true];

private _handle = 
[
	{
		_args params ["_group"];

		private _resetting = player getVariable ["GRAD_grandPrix_race_isResetting", false];
		if !(([] call grad_grandPrix_fnc_race_resetRequired) || _resetting) exitWith {};

		[_group] spawn grad_grandPrix_fnc_race_resetOnRoad;
	},
	5,
	[_group]
] call CBA_fnc_addPerFrameHandler;

[
	{
		player inArea GRAD_grandPrix_race_rampBoost
	},
	{
		params ["_handle", "_group"];

		[_handle] call CBA_fnc_removePerFrameHandler;
		(vehicle player)  setVelocityModelSpace [0, 100, 0];

		missionNamespace setVariable ["GRAD_grandPrix_race_localCarPartDone", true];
		[_group] spawn grad_grandPrix_fnc_race_handlePlanePartLocal;
	},
	[_handle, _group]
] call CBA_fnc_waitUntilAndExecute;

missionNamespace setVariable ["GRAD_grandPrix_race_localCarPartDone", false];
[[["NFS_soundtrack_3", 0, 1109]], "GRAD_grandPrix_race_localCarPartDone"] spawn grad_grandprix_fnc_common_runPlaylist;

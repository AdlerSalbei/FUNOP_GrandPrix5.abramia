if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

params ["_vehicle", "_group"];

// attach the 2 water tanks
private _tankFront = "Land_WaterTank_F" createVehicle [random 1000, random 1000, (random 1000) + 100];
_tankFront attachTo [_vehicle, [-0.00146484,-0.0522461,1.868]];
_tankFront setDir 270;
private _tankBack = "Land_WaterTank_F" createVehicle [random 1000, random 1000, (random 1000) + 100];
_tankBack attachTo [_vehicle, [-0.00146484,-1.47388,1.868]];
_tankBack setDir 90;
_vehicle setVariable ["GRAD_grandPrix_attachedWaterTanks", [_tankFront, _tankBack], true];

// prevent vehicle from taking damage after locality-change
_vehicle addEventHandler ["GetIn", {
	params ["_vehicle", "_role", "_unit", "_turret"];

	[
		{
			params ["_vehicle"];

			[_vehicle, false] remoteExec ["allowDamage", _vehicle];
		},
		[_vehicle],
		1
	] call CBA_fnc_waitAndExecute;	
}];

[_vehicle] remoteExecCall ["GRAD_grandPrix_fnc_water_addAceAction", _group, true];

// handle water loss
[_vehicle] call GRAD_grandPrix_fnc_water_addCollisionHandler;

private _allInstructors = [];
{
	_allInstructors pushBackUnique (getAssignedCuratorUnit _x);
} forEach allCurators;
// handle visual water leakage

diag_log "waiting 30 seconds, before starting leakage handler";

// wait a bit for group to fill
sleep 30;

diag_log "starting leakage handler";
[_vehicle] remoteExec ["grad_grandPrix_fnc_water_leakageHandler", (units _group) + _allInstructors];


[
	{
		missionNamespace getVariable ["GRAD_grandPrix_complete", false]
	},
	{
		params ["_vehicle", "_group"];

		private _water = _vehicle getVariable ["GRAD_grandPrix_water_currentVolume", 5500];
		[_group, round ((_water / 5500) * 1000), "Wassertransport"] call grad_grandPrix_fnc_addPoints;
	},
	[_vehicle, _group]
] call CBA_fnc_waitUntilAndExecute;

// if (isServer) then {
//    [
// 	   {
// 		   !(isNull GRAD_grandPrix_team_Lovelace)
// 	   },
// 	   {
// 		   params ["_vehicle"];
// 		   [_vehicle, GRAD_grandPrix_team_Lovelace] call grad_grandPrix_fnc_water_setupVehicle;
// 	   },
// 	   [this]
//    ] call CBA_fnc_waitUntilAndExecute;
// };
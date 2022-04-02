params ["_vehicle"];

// attach the 2 water tanks
private _tank1 = "Land_WaterTank_F" createVehicle [random 1000, random 1000, (random 1000) + 100];
_tank1 attachTo [_vehicle, [-0.00146484,-0.0522461,1.868]];
_tank1 setDir 270;
private _tank2 = "Land_WaterTank_F" createVehicle [random 1000, random 1000, (random 1000) + 100];
_tank2 attachTo [_vehicle, [-0.00146484,-1.47388,1.868]];
_tank2 setDir 90;
_vehicle setVariable ["GRAD_grandPrix_attachedWaterTanks", [_tank1, _tank2], true];

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

[_vehicle] call GRAD_grandPrix_fnc_water_addCollisionHandler;
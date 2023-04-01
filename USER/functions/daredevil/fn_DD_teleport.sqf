if !(hasInterface) exitWith {};

params ["_index"];
		
cutText ["", "BLACK", 0.1];

[{
	params ["_index"];
	playSound "jumpTPSound";

	_index params ["_vehicleName", "_type"];
	diag_log format ["%1", _index];

	systemChat "Starting TP";

	if (_type isEqualType true) then {
		systemChat "Equal Type check";
		if (_type) then {
			systemChat "Driver";
			//player assignAsDriver _vehicleName; 
			//player moveInDriver _vehicleName;
		} else {
			systemChat "Gunner";
			//player assignAsGunner _vehicleName; 
			//player moveInGunner _vehicleName;
		};
	} else {
		//player assignAsCommander _vehicleName; 
		//player moveInCommander _vehicleName;
	};

	[{
		if (vehicle player isEqualTo player || !(driver vehicle player isEqualTo player)) then {
			cutText ["", "BLACK IN", 0.1];
		};
	}, [], 1.5] call CBA_fnc_waitAndExecute;
}, [_index], 0.3 + random 1] call CBA_fnc_waitAndExecute;

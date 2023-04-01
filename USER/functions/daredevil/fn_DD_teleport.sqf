if !(hasInterface) exitWith {};

params ["_index"];
		
cutText ["", "BLACK", 0.1];

[{
	playSound "jumpTPSound";

	_index params ["_vehicleName", "_type"];

	if (_type isEqualType true) then {
		if (_type) then {
			player assignAsDriver _vehicleName; 
			player moveInDriver _vehicleName;
		} else {
			player assignAsGunner _vehicleName; 
			player moveInGunner _vehicleName;
		};
	} else {
		player assignAsCommander _vehicleName; 
		player moveInCommander _vehicleName;
	};

	[{
		if (vehicle player isEqualTo player || !(driver vehicle player isEqualTo player)) then {
			cutText ["", "BLACK IN", 0.1];
		};
	}, [], 1.5] call CBA_fnc_waitAndExecute;
}, [_vehicleName], 0.3 + random 1] call CBA_fnc_waitAndExecute;

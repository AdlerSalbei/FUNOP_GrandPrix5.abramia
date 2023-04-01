if !(hasInterface) exitWith {};

params ["_index"];
		
cutText ["", "BLACK", 0.1];

[{
	params ["_index"];
	playSound "jumpTPSound";

	_index params ["_vehicleName", "_type"];
	private _veh = missionnamespace getvariable [_vehicleName, objNull];

	if (_type isEqualType true) then {
		if (_type) then {
			player assignAsDriver _veh; 
			player moveInDriver _veh;
		} else {
			player assignAsGunner _veh; 
			player moveInGunner _veh;
		};
	} else {
		player assignAsCommander _veh; 
		player moveInCommander _veh;
	};

	[{
		if (vehicle player isEqualTo player || !(driver vehicle player isEqualTo player)) then {
			cutText ["", "BLACK IN", 0.1];
		};
	}, [], 1.5] call CBA_fnc_waitAndExecute;
}, [_index], 0.3 + random 1] call CBA_fnc_waitAndExecute;

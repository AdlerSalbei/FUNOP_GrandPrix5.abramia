if !(hasInterface) exitWith {};

params ["_index"];

		
		
cutText ["", "BLACK", 0.1];

[{
	params ["_unit", "_vehicleName"];

	playSound "jumpTPSound";

	_index params ["_num", "_type"];
	private _vehicleName = missionnamespace getvariable [ format ["%1", "dd_tank_0" + str _num], objNull];

	if (_type isEqualType true) then {
		if (_type) then {
			_x assignAsDriver _vehicleName; 
			_x moveInDriver _vehicleName;
		} else {
			_x assignAsGunner _vehicleName; 
			_x moveInGunner _vehicleName;
		};
	} else {
		_x assignAsCommander _vehicleName; 
		_x moveInCommander _vehicleName;
	};

	[{
		if (vehicle player isEqualTo player || !(driver vehicle player isEqualTo player)) then {
			cutText ["", "BLACK IN", 0.1];
		};
	}, [], 1.5] call CBA_fnc_waitAndExecute;
}, [player, _vehicleName], 0.3 + random 1] call CBA_fnc_waitAndExecute;

private _handler = [
	"ace_unconscious",
	{
		params ["_unit", "_unconscious"];

		if !(isPlayer _unit) exitWith {};
		
		if (_unconscious) then {
			player setVariable ["GRAD_grandPrix_ZiG_unconsciousTime", [time, serverTime] select isDedicated, true];
			systemChat "player went unconscious";
		} else {
			systemChat "player woke up";
			player setVariable ["GRAD_grandPrix_ZiG_unconsciousTime", 0, true];
		};
	}
] call CBA_fnc_addEventHandler;

player setVariable ["GRAD_grandPrix_ZiG_unconsciousHandler", _handler, true];
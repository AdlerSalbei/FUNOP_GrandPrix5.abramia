private _handler = [
	"ace_unconscious",
	{
		params ["_unit", "_unconscious"];

		if !(isPlayer _unit) exitWith {};
		
		if (_unconscious) then {
			[
				{!((_this select 0) getVariable ["ACE_isUnconscious", false])},
				{},
				[_unit],
				15,
				{
					params ["_unit"];

					_unit setVariable ["GRAD_grandPrix_ZiG_isUnconsious", true, true];
				}
			] call CBA_fnc_waitUntilAndExecute;
		} else {
			_unit setVariable ["GRAD_grandPrix_ZiG_isUnconsious", false, true];
		};
	}
] call CBA_fnc_addEventHandler;

player setVariable ["GRAD_grandPrix_ZiG_unconsciousHandler", _handler, true];
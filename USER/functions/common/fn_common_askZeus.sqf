if !(hasInterface) exitWith {};
if (getAssignedCuratorLogic (call CBA_fnc_currentUnit) isEqualTo objNull) exitWith {
	{
		_this remoteExecCall ["grad_grandprix_fnc_water_askZeus", _x, false];
	}forEach allCurators;
};

params ["_unit", "_stage"];

hint "Ask Zeus";

//Hier fehlt noch alles
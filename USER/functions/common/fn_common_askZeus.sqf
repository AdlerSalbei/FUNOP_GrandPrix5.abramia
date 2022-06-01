if !(hasInterface) exitWith {};
if (getAssignedCuratorLogic (call CBA_fnc_currentUnit) isEqualTo objNull) exitWith {
	{
		_this remoteExecCall [_fnc_scriptName, _x, false];
	}forEach allCurators;
};

params ["_unit", "_stage"];

private _text = format ["%1 braucht hilfe bei der Stage: %2", _unit, _stage];

hint _text;
systemChat _text;

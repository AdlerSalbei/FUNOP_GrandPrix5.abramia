if (!isServer) exitWith { _this remoteExecCall [_fnc_scriptName, 2]; };

missionNamespace setVariable ["GRAD_grandPrix_ZiG_spawningMoney", true, true];

private _timeModifier = 0.1;
private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
private _emptyHolders = _holders select { getMagazineCargo _x isEqualTo [[],[]]};

{
	[{
		_this addMagazineCargoGlobal  ["photo9", 1];
	}, _x, _timeModifier * (_forEachIndex + 1)] call CBA_fnc_waitAndExecute;
} forEach _emptyHolders;

[{
	missionNamespace setVariable ["GRAD_grandPrix_ZiG_spawningMoney", false, true];
}, [], _timeModifier * (count _emptyHolders  + 1)] call CBA_fnc_waitAndExecute;

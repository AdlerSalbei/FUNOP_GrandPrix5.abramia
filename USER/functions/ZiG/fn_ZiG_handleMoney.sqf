if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

missionNamespace setVariable ["GRAD_grandPrix_ZiG_spawningMoney", true, true];

private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
private _emptyHolders = _holders select { getMagazineCargo _x isEqualTo [] };
{
	_x addMagazineCargoGlobal  ["photo9", 1];
	sleep 0.1;
} forEach _emptyHolders;

missionNamespace setVariable ["GRAD_grandPrix_ZiG_spawningMoney", false, true];

// [
// 	{
// 		params ["_args", "_handle"];
// 		_args params ["_emptyHolders"];

// 		if ((count _emptyHolders) <= 0) exitWith {
// 			[_handle] call CBA_fnc_removePerFrameHandler;
// 		};
// 		(_emptyHolders#0) addMagazineCargoGlobal  ["photo9", 1];
// 		_emptyHolders deleteAt 0;
// 		systemChat str (count _emptyHolders);
// 	},
// 	0,
// 	[]
// ] call CBA_fnc_addPerFrameHandler;
if !(isServer) exitWith {};

private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
{
	if (getMagazineCargo _x isEqualTo []) then {
		_x addMagazineCargoGlobal  ["photo9", 1];
	};
} forEach _holders;

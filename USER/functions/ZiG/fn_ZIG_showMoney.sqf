if !(hasInterface) exitWith {};

private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
{
	_x hideObject false;
} forEach _holders;

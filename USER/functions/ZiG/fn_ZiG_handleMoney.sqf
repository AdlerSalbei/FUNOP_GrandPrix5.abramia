private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
{
	_x addMagazineCargoGlobal  ["photo9", 1];
} forEach _holders;

systemChat "money placed";
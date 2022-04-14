private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
{
	_x addMagazineCargoGlobal  ["photo9", 1];
} forEach _holders;

systemChat "money placed";

waitUntil { !(missionNameSpace getVariable ["GRAD_grandPrix_ZiG_collectingActive", true]) };

{
	clearMagazineCargoGlobal _x;
} forEach _holders;
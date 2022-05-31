params ["_unit"];

[_unit] call ace_medical_treatment_fnc_fullHealLocal;

private _pos = [grad_grandPrix_fnc_ZiG_teleport] call BIS_fnc_randomPosTrigger;
_pos set [2, 0];
_unit setPos _pos;
_unit setUnitLoadout (_unit getVariable ["GRAD_grandPrix_ZiG_savedLoadout", []]);

private _markers = _unit getVariable ["GRAD_grandPrix_ZiG_moneyMarkers", []];
{
	deleteMarker _x;
} forEach _markers;

_x allowDamage false;

private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
{
	_x hideObject true;
} forEach _holders;
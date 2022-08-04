[player] call ace_medical_treatment_fnc_fullHealLocal;

private _pos = [grad_grandPrix_fnc_ZiG_teleport] call BIS_fnc_randomPosTrigger;
_pos set [2, 0];
player setPos _pos;
player setUnitLoadout (missionNamespace getVariable ["GRAD_grandPrix_ZiG_savedLoadout_" + getPlayerUID player, []]);

private _markers = player getVariable ["GRAD_grandPrix_ZiG_moneyMarkers", []];
{
	deleteMarker _x;
} forEach _markers;

player allowDamage false;

private _handler = player getVariable ["GRAD_grandPrix_ZiG_unconsciousHandler", -1];
["ace_unconscious", _handler] call CBA_fnc_removeEventHandler;
player setVariable ["GRAD_grandPrix_ZiG_isUnconsious", false, true]; 

private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
{
	_x hideObject true;
} forEach _holders;
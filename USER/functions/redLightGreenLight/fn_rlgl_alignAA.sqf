params ["_aa", "_unit"];

_aa setDir (_aa getDir _unit);

private _pos = (getPosWorld _aa) vectorDiff (getPosWorld _unit);
private _mag = sqrt ((_pos#0)^2 + (_pos#1)^2 + (_pos#2)^2);
private _op = _pos # 2;
private _ad = sqrt ((_pos#0)^2 + (_pos#1)^2);
private _pitch = ((_op atan2 _ad) * -1);



[_aa, _pitch, 0] call BIS_fnc_setPitchBank;

private _posG = _aa vectorModelToWorld (_aa selectionPosition ((selectionNames _aa) # 4));
private _vecW = _aa weaponDirection (currentWeapon _aa);
_vecA = _posG vectorFromTo (getPosWorld _unit);

systemChat format ["weapon: %1 | should: %2", _vecW, _vecA];
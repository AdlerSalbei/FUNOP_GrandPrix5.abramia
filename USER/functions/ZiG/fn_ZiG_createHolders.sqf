if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

// handler to remove dropped leaflets
private _handler = ["Leaflet_05_F", "init",
	{
		params ["_leaflet"];
		// systemChat format ["Deleting %1", _leaflet];
		deleteVehicle _leaflet;
	}
] call CBA_fnc_addClassEventHandler;

sleep 10;

private _holders = [];
for "_i" from 1 to 5000 do {
	private _pos = GRAD_grandPrix_ZiG_moneyArea call BIS_fnc_randomPosTrigger;
	_pos set [2, 0.002];
	private _posASL = AGLToASL _pos;
	private _intersects = lineIntersectsSurfaces [_posASL, _posASL vectorAdd [0, 0, 20], objNull, objNull, true, 1, "VIEW"];
	if (_intersects isNotEqualTo []) then { 
		_i = _i - 1;
		continue
	};
	private _holder = "groundweaponHolder_scripted" createVehicle _pos;
	_holder setPos _pos;
	_holder setDir (random 360);
	_holders pushBack _holder;
};

systemChat "Holders placed";
missionNamespace setVariable ["GRAD_grandPrix_ZiG_weaponHolders", _holders];
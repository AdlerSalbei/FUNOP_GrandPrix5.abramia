if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

// handler to remove dropped leaflets
private _handler = ["Leaflet_05_F", "init",
	{
		params ["_leaflet"];
		deleteVehicle _leaflet;
	}
] call CBA_fnc_addClassEventHandler;

// setup plantation ambience
private _positions = [];
private _positionsMarkerStart = 1; 
private _positionsMarkerEnd = 136; 
for "_i" from _positionsMarkerStart to _positionsMarkerEnd do
{   
	private _marker = call(compile format ["GRAD_grandPrix_ZiG_millettia_%1",_i]); 
	_positions pushBack _marker;
};

{
	private _pos = getPosWorld _x;
	private _posX = (_pos#0) + selectRandom [-(random 0.1), random 0.1];
	private _posY = (_pos#1) + selectRandom [-(random 0.1), random 0.1];
	private _posZ = (_pos#2) + (random 0.2);
	_pos = [_posX, _posY, _posZ];
	private _tree = createSimpleObject ["a3\vegetation_f_exp\tree\t_millettia_plantation_f.p3d", _pos];
	_tree setDir (getDir _x) + selectRandom [-(random 5), random 5];
} foreach _positions;

sleep 5;

// setup weapon holders that will hold the money
private _holders = [];
for "_i" from 1 to 1000 do {
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
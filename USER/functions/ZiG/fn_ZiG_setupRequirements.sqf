if (!isServer) exitWith { _this remoteExecCall [_fnc_scriptName, 2]; };

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
	private _marker = call compile format ["GRAD_grandPrix_ZiG_millettia_%1",_i]; 
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

[{
	private _moneyTargetAmount = 1000;
	private _spawnHandle = 
	[
		{
			params ["_targetAmount", "_handle"];

			private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
			if ((count _holders) >= _targetAmount) exitWith {
				[_handle] call CBA_fnc_removePerFrameHandler;
				missionNamespace setVariable ["GRAD_grandPrix_ZiG_weaponHolders", _holders, true];
			};

			private _pos = GRAD_grandPrix_ZiG_moneyArea call BIS_fnc_randomPosTrigger;
			_pos set [2, 0.002];

			private _posASL = AGLToASL _pos;
			private _intersects = lineIntersectsSurfaces [_posASL, _posASL vectorAdd [0, 0, 20], objNull, objNull, true, 1, "VIEW"];
			if (_intersects isNotEqualTo []) exitWith {};

			private _holder = "groundweaponHolder_scripted" createVehicle _pos;
			_holder setPos _pos;
			_holder setDir (random 360);

			_holder addMagazineCargoGlobal  ["photo9", 1];
			_holder hideObjectGlobal true;

			_holders pushBack _holder;

			missionNamespace setVariable ["GRAD_grandPrix_ZiG_weaponHolders", _holders];
		},
		30 / _moneyTargetAmount,
		_moneyTargetAmount
	] call CBA_fnc_addPerFrameHandler;
}, [], 5] call CBA_fnc_waitAndExecute;
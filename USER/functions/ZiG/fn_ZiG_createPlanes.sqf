private _plane = createVehicle ["gm_ge_airforce_do28d2", [random 1000, random 1000, 100 + (random 1000)], [], 0, "FLY"];
private _crew = createVehicleCrew _plane;
private _plane2 = createVehicle ["gm_ge_airforce_do28d2", [random 1000, random 1000, 100 + (random 1000)], [], 0, "FLY"];
private _crew2 = createVehicleCrew _plane2;
private _plane3 = createVehicle ["gm_ge_airforce_do28d2", [random 1000, random 1000, 100 + (random 1000)], [], 0, "FLY"];
private _crew3 = createVehicleCrew _plane3;
_plane action ["flapsDown", _plane];
_plane2 action ["flapsDown", _plane2];
_plane3 action ["flapsDown", _plane3];
[
	{
		params ["_plane", "_plane2", "_plane3"];
		_plane action ["flapsDown", _plane];
		_plane2 action ["flapsDown", _plane2];
		_plane3 action ["flapsDown", _plane3];
	},
	[_plane, _plane2, _plane3],
	2
] call CBA_fnc_waitAndExecute;




private _drones = [];
for "_i" from 1 to 6 do {
	private _drone = createVehicle ["B_UAV_06_F", [random 1000, random 1000, 100 + (random 1000)], [], 0, "FLY"];
	createVehicleCrew _drone;
	_drones pushBack _drone;
};

(_drones#0) attachTo [_plane, [-0.254028,-1.53064,-1.69751]];
(_drones#1) attachTo [_plane, [0.254028,-1.53064,-1.69751]];
(_drones#2) attachTo [_plane2, [-0.254028,-1.53064,-1.69751]];
(_drones#3) attachTo [_plane2, [0.254028,-1.53064,-1.69751]];
(_drones#4) attachTo [_plane3, [-0.254028,-1.53064,-1.69751]];
(_drones#5) attachTo [_plane3, [0.254028,-1.53064,-1.69751]];
{
	_x addMagazine "1Rnd_Leaflets_West_F";
	_x addWeapon "Bomb_Leaflets";
	hideObjectGlobal _x;
	_x setDir 0;
} forEach _drones;


[[_plane, _plane2, _plane3], _drones]
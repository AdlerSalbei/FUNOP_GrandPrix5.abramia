params ["_group"];

waitUntil { player inArea GRAD_grandPrix_race_switchToPlane };

private _playerPos = getPos player;
// private _playerDir = getDir player;
private _velY = (velocityModelSpace player) # 1;
deleteVehicle (vehicle player);

private _spawnPos = [random 1000, random 1000, (random 1000) + 200];
private _plane = "C_Plane_Civil_01_racing_F" createVehicle _spawnPos;
_plane engineOn true;
_plane setDir (_playerPos getDir (getPos GRAD_grandPrix_race_planeTarget_1));

_plane setPos _playerPos;
player moveInDriver _plane;
_plane setVelocityModelSpace [0, _velY max 75, 0];
_plane allowDamage false;

private _allGates = [];
private _gateMarkerStart = 1; 
private _gateMarkerEnd = 19;
for "_i" from _gateMarkerStart to _gateMarkerEnd do
{   
	private _gate = call(compile format ["GRAD_grandPrix_race_planeTarget_%1",_i]);
	_allGates pushBack _gate;
};

{
	_x hideObject false;
} forEach _allGates;

private _handle = 
[
	{
		_args params ["_plane"];

		private _pos = getPosASL _plane;
		if ((_pos # 2) > 2) exitWith {};
		private _vel = velocityModelSpace _plane;
		_plane setVelocityModelSpace [_vel # 0, _vel # 2, 10];
	},
	0,
	[_plane]
] call CBA_fnc_addPerFrameHandler;

{

	player setVariable ["GRAD_grandPrix_race_currentPlaneTarget", _x];
	private _trigger = createTrigger ["EmptyDetector", _x, false];
	_trigger setTriggerArea [18, 20, getDir _x, true, 18];
	_trigger setPosASL (getPosASL _x);
	_trigger setTriggerActivation ["VEHICLE", "PRESENT", false];
	_trigger triggerAttachVehicle [_plane];
	_trigger setTriggerStatements ["this", "", ""];
	_trigger setTriggerInterval 0;
	_x hideObjectGlobal false;
	private _id =
	addMissionEventHandler ["Draw3D", {
		drawIcon3D [
			"\a3\ui_f\data\IGUI\Cfg\Radar\targeting_ca.paa",
			[0.9,0.9,0,1],
			getPos (player getVariable "GRAD_grandPrix_race_currentPlaneTarget"),
			0.5,
			0.5,
			getDir (player getVariable "GRAD_grandPrix_race_currentPlaneTarget")
		];
	}];	
	waitUntil { triggerActivated _trigger || !(alive _plane) };
	removeMissionEventHandler ["Draw3D", _id];
	if !(alive _plane) exitWith { deleteVehicle _trigger; };
	hideObject _x;
	
} forEach _allGates;

[_handle] call CBA_fnc_removePerFrameHandler;

[_group] call GRAD_grandPrix_fnc_race_handleJetskiPartLocal;
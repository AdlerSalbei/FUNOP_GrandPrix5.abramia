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

player setVariable ["GRAD_grandPrix_race_plane", _plane];

private _allGates = [];
private _gateMarkerStart = 1; 
private _gateMarkerEnd = 19;
for "_i" from _gateMarkerStart to _gateMarkerEnd do
{   
	private _gate = call(compile format ["GRAD_grandPrix_race_planeTarget_%1",_i]);
	_allGates pushBack _gate;
};

missionNamespace setVariable ["GRAD_grandPrix_race_allGates", _allGates];

private _handle = 
[
	{
		_args params ["_plane"];

		private _posASL = getPosASL _plane;
		private _posAGL = ASLToAGL _posASL;
		if (((_posASL # 2) > 2) && ((_posAGL # 2) > 3) && !(isTouchingGround _plane)) exitWith {};
		private _speed = (velocityModelSpace _plane) # 1;
		_posASL set [2, (_posASL#2) + 100];
		_plane setPosASL _posASL;
		_plane setVelocityModelSpace [0, _speed, 0];
		_plane setDamage 0;
	},
	0,
	[_plane]
] call CBA_fnc_addPerFrameHandler;

//Set up all 3 gates 
[0, true, "GRAD_GrandPrix_planeGate01"] call GRAD_grandPrix_fnc_race_showGate;
[1, false, "GRAD_GrandPrix_planeGate02"] call GRAD_grandPrix_fnc_race_showGate;
[2, false, "GRAD_GrandPrix_planeGate03"] call GRAD_grandPrix_fnc_race_showGate;

//Add 3D marker for Gates
[] call GRAD_grandPrix_fnc_race_add3DMarker;

// adjust viewDistance
private _previousViewDistance = ace_viewdistance_viewDistanceAirVehicle;
if (_previousViewDistance < 3000) then {
	ace_viewdistance_viewDistanceAirVehicle = 3000;
	[false] call ace_viewdistance_fnc_adaptViewDistance;
};

[{
	params ["_allGates"];

	private _count = count _allGates;

	(_count -2) <= (player getVariable "GRAD_grandPrix_race_currentPlaneTarget") &&
	{isNull ((_allGates select (_count -1)) getVariable "grad_grandprix_race_triggerGate")}
}, {
	params ["", "_handle", "_group", "_previousViewDistance"];

	private _IDs = missionNamespace getVariable "grad_grandPrix_planGate3DMarker_ID";
	{
		removeMissionEventHandler ["Draw3D", _x];
	}forEach _IDs;

	private _allGate = missionNamespace getVariable "GRAD_grandPrix_race_allGates";
	{
		_x hideObject true;
	} forEach _allGates;

	ace_viewdistance_viewDistanceAirVehicle = _previousViewDistance;
	[false] call ace_viewdistance_fnc_adaptViewDistance;

	[_handle] call CBA_fnc_removePerFrameHandler;
	missionNamespace setVariable ["GRAD_grandPrix_race_localPlanePartDone", true];
	[_group] spawn GRAD_grandPrix_fnc_race_handleJetskiPartLocal;
}, [_allGates, _handle, _group, _previousViewDistance]] call CBA_fnc_waitUntilAndExecute;

// Play plane music
missionNamespace setVariable ["GRAD_grandPrix_race_localPlanePartDone", false];
[[["NFS_soundtrack_3", 0, 1109]], "GRAD_grandPrix_race_localPlanePartDone"] spawn grad_grandprix_fnc_common_runPlaylist;

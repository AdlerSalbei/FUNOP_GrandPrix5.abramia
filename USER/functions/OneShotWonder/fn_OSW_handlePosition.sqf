if !(hasInterface) exitWith {};

params ["_position"];

private _positionInfo = _position getVariable ["GRAD_grandPrix_OSW_info", []];
// _door -> piece of stand that opens
// _target -> target the player has to shoot at
_positionInfo params ["_door", "_target", "_trigger"];

// show position
diag_log format ["[fn_OSW_handlePosition]: revealing position %1", vehicleVarName _position];
private _objects = (allMissionObjects "") select {_x inArea _trigger};
{
	[_x, false] remoteExecCall ["hideObjectGlobal", 2];
} foreach (_objects + [_target]);

// set pre-positon requirements
missionNamespace setVariable ["GRAD_grandPrix_OSW_currentCompleted_" + getPlayerUID player, false, true];
_position setVariable ["GRAD_grandPrix_OSW_currentlyActive", true, true];
missionNamespace setVariable ["GRAD_grandPrix_OSW_currentPos_" + getPlayerUID player, _position, true];

// create door locally for smoother movement
diag_log "[fn_OSW_handlePosition]: creating local door";
private _localDoor = (typeOf _door) createVehicleLocal (getPos _door);
_localDoor setVectorDirAndUp [vectorDir _door, vectorUp _door];
_localDoor setPosASL (getPosASL _door);
diag_log "[fn_OSW_handlePosition]: hiding global door, in global scope";
[_door, true] remoteExecCall ["hideObjectGlobal", _door];
diag_log "[fn_OSW_handlePosition]: disabling simulation of global door, in local scope";
_door enableSimulation false;

// add target Hit-EH
private _hitHandler = _target addEventHandler ["HitPart", { 
	(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];

	if ((_shooter isNotEqualTo player) || !_isDirect) exitWith {};
	_target setVariable ["GRAD_grandPrix_OSW_hit", true];
}];

private _firedHandler = 
[
	player,
	"fired",
	{
		_thisArgs params ["_target"];
		player setVariable ["GRAD_grandPrix_OSW_timeFired", time];
		player removeEventHandler ["fired", _thisID];

		[
			{
				params ["_target"];
				private _alreadyHit = _target getVariable ["GRAD_grandPrix_OSW_hit", ""];
				if (_alreadyHit isEqualTo "") then {
					_target setVariable ["GRAD_grandPrix_OSW_hit", false];
				};
			},
			[_target],
			0.5
		] call CBA_fnc_waitAndExecute;
	},
	[_target]
] call CBA_fnc_addBISEventHandler;

// handle actual position
private _posPos = getPosASL _position;
_posPos set [2, (_posPos # 2) + 0.698];
private _angleToDoor = _position getDir _door;
private _previousAngleToDoor = player getVariable ["GRAD_grandPrix_OSW_anglePreviousPosition", _angleToDoor];
private _offset = (((getDir player) - _previousAngleToDoor) + 180) mod 360 - 180;
private _newAngle = _angleToDoor + _offset;
private _visited = missionNamespace getVariable ["GRAD_grandPrix_OSW_visited_" + getPlayerUID player, []];
if (_visited isEqualTo []) then {
	_newAngle = _angleToDoor;
};
player setPosASL _posPos;
player setDir _newAngle;
hintSilent "";

sleep 1;

// open shit
private _initialDoorPos = getPosASL _localDoor;
diag_log "[fn_OSW_handlePosition]: opening local door...";
private _openHandler = 
[
	{
		_args params ["_door", "_targetPos"];
		
		_pos = getPosASL _door;
		if (_pos#2 > _targetPos#2) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };
		_door setPosASL [_targetPos#0, _targetPos#1, (_pos#2) + 0.05];
	},
	0,
	[_localDoor, [_initialDoorPos#0, _initialDoorPos#1, (_initialDoorPos#2) + 0.8]]
] call CBA_fnc_addPerFrameHandler;

// add Gun magazine
private _loadout = getUnitLoadout player;
_loadout set [0,[]];
_loadout set [1,[]];
_loadout set [2,["GrandPrix_hgun_Pistol_heavy_02_F","","","",["1Rnd_45ACP_Cylinder",1],[],""]];
player setUnitLoadout _loadout;

// time shit?
private _start = [time, servertime] select isMultiplayer;;

// evaluate result
waitUntil { (_target getVariable ["GRAD_grandPrix_OSW_hit", ""]) isNotEqualTo "" };

private _hit = _target getVariable ["GRAD_grandPrix_OSW_hit", ""];
_target setVariable ["GRAD_grandPrix_OSW_hit", ""];
private _timeTaken = ([time, servertime] select isMultiplayer) - _start;
if (_hit) then {
	hintSilent "Treffer!";
} else {
	hintSilent "Verfehlt!";
	_timeTaken = _timeTaken + 10;
};
// systemChat str _timeTaken;
private _totalPlayerTime = missionNamespace getVariable ["GRAD_grandPrix_OSW_totalTime_" + getPlayerUID player, 0];
_totalPlayerTime = _totalPlayerTime + _timeTaken;
missionNamespace setVariable ["GRAD_grandPrix_OSW_totalTime_" + getPlayerUID player, _totalPlayerTime, true];
// close shit
sleep 0.5;
diag_log "[fn_OSW_handlePosition]: closing local door...";
private _closeHandler = 
[
	{
		_args params ["_localDoor", "_targetPos"];
		
		_pos = getPosASL _localDoor;
		if (_pos#2 <= _targetPos#2) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };
		_localDoor setPosASL [_targetPos#0, _targetPos#1, (_pos#2) - 0.05];
	},
	0,
	[_localDoor, [_initialDoorPos#0, _initialDoorPos#1, _initialDoorPos#2]]
] call CBA_fnc_addPerFrameHandler;

// wait for the door to close
waitUntil { ((getPosASL _localDoor) # 2) <= (_initialDoorPos # 2) };
sleep 0.5;
// clean up
_target removeAllEventHandlers "hit";
player removeAllEventHandlers "fired";
player setVariable ["GRAD_grandPrix_OSW_anglePreviousPosition", _angleToDoor];

_visited pushBackUnique _position;
missionNamespace setVariable ["GRAD_grandPrix_OSW_visited_" + getPlayerUID player, _visited, true];
missionNamespace setVariable ["GRAD_grandPrix_OSW_currentCompleted_" + getPlayerUID player, true, true];

// wait for player to be teleported away
waitUntil { !(player inArea [_position, 1.5, 1.5, getDir _position, true, 2.5]) };
deleteVehicle _localDoor;
private _timesVisited = _position getVariable ["GRAD_grandPrix_timesVisited", 0];
_timesVisited = _timesVisited + 1;
_position setVariable ["GRAD_grandPrix_timesVisited", _timesVisited, true];

// hide position
{
	[_x, true] remoteExecCall ["hideObjectGlobal", 2];
} foreach _objects;

_position setVariable ["GRAD_grandPrix_OSW_currentlyActive", false, true];

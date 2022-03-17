params ["_position"];

private _positionInfo = _position getVariable ["GRAD_grandPrix_OSW_info", []];
// _door -> piece of stand that opens
// _target -> target the player has to shoot at
_positionInfo params ["_door", "_target", "_trigger"];

// show position
private _objects = (allMissionObjects "") select {_x inArea _trigger};
{
	[_x, false] remoteExecCall ["hideObjectGlobal", 2];
} foreach (_objects + [_target]);

// set pre-positon requirements
player setVariable ["GRAD_grandPrix_OSW_currentCompleted", false, true];
_position setVariable ["GRAD_grandPrix_OSW_currentlyActive", true, true];

// create door locally for smoother movement
private _localDoor = (typeOf _door) createVehicleLocal (getPos _door);
_localDoor setVectorDirAndUp [vectorDir _door, vectorUp _door];
_localDoor setPosASL (getPosASL _door);
hideObject _door;
_door enableSimulation false;

// add target Hit-EH
_target setVariable ["GRAD_grandPrix_OSW_hit", ""];
private _hitHandler = _target addEventHandler ["hit", { 
	params ["_unit", "_source", "_damage", "_instigator"];
	if (_instigator isNotEqualTo player) exitWith {};
	_unit setVariable ["GRAD_grandPrix_OSW_hit", true];
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
player setPosASL (getPosASL _position);
player setDir (getDir _position);
hintSilent "";

sleep 1;

// open shit
private _initialDoorPos = getPosASL _localDoor;
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
player addMagazine "1Rnd_45ACP_Cylinder"; 
player addWeapon "GrandPrix_hgun_Pistol_heavy_02_F";

// time shit?
private _start = time;

// evaluate result
waitUntil { (_target getVariable ["GRAD_grandPrix_OSW_hit", ""]) isNotEqualTo "" };

private _hit = _target getVariable ["GRAD_grandPrix_OSW_hit", ""];
private _timeTaken = time - _start;
if (_hit) then {
	hintSilent "Treffer!";
} else {
	hintSilent "Verfehlt!";
	_timeTaken = _timeTaken + 20;
};
systemChat str _timeTaken;
private _totalPlayerTime = player getVariable ["GRAD_grandPrix_OSW_totalTime", 0];
_totalPlayerTime = _totalPlayerTime + _timeTaken;
player setVariable ["GRAD_grandPrix_OSW_totalTime", _totalPlayerTime, true];

// close shit
sleep 0.5;
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
private _visited = player getVariable ["GRAD_grandPrix_OSW_visited", []];
_visited pushBackUnique _position;
player setVariable ["GRAD_grandPrix_OSW_visited", _visited, true];
player setVariable ["GRAD_grandPrix_OSW_currentCompleted", true, true];

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




// [
// 	{
// 		params ["_target", "_localDoor", "_initialDoorPos"];
// 		(_target getVariable ["GRAD_grandPrix_OSW_hit", ""]) isNotEqualTo ""
// 	},
// 	{
// 		params ["_target", "_localDoor", "_initialDoorPos"];
// 		private _hit = _target getVariable ["GRAD_grandPrix_OSW_hit", ""];
// 		private _timeTaken = time - (player getVariable ["GRAD_grandPrix_OSW_timeFired", time - 5]);
// 		if (_hit) then {
// 			hintSilent "Treffer!";
// 		} else {
// 			hintSilent "Verfehlt!";
// 			_timeTaken = _timeTaken + 20;
// 		};

// 		// close shit
// 		private _openHandler = 
// 		[
// 			{
// 				_args params ["_localDoor", "_targetPos"];
				
// 				_pos = getPosASL _localDoor;
// 				if (_pos#2 <= _targetPos#2) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };
// 				_localDoor setPosASL [_targetPos#0, _targetPos#1, (_pos#2) - 0.05];
// 			},
// 			0,
// 			[_localDoor, [_initialDoorPos#0, _initialDoorPos#1, _initialDoorPos#2]]
// 		] call CBA_fnc_addPerFrameHandler;		
// 	},
// 	[_target, _localDoor, _initialDoorPos]
// ] call CBA_fnc_waitUntilAndExecute;
if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

params ["_station", "_group"];


_station setVariable ["stationIsRunning", true, true];

// find nearest instructor to notify them throughout the stage
private _allInstructors = allCurators apply { getAssignedCuratorUnit _x };
private _nearestInstructor = objNull;
private _distance = _station distance (_allInstructors#0);
{
	if ((_station distance _x) < _distance) then {
		_distance = _station distance _x;
		_nearestInstructor = _x;
	}	
} forEach _allInstructors;


// setup local doors
[] remoteExecCall ["GRAD_grandPrix_fnc_rlgl_handleGunDoor", (units _group) + [_nearestInstructor]];


// teleport players, enable pip and finish-handler
{
	private _pos = GRAD_grandPrix_rlgl_start call BIS_fnc_randomPosTrigger;
	_pos set [2,0];
	_x setPos _pos;
	[] remoteExec ["GRAD_grandPrix_fnc_rlgl_handlePIP", _x];
	[] remoteExecCall ["GRAD_grandPrix_fnc_rlgl_handleFinishLocal", _x];
	// disable player damage, just to be safe
	[_x, false] remoteExec ["allowDamage", _x];
} forEach (units _group);
[] remoteExec ["GRAD_grandPrix_fnc_rlgl_handlePIP", _nearestInstructor];

// To-Do: countdown
sleep 3;

// stage-loop
private _activePlayers = (units _group) select { !(_x inArea GRAD_grandPrix_rlgl_finish) };
systemChat "go!";
private _start =  [time, serverTime] select isMultiplayer;
while { (count _activePlayers) > 0 } do {	
	systemChat "toggle green";
	["GRAD_rlgl_toggleGreen", [], (units _group) + [_nearestInstructor]] call CBA_fnc_targetEvent;

	// active for 5 to 15 seconds
	sleep (5 + (random 10));

	_activePlayers = (units _group) select { !(_x inArea GRAD_grandPrix_rlgl_finish) && !(_x getVariable ["GRAD_grandPrix_rlgl_reachedFinish", false]) };
	if ((count _activePlayers) == 0) exitWith {};

	systemChat "toggle red";
	["GRAD_rlgl_toggleRed", [], (units _group) + [_nearestInstructor]] call CBA_fnc_targetEvent;

	sleep 0.5;
	[] remoteExecCall ["GRAD_grandPrix_fnc_rlgl_holdInPlace", _activePlayers];

	// open Door
	["GRAD_rlgl_openDoor", [], (units _group) + [_nearestInstructor]] call CBA_fnc_targetEvent;

	sleep 3;

	private _visiblePlayers = _activePlayers select { [GRAD_grandPrix_rlgl_gun, _x] call GRAD_grandPrix_fnc_rlgl_isVisible };
	if ((count _visiblePlayers) > 0) then {
		private _target = selectRandom _visiblePlayers;

		[_target, true] remoteExecCall ["allowDamage", _target];

		[GRAD_grandPrix_rlgl_gun, _target] call GRAD_grandPrix_fnc_rlgl_fire;
		waitUntil { _target getVariable ["ACE_isUnconscious", false] };
		
		sleep 5;

		[_target] remoteExecCall ["ace_medical_treatment_fnc_fullHealLocal", _target];
		[_target, false] remoteExecCall ["allowDamage", _target];
		private _pos = GRAD_grandPrix_rlgl_start call BIS_fnc_randomPosTrigger;
		_pos set [2,0];
		_target setPos _pos;

		sleep 2;

		[] remoteExecCall ["GRAD_grandPrix_fnc_rlgl_holdInPlace", _target];

		sleep 3;
	};

	// close Door
	["GRAD_rlgl_closeDoor", [], (units _group) + [_nearestInstructor]] call CBA_fnc_targetEvent;

	// systemChat "iteration completed; Starting again in 5 seconds";
	sleep 3;
};

private _stop =  [time, serverTime] select isMultiplayer;
private _timeTaken = _stop - _start;
// private _points = [_group, _timeTaken, 470, 1000, "Red Light - Green Light"] call GRAD_grandPrix_fnc_addTime;

// close pip and color-bar
["GRAD_rlgl_endPIP", [], (units _group) + [_nearestInstructor]] call CBA_fnc_targetEvent;
// delete door and corresponding handlers
["GRAD_rlgl_endDoor", [], (units _group) + [_nearestInstructor]] call CBA_fnc_targetEvent;


// To-Do: teleport players back


[format["Ihr hab %1 gebraucht. Damit habt ihr euch %2 Punkte erspielt!", [_timeTaken, "MM:SS.MS"] call BIS_fnc_secondsToString], _points] remoteExec ["hint", (units _group) + [_nearestInstructor]];

_station setVariable ["stationIsRunning", false, true];
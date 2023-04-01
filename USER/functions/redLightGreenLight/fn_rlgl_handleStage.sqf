if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

params ["_station", "_group"];


_station setVariable ["stationIsRunning", true, true];
_group setVariable ["GRAD_GrandPrix_currentStage", "rlgl", true];

// find nearest instructor to notify them throughout the stage
private _nearestInstructor = [_station] call grad_grandprix_fnc_common_getNearestZeus;

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
// [] remoteExec ["GRAD_grandPrix_fnc_rlgl_handlePIP", _nearestInstructor];

// countdown
["grad_grandPrix_race_triggerCountdown", [], units _group] call CBA_fnc_targetEvent;
sleep 3;

// stage-loop
private _activePlayers = (units _group) select { !(_x inArea GRAD_grandPrix_rlgl_finish) };
private _start =  [time, serverTime] select isMultiplayer;
// use pre-determined sleep-times for fairness
private _index = 0;
private _sleepTimes = missionNamespace getVariable ["GRAD_grandPrix_rlgl_sleepTimes", []];
while { (count _activePlayers) > 0 } do {	
	["GRAD_rlgl_toggleGreen", [], (units _group) + [_nearestInstructor]] call CBA_fnc_targetEvent;

	// active for 6 to 15 seconds
	sleep (_sleepTimes # _index);
	_index = _index + 1;

	_activePlayers = (units _group) select { !(_x inArea GRAD_grandPrix_rlgl_finish) && !(_x getVariable ["GRAD_grandPrix_rlgl_reachedFinish", false]) };
	if ((count _activePlayers) == 0) exitWith {};

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

		[GRAD_grandPrix_rlgl_gun, _target, _nearestInstructor] call GRAD_grandPrix_fnc_rlgl_fire;
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
	
	sleep 3;
};

private _stop =  [time, serverTime] select isMultiplayer;
private _timeTaken = _stop - _start;
private _points = [_group, _timeTaken, 500, 1000, "Red Light - Green Light"] call GRAD_grandPrix_fnc_addTime;

// close pip and color-bar
["GRAD_rlgl_endPIP", [], (units _group) + [_nearestInstructor]] call CBA_fnc_targetEvent;
// delete door and corresponding handlers
["GRAD_rlgl_endDoor", [], (units _group) + [_nearestInstructor]] call CBA_fnc_targetEvent;

sleep 2;

private _playerTimes = [];
{
	// Handle time
	private _playerTime = _x getVariable ["GRAD_grandPrix_rlgl_timeTaken", 0];
	_playerTimes pushBack [name _x, _playerTime];

	// teleport players back
	private _pos = GRAD_grandPrix_rlgl_backPort call BIS_fnc_randomPosTrigger;
	_pos set [2,0];
	_x setPos _pos;
	[_x, false] remoteExec ["setCaptive", _x];
	[_x] remoteExecCall ["removeAllWeapons", _x];
} forEach (units _group);

[] remoteExec ["hint", (units _group) + [_nearestInstructor]];

private _msg = format ["Ihr habt %1 gebraucht. Damit habt ihr euch %2 Punkte erspielt!", [_timeTaken, "MM:SS"] call BIS_fnc_secondsToString, _points];
_msg = _msg + "<br /> <br /><t align='left'>Spieler Zeit:</t>"; 

{ 
	_msg = _msg + format ["<br /> <t align='center'>%1:</t> <t align='right'>%2</t>", _x select 0, [_x select 1, "MM:SS"] call BIS_fnc_secondsToString]; 
}forEach _playerTimes; 

[parseText _msg] remoteExec ["hint", (units _group) + [_nearestInstructor]];

[{player setVariable ["GRAD_grandPrix_rlgl_reachedFinish", false, true]}] remoteExec ["call", units _group];

_group setVariable ["GRAD_GrandPrix_currentStage", "", true];
_station setVariable ["stationIsRunning", false, true];
_station setVariable ["GRAD_grandPrix_rlgl_introDone", false, true];

[] remoteExec ["grad_grandPrix_fnc_common_setRadioFrequencies", _group];

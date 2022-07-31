#define BEST_TIME 350

if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

params ["_station", "_group"];

_station setVariable ["stationIsRunning", true, true];
missionNamespace setVariable ["GRAD_grandPrix_PUPS_currentGroup", _group, true];
_group setVariable ["GRAD_GrandPrix_currentStage", "PUPS", true];

{
	[
		{
			player addMagazine "1000Rnd_408_Mag"; 
			player addWeapon "GrandPrix_srifle_LRR_F";
			player addPrimaryWeaponItem "optic_lrps";

			player addMagazine "1000Rnd_9x21_Mag";
			player addWeapon "GrandPrix_hgun_P07_F";

			player addWeapon "ACE_Vector";
			// _x addItem "ACE_ATragMX";
			player addItem "ACE_RangeCard";	
			player addVest "V_RebreatherIA";		
		}
	] remoteExec ["call", _x];
} forEach (units _group);

[] remoteExec ["GRAD_grandPrix_fnc_PUPS_handleStationLocal", _group];

private _stageComplete = false;
while {!_stageComplete} do {
	
	private _players = units _group;
	private _done = _players select { _x getVariable ["GRAD_grandPrix_PUPS_stationFinished", false]; };
	if ((count _players) isEqualTo (count _done)) then {
		_stageComplete = true;
	};

	sleep 5;
};

sleep 6;

private _totalTimeTaken = 0;
private _playerTimes = [];
{
	// Handle time
	private _playerTime = _x getVariable ["GRAD_grandPrix_PUPS_timeTaken", 0];
	_totalTimeTaken = _totalTimeTaken + _playerTime;
	_playerTimes pushBack [name _x, _playerTime];

	//Clear inventory
	[{ removeAllWeapons player; }] remoteExec ["call", _x];
	_x removeItem "ACE_RangeCard";
	removeVest _x;
} forEach (units _group);

private _averageTimeTaken = _totalTimeTaken / (count (units _group));
private _points = [_group, _averageTimeTaken, BEST_TIME, 1000, "P.U.P.S"] call grad_grandPrix_fnc_addTime;

private _nearestInstructor = [_station] call grad_grandprix_fnc_common_getNearestZeus;

private _msg = format ["Ihr habt durchschnittlich %1 benötigt.\nDamit habt ihr euch %2 Punkte erspielt!", [_averageTimeTaken, "MM:SS"] call BIS_fnc_secondsToString, _points];
_msg = _msg + "<br /> <br /><t align='left'>Spieler Zeit:</t>"; 

{ 
	_msg = _msg + format ["<br /> <t align='center'>%1:</t> <t align='right'>%2</t>", _x select 0, [_x select 1, "MM:SS"] call BIS_fnc_secondsToString]; 
}forEach _playerTimes; 

[parseText _msg] remoteExec ["hint", (units _group) + [_nearestInstructor]];

_group setVariable ["GRAD_GrandPrix_currentStage", "", true];
_station setVariable ["stationIsRunning", false, true];
missionNamespace setVariable ["GRAD_grandPrix_PUPS_currentGroup", grpNull, true];
#define BEST_TIME 350

if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

params ["_station", "_group"];

_station setVariable ["stationIsRunning", true, true];

{
	[
		{
			player addMagazine "1000Rnd_408_Mag"; 
			player addWeapon "GrandPrix_srifle_LRR_F";
			player addPrimaryWeaponItem "optic_lrps";
			player addWeapon "ACE_Vector";
			// _x addItem "ACE_ATragMX";
			player addItem "ACE_RangeCard";			
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
{
	_totalTimeTaken = _totalTimeTaken + (_x getVariable ["GRASD_grandPrix_PUPS_timeTaken", 0]);
	[{ removeAllWeapons player; }] remoteExec ["call", _x];
	_x removeItem "ACE_RangeCard";
} forEach (units _group);

private _averageTimeTaken = [_totalTimeTaken / (count (units _group)), "MM:SS"] call BIS_fnc_secondsToString;

private _nearestInstructor = [_station] call grad_grandprix_fnc_common_getNearestZeus;

private _result = format ["Ihr habt durchschnittlich %1 benötigt.\nDamit habt ihr euch %2 Punkte erspielt!", _averageTimeTaken, [_group, _averageTimeTaken, BEST_TIME, 1000, "P.U.P.S"] call grad_grandPrix_fnc_addTime];
[_result] remoteExec ["hint", (units _group) + [_nearestInstructor]];

_station setVariable ["stationIsRunning", false, true];
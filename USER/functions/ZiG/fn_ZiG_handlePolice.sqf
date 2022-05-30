params ["_group"];

missionNamespace setVariable ["GRAD_grandPrix_ZiG_aiSpawned", [], true];
private _spawns = [];
private _spawnMarkerStart = 1; 
private _spawnMarkerEnd = 8; 
diag_log "[fn_ZiG_handlePolice]: registering spawn positions...";
for "_i" from _spawnMarkerStart to _spawnMarkerEnd do
{   
	private _spawn = call(compile format ["grad_grandPrix_fnc_ZiG_policeSpawn_%1",_i]);
	_spawns pushBack _spawn;
};

_ZiG_fnc_canBeSeen = {
	params ["_pos", "_group"];

	_pos = AGLToASL _pos;
	_pos set [2, (_pos#2) + 1.7];

	private _canBeSeen = (units _group) findIf { !(lineIntersects [_pos, eyePos _x, _x]) } > -1;
	_canBeSeen
};

private _aiSpawned = [];
private _aiGoal = (count (units _group)) * 4;
private _skill = 0.1;
private _sleep = 450;

[
	{
		!(missionNameSpace getVariable ["GRAD_grandPrix_ZiG_collectingActive", true])
	},
	{
		diag_log "[fn_ZiG_handlePolice]: registered end of collection-perdiod; Deleting remaining police...";
		private _ai = missionNamespace getVariable ["GRAD_grandPrix_ZiG_aiSpawned", []];
		{
			deleteVehicle _x;			
		} forEach _ai;
	},
	[]
] call CBA_fnc_waitUntilAndExecute;

diag_log "[fn_ZiG_handlePolice]: Starting police spawn loop";
while { missionNameSpace getVariable ["GRAD_grandPrix_ZiG_collectingActive", true] } do {
	private _aiActive = count (_aiSpawned select { alive _x });
	for [{_i = _aiActive}, {_i < _aiGoal}, {_i = _i + 1}] do {
		private _spawn = selectRandom _spawns;
		private _pos = _spawn call BIS_fnc_randomPosTrigger;
		if ([_pos, _group] call _ZiG_fnc_canBeSeen) then {
			_i = _i - 1;
			continue
		};

		private _aiGroup = createGroup west;
		private _unit = _aiGroup createUnit ["B_GEN_Soldier_F", _pos, [], 0, "NONE"];
		systemChat "unit created!";
		_unit setSkill _skill;
		_aiSpawned pushBack _unit;
		[_unit, 800] spawn lambs_wp_fnc_taskRush;
		diag_log format ["[fn_ZiG_handlePolice]: Created unit %1 in group %2.", _unit, _group];
	};
	missionNamespace setVariable ["GRAD_grandPrix_ZiG_aiSpawned", _aiSpawned, true];
	if !(missionNameSpace getVariable ["GRAD_grandPrix_ZiG_collectingActive", true]) exitWith {
		diag_log "[fn_ZiG_handlePolice]: exiting spawn loop: Collecting no longer active";
	};

	_aiGoal = _aiGoal + (count (units _group));
	_skill = (_skill + 0.05) min 1;
	_sleep = (_sleep - 60) max 15;
	diag_log format ["[fn_ZiG_handlePolice]: creation iteration complete; Sleeping for %1 seconds...", _sleep];
	sleep _sleep;
};

{
	deleteVehicle _x;	
} forEach _aiSpawned;
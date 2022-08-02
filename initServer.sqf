["Initialize"] call BIS_fnc_dynamicGroups;

missionNamespace setVariable ["GRAD_GrandPrix_allContestantGroups", [GRAD_grandPrix_team_Einstein, GRAD_grandPrix_team_Hawking, GRAD_grandPrix_team_Newton, GRAD_grandPrix_team_Curie, GRAD_grandPrix_team_Lovelace], true];
missionNamespace setVariable ["GRAD_GrandPrix_allContestantGroupNames", ["Team Einstein", "Team Hawking", "Team Newton", "Team Curie", "Team Lovelace"], true];


// DC-Handle that takes care of all stages individually
private _disconnectHandler = 
addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];

	private _group = group _unit;
	private _currentStage = _group getVariable ["GRAD_GrandPrix_currentStage", ""];
	// the variable name that will be saved to the missionNamespace, in order to be handled on recconect
	private _varString = "GRAD_GrandPrix_" + _uid;
	// if (_currentStage isEqualTo "") exitWith { false };

	switch (toLower _currentStage) do {
		case "dd": {
			//Safe player position in vehicle
			private _vehicle = vehicle _unit;
			private _vehPos = (crew _vehicle) find _unit;

			missionNamespace setVariable [_varString, ["dd", _vehicle, _vehPos], true];

			//Start disconnect timer 
			if (missionNamespace getVariable ["GRAD_grandPrix_DD_startTime", -1] isNotEqualTo -1) then {
				missionNamespace setVariable ["Grad_grandprix_dd_disconnectTimer_" + _uid, diag_tickTime];
			};
		 };
		case "osw": { };
		case "pups": { };
		case "race": { };
		case "rlgl": { };
		case "zig": {
			private _loadout = getUnitLoadout _unit;			
			missionNamespace setVariable [_varString, ["zig", _loadout, _group], true];

			private _items = itemsWithMagazines _unit;
			private _money = ({ _x isEqualTo "photo9" } count _items) max 0;
			private _disconnects = missionNamespace getVariable ["GRAD_grandPrix_ZIG_disconnects", []];
			_disconnects pushBackUnique [_name, _money];
			missionNamespace setVariable ["GRAD_grandPrix_ZIG_disconnects", _disconnects, true];
		};
		default { false };
	};

	false;
}];

missionNamespace setVariable ["GRAD_GrandPrix_disconnectHandler", _disconnectHandler, true];
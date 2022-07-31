params ["_player", "_didJIP"];

if (didJIP) then {
    [player] remoteExec ["grad_common_fnc_addJipToZeus",2,false];
};

["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups;
grad_template_ratingEH = player addEventHandler ["HandleRating",{0}];

[player] remoteExecCall ["grad_grandprix_fnc_points_registerGroups",2,false];

["grad_grandPrix_race_triggerCountdown", {
    playSound "raceCountdown";
    ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\3.paa'/>",0,0,1,0] spawn BIS_fnc_dynamicText;

    [{

        ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\2.paa'/>",0,0,1,0] spawn BIS_fnc_dynamicText;

        [{

            ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\1.paa'/>",0,0,1,0] spawn BIS_fnc_dynamicText;

            [{
                ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\go.paa'/>",0,0,1,0] spawn BIS_fnc_dynamicText;
            }, [], 1] call CBA_fnc_waitAndExecute;
        }, [], 1] call CBA_fnc_waitAndExecute;
    }, [], 1] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;


// handler to remove dropped leaflets
private _handler = ["Leaflet_05_F", "init",
	{
		params ["_leaflet"];
		deleteVehicle _leaflet;
	}
] call CBA_fnc_addClassEventHandler;
player setVariable ["GRAD_grandPrix_ZiG_leafletHandler", _handler, true];

player allowDamage false;

["TAG_refill_stam", -5] call ace_advanced_fatigue_fnc_addDutyFactor;


// waiting until player properly initialised
// ripped this from the bi-forum
waitUntil { getClientStateNumber >= 10 && count (missionnamespace getvariable ["BIS_fnc_startLoadingScreen_ids",[]]) == 0 };
// waiting 2 seconds longer, just to be safe
sleep 2;

// handles the reconnect, after disconnecting out of an active stage
private _varString = "GRAD_GrandPrix_" + (getPlayerUID player);
private _disconnectVar = missionNamespace getVariable [_varString, []];
if (!didJIP || (_disconnectVar isEqualTo [])) exitWith {};

// the zero index of _disconnectVar has to be the stage-string
switch (toLower (_disconnectVar # 0)) do {
    case "dd": { };
    case "osw": { };
    case "pups": { };
    case "race": { };
    case "rlgl": { };
    case "zig": {
        _disconnectVar params ["_stage", "_loadout", "_group"];

        if (_group isNotEqualTo (group player)) exitWith {};
        // do not reinsert into the stage, if the group is already finished
        private _currentStage = toLower (_group getVariable ["GRAD_GrandPrix_currentStage", ""]);
        if (_currentStage isNotEqualTo _stage) exitWith {};

        player setUnitLoadout _loadout;
        private _teammates = (units _group) select { _x isNotEqualTo player };
        hint "Du wirst zurück zu deinem Team teleportiert; Rechne mit möglichem Feindkontakt!";
        [format["Achtung, %1 wird jetzt zu euch teleportiert!", name _player]] remoteExec ["hint", _teammates];
        sleep 3;

        // handle teleport
        private _theChosenOne = selectRandom _teammates;
        waitUntil { ([_theChosenOne] call grad_grandprix_fnc_common_safePosAvailable) # 0 };
        private _pos = ([_theChosenOne] call grad_grandprix_fnc_common_safePosAvailable) # 1;
        player setPos _pos;
    };
    default {  };
};
missionNamespace setVariable [_varString, [], true];

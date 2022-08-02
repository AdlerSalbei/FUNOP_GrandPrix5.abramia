params ["_player", "_didJIP"];

if (didJIP) then {
    [player] remoteExec ["grad_common_fnc_addJipToZeus",2,false];
};

//["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups;
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

["GRAD_grandprix_refill_stam", -5] call ace_advanced_fatigue_fnc_addDutyFactor;


// waiting until player properly initialised
// ripped this from the bi-forum
waitUntil { getClientStateNumber >= 10 && count (missionnamespace getvariable ["BIS_fnc_startLoadingScreen_ids",[]]) == 0 };
// waiting 2 seconds longer, just to be safe
sleep 2;

// handles the reconnect, after disconnecting out of an active stage
private _varString = "GRAD_GrandPrix_" + (getPlayerUID player);
private _disconnectVar = missionNamespace getVariable [_varString, []];
if (!didJIP || (_disconnectVar isEqualTo [])) exitWith {};

// do not reinsert into the stage, if the group is already finished
private _currentStage = toLower (_group getVariable ["GRAD_GrandPrix_currentStage", ""]);
private _savedStage = toLower (_disconnectVar select 0);
if (_currentStage isNotEqualTo _savedStage) then {
    _savedStage = "";
};

// the zero index of _disconnectVar has to be the stage-string
switch (_savedStage) do {
    case "dd": { 
        _disconnectVar params ["_stage", "_veh", "_vehPos"];

        if (isNull _veh) exitWith {};

        private _time = missionNamespace getVariable ["Grad_grandprix_dd_disconnectTimer_" + _uid, 0];
        private _disconTime = missionNamespace getVariable ["Grad_grandprix_dd_disconnectTimer", 0];
        missionNamespace setVariable ["Grad_grandprix_dd_disconnectTimer", 0 + (diag_tickTime - _time)];

        switch (_vehPos) do {
            case 0 : {
                private _driver = driver _veh;

                if (!isNil "_driver" && {!isNull _driver}) then {
                    _driver assignAsGunner _veh;
                    _driver moveInGunner _veh;
                };

                player assignAsDriver _veh 
                player moveInDriver _veh
            };
            case 1 : {
                private _driver = gunner _veh;

                if (!isNil "_driver" && {!isNull _driver}) then {
                    _driver assignAsDriver _veh;
                    _driver moveInDriver _veh;
                };

                player assignAsGunner _veh 
                player moveInGunner _veh
            };
            case 2 : {
                private _driver = commander _veh;

                if (!isNil "_driver" && {!isNull _driver}) then {
                    _driver moveInCargo _veh;
                };

                player assignAsCommander _veh 
                player moveInCommander _veh
            };
            default : {
                player moveInCargo _veh
            };
        };

    };
    case "osw": { };
    case "pups": { };
    case "race": { };
    case "rlgl": { };
    case "zig": {
        _disconnectVar params ["_stage", "_loadout", "_group"];

        if (_group isNotEqualTo (group player)) exitWith {};

        player setUnitLoadout _loadout;
        private _teammates = (units _group) select { _x isNotEqualTo player };
        hint "Du wirst zurück zu deinem Team teleportiert; Rechne mit möglichem Feindkontakt!";
        [format["Achtung, %1 wird jetzt zu euch teleportiert!", name _player]] remoteExec ["hint", _teammates];
        sleep 3;

        // handle teleport
        private _theChosenOne = selectRandom _teammates;
        waitUntil { ([_theChosenOne] call grad_grandprix_fnc_common_safePosAvailable) select 0 };
        private _pos = ([_theChosenOne] call grad_grandprix_fnc_common_safePosAvailable) select 1;
        player setPos _pos;
    };
    //Handle player between stages
    default {
        private _units = units group player;
        private _unit = _units select 0;
        if (unit isEqualTo player) then {
            _unit = _units select 1;
        };

        private _vehicle = vehicle _unit;
        if (_vehicle isEqualTo _unit) then {
            _unit moveInCargo _vehicle;
        } else {
            private _pos = ([_unit] call grad_grandprix_fnc_common_safePosAvailable) select 1;
        player setPos _pos;
        };
    };
};

missionNamespace setVariable [_varString, [], true];

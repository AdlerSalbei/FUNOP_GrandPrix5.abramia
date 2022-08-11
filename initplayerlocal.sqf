params ["_player", "_didJIP"];

if (didJIP) then {
    [_player] remoteExec ["grad_common_fnc_addJipToZeus",2,false];
};

//["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups;
grad_template_ratingEH = _player addEventHandler ["HandleRating",{0}];

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
_player setVariable ["GRAD_grandPrix_ZiG_leafletHandler", _handler, true];

_player allowDamage false;

["GRAD_grandprix_refill_stam", -5] call ace_advanced_fatigue_fnc_addDutyFactor;


// waiting until player properly initialised
// ripped this from the bi-forum
waitUntil { getClientStateNumber >= 10 && count (missionnamespace getvariable ["BIS_fnc_startLoadingScreen_ids",[]]) == 0 };
// waiting 2 seconds longer, just to be safe
sleep 2;

// handles the reconnect, after disconnecting out of an active stage
private _varString = "GRAD_GrandPrix_" + (getPlayerUID _player);
private _disconnectVar = missionNamespace getVariable [_varString, []];
if (!didJIP || (_disconnectVar isEqualTo [])) exitWith {};

private _group = group _player;
private _uid = getPlayerUID _player;

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

                _player assignAsDriver _veh; 
                _player moveInDriver _veh;

                cutText ["", "BLACK", 0.1];
            };
            case 1 : {
                private _driver = gunner _veh;

                if (!isNil "_driver" && {!isNull _driver}) then {
                    _driver assignAsDriver _veh;
                    _driver moveInDriver _veh;
                };

                _player assignAsGunner _veh;
                _player moveInGunner _veh;
            };
            case 2 : {
                private _driver = commander _veh;

                if (!isNil "_driver" && {!isNull _driver}) then {
                    _driver moveInCargo _veh;
                };

                _player assignAsCommander _veh; 
                _player moveInCommander _veh;
            };
            default {
                _player moveInCargo _veh;
            };
        };

    };
    case "osw": {
        _disconnectVar params ["_stage", "_group"];

        if (_group isNotEqualTo (group _player)) exitWith {};

        hint "Du wirst zurück in die Station 'OSW' teleportiert; Halte dich bereit!";
        sleep 4;
        private _activePlayers = missionNamespace getVariable ["GRAD_grandPrix_OSW_activePlayers", [[player], []] select isMultiplayer];
        _activePlayers pushBackUnique player;
        missionNamespace setVariable ["GRAD_grandPrix_OSW_activePlayers", _activePlayers, true];
    };
    case "pups": { };
    case "race": { };
    case "rlgl": { 
        _disconnectVar params ["_stage", "_pos"];

        _player setPosASL _pos;
        _player setDir 0;

        [] call GRAD_grandPrix_fnc_rlgl_handleGunDoor;
        [] call GRAD_grandPrix_fnc_rlgl_handlePIP;
	    [] call GRAD_grandPrix_fnc_rlgl_handleFinishLocal;
    };
    case "zig": {
        _disconnectVar params ["_stage", "_loadout", "_group"];

        if (_group isNotEqualTo (group _player)) exitWith {};

        _player setUnitLoadout _loadout;
        [] call grad_grandPrix_fnc_ZiG_createMarkerLocal;
        private _teammates = (units _group) select { _x isNotEqualTo _player };
        hint "Du wirst zurück zu deinem Team teleportiert; Rechne mit möglichem Feindkontakt!";
        [format["Achtung, %1 wird jetzt zu euch teleportiert!", name _player]] remoteExec ["hint", _teammates];
        sleep 4;

        _player allowDamage true;
        [[["Time_Window", 155, 0], ["Razormind", 214, 59], ["Full_Force_Forward", 246, 0], ["Black_Yellow_Moebius", 188, 29], ["The_Mark", 348, 59], ["Fuse_Box", 205, 0], ["Tick_Tock", 146, 19], ["Wheres_the_Van", 162, 0], ["Calling_All_Units", 164, 18]], "GRAD_grandPrix_ZiG_endPressed"] spawn grad_grandprix_fnc_common_runPlaylist;

        // handle teleport
        private _theChosenOne = selectRandom _teammates;
        waitUntil { ([_theChosenOne] call grad_grandprix_fnc_common_safePosAvailable) select 0 };
        private _pos = ([_theChosenOne] call grad_grandprix_fnc_common_safePosAvailable) select 1;
        _player setPos _pos;
    };
    //Handle _player between stages
    default {
        private _units = units group _player;
        private _unit = _units select 0;
        if (unit isEqualTo _player) then {
            _unit = _units select 1;
        };

        private _vehicle = vehicle _unit;
        if (_vehicle isEqualTo _unit) then {
            _unit moveInAny _vehicle;
        } else {
            private _pos = ([_unit] call grad_grandprix_fnc_common_safePosAvailable) select 1;
        _player setPos _pos;
        };
    };
};

missionNamespace setVariable [_varString, [], true];

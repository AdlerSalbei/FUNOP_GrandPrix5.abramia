if (didJIP) then {
    [player] remoteExec ["grad_common_fnc_addJipToZeus",2,false];
};

["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups;
grad_template_ratingEH = player addEventHandler ["HandleRating",{0}];

[player] remoteExec ["grad_grandprix_fnc_points_registerGroups",2,false];

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

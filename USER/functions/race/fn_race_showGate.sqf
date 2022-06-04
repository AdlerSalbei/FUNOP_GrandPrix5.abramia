params ["_index", "_overwirte", "_string"];

//Select next gate
private _allGates = missionNamespace getVariable "GRAD_grandPrix_race_allGates";
private _gate = _allGates select _index;
player setVariable [_string, _gate];

if (_overwirte) then {
	player setVariable ["GRAD_grandPrix_race_currentPlaneTarget", _index ];
};

//Add trigger to gate
private _trigger = createTrigger ["EmptyDetector", _gate , false];
_trigger setTriggerArea [18, 20, getDir _gate , true, 18];
_trigger setPosASL (getPosASL _gate );
_trigger setTriggerActivation ["VEHICLE", "PRESENT", false];
_trigger triggerAttachVehicle [_plane];
_trigger setTriggerStatements [
	"this && (vehicle player) in thisList", 
	"{
		if (local _x) then {
			[thisTrigger] call grad_grandPrix_fnc_race_handleNextGate;
		};
	}forEach thisList;"
	, ""
];
_trigger setTriggerInterval 0;

_trigger setVariable ["grad_grandprix_race_triggerGate", _gate];
_gate setVariable ["grad_grandprix_race_triggerGate", _trigger];


//Unhide gate
_gate  hideObject false;








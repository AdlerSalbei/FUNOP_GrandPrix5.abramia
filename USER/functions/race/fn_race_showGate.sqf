params ["_index", "_overwirte", "_string"];

//Select next gate
private _plane = player getVariable "GRAD_grandPrix_race_plane";
private _allGates = missionNamespace getVariable "GRAD_grandPrix_race_allGates";
private _countGates = count _allGates;

if (_index > _countGates) exitWith {};
private _gate = _allGates select _index;
player setVariable [_string, _gate];

if (_overwirte) then {
	player setVariable ["GRAD_grandPrix_race_currentPlaneTarget", _index ];
};

if !(isNull (_gate getVariable ["grad_grandprix_race_triggerGate", objNull])) exitWith {};

//Add trigger to gate
private _trigger = createTrigger ["EmptyDetector", getPos _gate , false];
_trigger setTriggerArea [18, 20, getPosASL _gate , true, 18];
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

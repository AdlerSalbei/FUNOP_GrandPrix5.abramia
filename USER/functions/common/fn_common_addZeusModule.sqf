["GRAD Grand Prix", "Open Hangar", {
	params ["_position", "_object"];

	Grad_Hangar animateSource ["Door_7_sound_source", 1];
}] call zen_custom_modules_fnc_register;

private _allGates = [];
private _gateMarkerStart = 1; 
private _gateMarkerEnd = 19;
for "_i" from _gateMarkerStart to _gateMarkerEnd do
{   
	private _gate = call(compile format ["GRAD_grandPrix_race_planeTarget_%1",_i]);
	_gate hideObject false;
	_allGates pushBack _gate;
};
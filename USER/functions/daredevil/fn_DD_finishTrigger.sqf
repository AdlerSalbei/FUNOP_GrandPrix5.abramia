if !(hasInterface) exitWith {};

params ["_vehicle"];

cutText ["", "BLACK IN", 0.1];

private _driver = driver _vehicle; 
private _startTime = _driver getVariable ["GRAD_grandPrix_DD_startTime", -1];  

if (_startTime isEqualTo -1) exitWith {}; 

private _endTime = [time, servertime] select isMultiplayer;  

if (_driver isEqualTo player) then {
	_driver setVariable ["GRAD_grandPrix_DD_endTime", _endTime, true]; 
};

hint format ["Ihr hab %1 Zeit benötigt für euren Teil!", [_endTime, "MM:SS.MS"] call BIS_fnc_secondsToString];

player setVariable ["GRAD_grandPrix_DD_complete", true, true];

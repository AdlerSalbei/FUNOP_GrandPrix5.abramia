if !(hasInterface) exitWith {};

params ["_vehicle"];

cutText ["", "BLACK IN", 0.1];

private _driver = driver _vehicle; 
private _crew = crew _vehicle;
private _startTime = missionNamespace getVariable ["GRAD_grandPrix_DD_startTime", -1];  

if (_startTime isEqualTo -1) exitWith {}; 

private _disconTime = missionNamespace getVariable ["Grad_grandprix_dd_disconnectTimer", 0];
private _totalTime = ((diag_tickTime - _startTime) - (_disconTime max 0));  

[format ["Ihr hab %1s Zeit benötigt für euren Teil!", [_totalTime, "MM:SS"] call BIS_fnc_secondsToString]] remoteExec ["hint", _crew, false];
{
	_x setVariable ["GRAD_grandPrix_DD_complete", true, true];
	_x setVariable ["GRAD_grandPrix_DD_totalTime", _totalTime, true]; 
}forEach _crew;

missionNamespace setVariable ["GRAD_grandPrix_DD_startTime", -1];
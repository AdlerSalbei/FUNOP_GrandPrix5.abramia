if !(hasInterface) exitWith {};

params ["_vehicle"];

private _startTime = missionNamespace getVariable ["GRAD_grandPrix_DD_startTime", -1]; 

if (_startTime isNotEqualTo -1) exitWith {}; 
private _driver = driver _vehicle;

player allowDamage false;

if (_driver isEqualTo player) then {
	_vehicle allowDamage false;
	missionNamespace setVariable ["GRAD_grandPrix_DD_startTime", diag_tickTime, true];
};
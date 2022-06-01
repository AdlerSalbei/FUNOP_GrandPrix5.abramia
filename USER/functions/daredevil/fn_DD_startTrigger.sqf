if !(hasInterface) exitWith {};

params ["_vehicle"];

private _driver = driver _vehicle;
private _startTime = _driver getVariable ["GRAD_grandPrix_DD_startTime", -1]; 

if (_startTime isNotEqualTo -1) exitWith {}; 

player allowDamage false;

if (_driver isEqualTo player) then {
	_vehicle allowDamage false;
	_driver setVariable ["GRAD_grandPrix_DD_startTime", diag_tickTime, false];
};
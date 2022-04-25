if !(isServer) exitWith {};

params ["_group"];

private _players = units _group;
private _teams = [1,1,2,2] call BIS_fnc_arrayShuffle;

{
	private _index = _teams select _forEachIndex;
	private _vehicleName = "DD_veh0" + str(_index);

	_x moveInAny _vehicleName;
	_x setVariable ["GrandPrix_DD_vehicleTeam", _index, true];
}forEach _players;
if !(hasInterface) exitWith {};

params ["_unit"];

private _index = _unit addEventHandler ["InventoryOpened", {
	[
		{!isNull (findDisplay 602)},
		{ (findDisplay 602) closeDisplay 1},
		[]
	] call CBA_fnc_waitUntilAndExecute;
}];

_unit setVariable ["DD_inventoryIndex", _index];
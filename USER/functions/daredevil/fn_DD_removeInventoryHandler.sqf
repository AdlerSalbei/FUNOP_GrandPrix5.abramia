if !(hasInterface) exitWith {};

params ["_unit"];

private _index = _unit getVariable ["DD_inventoryIndex", -1];

if (_index isEqualTo -1) exitWith {
	diag_log format ["Has no Inventory handle: %1", _unit];
};

_unit removeEventHandler ["InventoryOpened", _index];
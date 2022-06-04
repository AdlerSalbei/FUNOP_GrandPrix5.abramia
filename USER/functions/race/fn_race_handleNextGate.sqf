params ["_trigger"];

private _gate = _trigger getVariable "grad_grandprix_race_triggerGate";
private _playerIndex = player getVariable "GRAD_grandPrix_race_currentPlaneTarget";
private _allGates = missionNamespace getVariable "GRAD_grandPrix_race_allGates";
private _index = _allGates find _gate;

[_index + 1, true, "GRAD_GrandPrix_planeGate01"] call GRAD_grandPrix_fnc_race_showGate;
[_index + 2, false, "GRAD_GrandPrix_planeGate02"] call GRAD_grandPrix_fnc_race_showGate;
[_index + 3, false, "GRAD_GrandPrix_planeGate03"] call GRAD_grandPrix_fnc_race_showGate;

deleteVehicle _trigger;

switch (_index - _playerIndex) do {
	case 0 : {
		deleteVehicle ((_allGates select (_index +1)) getVariable 'grad_grandprix_race_triggerGate');
		deleteVehicle ((_allGates select (_index +2)) getVariable 'grad_grandprix_race_triggerGate');
	};
	case 1 : {
		deleteVehicle ((_allGates select (_index +1)) getVariable 'grad_grandprix_race_triggerGate');
		deleteVehicle ((_allGates select (_index -1)) getVariable 'grad_grandprix_race_triggerGate');
	};
	case 2 : {
		deleteVehicle ((_allGates select (_index -1)) getVariable 'grad_grandprix_race_triggerGate');
		deleteVehicle ((_allGates select (_index -2)) getVariable 'grad_grandprix_race_triggerGate');
	};
};

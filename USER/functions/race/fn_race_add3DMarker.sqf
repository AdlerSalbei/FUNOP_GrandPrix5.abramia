private _id1 = addMissionEventHandler ["Draw3D", {
	drawIcon3D [
		"\a3\ui_f\data\IGUI\Cfg\Radar\targeting_ca.paa",
		[0.9,0.9,0,1],
		getPos (player getVariable "GRAD_GrandPrix_planeGate01"),
		0.5,
		0.5,
		getDir (player getVariable "GRAD_GrandPrix_planeGate01")
	];
}];

private _id2 = addMissionEventHandler ["Draw3D", {
	drawIcon3D [
		"\a3\ui_f\data\IGUI\Cfg\Radar\targeting_ca.paa",
		[0.9,0,0.9,1],
		getPos (player getVariable "GRAD_GrandPrix_planeGate02"),
		0.5,
		0.5,
		getDir (player getVariable "GRAD_GrandPrix_planeGate02")
	];
}];

private _id3 = addMissionEventHandler ["Draw3D", {
	drawIcon3D [
		"\a3\ui_f\data\IGUI\Cfg\Radar\targeting_ca.paa",
		[1,0,0,1],
		getPos (player getVariable "GRAD_GrandPrix_planeGate03"),
		0.5,
		0.5,
		getDir (player getVariable "GRAD_GrandPrix_planeGate03")
	];
}];

missionNamespace setVariable ["grad_grandPrix_planGate3DMarker_ID", [_id1, _id2, _id3]];

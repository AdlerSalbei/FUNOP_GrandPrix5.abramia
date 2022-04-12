params ["_station", "_group"];

_station setVariable ["stationIsRunning", true, true];
missionNamespace setVariable ["GRAD_grandPrix_ZiG_planesDone", false, true];
missionNameSpace setVariable ["GRAD_grandPrix_ZiG_collectingActive", false, true];

private _allInstructors = [];
{
	_allInstructors pushBackUnique (getAssignedCuratorUnit _x);
} forEach allCurators;
private _nearestInstructor = objNull;
private _distance = _station distance (_allInstructors#0);
{
	if ((_station distance _x) < _distance) then {
		_distance = _station distance _x;
		_nearestInstructor = _x;
	}	
} forEach _allInstructors;

private _housesMarkerStart = 1; 
private _housesMarkerEnd = 24; 
for "_i" from _housesMarkerStart to _housesMarkerEnd do
{   
	private _house = call(compile format ["GRAD_grandPrix_ZiG_HousesToRepair_%1",_i]);
	_house setDamage 0;
};

[] remoteExec ["grad_grandPrix_fnc_ZiG_createMarkerLocal", (units _group) + [_nearestInstructor]];

//set Loadouts
{
	_x setVariable ["GRAD_grandPrix_ZiG_savedLoadout", getUnitLoadout _x, true];
	_x setUnitLoadout [["SMG_03C_TR_black","","","FHQ_optic_AC11704",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_P07_blk_F","","","",["30Rnd_9x21_Mag",30],[],""],["SMA_UNIFORMS_BLACK",[["ACE_fieldDressing",16],["ACE_tourniquet",4],["ACE_salineIV_500",2],["SmokeShell",5,1],["HandGrenade",3,1]]],["SMA_UNIFORMS_black_VEST",[["50Rnd_570x28_SMG_03",10,50]]],["B_Messenger_Black_F",[["30Rnd_9x21_Mag",3,30]]],"SMA_Helmet_Black","UK3CB_G_Balaclava2_BLK",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
} forEach (units _group);

[] call grad_grandPrix_fnc_ZiG_handlePlanes;

waitUntil { missionNamespace getVariable ["GRAD_grandPrix_ZiG_planesDone", false]; };

[] call grad_grandPrix_fnc_ZiG_handleMoney;

//To-do: handle Stage-Start

missionNameSpace setVariable ["GRAD_grandPrix_ZiG_collectingActive", true, true];
[_group] spawn grad_grandPrix_fnc_ZiG_handlePolice;
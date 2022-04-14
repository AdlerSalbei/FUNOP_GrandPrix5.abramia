if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

params ["_station", "_group"];

_station setVariable ["stationIsRunning", true, true];
// missionNamespace setVariable ["GRAD_grandPrix_ZiG_endPressed", false, true];
// missionNamespace setVariable ["GRAD_grandPrix_ZiG_planesDone", false, true];
// missionNameSpace setVariable ["GRAD_grandPrix_ZiG_collectingActive", false, true];

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
	_x setUnitLoadout [["SMG_03C_TR_black","","","FHQ_optic_AC11704",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_P07_blk_F","","","",["30Rnd_9x21_Mag",30],[],""],["UK3CB_CW_US_B_LATE_U_SF_CombatUniform_02_BLK",[["ACE_fieldDressing",18],["ACE_tourniquet",4],["ACE_salineIV_500",2],["SmokeShell",2,1]]],["UK3CB_ADA_B_V_TacVest_BLK",[["50Rnd_570x28_SMG_03",8,50],["SmokeShell",1,1]]],["B_Messenger_Black_F",[["30Rnd_9x21_Mag",3,30]]],"H_PASGT_basic_black_F","UK3CB_G_Balaclava2_BLK",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
	[_x, true] remoteExec ["allowDamage", _x];
} forEach (units _group);

[] call grad_grandPrix_fnc_ZiG_handlePlanes;

waitUntil { missionNamespace getVariable ["GRAD_grandPrix_ZiG_planesDone", false]; };

[] spawn grad_grandPrix_fnc_ZiG_handleMoney;

sleep 3;
["grad_grandPrix_race_triggerCountdown", [], units _group] call CBA_fnc_targetEvent;
sleep 3;

missionNameSpace setVariable ["GRAD_grandPrix_ZiG_collectingActive", true, true];
private _policeHandle = [_group] spawn grad_grandPrix_fnc_ZiG_handlePolice;


//add unconscious handler to players
{
	[] remoteExecCall ["grad_grandPrix_fnc_ZiG_unconsciousHandlerLocal", _x];
} forEach (units _group);

ZiG_fnc_allPlayersUnconscious = {
	params ["_group"];

	private _times = [];
	{
		private _time = _x getVariable ["GRAD_grandPrix_ZiG_unconsciousTime", 0];
		if (_time == 0) then {
			_times pushBack 0;
		} else {
			_times pushBack (([time, serverTime] select isDedicated) - _time);
		};
	} forEach (units _group);

	(count _times) == (count (_times select { _x >= 30 }))
};


// wait until button press or tpk
waitUntil { (missionNamespace getVariable ["GRAD_grandPrix_ZiG_endPressed", false]) || ([_group] call ZiG_fnc_allPlayersUnconscious) };

missionNamespace setVariable ["GRAD_grandPrix_ZiG_collectingActive", false, true];

private _money = 0;
if (missionNamespace getVariable ["GRAD_grandPrix_ZiG_endPressed", false]) then {
	{
		private _items = itemsWithMagazines _x;
		_money = _money + ({ _x isEqualTo "photo9" } count _items);
	} forEach ((units _group) select { _x inArea grad_grandPrix_fnc_ZiG_moneyCollection });
};

{
	private _unit = _x;
	[_x] remoteExecCall ["ace_medical_treatment_fnc_fullHealLocal", _x];
	private _pos = [grad_grandPrix_fnc_ZiG_teleport] call BIS_fnc_randomPosTrigger;
	_pos set [2, 0];
	_x setPos _pos;
	_x setUnitLoadout (_x getVariable ["GRAD_grandPrix_ZiG_savedLoadout", []]);
	private _handler = _x getVariable ["GRAD_grandPrix_ZiG_unconsciousHandler", -1];
	["ace_unconscious", _handler] call CBA_fnc_removeEventHandler;
	private _markers = _x getVariable ["GRAD_grandPrix_ZiG_moneyMarkers", []];
	{
		[_x] remoteExec ["deleteMarker", _unit];
	} forEach _markers;
	[_x, false] remoteExec ["allowDamage", _x];
} forEach (units _group);

[_group, _money, "Zeit ist Geld"] call grad_grandPrix_fnc_addPoints;

private _msg = format ["Ihr habt %1€ erbeutet und euch damit %2 Punkte erspielt!", _money * 100, _money];
[_msg] remoteExec ["hint", (units _group) + [_nearestInstructor]];

missionNamespace setVariable ["GRAD_grandPrix_ZiG_endPressed", false, true];
missionNamespace setVariable ["GRAD_grandPrix_ZiG_planesDone", false, true];
missionNameSpace setVariable ["GRAD_grandPrix_ZiG_collectingActive", false, true];

sleep 2;
terminate _policeHandle;

_station setVariable ["stationIsRunning", false, true];
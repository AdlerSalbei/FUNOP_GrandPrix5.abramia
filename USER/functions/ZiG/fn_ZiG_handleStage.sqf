if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

params ["_station", "_group"];

_station setVariable ["stationIsRunning", true, true];

private _nearestInstructor = [_station] call grad_grandprix_fnc_common_getNearestZeus;

private _housesMarkerStart = 1; 
private _housesMarkerEnd = 24; 
for "_i" from _housesMarkerStart to _housesMarkerEnd do
{   
	private _house = call(compile format ["GRAD_grandPrix_ZiG_HousesToRepair_%1",_i]);
	_house setDamage 0;
};

[] remoteExec ["grad_grandPrix_fnc_ZiG_createMarkerLocal", _nearestInstructor];

//add unconscious handler to players, show Markers, add Loadout & show money
[] remoteExecCall ["grad_grandPrix_fnc_ZiG_startStageClient", _group, false];

//Show planes
//[] call grad_grandPrix_fnc_ZiG_handlePlanes;

//waitUntil { missionNamespace getVariable ["GRAD_grandPrix_ZiG_planesDone", false]; };

sleep 3;

["grad_grandPrix_race_triggerCountdown", [], units _group] call CBA_fnc_targetEvent;

sleep 3;

missionNameSpace setVariable ["GRAD_grandPrix_ZiG_collectingActive", true, true];
private _policeHandle = [_group] spawn grad_grandPrix_fnc_ZiG_handlePolice;

// wait until button press or tpk
waitUntil { (missionNamespace getVariable ["GRAD_grandPrix_ZiG_endPressed", false]) || ([_group] call grad_grandPrix_fnc_ZiG_allPlayersUnconscious) };

missionNamespace setVariable ["GRAD_grandPrix_ZiG_collectingActive", false, true];

private _money = 0;
private _playerMoney = [];
if (missionNamespace getVariable ["GRAD_grandPrix_ZiG_endPressed", false]) then {
	{
		private _items = itemsWithMagazines _x;
		private _xMoney = ({ _x isEqualTo "photo9" } count _items) max 0;

		_money = _money + _xMoney;
		_playerMoney pushBackUnique [name _x, _xMoney];
	} forEach ((units _group) select { _x inArea grad_grandPrix_fnc_ZiG_moneyCollection });
};

[_group, _money, "Zeit ist Geld"] call grad_grandPrix_fnc_addPoints;

//Nachricht an die Spieler
private _msg = "<t align='left'>Ihr habt leider kein Geld gefunden :(</t>"; 
if (_money > 0) then { 
	_msg = format ["<t align='left'>Ihr habt %1€ erbeutet und euch damit %2 Punkte erspielt!</t>", _money * 100, _money]; 
	_msg = _msg + "<br /> <br /><t align='left'>Spieler haben gesammelt:</t>"; 

	{ 
		_msg = _msg + format ["<br /> <t align='center'>%1:</t> <t align='right'>%2€</t>", _x select 0, (_x select 1) * 100]; 
	}forEach _playerMoney; 
}; 
 
[parseText _msg] remoteExec ["hint", (units _group) + [_nearestInstructor]];

//Player Healen, marker löschen & zuruek teleportieren
[] remoteExecCall ["grad_grandPrix_fnc_ZiG_endStageClient", _group, false];

{
	private _handler = _x getVariable ["GRAD_grandPrix_ZiG_unconsciousHandler", -1];
	["ace_unconscious", _handler] call CBA_fnc_removeEventHandler;
} forEach (units _group);

missionNamespace setVariable ["GRAD_grandPrix_ZiG_endPressed", false, true];
missionNamespace setVariable ["GRAD_grandPrix_ZiG_planesDone", false, true];
missionNameSpace setVariable ["GRAD_grandPrix_ZiG_collectingActive", false, true];

sleep 2;
terminate _policeHandle;

[] call grad_grandPrix_fnc_ZiG_handleMoney;

_station setVariable ["stationIsRunning", false, true];
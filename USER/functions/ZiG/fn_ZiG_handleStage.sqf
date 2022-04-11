missionNamespace setVariable ["GRAD_grandPrix_ZiG_planesDone", false, true];

private _housesMarkerStart = 1; 
private _housesMarkerEnd = 24; 
for "_i" from _housesMarkerStart to _housesMarkerEnd do
{   
	private _house = call(compile format ["GRAD_grandPrix_ZiG_HousesToRepair_%1",_i]);
	_house setDamage 0;
};

[] call grad_grandPrix_fnc_ZiG_handlePlanes;

waitUntil { missionNamespace getVariable ["GRAD_grandPrix_ZiG_planesDone", false]; };

systemChat "spawning money";
[] call grad_grandPrix_fnc_ZiG_handleMoney;
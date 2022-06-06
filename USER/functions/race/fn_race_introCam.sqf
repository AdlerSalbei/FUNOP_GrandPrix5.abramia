diwako_dui_main_toggled_off = true;
cutText ["", "BLACK", 1];
5 fadeSound 0.2;
sleep 3;

private _roadMap = missionNamespace getVariable ["GRAD_grandPrix_race_roadMap", createHashMap];
toArray _roadMap params ["_keys", "_values"];
private _sortedValues = +_values;
_sortedValues sort true;

private _sortedKeys = [];
{
	private _index = _values find _x;
	private _pos = _keys # _index;
	_pos set [2, 1.5];
	_sortedKeys pushBack _pos;
} forEach _sortedValues;

private _allGates = [];
private _gateMarkerStart = 1; 
private _gateMarkerEnd = 19;
for "_i" from _gateMarkerStart to _gateMarkerEnd do
{   
	private _gate = call(compile format ["GRAD_grandPrix_race_planeTarget_%1",_i]);
	_gate hideObject false;
	_allGates pushBack _gate;
};
GRAD_grandPrix_race_finish hideObject false;
_allGates insert [0, [GRAD_grandPrix_race_introCamPos_1, GRAD_grandPrix_race_introCamPos_2]];
_allGates pushBack GRAD_grandPrix_race_introCamPos_3;
private _gateCount = count _allGates;

private _cam = "camera" camCreate (_sortedKeys # 0);
_cam cameraEffect ["internal", "BACK"];
cutText ["", "BLACK IN", 0];
_sortedKeys deleteAt 0;
_sortedKeys deleteRange [((count _sortedKeys) - 6), ((count _sortedKeys) - 1)];

private _pos = _sortedKeys # 0;
private _nextPos = _sortedKeys # 1;
_cam camSetTarget _nextPos;
_cam camCommit 0;
sleep 1;

private _keyCount = count _sortedKeys;
{
	_pos = _x;
	if (_foreachIndex == (_keyCount - 1)) exitWith {};
	
	private _nextPos = _sortedKeys # (_foreachIndex + 1);
	private _dist = _pos distance _nextPos;
	private _sleepTime = _dist / 210;
	
	_cam camSetTarget _nextPos;
	_cam camSetPos _pos;
	_cam camCommit _sleepTime;
	sleep _sleepTime;	
} forEach _sortedKeys;

_gateCount = count _allGates;
{
	_pos = getpos _x;
	if (_foreachIndex == (_gateCount - 1)) exitWith {};
	
	private _nextPos = _allGates # (_foreachIndex + 1);
	private _dist = _pos distance _nextPos;
	private _sleepTime = _dist / 900;
	
	_cam camSetTarget _nextPos;
	_cam camCommit (_sleepTime * 3);
	_cam camSetPos _pos;
	_cam camCommit _sleepTime;
	sleep _sleepTime;		
} forEach _allGates;


private _spheres = missionNamespace getVariable ["GRAD_grandPrix_race_jetskiCamPos", []];
_sphereCount = count _spheres;
{
	_pos = getpos _x;
	if (_foreachIndex == (_sphereCount - 1)) exitWith {};
	
	private _nextPos = _spheres # (_foreachIndex + 1);
	private _dist = _pos distance _nextPos;
	private _sleepTime = _dist / 250;
	
	_cam camSetTarget _nextPos;
	_cam camSetPos _pos;
	_cam camCommit _sleepTime;
	sleep _sleepTime;		
} forEach _spheres;

_cam cameraEffect ["terminate", "BACK"];
camDestroy _cam;
diwako_dui_main_toggled_off = false;
1 fadeSound 1;

player setVariable ["GRAD_grandPrix_race_introDone", true, true];
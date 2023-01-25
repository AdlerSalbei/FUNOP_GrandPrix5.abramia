#include "component.hpp"

params [["_respawnUnit",objNull]];

private _respawnPos = [];
private _tooClose = true;
private _otherPlayers = allPlayers select {_x != _respawnUnit && alive _x};

for "_i" from 0 to 10 do {
    _respawnPos = [];
    _searchPos = [EGVAR(missionSetup,playAreaCenter),[0,(EGVAR(missionSetup,playAreaSize) - 80) max 1],[0,360]] call EFUNC(common,randomPos);

    for "_k" from 0 to 10 do {
        _houseList = (_searchPos nearObjects ["House",75 min (EGVAR(missionSetup,playAreaSize)/2)]) select {!((_x buildingPos 0) isEqualTo [0,0,0])};
        if (count _houseList > 0) then {
            _house = selectRandom _houseList;
            _respawnPos = selectRandom ([_house] call BIS_fnc_buildingPositions);
        };
        if ((count _respawnPos) > 0) exitWith {};
    };

    if (count _respawnPos > 0 && {!(_respawnPos isEqualTo [0,0,0])}) then {
        _tooClose = (_otherPlayers findIf {(_respawnPos distance2D _x) < 20}) >= 0;
    };
    if (!_tooClose) exitWith {};
};

if (count _respawnPos == 0 || _tooClose || {_respawnPos isEqualTo [0,0,0]}) then {
    for "_i" from 0 to 10 do {
        _respawnPos = [];
        _searchPos = [0,0,0];
        for "_j" from 0 to 10 do {
            _searchPos = [EGVAR(missionSetup,playAreaCenter),[0,EGVAR(missionSetup,playAreaSize) - 35],[0,360]] call EFUNC(common,randomPos);
            if (!surfaceIsWater _searchPos) exitWith {};
        };
        if (surfaceIsWater _searchPos) then {
            _searchPos = EGVAR(missionSetup,playAreaCenter);
        };

        for "_k" from 0 to 10 do {
            _respawnPos = ([_searchPos,[0,50]] call EFUNC(common,randomPos)) findEmptyPosition [0,30,"B_Soldier_F"];
            if ((count _respawnPos) > 0) exitWith {};
        };

        if (count _respawnPos > 0 && {!(_respawnPos isEqualTo [0,0,0])}) then {
            _tooClose = (_otherPlayers findIf {(_respawnPos distance2D _x) < 20}) >= 0
        };
        if (!_tooClose) exitWith {};
    };
};

// just to be sure
if (isNil "_respawnPos" || {count _respawnPos == 0} || {_respawnPos isEqualTo [0,0,0]}) then {
    for "_h" from 0 to 100 do {
        _respawnPos = [EGVAR(missionSetup,playAreaCenter),[0,EGVAR(missionSetup,playAreaSize) - 35],[0,360]] call EFUNC(common,randomPos);
        if (!surfaceIsWater _searchPos) exitWith {};
    };
    if (count _respawnPos == 0 || {_respawnPos isEqualTo [0,0,0]}) then {
        _respawnPos = EGVAR(missionSetup,playAreaCenter);
    };
};

_respawnPos

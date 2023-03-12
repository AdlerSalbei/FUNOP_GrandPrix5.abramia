#include "component.hpp"

private _spawnGroupsMinDist = [missionConfigFile >> "cfgMission","spawnGroupMinDist",50] call BIS_fnc_returnConfigEntry;
private _startPositions = [];

{
    _player = _x;
	_repetitions = 0;
	_tooCloseFound = true;
    _startPos = grad_grandprix_gog_playAreaCenter;

	while {_tooCloseFound} do {

		//find position that is not over water
		_isWater = true;
		for [{_i=0}, {_i<100}, {_i = _i + 1}] do {
			_startPos = [grad_grandprix_gog_playAreaCenter,[0,grad_grandprix_gog_playAreaSize - 25],[0,360]] call grad_grandprix_gog_fnc_randomPos;
			_isWater = surfaceIsWater _startPos;
            if (!_isWater) exitWith {};
		};

        if (_isWater) then {INFO_2("Server found only water positions in 100 cycles around %1 with a searchradius of %2.",grad_grandprix_gog_playAreaCenter,grad_grandprix_gog_playAreaSize - 25)};

		//make sure position is at least SPAWNGROUPMINDIST away from other positions
		_tooCloseFound = false;
		{
			if ((_x distance2D _startPos) < _spawnGroupsMinDist) exitWith {_tooCloseFound = true; INFO_1("Start position for %1 to close to other position. Repeating.", name _player)};
		} forEach _startPositions;

		//unless this has been repeated too often -> use position anyway
		if (_repetitions >= 10) then {
			_tooCloseFound = false;
		};

		_repetitions = _repetitions + 1;
	};

    _startPositions pushBack _startPos;
    [_x,_startPos] remoteExec ["grad_grandprix_gog_teleport",_x,false];

} forEach (allPlayers select {_x getVariable ["grad_grandprix_gog_isPlaying",false]});

#include "component.hpp"

// no areas --> random center ==================================================
if (count EGVAR(votePlayzone,areaMarkers) == 0) then {
    INFO("No play areas proposed. Selecting at random.");

    _isWater = true;
    while {_isWater} do {
        grad_grandprix_gog_playAreaCenter = [[worldSize/2, worldSize/2, 0], [0, 1000], [0,360]] call grad_grandprix_gog_fnc_randomPos;
        _isWater = surfaceIsWater grad_grandprix_gog_playAreaCenter;
    };

    _playerAmount = count playableUnits;
    grad_grandprix_gog_playAreaSize = (((_playerAmount ^ 0.38) * 500 - 650) max 200);
    publicVariable "grad_grandprix_gog_playAreaSize";

// select most upvoted =========================================================
} else {

    _mostUpvotedID = [EGVAR(votePlayzone,markerVotes)] call grad_grandprix_gog_fnc_findMax;

    //no single most upvoted
    if (_mostUpvotedID == -1) then {
        INFO("No single most upvoted play area. Selecting at random from most upvoted.");

        _mostUpvotedIDs = [];
        _max = -999999;

        for [{_i=0}, {_i<(count EGVAR(votePlayzone,markerVotes))}, {_i=_i+1}] do {
            _element = EGVAR(votePlayzone,markerVotes) select _i;
            if (_element == _max) then {
                _mostUpvotedIDs pushBack _i;
            };

            if (_element > _max) then {
                _max = _element;
                _mostUpvotedIDs = [];
                _mostUpvotedIDs pushBack _i;
            };
        };

        _randomID = selectRandom _mostUpvotedIDs;
        _selectedMarker = EGVAR(votePlayzone,areaMarkers) select _randomID;
        grad_grandprix_gog_playAreaCenter = getMarkerPos _selectedMarker;
        grad_grandprix_gog_playAreaSize = (getMarkerSize _selectedMarker) select 0;

    //most upvoted
    } else {
        _selectedMarker = EGVAR(votePlayzone,areaMarkers) select _mostUpvotedID;
        grad_grandprix_gog_playAreaCenter = getMarkerPos _selectedMarker;
        grad_grandprix_gog_playAreaSize = (getMarkerSize _selectedMarker) select 0;
        INFO("Most upvoted playarea is %1", _selectedMarker);
    };
};

publicVariable Qgrad_grandprix_gog_playAreaCenter;
publicVariable "grad_grandprix_gog_playAreaSize";


//DELETE VOTING MARKERS ========================================================
{
    //delete voter markers
    _allfound = false;
    _i = 0;
    while {!_allFound} do {
        _oldVoterMarkerName = format ["%1_%2", _x, _i];
        if (str getMarkerPos _oldVoterMarkerName != "[0,0,0]") then {
            deleteMarker _oldVoterMarkerName;
        } else {
            _allFound = true;
        };
        _i = _i + 1;
    };

    deleteMarker _x;
} forEach EGVAR(votePlayzone,voteMarkers);

{
  deleteMarker _x;
} forEach EGVAR(votePlayzone,areaMarkers);


//CREATE PLAY AREA MARKERS =====================================================
_marker = createMarker ["grad_grandprix_gog_(playAreaMarker", grad_grandprix_gog_playAreaCenter];
_marker setMarkerColor "COLORWEST";
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "Border";
_marker setMarkerSize [grad_grandprix_gog_playAreaSize,grad_grandprix_gog_playAreaSize];


//BUILD WALL ===================================================================
[] call FUNC(buildTheWall);

INFO("fn_playAreaSetup done");

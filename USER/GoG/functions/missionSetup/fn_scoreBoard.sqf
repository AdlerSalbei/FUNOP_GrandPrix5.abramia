#include "component.hpp"
#include "..\..\dialog\scoreboard\defines.hpp"

if (!hasInterface) exitWith {};
if !(missionNamespace getVariable [QGVAR(gameStarted),false]) exitWith {};

private ["_display", "_teamScore", "_teamName"];
if (!alive player) exitWith {};
disableSerialization;

private _allPlayingPlayers = allPlayers select {_x getVariable [QGVAR(isPlaying),false]};
private _allPlayingPlayersScores = _allPlayingPlayers apply {[_x getVariable [QGVAR(currentScore),0],_x]};
_allPlayingPlayersScores sort false;

private _display = uiNamespace getVariable "ScoreBoard_Display";
if (isNil "_display" || {isNull _display}) then {
    cutRsc ["ScoreBoard", "PLAIN", 1];
    _display = uiNamespace getVariable "ScoreBoard_Display";
};

private _fnc_addUnitScore = {
    _scoreBoardItem ctrlSetBackgroundColor [0,0,0,0.4];
    _scoreBoardItem ctrlSetText (_unit getVariable ["ACE_Name","ERROR: NO NAME"]);
    _scoreBoardScore ctrlSetBackgroundColor [0,0,0,0.4];
    _scoreBoardScore ctrlSetText str _score;
};

private _fnc_hideRow = {
    _scoreBoardItem ctrlSetBackgroundColor [0,0,0,0];
    _scoreBoardItem ctrlSetText "";
    _scoreBoardScore ctrlSetBackgroundColor [0,0,0,0];
    _scoreBoardScore ctrlSetText "";
};

private _playerRank = _allPlayingPlayersScores find [player getVariable [QGVAR(currentScore),0],player];
private _maxID = count _allPlayingPlayers;
for [{_i=0}, {_i < 5}, {_i=_i+1}] do {
    _scoreBoardItem = _display displayCtrl SCOREBOARD_ITEM1 + _i;
    _scoreBoardScore = _display displayCtrl SCOREBOARD_SCORE1 + _i;

    if (_i < _maxID) then {
        (_allPlayingPlayersScores param [_i,[0,objNull]]) params ["_score","_unit"];

        // skip fourth row if player is lower than rank 5 to indicate gap
        if (_i == 3 && _playerRank > 4) then {
            _scoreBoardItem ctrlSetBackgroundColor [0,0,0,0.4];
            _scoreBoardItem ctrlSetText "...";
            _scoreBoardScore ctrlSetBackgroundColor [0,0,0,0];
            _scoreBoardScore ctrlSetText "";
        } else {
            // display player in fifth row even if rank is lower
            if (_i == 4 && _playerRank > 4) then {
                _score = player getVariable [QGVAR(currentScore),0];
                _unit = player;
                call _fnc_addUnitScore;
            } else _fnc_addUnitScore;
        };
    } else _fnc_hideRow;

};

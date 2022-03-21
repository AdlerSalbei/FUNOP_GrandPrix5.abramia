#include "idcmacros.hpp"

#define DIALOG_W (115 * GRID_W)
#define DIALOG_H (75 * GRID_H)
#define MARGIN_H (0.5 * GRID_H)
#define MARGIN_W (0.5 * GRID_W)
#define GAME_COL_WIDTH 0.25

private _allGroups = missionNamespace getVariable ["GRAD_GrandPrix_allContestantGroups", []];
private _allGroupNames = missionNamespace getVariable ["GRAD_GrandPrix_allContestantGroupNames", []];
if ((count _allGroups) <= 0) exitWith { systemChat format["%1: No contestant-groups found!", _fnc_scriptName]; };

private _dialogX = CENTER_X(DIALOG_W);
private _dialogY = CENTER_Y(DIALOG_H);

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
uiNamespace setVariable ["GRAD_resultDisplay", _display];
 _display displayAddEventHandler ["unload", {
     uiNamespace setVariable ["GRAD_resultDisplay", nil];
}];

(_display displayCtrl 1202) ctrlSetText "";

private _ctrlBack = _display ctrlCreate ["ctrlStaticBackground", 1];
// _ctrlBack ctrlSetBackgroundColor [0.3, 0.3, 0.3, 0.9];
_ctrlBack ctrlSetPosition [_dialogX, _dialogY, DIALOG_W, DIALOG_H + DIALOG_FOOTER_H];
_ctrlBack ctrlCommit 0;

private _ctrlTitle = _display ctrlCreate ["ctrlStaticTitle", 2];
_ctrlTitle ctrlSetPosition [_dialogX, _dialogY - DIALOG_TITLE_H, DIALOG_W, DIALOG_TITLE_H];
_ctrlTitle ctrlCommit 0;
_ctrlTitle ctrlSetText "Grand Prix Ergebnisse:";

private _ctrlFooter = _display ctrlCreate ["ctrlStaticFooter", 3];
_ctrlFooter ctrlSetPosition [_dialogX, _dialogY + DIALOG_H, DIALOG_W, DIALOG_FOOTER_H];
_ctrlFooter ctrlCommit 0;

private _ctrlBtnOk = _display ctrlCreate ["ctrlButtonOK", 4];
_ctrlBtnOk ctrlSetPosition [
    _dialogX + DIALOG_W/2 - (14 * GRID_W)/2,
    _dialogY + DIALOG_H + DIALOG_BUTTON_SPACING * GRID_H,
    14 * GRID_W,
    DIALOG_FOOTER_H - DIALOG_BUTTON_SPACING * 2 * GRID_H
];

_ctrlBtnOk ctrlCommit 0;
_ctrlBtnOk ctrlAddEventHandler ["ButtonClick", {
	params ["_ctrl"];
	
    private _display = ctrlParent _ctrl;
	_display closeDisplay 1;
}];

private _resultCtrl = _display ctrlCreate ["JulesListBox", 5];
_resultCtrl ctrlSetBackgroundColor [0, 0, 0, 0];
_resultCtrl ctrlSetPosition [_dialogX, _dialogY, DIALOG_W, DIALOG_H];
_resultCtrl ctrlCommit 0;

// delete all existing columns
while { count (lnbGetColumnsPosition _resultCtrl) > 0 } do {
    _resultCtrl lnbDeleteColumn 0;
};

// add "game" column
_resultCtrl lnbAddColumn 0;

// add teams columns
private _teamsCount = (count _allGroups);
private _colWidth = (1 - GAME_COL_WIDTH) / _teamsCount;
private _xPos = GAME_COL_WIDTH;
while { _xPos < 1 } do {
    _resultCtrl lnbAddColumn _xPos;
    _xPos = _xPos + _colWidth;
};

private _headRow = [""] + _allGroupNames;
private _allGroupVars = [];
{
	// Current result is saved in variable _x
	private _groupName = _allGroupNames # _foreachIndex;
    private _var = missionNamespace getVariable [_groupName, []];
    _allGroupVars pushBackUnique [_groupName, _var];
} forEach _allGroups;
_resultCtrl lnbAddRow _headRow;

private _allStages = [];
private _allPoints = [];
{
    _x params [["_name", ""], ["_var", []]];
    {
        _x params ["_stage", "_points"];
        _allStages pushBackUnique _stage;
    } forEach _var;

} forEach _allGroupVars;

{
    private _rowStage = _x;
    private _row = [_rowStage];
    {
        _x params [["_name", ""], ["_var", []]];
        private _pointsFound = false;
        {
            _x params [["_stage", ""], ["_points", 0]];
            if (_stage isEqualTo _rowStage) then {
                _row pushBack (str _points);
                _pointsFound = true;
                break;
            };
        } forEach _var;
        if !(_pointsFound) then {
            _row pushBack "-/-";
        };
    } forEach _allGroupVars;
    _resultCtrl lnbAddRow _row;
} foreach _allStages;

private _footRow = ["Gesamtpunktzahl"];
{
    _x params [["_name", ""], ["_var", []]];
    private _overallPoints = 0;
    {
        _x params ["_stage", "_points"];
        _overallPoints = _overallPoints + _points;
    } forEach _var;
    _footRow pushBack (str _overallPoints);
} forEach _allGroupVars;
_resultCtrl lnbAddRow _footRow;
#include "component.hpp"

#define IDC_LISTBOX 100

#define TOTAL_W     0.5
#define TOTAL_H     1.0
#define TOTAL_X     0.0
#define TOTAL_Y     0.0

#define BUTTON_H    (TOTAL_H * 0.05)

([false] call FUNC(getAllAvailableWeapons)) params ["_allAvailableRifles","_allAvailablePistols"];

private _checkboxTextures = [
    tolower gettext (configfile >> "RscCheckBox" >> "textureUnchecked"),
    tolower gettext (configfile >> "RscCheckBox" >> "textureChecked")
];

private _weaponBlacklist = [missionConfigFile >> "cfgMission","weaponBlacklist",[]] call BIS_fnc_returnConfigEntry;

// CREATE DIALOG ===============================================================
disableSerialization;
private _display = (findDisplay 46) createDisplay "RscDisplayEmpty";

private _ctrlBg = _display ctrlCreate ["RscBackground",-1];
_ctrlBg ctrlSetPosition [TOTAL_X,TOTAL_Y,TOTAL_W,TOTAL_H];
_ctrlBg ctrlCommit 0;

private _ctrlListbox = _display ctrlCreate ["mcd_lbMulti",IDC_LISTBOX];
_ctrlListbox ctrlSetPosition [TOTAL_X,TOTAL_Y,TOTAL_W,TOTAL_H];
_ctrlListbox ctrlCommit 0;

private _ctrlButtonToggle = _display ctrlCreate ["RscButton",-1];
_ctrlButtonToggle ctrlSetPosition [TOTAL_X,TOTAL_Y + TOTAL_H,TOTAL_W / 2,BUTTON_H];
_ctrlButtonToggle ctrlSetText "TOGGLE";
_ctrlButtonToggle ctrlCommit 0;

private _ctrlButtonExport = _display ctrlCreate ["RscButton",-1];
_ctrlButtonExport ctrlSetPosition [TOTAL_X + TOTAL_W / 2,TOTAL_Y + TOTAL_H,TOTAL_W / 2,BUTTON_H];
_ctrlButtonExport ctrlSetText "EXPORT";
_ctrlButtonExport ctrlCommit 0;

// FILL LISTBOX ================================================================
{
    _id = _ctrlListbox lbAdd ([configfile >> "cfgWeapons" >> _x,"displayName","ERROR: NO NAME"] call BIS_fnc_returnConfigEntry);
    _ctrlListbox lbSetTooltip [_id,_x];
    _ctrlListbox lbSetData [_id,_x];

    _ctrlListbox lbSetPictureColor [_id,[1,1,1,1]];
    _ctrlListbox lbSetPicture [_id,[_x] call EFUNC(common,getPicturePath)];

    _ctrlListbox lbSetPictureRightColor [_id,[1,1,1,1]];
    _ctrlListbox lbSetPictureRight [_id,_checkboxTextures select (_x in _weaponBlacklist)];
} forEach (_allAvailableRifles + _allAvailablePistols);

// BUTTON TOGGLE ===============================================================
_ctrlButtonToggle ctrlAddEventHandler ["ButtonClick",{
    params ["_ctrlButton"];

    disableSerialization;

    private _checkboxTextures = [
        tolower gettext (configfile >> "RscCheckBox" >> "textureUnchecked"),
        tolower gettext (configfile >> "RscCheckBox" >> "textureChecked")
    ];

    private _display = ctrlParent _ctrlButton;
    if (isNull _display) exitWith {};

    private _ctrlListbox = _display displayCtrl IDC_LISTBOX;
    private _sel = lbSelection _ctrlListbox;

    if (count _sel == 0) exitWith {};
    private _firstElementValue = _ctrlListbox lbValue (_sel select 0);

    {
        _ctrlListbox lbSetValue [_x,[1,0] select _firstElementValue];
        _ctrlListbox lbSetPictureRight [_x,_checkboxTextures select (_firstElementValue == 0)];
    } forEach _sel;
}];

// BUTTON EXPORT ===============================================================
_ctrlButtonExport ctrlAddEventHandler ["ButtonClick",{
    params ["_ctrlButton"];

    disableSerialization;

    private _display = ctrlParent _ctrlButton;
    if (isNull _display) exitWith {};

    private _textArray = [];

    private _ctrlListbox = _display displayCtrl IDC_LISTBOX;
    for [{_i=0},{_i < lbSize _ctrlListbox},{_i=_i+1}] do {
        if ((_ctrlListbox lbValue _i) == 1) then {
            _textArray pushBack (_ctrlListbox lbData _i);
        };
    };

    playSound "addItemOK";
    systemChat format ["Exported %1 items.",count _textArray];
    copyToClipboard (_textArray joinString (toString [44,13,10]));
}];

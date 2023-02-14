#include "component.hpp"

#define INITIALWAITTIME     10
#define WAITTIMEOUT         60

if (!isServer) exitWith {};

private _fnc_selectWeapons = {
    GVAR(chosenWeapons) = [];
    GVAR(muzzleItems) = [];
    GVAR(scopes) = [];
    private _weaponsNeeded = EGVAR(missionSetup,killsForWin);

    ([] call FUNC(getAllAvailableWeapons)) params ["_availableRifles","_availablePistols"];

    private _numberOfPistols = (round (_weaponsNeeded / 5)) min 6;
    for "_i" from 1 to (_weaponsNeeded - _numberOfPistols) do {
        GVAR(chosenWeapons) pushBack selectRandom _availableRifles;
    };
    for "_j" from 1 to _numberOfPistols do {
        GVAR(chosenWeapons) pushBack selectRandom _availablePistols;
    };

    // CHOOSE MUZZLE ATTACHMENTS ===================================================
    private _muzzleAttachmentProb = [missionConfigFile >> "cfgMission","muzzleAttachmentProbability",40] call BIS_fnc_returnConfigEntry;
    {
        if (random 100 <= _muzzleAttachmentProb) then {
            _weapon = _x;
            _cfg = (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
            _allMuzzleItems = getArray _cfg;

            //RHS is stupid
            if (count _allMuzzleItems == 0) then {
                _attributes = configProperties [_cfg, "true", true];
                {
                    _str = str (_x);
                    _strArray = _str splitString "/";
                    _attachmentName = _strArray select ((count _strArray) - 1);
                    if ((getNumber (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems" >> _attachmentName)) == 1) then {
                        _allMuzzleItems pushBack _attachmentName;
                    };
                } forEach _attributes;
            };

            if (count _allMuzzleItems == 0) then {
                GVAR(muzzleItems) pushBack "EMPTY";
            } else {
                _muzzleItem = selectRandom _allMuzzleItems;
                GVAR(muzzleItems) pushBack _muzzleItem;
            };

        } else {
            GVAR(muzzleItems) pushBack "EMPTY";
        };
    } forEach GVAR(chosenWeapons);

    // CHOOSE GVAR(scopes) ===============================================================
    private _scopesProb = [missionConfigFile >> "cfgMission","scopesProbability",60] call BIS_fnc_returnConfigEntry;
    {
        private _weapon = _x;
        private _probability = _scopesProb;
        if ([_weapon] call FUNC(isSniper)) then {_probability = 100};

        if (random 100 <= _probability) then {
            _attributes = configProperties [(configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems"),"true",true];
            _compatibleScopes = [];

            {
                _str = str (_x);
                _strArray = _str splitString "/";
                _scopeName = _strArray select ((count _strArray) -1);
                _compatibleScopes pushBack _scopeName;
            } forEach _attributes;

            if (count _compatibleScopes == 0) then {
                _compatibleScopes = getArray (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
            };

            _compatibleScopes = [_compatibleScopes] call FUNC(filterNvScopes);

            if (count _compatibleScopes > 0) then {
                GVAR(scopes) pushBack selectRandom _compatibleScopes;
            } else {
                GVAR(scopes) pushBack "EMPTY";
            };

        } else {
            GVAR(scopes) pushBack "EMPTY";
        };
    } forEach GVAR(chosenWeapons);

    //GAME MODE ====================================================================
    switch ("GameMode" call BIS_fnc_getParamValue) do {
        case 0: {};
        case 1: {
            reverse GVAR(chosenWeapons);
            reverse GVAR(muzzleItems);
            reverse GVAR(scopes);
        };
        case 2: {
            [GVAR(chosenWeapons), GVAR(muzzleItems), GVAR(scopes)] call mcd_fnc_randomizeArrays;
        };
    };

    //BROADCAST ================================================================
    publicVariable QGVAR(chosenWeapons);
    publicVariable QGVAR(muzzleItems);
    publicVariable QGVAR(scopes);

    //LOG ======================================================================
    INFO("Weapons selected:");
    {
        _muzzle = GVAR(muzzleItems) param [_forEachIndex,""];
        _scope = GVAR(scopes) param [_forEachIndex,""];
        INFO_3("%1, %2, %3",_x,_muzzle,_scope);
    } forEach GVAR(chosenWeapons);

    // COMPLETE ================================================================
    missionNamespace setVariable [QGVAR(selectWeaponsComplete),true,true];
};

[{
    [{count allPlayers >= GVAR(receivedDlcsCount)},_this,[],WAITTIMEOUT,_this] call CBA_fnc_waitUntilAndExecute;
},_fnc_selectWeapons,INITIALWAITTIME] call CBA_fnc_waitAndExecute;

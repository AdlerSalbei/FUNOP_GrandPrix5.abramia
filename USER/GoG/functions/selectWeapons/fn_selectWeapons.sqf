#include "component.hpp"

#define INITIALWAITTIME     10
#define WAITTIMEOUT         60

if (!isServer) exitWith {};

private _fnc_selectWeapons = {
    grad_grandprix_gog_receivedDlcsCount = [];
    grad_grandprix_gog_muzzleItems = [];
    grad_grandprix_gog_scopes = [];
    private _weaponsNeeded = grad_grandprix_gog_killsForWin;

    ([] call FUNC(getAllAvailableWeapons)) params ["_availableRifles","_availablePistols"];

    private _numberOfPistols = (round (_weaponsNeeded / 5)) min 6;
    for "_i" from 1 to (_weaponsNeeded - _numberOfPistols) do {
        grad_grandprix_gog_receivedDlcsCount pushBack selectRandom _availableRifles;
    };
    for "_j" from 1 to _numberOfPistols do {
        grad_grandprix_gog_receivedDlcsCount pushBack selectRandom _availablePistols;
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
                grad_grandprix_gog_muzzleItems pushBack "EMPTY";
            } else {
                _muzzleItem = selectRandom _allMuzzleItems;
                grad_grandprix_gog_muzzleItems pushBack _muzzleItem;
            };

        } else {
            grad_grandprix_gog_muzzleItems pushBack "EMPTY";
        };
    } forEach grad_grandprix_gog_receivedDlcsCount;

    // CHOOSE grad_grandprix_gog_scopes ===============================================================
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
                grad_grandprix_gog_scopes pushBack selectRandom _compatibleScopes;
            } else {
                grad_grandprix_gog_scopes pushBack "EMPTY";
            };

        } else {
            grad_grandprix_gog_scopes pushBack "EMPTY";
        };
    } forEach grad_grandprix_gog_receivedDlcsCount;

    //GAME MODE ====================================================================
    switch ("GameMode" call BIS_fnc_getParamValue) do {
        case 0: {};
        case 1: {
            reverse grad_grandprix_gog_receivedDlcsCount;
            reverse grad_grandprix_gog_muzzleItems;
            reverse grad_grandprix_gog_scopes;
        };
        case 2: {
            [grad_grandprix_gog_receivedDlcsCount, grad_grandprix_gog_muzzleItems, grad_grandprix_gog_scopes] call mcd_fnc_randomizeArrays;
        };
    };

    //BROADCAST ================================================================
    publicVariable "grad_grandprix_gog_chosenWeapons";
    publicVariable "grad_grandprix_gog_muzzleItems";
    publicVariable "grad_grandprix_gog_scopes";

    //LOG ======================================================================
    INFO("Weapons selected:");
    {
        _muzzle = grad_grandprix_gog_muzzleItems param [_forEachIndex,""];
        _scope = grad_grandprix_gog_scopes param [_forEachIndex,""];
        INFO_3("%1, %2, %3",_x,_muzzle,_scope);
    } forEach grad_grandprix_gog_receivedDlcsCount;

    // COMPLETE ================================================================
    missionNamespace setVariable ["grad_grandprix_gog_selectWeaponsComplete",true,true];
};

[{
    [{count allPlayers >= grad_grandprix_gog_receivedDlcsCount},_this,[],WAITTIMEOUT,_this] call CBA_fnc_waitUntilAndExecute;
},_fnc_selectWeapons,INITIALWAITTIME] call CBA_fnc_waitAndExecute;

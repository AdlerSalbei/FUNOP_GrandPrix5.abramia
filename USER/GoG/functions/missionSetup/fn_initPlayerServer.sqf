#include "component.hpp"

params ["_unit"];

systemChat "Init Server Player";

_unit setVariable ["grad_grandprix_gog_isPlaying", true, true];
_unit setVariable ["grad_grandprix_gog_kills", 0, true];
_unit setVariable ["grad_grandprix_gog_deaths", 0, true];
_unit setVariable ["grad_grandprix_gog_longestKill", 0, true];
_unit setVariable ["grad_grandprix_gog_eloThisGame", 0, true];
_unit setVariable ["grad_grandprix_gog_currentScore", 0, true];
_unit setVariable ["grad_grandprix_gog_radioInstance", format ["TFAR_anprc152_%1", _forEachIndex + 1], true];

private _allCfgWeapons = "(getNumber (_x >> 'scope')) == 2" configClasses (configFile >> "cfgWeapons");
private _allAvailableUniforms = [];

{
    if (
        _x isKindOf ["Uniform_Base", configFile >> "cfgWeapons"] &&
        // filter LOP, because they have no preview pictures -,-
        {(_x find "LOP") != 0} &&
        {[_x] call grad_grandprix_gog_fnc_hasUniformDLC}
    ) then {
        _allAvailableUniforms pushBack _x
    };
} forEach (_allCfgWeapons apply {configName _x});

_unit setVariable ["grad_grandprix_gog_playerUniform", ( selectRandom _allAvailableUniforms)];

//save UID of everyone who is playing
_playerUID = getPlayerUID _unit;
GVAR(allPlayerUIDs) pushBack _playerUID;

[] call grad_grandprix_gog_fnc_removeInitialWeapon;

// wait 10s
[{
	[] call grad_grandprix_gog_fnc_movePlayerToStartPos;
	[] remoteExec ["grad_grandprix_gog_fnc_initPlayerInPlayzone", [0, _unit] select isDedicated, false];
	[] remoteExec ["grad_grandprix_gog_fnc_initCampingProtection", [0, _unit] select isDedicated, false];

	[_unit, 0] call grad_grandprix_gog_fnc_applyWeapon;

}, [], 10] call CBA_fnc_waitAndExecute;

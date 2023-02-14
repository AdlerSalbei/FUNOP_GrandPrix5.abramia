#include "component.hpp"

params ["_unit"];

_unit setVariable [QGVAR(isPlaying), true, true];
_unit setVariable [QGVAR(kills), 0, true];
_unit setVariable [QGVAR(deaths), 0, true];
_unit setVariable [QGVAR(longestKill), 0, true];
_unit setVariable [QGVAR(eloThisGame), 0, true];
_unit setVariable [QGVAR(currentScore), 0, true];
_unit setVariable [QGVAR(radioInstance), format ["TFAR_anprc152_%1", _forEachIndex + 1], true];

private _allCfgWeapons = "(getNumber (_x >> 'scope')) == 2" configClasses (configFile >> "cfgWeapons");
private _allAvailableUniforms = [];

{
    if (
        _x isKindOf ["Uniform_Base", configFile >> "cfgWeapons"] &&
        // filter LOP, because they have no preview pictures -,-
        {(_x find "LOP") != 0} &&
        {[_x] call FUNC(hasUniformDLC)}
    ) then {
        _allAvailableUniforms pushBack _x
    };
} forEach (_allCfgWeapons apply {configName _x});

_unit setVariable [QGVAR(playerUniform), ( selectRandom _allAvailableUniforms)];

//save UID of everyone who is playing
_playerUID = getPlayerUID _unit;
GVAR(allPlayerUIDs) pushBack _playerUID;

[] call FUNC(removeInitialWeapon);

// wait 10s
[{
	[] call FUNC(movePlayerToStartPos);
	[] remoteExec [QFUNC(initPlayerInPlayzone), _unit, false];
	[] remoteExec [QFUNC(initCampingProtection), _unit, false];

	[_unit, 0] call FUNC(applyWeapon);

}, [], 10] call CBA_fnc_waitAndExecute;

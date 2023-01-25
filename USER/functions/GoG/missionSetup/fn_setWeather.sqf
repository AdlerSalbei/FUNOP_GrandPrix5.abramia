#include "component.hpp"

params ["_timeOfDay"];

//OVERCAST =====================================================================
private _overcast = 0;
private _weatherSetting = "WeatherSetting" call BIS_fnc_getParamValue;

//random
if (_weatherSetting == -1) then {
    _availableSettings = getArray (missionConfigFile >> "Params" >> "WeatherSetting" >> "values");
    _availableSettings = _availableSettings - [-1];
    _overcast = selectRandom _availableSettings;

//fixed
} else {
    _overcast = _weatherSetting;
};

INFO_1("Setting overcast to %1.", _overcast);
[_overcast * 0.01] call bis_fnc_setOvercast;

//FOG ==========================================================================
private _mid = 0.03;
//extra chance of fog when its raining
if (_overcast >= 75) then {
    _mid = _mid + 0.08;
};
//extra chance of fog in the morning
if (_timeOfDay <= 8) then {
    _mid = _mid + 0.12;
};

private _fog = random [0,_mid,0.4];

INFO_1("Setting fog to %1.", _fog);

0 setFog _fog;

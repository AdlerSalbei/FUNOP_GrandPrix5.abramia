#include "component.hpp"

private _timeOfDay = "TimeOfDay" call BIS_fnc_getParamValue;

//random
if (_timeOfDay == 1000) then {
    _availableSettings = getArray (missionConfigFile >> "Params" >> "TimeOfDay" >> "values");
    _availableSettings = _availableSettings - [1000];
    _timeOfDay = selectRandom _availableSettings;
};

INFO_1("Setting time to %1:00",_timeOfDay);

[[2015, 2, 5, _timeOfDay, 0]] call bis_fnc_setDate;

_timeOfDay

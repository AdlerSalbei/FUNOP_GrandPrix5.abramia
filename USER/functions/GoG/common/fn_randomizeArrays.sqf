/*  Randomizes (multiple) arrays synchronously
*
*/

if (count (_this select 0) <= 1) exitWith {};

//check if all arrays have same number of elements
_numberOfElements = count (_this select 0);
_theyAreTheSameBrah = true;
{
  if (count _x != _numberOfElements) exitWith {_theyAreTheSameBrah = false};
} forEach _this;
if (!_theyAreTheSameBrah) exitWith {diag_log "fn_randomizeArrays - Arrays are not the same length."};

//temp copy of arrays
{
  _temptempArray = +_x;
  _variableName = format ["_tempArray%1", _forEachIndex];
  missionNamespace setVariable [_variableName, _temptempArray];
} forEach _this;

//empty original arrays
{
  _x resize 0;
} forEach _this;

//fill original arrays
for [{_i=0}, {_i<_numberOfElements}, {_i=_i+1}] do {
  _rndID = round random ((count (missionNameSpace getVariable "_tempArray0"))-1);
  {
    _variableName = format ["_tempArray%1", _forEachIndex];
    _temptempArray = missionNamespace getVariable _variableName;
    _x pushBack (_temptempArray select _rndID);
    _temptempArray deleteAt _rndID;
  } forEach _this;
};

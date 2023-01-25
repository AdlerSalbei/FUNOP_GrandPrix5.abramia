/*  Finds greatest number in array
*
*   Params:
*   0:  Array
*
*   Returns:
*   index of greatest element
*   -1 if no single greatest element found
*/

params ["_array"];

private _max = -999999;
private _maxID = -1;
for [{_i=0}, {_i<(count _array)}, {_i=_i+1}] do {
    _element = _array select _i;
    if (typeName _element == "SCALAR") then {
        if (_element == _max) then {
            _maxID = -1;
        };
        if (_element > _max) then {
            _max = _element;
            _maxID = _i;
        };
    };
};

_maxID

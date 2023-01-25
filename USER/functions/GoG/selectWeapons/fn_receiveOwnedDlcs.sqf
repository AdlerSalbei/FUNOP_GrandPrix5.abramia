#include "component.hpp"

params [["_ownedDlcs",[]]];

if (isNil QGVAR(allPlayerOwnedDlcsIntersect)) then {
    GVAR(allPlayerOwnedDlcsIntersect) = _ownedDlcs;
} else {
    GVAR(allPlayerOwnedDlcsIntersect) = GVAR(allPlayerOwnedDlcsIntersect) arrayIntersect _ownedDlcs;
};

GVAR(receivedDlcsCount) = (missionNamespace getVariable [QGVAR(receivedDlcsCount),0]) + 1;

#include "component.hpp"

params [["_ownedDlcs",[]]];

if (isNil "grad_grandprix_gog_allPlayerOwnedDlcsIntersect") then {
    GVAR(allPlayerOwnedDlcsIntersect) = _ownedDlcs;
} else {
    GVAR(allPlayerOwnedDlcsIntersect) = GVAR(allPlayerOwnedDlcsIntersect) arrayIntersect _ownedDlcs;
};

GVAR(receivedDlcsCount) = (missionNamespace getVariable ["grad_grandprix_gog_receivedDlcsCount",0]) + 1;

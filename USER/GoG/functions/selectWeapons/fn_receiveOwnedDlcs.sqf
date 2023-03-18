#include "component.hpp"

params [["_ownedDlcs",[]]];

if (isNil "grad_grandprix_gog_allPlayerOwnedDlcsIntersect") then {
    grad_grandprix_gog_allPlayerOwnedDlcsIntersect = _ownedDlcs;
} else {
    grad_grandprix_gog_allPlayerOwnedDlcsIntersect = grad_grandprix_gog_allPlayerOwnedDlcsIntersect arrayIntersect _ownedDlcs;
};

grad_grandprix_gog_receivedDlcsCount = (missionNamespace getVariable ["grad_grandprix_gog_receivedDlcsCount",0]) + 1;

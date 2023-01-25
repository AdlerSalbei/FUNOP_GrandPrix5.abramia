#include "component.hpp"
#define OWNED_DLCS      1

if (!hasInterface) exitWith {};

[getDLCs OWNED_DLCS] remoteExecCall [QFUNC(receiveOwnedDlcs),2,false];

#include "component.hpp"

GVAR(statsArray) = profileNameSpace getVariable "mcd_gameofguns_stats";

if (isNil QGVAR(statsArray)) then {
	profileNameSpace setVariable ["mcd_gameofguns_stats", []];
	GVAR(statsArray) = profileNameSpace getVariable "mcd_gameofguns_stats";

	INFO("STATS NOT FOUND ON SERVER. STATS ARRAY HAS BEEN CREATED IN PROFILENAMESPACE.");
};

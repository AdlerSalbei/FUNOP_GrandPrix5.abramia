if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

private _sleepTimes = [];
for "_i" from 1 to 10000 step 1 do {
	// average of 10 seconds
	private _sleepTime = parseNumber ((6 + (random 9)) toFixed 1);
	_sleepTimes pushBack _sleepTime;
};

missionNamespace setVariable ["GRAD_grandPrix_rlgl_sleepTimes", _sleepTimes, true];
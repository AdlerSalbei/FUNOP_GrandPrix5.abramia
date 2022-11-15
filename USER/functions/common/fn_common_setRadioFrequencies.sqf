// has to be executed locally!

private _groupFreq = (group player) getVariable ["GRAD_grandPrix_groupFrequency", 30];
private _activeSR = [] call TFAR_fnc_activeSwRadio;

for "_i" from 1 to 8 do {
	[_activeSR, _i, _groupFreq] call TFAR_fnc_setChannelFrequency;
};
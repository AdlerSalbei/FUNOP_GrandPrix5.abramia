#define FADE_DELAY 1

params ["_playlistVarName", "_stopVariable"];

if (missionNamespace getVariable [_stopVariable, false]) exitWith {};

private _playlist = missionNamespace getVariable [_playlistVarName, []];

[
	{
		params ["_stopVariable", "_spawnHandle"];
		missionNamespace getVariable [_stopVariable, false]
	},
	{
		params ["_stopVariable", "_spawnHandle"];
		FADE_DELAY fadeMusic 0;
		[
			{
				params ["_spawnHandle"];
				
				systemChat "terminating playlist";
				playMusic "";
				terminate _spawnHandle;
				0 fadeMusic 1;
			},
			[_spawnHandle],
			FADE_DELAY
		] call CBA_fnc_waitAndExecute;
	},
	[_stopVariable, _thisScript]
] call CBA_fnc_waitUntilAndExecute;


{
	_x params ["_song", "_length", "_start"];

	0 fadeMusic 0;
	playMusic "";
	sleep 5;

	systemChat format["Now playing: '%1'", _song];
	playMusic [_song, _start];

	FADE_DELAY fadeMusic 1;

	sleep (_length + 5);	

} forEach _playlist;

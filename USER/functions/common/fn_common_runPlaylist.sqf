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

	FADE_DELAY fadeMusic 0;
	playMusic "";
	sleep FADE_DELAY + 1;

	playMusic [_song, _start];

	FADE_DELAY fadeMusic 1;

	[
		{
			params ["_song", "_start"];
			if (getMusicPlayedTime <= 0) then {
				0 fadeMusic 0;
				playMusic [_song, _start + FADE_DELAY];
				FADE_DELAY fadeMusic 1;
			};
		},
		[_song, _start],
		FADE_DELAY
	] call CBA_fnc_waitAndExecute;

	sleep (_length + 1);	

} forEach _playlist;

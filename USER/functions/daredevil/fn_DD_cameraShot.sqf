if !(hasInterface) exitWith {};

[] spawn {
	STHud_UIMode = 0;
	diwako_dui_main_toggled_off = true;

	cutText ["", "BLACK", 0.1];

	sleep 1;
		
	["Default", 0, false] call BIS_fnc_setPPeffectTemplate;

	private _filmgrain = ppEffectCreate ["FilmGrain", 2000];
	_filmgrain ppEffectEnable true;
	_filmgrain ppEffectAdjust [0.3, 0.3, 0.12, 0.12, 0.12, true];
	_filmgrain ppEffectCommit 0;

	private _camera = "camera" camCreate (getPos dd_camPos_01);
	_camera camCommand "inertia on";
	_camera camSetTarget dd_camPos_02;
	_camera cameraEffect ["internal", "back"];
	_camera camSetFov 1;
	_camera camCommit 0;
	_camera camSetTarget dd_camPos_02;
	_camera camCommit 1;

	showCinemaBorder true;

	sleep 1;

	cutText ["", "BLACK IN", 3];

	playSound "PUPS_Description";

	sleep 1;

	[ 
		parseText "<t font='Caveat' size='11' color='#8b0000'>D</t><t font='Caveat' size='11' color='#ffffff'>are</t><t font='Caveat' size='11' color='#8b0000'>D</t><t font='Caveat' size='11' color='#ffffff'>evil</t>", 
		[ 
		safezoneX + 0.3 * safezoneW, 
			safezoneY + 0.37 * safezoneH, 
			2, 
			1 
		], 
		nil, 
		3, 
		[3,1], 
		0 
	] spawn BIS_fnc_textTiles;

	sleep 4;

	for "_i" from 2 to 35 do {

		private _camNum = str _i;
		private _targetNum = str (_i +1);

		if (_i < 10) then {
			_camNum = "0" + _camNum;
		};

		if (_i < 9) then {
			_targetNum = "0" + _targetNum;
		};

		private _camPos = missionnamespace getvariable [ format ["dd_camPos_%1", _camNum], objNull];
		private _camTarget = missionnamespace getvariable [ format ["dd_camPos_%1", _targetNum], objNull];

		_camera camSetPos (getPos _camPos);
		_camera camSetTarget _camTarget;
		_camera camCommit 2;

		sleep 1.95;
	};
	_camera camSetTarget dd_camPos_01;
	_camera camCommit 1;
	_camera camSetPos (getPos dd_camPos_36);
	_camera camCommit 3;

	sleep 4;

	cutText ["", "BLACK OUT", 1];

	sleep 1;

	_filmgrain ppEffectEnable false;
	ppEffectDestroy _filmgrain;
	_camera cameraEffect ["terminate", "back"];
	camDestroy _camera;

	sleep 1;

	cutText ["", "BLACK IN", 2];

	sleep 1;

	5 fadeMusic 0;
	STHud_UIMode = 1;
	diwako_dui_main_toggled_off = false;

	sleep 5;

	playMusic "";
	0 fadeMusic 1;

	player setVariable ["GRAD_grandPrix_DD_introFin", true, true];
};
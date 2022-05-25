_pos = getPos player;
_pos set [2, (_pos#2) + 0.1];
player setPos _pos;
[ 
	{ 
		params ["_args", "_handle"];

		if ( ((player getVariable ["GRAD_grandPrix_rlgl_currentColor", 0]) == 1) || (player getVariable ["ACE_isUnconscious", false]) ) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
		};
		player setVelocity [0,0,0];
	}, 
	0, 
	[]
] call CBA_fnc_addPerFrameHandler;
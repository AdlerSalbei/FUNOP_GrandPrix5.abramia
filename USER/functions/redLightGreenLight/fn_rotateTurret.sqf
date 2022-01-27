params ["_turret"];

private _pos = getPos _turret;
private _viewPositions = [
	_pos vectorAdd [0,15,1.5], 
	_pos vectorAdd [15,15,1.5],
	_pos vectorAdd [15,0,1.5],
	_pos vectorAdd [15,-15,1.5],
	_pos vectorAdd [0,-15,1.5],
	_pos vectorAdd [-15,-15,1.5],
	_pos vectorAdd [-15,0,1.5],
	_pos vectorAdd [-15,15,1.5]
];

[{
	params ["_args", "_handle"];
	_args params ["_turret", "_viewPositions"];
	
	private _nextView = _turret getVariable ["grandprix_nextViewPos", 0];
	_nextView = _nextView +1;
	
	if (_nextView > 3) then {
		_nextView = 0;
	};

	_turret setVariable ["grandprix_nextViewPos", _nextView];
	
	_turret doWatch (_viewPositions select _nextView);
}, 5, [_turret, _viewPositions]] call CBA_fnc_addPerFrameHandler;

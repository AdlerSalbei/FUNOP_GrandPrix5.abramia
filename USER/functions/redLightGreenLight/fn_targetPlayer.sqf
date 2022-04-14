params ["_turrets", "_players"];

private _handle = [{
	params ["_args", "_handle"];
	_args params ["_turrets", "_players"];

	{
		private _turret = _x;
		private _playersInArea = _players inArea [(getPos _turret), 50, 50, 0, false];

		{
			private _intersects = lineIntersects [aimPos _turret,  eyePos _x, _turret, _x];

			if (count _intersects <= 0 ) then {
				_turret doWatch _x;
				 [_turret] call grad_user_fnc_burstFire;
			};
		}forEach _playersInArea;
	}forEach _turrets;
	
},[_turrets, _players], 0.5] call CBA_fnc_addPerFrameHandler;
// removeAllWeapons this;
// this addWeapon "GrandPrix_srifle_LRR_F";
// this addWeaponItem ["GrandPrix_srifle_LRR_F", "1000Rnd_408_Mag"];

player addEventHandler ["Fired", { 
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

	private _shotsFired = player getVariable ["GRAD_grandPrix_PUPS_shotsFired", 0];
	_shotsFired = _shotsFired + 1;
	player setVariable ["GRAD_grandPrix_PUPS_shotsFired", _shotsFired];

	private _vel = velocity player;
	if ((abs (_vel#0) > 0.1) || (abs (_vel#1) > 0.1) || (abs (_vel#2) > 0.1)) exitWith {};
	
	player setVariable ["GRAD_grandPrix_PUPS_isFlying", true];

	private _initPos = getPosASL player;
	player attachTo [_projectile, [0,0,0]];

	private _handle = 
	[ 
		{ 
			_args params ["_projectile", "_initPos"];
			
			if (!(alive _projectile) || !(player in (attachedObjects _projectile))) exitWith {
				[_handle] call CBA_fnc_removePerFrameHandler;
				[
					{
						params ["_initPos"];
						if (((getPosASL player)#2 <= 0) || underwater player) then {
							player setPosAsl _initPos;
						} else {
							player setVariable ["GRAD_grandPrix_PUPS_movementCenter", getPosASL player];
						};
						player setVariable ["GRAD_grandPrix_PUPS_isFlying", false];
					},
					[_initPos],
					0.5
				] call CBA_fnc_waitAndExecute;
			}; 
			
			private _playerPos = getPosASL player;
			if ((_playerPos#2 <= 0) || underwater player) exitWith {
				detach player;
				player setPosAsl _initPos;
				[_handle] call CBA_fnc_removePerFrameHandler;
				player setVariable ["GRAD_grandPrix_PUPS_isFlying", false];
			};
		}, 
		0, 
		[_projectile, _initPos] 
	] call CBA_fnc_addPerFrameHandler;
}];
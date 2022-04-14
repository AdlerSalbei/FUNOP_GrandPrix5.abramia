// removeAllWeapons this;
// this addWeapon "GrandPrix_srifle_LRR_F";
// this addWeaponItem ["GrandPrix_srifle_LRR_F", "1000Rnd_408_Mag"];

private _handle =
player addEventHandler ["Fired", { 
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

	private _shotsFired = player getVariable ["GRAD_grandPrix_PUPS_shotsFired", 0];
	_shotsFired = _shotsFired + 1;
	player setVariable ["GRAD_grandPrix_PUPS_shotsFired", _shotsFired, true];

	private _vel = velocity player;
	if ((abs (_vel#0) > 0.01) || (abs (_vel#1) > 0.01) || (abs (_vel#2) > 0.01)) exitWith {};
	
	player setVariable ["GRAD_grandPrix_PUPS_isFlying", true];

	private _initPos = getPosASL player;
	player attachTo [_projectile, [0,-0.3,0]];
	private _initalVec = player weaponDirection (currentWeapon player);
	private _initialAngle = [_initalVec, [_initalVec#0, _initalVec#1, 0]] call grad_grandPrix_fnc_PUPS_angleBetween3dVectors;

	private _handle = 
	[ 
		{ 
			_args params ["_projectile", "_initPos", "_initalVec", "_initialAngle"];
			
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
						[player getVariable ["GRAD_grandPrix_PUPS_currentTarget", objNull], 5] call grad_grandPrix_fnc_PUPS_handleIndicator;
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
				[player getVariable ["GRAD_grandPrix_PUPS_currentTarget", objNull], 5] call grad_grandPrix_fnc_PUPS_handleIndicator;
			};

			private _vel1 = velocity _projectile;
			private _vel2 = [_vel1#0, _vel1#1, 0];
			private _pitchAngle = [_vel1, _vel2] call grad_grandPrix_fnc_PUPS_angleBetween3dVectors;
			_pitchAngle = _pitchAngle - _initialAngle;

			// systemChat format ["angle: %1° | _initialAngle: %2 | vel: %3", _pitchAngle, _initialAngle, _vel1];
			[player, [_pitchAngle, 0, 0]] call grad_grandPrix_fnc_PUPS_setPitchBankYaw;
		}, 
		0, 
		[_projectile, _initPos, _initalVec, _initialAngle] 
	] call CBA_fnc_addPerFrameHandler;
}];

_handle
params ["_vehicle"];

waitUntil { (_vehicle getVariable ["GRAD_grandPrix_water_currentVolume", 5500]) < 5250 };

diag_log "starting leakage-handler";

private _tanks = _vehicle getVariable ["GRAD_grandPrix_attachedWaterTanks", []];
_tanks params ["_tankFront", "_tankBack"];

private _streamFront = "#particlesource" createVehicleLocal [0,0,0];
_streamFront attachTo [_tankFront, [1.2,0,-0.56]];

private _streamBack = "#particlesource" createVehicleLocal [0,0,0];
_streamBack attachTo [_tankBack, [1.2,0,-0.56]];

// dynamically adjust leakage
[
	{
		params ["_args", "_handle"];
		_args params ["_vehicle", "_tankFront", "_tankBack", "_streamFront", "_streamBack"];
		private _waterLevel = _vehicle getVariable ["GRAD_grandPrix_water_currentVolume", 5500];
		private _leakageParams = _vehicle getVariable ["GRAD_grandPrix_water_leakageParams", [1, [0.05,0.2], 0.1]];
		_leakageParams params ["_moveVelocityFactor", "_size", "_dropInterval"];
		
		if (_waterLevel <= 0) exitWith {
			deleteVehicle _streamFront;
			deleteVehicle _streamBack;
			[_handle] call CBA_fnc_removePerFrameHandler;
		};

		// private _vel = velocity _vehicle;
		private _dir = vectorDir _vehicle;

		if (_waterLevel < 5000) then {
			_moveVelocityFactor = 1.5;
			_size = [0.07, 0.25];
			_dropInterval = 0.05;
		};

		if (_waterLevel < 3000) then {
			_moveVelocityFactor = 2;
			_size = [0.075, 0.26];
			_dropInterval = 0.01;
		};

		if (_waterLevel < 2000) then {
			_moveVelocityFactor = 2.5;
			_size = [0.08, 0.27];
			_dropInterval = 0.005;
		};

		if (_waterLevel < 1000) then {
			_moveVelocityFactor = 3;
			_size = [0.85, 0.28];
			_dropInterval = 0.001;
		};		

		if (_waterLevel < 4000) then {
			
			// private _backVelocity = [(_vel#0) * -1, (_vel#1) * -1, _vel#2];
			private _dirBack = [(_dir#0) * -1, (_dir#1) * -1, _dir#2 *-1];

			_streamBack setParticleParams [
			/*shapeName*/					["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],
			/*animationName*/				"",
			/*particleType*/				"BillBoard",
			/*timerPeriod*/					1,
			/*lifeTime*/					3,
			/*position*/					[0,0,0],
			/*moveVelocity*/				_dirBack vectorMultiply _moveVelocityFactor,
			/*rotationVelocity*/			0,
			/*weight*/						1.5,
			/*volume*/						1,
			/*rubbing*/						0.1,
			/*size*/						_size,
			/*color*/						[[0.678,0.847,0.902,0.3], [0.678,0.847,0.902,0.7]],
			/*animationSpeed*/				[1],
			/*randomDirectionPeriod*/		1,
			/*randomDirectionIntensity*/	0,
			/*onTimerScript*/				"",
			/*beforeDestroyScript*/			"",
			/*object*/						_streamBack,
			/*angle*/						0,
			/*onSurface*/					true,
			/*bounceOnSurface*/				0
			];

			if ((player distance _vehicle) >= 250) then {
				_dropInterval = 600;
			};
			_streamBack setDropInterval _dropInterval;			
		};

		_streamFront setParticleParams [
		/*shapeName*/					["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],
		/*animationName*/				"",
		/*particleType*/				"BillBoard",
		/*timerPeriod*/					1,
		/*lifeTime*/					3,
		/*position*/					[0,0,0],
		/*moveVelocity*/				_dir vectorMultiply _moveVelocityFactor,
		/*rotationVelocity*/			0,
		/*weight*/						1.5,
		/*volume*/						1,
		/*rubbing*/						0.1,
		/*size*/						_size,
		/*color*/						[[0.678,0.847,0.902,0.3], [0.678,0.847,0.902,0.7]],
		/*animationSpeed*/				[1],
		/*randomDirectionPeriod*/		1,
		/*randomDirectionIntensity*/	0,
		/*onTimerScript*/				"",
		/*beforeDestroyScript*/			"",
		/*object*/						_streamFront,
		/*angle*/						0,
		/*onSurface*/					true,
		/*bounceOnSurface*/				0
		];

		if ((player distance _vehicle) >= 250) then {
			_dropInterval = 600;
		};
		_streamFront setDropInterval _dropInterval;
	},
	0.3,
	[_vehicle, _tankFront, _tankBack, _streamFront, _streamBack]
] call CBA_fnc_addPerFrameHandler;
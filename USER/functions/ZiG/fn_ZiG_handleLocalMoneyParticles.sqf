// has to be run on client, to drop money-particles!

// wait for planes to exist
waitUntil { ((missionNamespace getVariable ["GRAD_grandPrix_ZiG_moneyDropPlanes", []]) isNotEqualTo []) };
(missionNamespace getVariable ["GRAD_grandPrix_ZiG_moneyDropPlanes", []]) params ["_planes", "_drones"];

// wait for existing planes to enter drop-zone
waitUntil { (_planes # 2) inArea GRAD_grandPrix_ZiG_startDrop };

{
	private _test = "#particlesource" createVehicleLocal [0,0,0];
	_test attachTo [_x, [0,0,0]];
	_test setParticleParams [
	/*shapeName*/					["\mdl\obj\9.p3d",1,0,1],
	/*animationName*/				"",
	/*particleType*/				"SpaceObject",
	/*timerPeriod*/					1,
	/*lifeTime*/					29,
	/*position*/					[0,0,0],
	/*moveVelocity*/				[0,0,-0.5],
	/*rotationVelocity*/			5,
	/*weight*/						1.335,
	/*volume*/						1,
	/*rubbing*/						0.5,
	/*size*/						[1],
	/*color*/						[[1,1,1,1], [1,1,1,1]],
	/*animationSpeed*/				[1],
	/*randomDirectionPeriod*/		0.01,
	/*randomDirectionIntensity*/	0.05,
	/*onTimerScript*/				"",
	/*beforeDestroyScript*/			"",
	/*object*/						_test,
	/*angle*/						0,
	/*onSurface*/					false,
	/*bounceOnSurface*/				0
	];

	_test setParticleRandom [
	/* LifeTime */			0,
	/* Position */			[2,2,1],
	/* MoveVelocity */		[10,10,-1],
	/* rotationVel */		5,
	/* Scale */				0,
	/* Color */				[0,0,0,0],
	/* randDirPeriod */		0.01,
	/* randDirIntensity */	0.05,
	/* Angle */				10
	];

	_test setDropInterval 0.02;		
} forEach _drones;
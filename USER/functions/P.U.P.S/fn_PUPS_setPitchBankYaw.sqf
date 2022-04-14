params ["_object", "_rotations", ["_inital", [[0,0,0], [0,0,0]]]];

private ["_aroundX","_aroundY","_aroundZ","_dirX","_dirY","_dirZ","_upX","_upY","_upZ","_dir","_up","_dirXTemp", "_upXTemp"];
_aroundX = _rotations select 0;
_aroundY = _rotations select 1;
_aroundZ = (360 - (_rotations select 2)) - 360;
_dirX = 0;
_dirY = 1;
_dirZ = 0;
_upX = 0;
_upY = 0;
_upZ = 1;
if (_aroundX != 0) then { 
	_dirY = cos _aroundX;
	_dirZ = sin _aroundX;
	_upY = -sin _aroundX;
	_upZ = cos _aroundX;
};
if (_aroundY != 0) then { 
	_dirX = _dirZ * sin _aroundY;
	_dirZ = _dirZ * cos _aroundY;
	_upX = _upZ * sin _aroundY;
	_upZ = _upZ * cos _aroundY;
};
if (_aroundZ != 0) then { 
	_dirXTemp = _dirX;
	_dirX = (_dirXTemp* cos _aroundZ) - (_dirY * sin _aroundZ);
	_dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);
	_upXTemp = _upX;
	_upX = (_upXTemp * cos _aroundZ) - (_upY * sin _aroundZ);
	_upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ);
};
_inital params ["_vecDir", "_vecUp"];
_dir = [_dirX - _vecDir#0, _dirY - _vecDir#1, _dirZ - _vecDir#2];
_up = [_upX - _vecUp#0, _upY - _vecUp#1, _upZ - _vecUp#2];
_object setVectorDirAndUp [_dir,_up];
// systemChat format ["set to %1°", _aroundX];
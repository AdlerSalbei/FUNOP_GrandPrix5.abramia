private _polygon = [];
private _polygonMarkerStart = 1; 
private _polygonMarkerEnd = 217; 
for "_i" from _polygonMarkerStart to _polygonMarkerEnd do   
{   
	private _marker = call(compile format ["GRAD_grandPrix_race_carPolygon_%1",_i]); 
	private _pos = getPos _marker;
	_pos set [2, 0];
	_polygon pushBack _pos;
};

private _roadMap = createHashMap;
private _startRoad = roadAt [4959.13,4424.74,0];
private _currentRoad = _startRoad;
private _currentRoadPos = getPos _currentRoad;
private _increment = 1;
_roadMap set [_currentRoadPos, 1];
_currentRoadPos set [2, 0];

// triggers with roads to ignore
private _exclusionAreas = [grad_grandPrix_race_roadExclusion_1];

while { _currentRoadPos inPolygon _polygon } do {
	_increment = _increment + 1;
	private _connected = (roadsConnectedTo _currentRoad) select { !((getPos _x) in _roadMap) };
	{
		private _area = _x;
		_connected = _connected select { !((getPos _x) inArea _area) };
	} forEach _exclusionAreas;
	switch (count _connected) do {
		case 1: {
			_currentRoad = _connected # 0;
			_currentRoadPos = getPos _currentRoad;
			_roadMap set [_currentRoadPos, _increment];
		};
		default {
			private _correctRoad = _connected select { count ((roadsConnectedTo _x) select { !((getPos _x) in _roadMap) }) > 0 };

			if (count _correctRoad > 1) exitWith { _currentRoadPos = [0,0,0] };

			_currentRoad = _correctRoad # 0;
			_currentRoadPos = getPos _currentRoad;
			_roadMap set [_currentRoadPos, _increment];			
		};
	};
};

missionNamespace setVariable ["GRAD_grandPrix_race_roadMap", _roadMap, true];
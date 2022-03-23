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

private _pos = getPos player;
_pos set [2, 0];
private _polyCondition = !(_pos inPolygon _polygon);
private _speedCondition = (abs (speed player)) < 1;
private _vecCondition = ((vectorUp player) # 2) < 0;

_polyCondition || (_speedCondition && _vecCondition)
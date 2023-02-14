#include "component.hpp"

private _wallCounter = 0;
private _pi = 3.1415;
private _wallX = 4;
private _step = (360 * _wallX) / (2 * _pi * grad_grandprix_gog_playAreaSize);
private _maxDegree = (360 + _step * (grad_grandprix_gog_playAreaSize / 230));

diag_log format ["Center: %1, PlayArea: %2", grad_grandprix_gog_playAreaCenter, grad_grandprix_gog_playAreaSize];

for [{_i=1},{_i<=_maxDegree},{_i=_i+_step}] do {
  _pos = grad_grandprix_gog_playAreaCenter getPos [grad_grandprix_gog_playAreaSize, _i];

  _wall = createVehicle ["Land_Mil_WallBig_4m_F", _pos,[],0,"CAN_COLLIDE"];
  _wall setDir _i;
  _wall enableSimulationGlobal false;

  _wallCounter = _wallCounter + 1;
};

INFO_2("Playareasize is %1. %2 wall segments created.", grad_grandprix_gog_playAreaSize, _wallCounter);

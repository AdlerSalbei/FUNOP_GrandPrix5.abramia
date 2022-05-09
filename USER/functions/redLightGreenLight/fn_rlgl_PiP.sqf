fnc_resizePIP = { 
 
_dispPos = [ _this, 0, [ 0, 0 ], [ [] ], [ 2 ] ] call BIS_fnc_param; 
_scale = [ _this, 1, 1, [ 0 ] ] call BIS_fnc_param; 
 
 
_display = uiNamespace getVariable "BIS_fnc_PIP_RscPIP"; 
_basePos = ctrlPosition ( _display displayCtrl 2300 ); 
_baseScale = ctrlScale ( _display displayCtrl 2300 ); 
_scaleDiff = _scale / _baseScale; 
{ 
 _ctrl = _x; 
 _pos = ctrlPosition _ctrl; 
 _pos resize 2; 
 { 
  _diff = _x - ( _basePos select _forEachIndex ); 
  _newpos = ( _dispPos select _forEachIndex ) + ( _diff * _scaleDiff ); 
  _pos set [ _forEachIndex, _newpos ]; 
 }forEach _pos; 
 _ctrl ctrlSetPosition _pos; 
 _ctrl ctrlSetScale _scale; 
 _ctrl ctrlCommit 0; 
}forEach allControls _display; 
};

cam = ["rendertarget0", [[GRAD_grandPrix_rlgl_cam, [0,0,0]], GRAD_grandPrix_rlgl_camTarget], test, true] call BIS_fnc_PIP;
cam camCommit 0;

[[safezoneX + safezoneW - 0.45, safezoneY + safezoneH - 0.5], 2 ] call fnc_resizePIP;
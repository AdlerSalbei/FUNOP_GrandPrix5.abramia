#include "IDCmacros.hpp"

params [["_scale", 2]];

//function to display the turret-cam
_fnc_resizePIP = { 
 
    params ["_dispPos", "_scale"];
 
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
    } forEach _pos; 
        _ctrl ctrlSetPosition _pos; 
        _ctrl ctrlSetScale _scale; 
        _ctrl ctrlCommit 0; 
    } forEach allControls _display; 
};

// show PiP cam
_cam = ["rendertarget0", [[GRAD_grandPrix_rlgl_cam, [0,0,0]], GRAD_grandPrix_rlgl_camTarget], GRAD_grandPrix_rlgl_gun, true] call BIS_fnc_PIP;
_cam camCommit 0;
player setVariable ["GRAD_grandPrix_rlgl_cam", _cam];
// adjust size
[[safezoneX + safezoneW - GRID_W*43, safezoneY + safezoneH - GRID_H*31], 2 ] call _fnc_resizePIP;


//controls that display the color strip
private _display = uiNamespace getVariable "BIS_fnc_PIP_RscPIP";

private _ctrlRed = _display ctrlCreate ["ctrlStatic", 1337];
_ctrlRed ctrlSetPosition [safezoneX + safezoneW - GRID_W*45.3 - COLOR_WIDTH, safezoneY + safezoneH - GRID_H*31, COLOR_WIDTH, COLOR_HEIGHT];
_ctrlRed ctrlSetBackgroundColor RED;
_ctrlRed ctrlCommit 0;
player setVariable ["GRAD_grandPrix_rlgl_ctrlRed", _ctrlRed];

private _ctrlGreen = _display ctrlCreate ["ctrlStatic", 1338];
_ctrlGreen ctrlSetPosition [safezoneX + safezoneW - GRID_W*45.3 - COLOR_WIDTH, safezoneY + safezoneH - GRID_H*31 + COLOR_HEIGHT, COLOR_WIDTH, COLOR_HEIGHT];
_ctrlGreen ctrlSetBackgroundColor GREEN_DISABLED;
_ctrlGreen ctrlCommit 0;
player setVariable ["GRAD_grandPrix_rlgl_ctrlGreen", _ctrlGreen];

//EHs to change the color strip
private _redID = 
[
    "GRAD_rlgl_toggleRed",
    {
        private _display = uiNamespace getVariable "BIS_fnc_PIP_RscPIP";
        private _ctrlRed = (player getVariable ["GRAD_grandPrix_rlgl_ctrlRed", -1]);
        private _ctrlGreen = (player getVariable ["GRAD_grandPrix_rlgl_ctrlGreen", -1]);
        
        _ctrlGreen ctrlSetBackgroundColor GREEN_DISABLED;
        _ctrlGreen ctrlCommit 0;
        _ctrlRed ctrlSetBackgroundColor RED;
        _ctrlRed ctrlCommit 0;

        player setVariable ["GRAD_grandPrix_rlgl_currentColor", 0];
    }
] call CBA_fnc_addEventHandler;
player setVariable ["GRAD_grandPrix_rlgl_redHandler", _redID];

private _greenID = 
[
    "GRAD_rlgl_toggleGreen",
    {
        private _display = uiNamespace getVariable "BIS_fnc_PIP_RscPIP";
        private _ctrlRed = (player getVariable ["GRAD_grandPrix_rlgl_ctrlRed", -1]);
        private _ctrlGreen = (player getVariable ["GRAD_grandPrix_rlgl_ctrlGreen", -1]);
        
        _ctrlGreen ctrlSetBackgroundColor GREEN;
        _ctrlGreen ctrlCommit 0;
        _ctrlRed ctrlSetBackgroundColor RED_DISABLED;
        _ctrlRed ctrlCommit 0;

        player setVariable ["GRAD_grandPrix_rlgl_currentColor", 1];
    }
] call CBA_fnc_addEventHandler;
player setVariable ["GRAD_grandPrix_rlgl_greenHandler", _greenID];


private _endID = 
[
    "GRAD_rlgl_endPIP",
    {
        private _cam = player getVariable ["GRAD_grandPrix_rlgl_cam", objNull];
        private _greenID = player getVariable ["GRAD_grandPrix_rlgl_greenHandler", -1];
        private _redID = player getVariable ["GRAD_grandPrix_rlgl_redHandler", -1];
        private _endID = player getVariable ["GRAD_grandPrix_rlgl_endPIPHandler", -1];

        _cam cameraEffect ["TERMINATE", "BACK"];  
        camDestroy _cam;  
        ["rendertarget0"] call BIS_fnc_PIP; 

        ["GRAD_rlgl_toggleRed", _redID] call CBA_fnc_removeEventHandler;
        ["GRAD_rlgl_toggleGreen", _greenID] call CBA_fnc_removeEventHandler;
        ["GRAD_rlgl_endPIP", _endID] call CBA_fnc_removeEventHandler;
    }
] call CBA_fnc_addEventHandler;
player setVariable ["GRAD_grandPrix_rlgl_endPIPHandler", _endID];
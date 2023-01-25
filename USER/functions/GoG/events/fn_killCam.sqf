#include "component.hpp"
#include "..\..\dialog\killcam\defines.hpp"

params ["_totalTime",["_killedUnit",objNull],["_shooter",objNull]];
disableSerialization;

private _shooterName = [_shooter] call ACE_common_fnc_getName;
private _killedUnitName = [_killedUnit] call ACE_common_fnc_getName;
private _killMessage = [format ["YOU GOT KILLED BY %1", toUpper _shooterName],"YOU KILLED YOURSELF"] select (_shooterName == _killedUnitName);

private _layer = (["kcTitleLayer"] call BIS_fnc_rscLayer);
_layer cutRsc ["KillCamTitle", "PLAIN", 1];

private _display = uiNamespace getVariable ["KillCamTitle_Display",displayNull];
private _title = _display displayCtrl KILLCAMTITLE_TITLE;
_title ctrlSetText _killMessage;

private _camera = "camera" camCreate ((getPos _killedUnit) vectorAdd [0,0,2]);
_camera cameraEffect ["internal","back"];

showCinemaBorder true;
private _filmgrain = ppEffectCreate ["FilmGrain",2000];
_filmgrain ppEffectEnable true;
_filmgrain ppEffectAdjust [0.3,0.3,0.12,0.12,0.12,true];
_filmgrain ppEffectCommit 0;

_killedUnit setVariable [QGVAR(killCam), [_camera,_filmgrain]];

_camera camSetTarget _killedUnit;
_camera camSetFov 0.4;
_camera camCommit (_totalTime * 0.1);
sleep (_totalTime * 0.1);

_camera camSetTarget _shooter;
_camera camSetFov 0.2;
_camera camCommit ((_totalTime * 0.4) min 4);
sleep (_totalTime * 0.7);

cutRsc ["RscStatic", "PLAIN" , 3];
sleep (_totalTime * 0.1);

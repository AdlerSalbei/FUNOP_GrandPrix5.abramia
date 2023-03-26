// local door to reveal and hide the gun
private _pos = getPosWorld GRAD_grandPrix_rlgl_gunDoor;
private _vectors = [vectorDir GRAD_grandPrix_rlgl_gunDoor, vectorUp GRAD_grandPrix_rlgl_gunDoor];
private _door = (typeOf GRAD_grandPrix_rlgl_gunDoor) createVehicleLocal _pos;
_door setPosWorld _pos;
_door setVectorDirAndUp _vectors;
player setVariable ["GRAD_grandPrix_rlgl_door", _door];
player setVariable ["GRAD_grandPrix_rlgl_doorPos", getPosWorld _door];

player setCaptive true;

private _openID = 
[
    "GRAD_rlgl_openDoor",
    {
        private _door = player getVariable ["GRAD_grandPrix_rlgl_door", objNull];

		private _initialDoorPos = player getVariable ["GRAD_grandPrix_rlgl_doorPos", getPosWorld _door];
		private _openHandler = 
		[
			{
				_args params ["_door", "_targetPos"];
				
				_pos = getPosWorld _door;
				if (_pos#2 <= _targetPos#2) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };
				_door setPosWorld [_targetPos#0, _targetPos#1, (_pos#2) - 0.05];
			},
			0,
			[_door, [_initialDoorPos#0, _initialDoorPos#1, (_initialDoorPos#2) - 5]]
		] call CBA_fnc_addPerFrameHandler;
    }
] call CBA_fnc_addEventHandler;
player setVariable ["GRAD_grandPrix_rlgl_openHandler", _openID];

private _closeID = 
[
    "GRAD_rlgl_closeDoor",
    {
		private _door = player getVariable ["GRAD_grandPrix_rlgl_door", objNull];

		private _initialDoorPos = player getVariable ["GRAD_grandPrix_rlgl_doorPos", getPosWorld _door];
		private _openHandler = 
		[
			{
				_args params ["_door", "_targetPos"];
				
				_pos = getPosWorld _door;
				if (_pos#2 >= _targetPos#2) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };
				_door setPosWorld [_targetPos#0, _targetPos#1, (_pos#2) + 0.05];
			},
			0,
			[_door, _initialDoorPos]
		] call CBA_fnc_addPerFrameHandler;
    }
] call CBA_fnc_addEventHandler;
player setVariable ["GRAD_grandPrix_rlgl_closeHandler", _closeID];

private _endID = 
[
    "GRAD_rlgl_endDoor",
    {
        private _door = player getVariable ["GRAD_grandPrix_rlgl_door", objNull];
		private _openID = player getVariable ["GRAD_grandPrix_rlgl_openHandler", -1];
		private _closeID = player getVariable ["GRAD_grandPrix_rlgl_closeHandler", -1];
		private _endID = player getVariable ["GRAD_grandPrix_rlgl_endDoorHandler", -1];

		deleteVehicle _door;
        ["GRAD_rlgl_openDoor", _openID] call CBA_fnc_removeEventHandler;
        ["GRAD_rlgl_closeDoor", _closeID] call CBA_fnc_removeEventHandler;
        ["GRAD_rlgl_endDoor", _endID] call CBA_fnc_removeEventHandler;
    }
] call CBA_fnc_addEventHandler;
player setVariable ["GRAD_grandPrix_rlgl_endDoorHandler", _endID];
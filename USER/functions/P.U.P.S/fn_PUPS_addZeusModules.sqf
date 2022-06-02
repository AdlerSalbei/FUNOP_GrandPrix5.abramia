["GRAD Grand Prix", "PUPS teleport", {
	params ["_position", "_object"];

	systemChat "test2";

	["Teleport a participant", [
		[
			"COMBO",
			["Players", "Select the participant to teleport"],
			[
				units (missionNamespace getVariable ["GRAD_grandPrix_PUPS_currentGroup", grpNull]),
				(units (missionNamespace getVariable ["GRAD_grandPrix_PUPS_currentGroup", grpNull])) apply { name _x },
				0
			],
			true
		]], {
			params ["_dialogValues", "_args"];
			_dialogValues params ["_unit"];
			_args params ["_position"];

			_unit setVariable ["GRAD_grandPrix_PUPS_beingTeleported", true, true];
			_unit setPosASL _position;
			_unit setVariable ["GRAD_grandPrix_PUPS_movementCenter", _position];
			_unit setVariable ["GRAD_grandPrix_PUPS_beingTeleported", false, true];
		},
		{},
		[_position]
	] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;
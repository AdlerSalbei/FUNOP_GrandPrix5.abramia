if !(hasInterface) exitWith {};

cutText ["", "BLACK", 0.1];

private _handle = ["A3\Missions_F_EPA\video\A_in_intro.ogv"] spawn BIS_fnc_playVideo;

[{
	scriptDone (_this select 0)
},{
	[] call grad_grandPrix_fnc_ZiG_createMarkerLocal;

	private _pos = [grad_grandPrix_fnc_ZiG_teleport_1] call BIS_fnc_randomPosTrigger;
	_pos set [2, 0];
	player setPos _pos;
	player setDir 315;

	missionNamespace setVariable ["GRAD_grandPrix_ZiG_savedLoadout_" + getPlayerUID player, getUnitLoadout player, true];
	player setUnitLoadout [["SMG_03C_TR_black","","","FHQ_optic_AC11704",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_P07_blk_F","","","",["30Rnd_9x21_Mag",30],[],""],["UK3CB_CW_US_B_LATE_U_SF_CombatUniform_02_BLK",[["ACE_fieldDressing",18],["ACE_tourniquet",4],["ACE_salineIV_500",2],["SmokeShell",2,1]]],["UK3CB_ADA_B_V_TacVest_BLK",[["50Rnd_570x28_SMG_03",8,50],["SmokeShell",1,1]]],["B_Messenger_Black_F",[["30Rnd_9x21_Mag",3,30]]],"H_PASGT_basic_black_F","UK3CB_G_Balaclava2_BLK",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
	player allowDamage true;

	cutText ["", "BLACK IN", 1];

	[{missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []] isNotEqualTo []}, {
		private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
		{
			_x hideObject false;
		} forEach _holders;
	}, []] call CBA_fnc_waitUntilAndExecute;

	[] call grad_grandPrix_fnc_ZiG_unconsciousHandlerLocal;

	[] call grad_grandPrix_fnc_common_setRadioFrequencies;
}, [_handle]] call CBA_fnc_waitUntilAndExecute;
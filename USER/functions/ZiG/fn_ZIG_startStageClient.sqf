if !(hasInterface) exitWith {};

// params ["_unit"];

[] call grad_grandPrix_fnc_ZiG_createMarkerLocal;

player setVariable ["GRAD_grandPrix_ZiG_savedLoadout", getUnitLoadout player, false];
player setUnitLoadout [["SMG_03C_TR_black","","","FHQ_optic_AC11704",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_P07_blk_F","","","",["30Rnd_9x21_Mag",30],[],""],["UK3CB_CW_US_B_LATE_U_SF_CombatUniform_02_BLK",[["ACE_fieldDressing",18],["ACE_tourniquet",4],["ACE_salineIV_500",2],["SmokeShell",2,1]]],["UK3CB_ADA_B_V_TacVest_BLK",[["50Rnd_570x28_SMG_03",8,50],["SmokeShell",1,1]]],["B_Messenger_Black_F",[["30Rnd_9x21_Mag",3,30]]],"H_PASGT_basic_black_F","UK3CB_G_Balaclava2_BLK",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
player allowDamage true;

private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
{
	_x hideObject false;
} forEach _holders;

[] call grad_grandPrix_fnc_ZiG_unconsciousHandlerLocal;
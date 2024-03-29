if !(hasInterface) exitWith {};

cutText ["", "BLACK", 0.1];

// private _handle = ["A3\Missions_F_EPA\video\A_in_intro.ogv"] spawn BIS_fnc_playVideo;

// [{
// 	scriptDone (_this select 0)
// },{
[] call grad_grandPrix_fnc_ZiG_createMarkerLocal;

private _pos = [grad_grandPrix_fnc_ZiG_teleport_1] call BIS_fnc_randomPosTrigger;
_pos set [2, 0];
player setPos _pos;
player setDir 315;

missionNamespace setVariable ["GRAD_grandPrix_ZiG_savedLoadout_" + getPlayerUID player, getUnitLoadout player, true];
player setUnitLoadout [["rhs_weap_ak74m_fullplum_npz","","","FHQ_optic_AC11704",["rhs_60Rnd_545X39_AK_Green",60],[],""],[],[],["rhs_uniform_g3_blk",[["ACE_packingBandage",21],["ACE_tourniquet",4],["ACE_salineIV_500",2],["ACE_morphine",5]]],["V_PlateCarrier1_blk",[["SmokeShell",4,1],["rhs_60Rnd_545X39_AK_Green",5,60],["MiniGrenade",4,1]]],["B_Messenger_Black_F",[["rhs_60Rnd_545X39_AK_Green",5,60]]],"H_PASGT_basic_black_F","G_Balaclava_TI_blk_F",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152_3","ItemCompass","ItemWatch",""]];
player allowDamage true;

cutText ["", "BLACK IN", 1];

[
	{
		(missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []] isNotEqualTo []) &&
		(missionNamespace getVariable ["Grad_grandPrix_ZiG_showMoneyLocal", false])
	},
	{
		private _holders = missionNamespace getVariable ["GRAD_grandPrix_ZiG_weaponHolders", []];
		{
			_x hideObject false;
		} forEach _holders;
	},
[]] call CBA_fnc_waitUntilAndExecute;

[] call grad_grandPrix_fnc_ZiG_unconsciousHandlerLocal;

[
	{
		[] call grad_grandPrix_fnc_common_setRadioFrequencies;
	},
	[],
	5
] call CBA_fnc_waitAndExecute;

// drop money
[] spawn grad_grandPrix_fnc_ZiG_handleLocalMoneyParticles;

// waiting for money to drop
0 fadeMusic 1;
playMusic "Lets_Go_Shopping";

[
	"
		<t>Bitte haben Sie noch etwas Geduld.<br/>
		Sobald ein Countdown heruntergezählt wurde, dürfen Sie die Station betreten.<br/>
		Die Geldtransporter sind bereits im Anflug, benötigen allerdings noch ein paar Sekunden.<br/>
		Um die Zeit zu überbrücken, hier ein paar Fun-Facts:<br/><br/>
		Fact 1:<br/>
		Die älteste bekannte Währung der Welt sind chinesische Münzen, die vor mehr als 2500 Jahren geprägt wurden.<br/><br/>
		Fact 2:<br/>
		Der höchste Geldschein der Welt ist der 100.000-Dollar-Schein der USA, der jedoch nie in den Umlauf kam und nur von Banken genutzt wird.<br/><br/>
		Fact 3:<br/>
		Die meisten Banknoten haben eine Lebensdauer von etwa fünf Jahren, bevor sie ersetzt werden müssen.<br/><br/>
		Fact 4:<br/>
		1939 baute der Armenier George Luther Simjian den ersten funktionierenden Geldautomaten. Die City Bank of New York (Citibank) nahm ihn probeweise in Betrieb. Er wurde nur von wenigen Kunden genutzt und nach einem halben Jahr Probebetrieb wieder abgebaut. Simjian stellte nach dem Probebetrieb fest: „Es sieht so aus, dass ein paar Prostituierte und Glücksspieler, die nicht von Angesicht zu Angesicht mit Kassierern zu tun haben wollten, die einzigen Benutzer des Gerätes waren.“<br/><br/>
		Fact 5:<br/>
		100% aller Geldreserven des Don wurden rechtens versteuert und rund 99% kommen wohltätigen Zwecken zugute :)<br/><br/>
		Fact 6:<br/>
		Der Euro ist die am zweithäufigsten verwendete Währung der Welt, nach dem US-Dollar.<br/><br/>
		Fact 7:<br/>
		Es gibt eine Website namens „WheresGeorge.com“, auf der man den Weg von US-Dollar-Noten verfolgen kann, indem man ihre Seriennummer eingibt.<br/><br/>
		Fact 8:<br/>
		Die Währung mit dem höchsten Wechselkurs ist der kuwaitische Dinar, der derzeit etwa 3,30 US-Dollar wert ist.<br/><br/>
		Fact 9:<br/>
		Die Währung mit dem niedrigsten Nennwert ist der iranische Rial, der derzeit etwa 0,00002 US-Dollar wert ist.</t>
	",
	-1,
	safeZoneH + safeZoneY,
	93,
	0,
	-6.5,
	789
] spawn BIS_fnc_dynamicText;

sleep 86;

6 fadeMusic 0;
sleep 7;

playMusic "";
0 fadeMusic 1;

// }, [_handle]] call CBA_fnc_waitUntilAndExecute;
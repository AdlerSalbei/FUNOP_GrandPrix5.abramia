class upgradeWeaponTitle
{
	idd = UPGRADEWEAPON_DIALOG;
	duration = 99999;

	enableSimulation = 1;
	enableDisplay = 1;

	onload = "disableSerialization; _this call gungame_events_fnc_upgradeWeaponTitleOnLoad;";

	class ControlsBackground
	{
		class Background: mcd_IGUIBack
		{
			idc = UPGRADEWEAPON_BG;
			x = uw_x;
            y = uw_y;
			w = uw_w;
			h = uw_h;
		};

		class WeaponPicture: mcd_RscPicture
		{
			idc = UPGRADEWEAPON_PIC;
			x = uw_x + uw_paddingX;
			y = uw_y;
			w = uw_w - 2*uw_paddingX;
			h = uw_h - uw_paddingY;
			text = "";
		};

		class WeaponText: mcd_RscText
		{
			idc = UPGRADEWEAPON_TEXT;
			style = ST_CENTER;
			x = uw_x;
			y = uw_y + uw_h - uw_paddingY*1.4;
			w = uw_w;
			h = uw_paddingY;

		};
	};
};

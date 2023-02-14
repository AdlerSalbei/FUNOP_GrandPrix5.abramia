class voteCountdownTitle
{
    idd = 1400;
    duration = 99999;

    enableSimulation = 1;
    enableDisplay = 1;
    onLoad = "disableSerialization; _this call gungame_votePlayzone_fnc_setVoteDialogText;";

    class ControlsBackground
    {
        class statusMessage: mcd_RscMapText
        {
            moving = 1;
            idc = 1401;
            text = "PLAYZONE VOTING";
            x = safeZoneX + safeZoneW - 0.6 * 3/4;
            y = safeZoneY + safeZoneH - 1.600;
        };

		class skipMessage: mcd_RscMapTextSmall
		{
			idc = 1403;
			text = "";
			x = safeZoneX + safeZoneW - 0.6 * 3/4;
			y = safeZoneY + safeZoneH - 1.545;
		};

        class waitMessage: mcd_RscMapTextSmall
        {
            idc = 1402;
            text = "";
            x = safeZoneX + safeZoneW - 0.6 * 3/4;
            y = safeZoneY + safeZoneH - 1.490;
        };
    };
};

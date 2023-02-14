class KillCamText
{
    access = 0;
    type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    w = 0.1; h = 0.05;
    font = "PuristaMedium";
    sizeEx = 0.08;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    text = "";
    fixedWidth = 0;
    shadow = 0;
};

class KillCamTitle
{
    idd = KILLCAMTITLE_DIALOG;
    enableDisplay = true;
    enableSimulation = true;
	duration = 8;
	onLoad = "uiNamespace setVariable [""KillCamTitle_Display"", _this select 0]";

    class ControlsBackground
    {
        class Title: KillCamText
        {
            idc = KILLCAMTITLE_TITLE;
            x = kc_titleX;
            y = kc_titleY;
            w = kc_W;
            h = kc_H;
        };
    };
};

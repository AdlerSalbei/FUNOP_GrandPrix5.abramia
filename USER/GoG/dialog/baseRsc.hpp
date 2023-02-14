class mcd_IGUIBack
{
	type = 0;
	idc = 124;
	style = 128;
	text = "";
	colorText[] = {0, 0, 0, 0};
	font = "PuristaMedium";
	sizeEx = 0;
	shadow = 0;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	colorbackground[] =
	{
		"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"
	};
};

class mcd_RscText
{
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing = 1;
};

class mcd_RscBackground: mcd_RscText {
    colorBackground[] = {0,0,0,0.90};
    colorText[] = {0,0,0,0};
};

class mcd_RscMapText: mcd_RscText
{
	idc = -1;
	type = CT_STATIC;
	style = ST_LEFT;
	font = "PuristaLight";
	sizeEx = 0.04;
	colorBackground[] = { 0,0,0, 0.8 };
	text = "";
	w = 0.52 * 3/4;
	h = 0.05;
	duration = 1e+1000;
};

class mcd_RscMapTextSmall: mcd_RscText
{
	idc = -1;
	type = CT_STATIC;
	style = ST_LEFT;
	shadow = 2;
	font = "PuristaLight";
	sizeEx = 0.04;
	colorBackground[] = { 0,0,0, 0.8 };
	text = "";
	w = 0.52 * 3/4;
	h = 0.05;
	duration = 1e+1000;
};

class mcd_RscPicture
{
	shadow = 0;
	type = 0;
	style = 48;
	sizeEx = 0.023;
	font = "PuristaMedium";
	colorBackground[] = {};
	colorText[] = {};
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class mcd_RscActivePictureKeepAspect {
    idc = -1;
    access = 0;
    color[] = {1,1,1,0.5};
    colorActive[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.25};
    default = 0;
    deletable = 0;
    fade = 0;
    font = "RobotoCondensed";
    shadow = 2;
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    soundClick[] = {"",0.1,1};
    soundEnter[] = {"",0.1,1};
    soundEscape[] = {"",0.1,1};
    soundPush[] = {"",0.1,1};
    style = "0x30 + 0x800";
    text = "";
    tooltipColorBox[] = {1,1,1,1};
    tooltipColorShade[] = {0,0,0,0.65};
    tooltipColorText[] = {1,1,1,1};
    type = 11;
    url = "";
};

class mcd_RscButton {
    idc = -1;
    access = 0;
    borderSize = 0;
    colorBackground[] = {0,0,0,0.9};
    colorBackgroundActive[] = {0,0,0,0.9};
    colorBackgroundDisabled[] = {0,0,0,0.5};
    colorBorder[] = {0,0,0,1};
    colorDisabled[] = {1,1,1,0.25};
    colorFocused[] = {0,0,0,1};
    colorShadow[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    deletable = 0;
    fade = 0;
    font = "RobotoCondensed";
    offsetPressedX = 0;
    offsetPressedY = 0;
    offsetX = 0;
    offsetY = 0;
    shadow = 2;
    sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    style = 2;
    text = "";
    type = 1;
    url = "";
};

class mcd_lbMulti {
    access = 0;
    type = 5;
    style = LB_MULTI;
    
    x = 0;
    y = 0;
    w = 0.4;
    h = 0.4;

    font = "TahomaB";
    sizeEx = 0.04;
    rowHeight = 0;
    colorText[] = {1,1,1,1};
    colorScrollbar[] = {1,1,1,1};
    colorSelect[] = {0,0,0,1};
    colorSelect2[] = {1,0.5,0,1};
    colorSelectBackground[] = {0.6,0.6,0.6,1};
    colorSelectBackground2[] = {0.2,0.2,0.2,1};
    colorBackground[] = {0,0,0,1};
    maxHistoryDelay = 1.0;
    soundSelect[] = {"",0.1,1};
    period = 1;
    autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
    arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
    arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
    shadow = 0;
    class ListScrollBar {
        autoScrollDelay = 5;
        autoScrollEnabled = 0;
        autoScrollRewind = 0;
        autoScrollSpeed = -1;
        height = 0;
        scrollSpeed = 0.06;
        width = 0;

        color[] = {1,1,1,0.6};
        colorActive[] = {1,1,1,1};
        colorDisabled[] = {1,1,1,0.3};
        thumb = "#(argb,8,8,3)color(1,1,1,1)";
        arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
        arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
        border = "#(argb,8,8,3)color(1,1,1,1)";
        shadow = 0;
    };
};

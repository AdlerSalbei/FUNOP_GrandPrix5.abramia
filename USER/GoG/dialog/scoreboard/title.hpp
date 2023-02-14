class ScoreBoardItem
{
    access = 0;
    type = CT_STATIC;
    idc = -1;
    style = ST_LEFT;
    x = sb_totalX + sb_scoreW + sb_itemSpacingX;
    w = sb_itemW;
    h = sb_itemH;
    font = "PuristaLight";
    sizeEx = (0.04 * TEXT_SCALE);
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    text = "";
    fixedWidth = 0;
    shadow = 0;
};

class ScoreBoardScore: ScoreBoardItem
{
    style = ST_CENTER;
    x = sb_totalX;
    w = sb_scoreW;
    text = "";
};

class ScoreBoard
{
	idd = SCOREBOARD_DIALOG;
	enableDisplay = true;
	enableSimulation = true;
	duration = 1e+1000;
	onLoad = "uiNamespace setVariable [""ScoreBoard_Display"", _this select 0]";

	class ControlsBackground {
		class Item1: ScoreBoardItem
		{
			idc = SCOREBOARD_ITEM1;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 0);
		};

		class Score1: ScoreBoardScore
		{
			idc = SCOREBOARD_SCORE1;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 0);
		};

		class Item2: ScoreBoardItem
		{
			idc = SCOREBOARD_ITEM2;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 1);
		};

		class Score2: ScoreBoardScore
		{
			idc = SCOREBOARD_SCORE2;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 1);
		};

		class Item3: ScoreBoardItem
		{
			idc = SCOREBOARD_ITEM3;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 2);
		};

		class Score3: ScoreBoardScore
		{
			idc = SCOREBOARD_SCORE3;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 2);
		};

		class Item4: ScoreBoardItem
		{
			idc = SCOREBOARD_ITEM4;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 3);
		};

		class Score4: ScoreBoardScore
		{
			idc = SCOREBOARD_SCORE4;
			y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 3);
		};

        class Item5: ScoreBoardItem
        {
            idc = SCOREBOARD_ITEM5;
            y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 4);
        };

        class Score5: ScoreBoardScore
        {
            idc = SCOREBOARD_SCORE5;
            y = sb_totalY + ((sb_itemSpacingY + sb_itemH) * 4);
        };
	};
};

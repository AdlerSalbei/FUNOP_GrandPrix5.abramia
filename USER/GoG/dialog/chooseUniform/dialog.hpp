class gungame_rscChooseUniform {
	idd = CHOOSEUNIFORM_IDD_DIALOG;
	movingEnable = false;
    enableSimulation = true;
    onUnload = "_this call gungame_chooseUniform_fnc_onUnload";

	class controlsBackground {
        class mainBG: mcd_RscBackground {
            x = CHOOSEUNIFORM_X;
            y = CHOOSEUNIFORM_Y;
            w = CHOOSEUNIFORM_TOTAL_W;
            h = CHOOSEUNIFORM_TOTAL_H;
        };
        class topbar: mcd_RscBackground {
            x = CHOOSEUNIFORM_X;
            y = CHOOSEUNIFORM_Y - CHOOSEUNIFORM_TOPBAR_H - CHOOSEUNIFORM_TOPBAR_SPACER_H;
            w = CHOOSEUNIFORM_TOTAL_W;
            h = CHOOSEUNIFORM_TOPBAR_H;
        };
        class topbarText: mcd_RscText {
            x = CHOOSEUNIFORM_X;
            y = CHOOSEUNIFORM_Y - CHOOSEUNIFORM_TOPBAR_H - CHOOSEUNIFORM_TOPBAR_SPACER_H;
            w = CHOOSEUNIFORM_TOTAL_W;
            h = CHOOSEUNIFORM_TOPBAR_H;

            text = "CHOOSE UNIFORM";
            font = "EtelkaMonospacePro";
        };
	};
	class controls {
        class item0: mcd_RscActivePictureKeepAspect {
            idc = CHOOSEUNIFORM_IDC_ITEM0;
            x = CHOOSEUNIFORM_X + CHOOSEUNIFORM_PADDING_W + 0 * CHOOSEUNIFORM_SPACER_W + 0 * CHOOSEUNIFORM_COLUMN_W;
            y = CHOOSEUNIFORM_Y + CHOOSEUNIFORM_PADDING_H;
            w = CHOOSEUNIFORM_COLUMN_W;
            h = CHOOSEUNIFORM_COLUMN_H;

            action = "[0] call gungame_chooseUniform_fnc_onUniformSelected";
        };
        class item1: mcd_RscActivePictureKeepAspect {
            idc = CHOOSEUNIFORM_IDC_ITEM1;
            x = CHOOSEUNIFORM_X + CHOOSEUNIFORM_PADDING_W + 1 * CHOOSEUNIFORM_SPACER_W + 1 * CHOOSEUNIFORM_COLUMN_W;
            y = CHOOSEUNIFORM_Y + CHOOSEUNIFORM_PADDING_H;
            w = CHOOSEUNIFORM_COLUMN_W;
            h = CHOOSEUNIFORM_COLUMN_H;

            action = "[1] call gungame_chooseUniform_fnc_onUniformSelected";
        };
        class item2: mcd_RscActivePictureKeepAspect {
            idc = CHOOSEUNIFORM_IDC_ITEM2;
            x = CHOOSEUNIFORM_X + CHOOSEUNIFORM_PADDING_W + 2 * CHOOSEUNIFORM_SPACER_W + 2 * CHOOSEUNIFORM_COLUMN_W;
            y = CHOOSEUNIFORM_Y + CHOOSEUNIFORM_PADDING_H;
            w = CHOOSEUNIFORM_COLUMN_W;
            h = CHOOSEUNIFORM_COLUMN_H;

            action = "[2] call gungame_chooseUniform_fnc_onUniformSelected";
        };
        class buttonReroll: mcd_RscButton {
            idc = CHOOSEUNIFORM_IDC_REROLL;
            x = CHOOSEUNIFORM_X;
            y = CHOOSEUNIFORM_Y + CHOOSEUNIFORM_TOTAL_H + CHOOSEUNIFORM_TOPBAR_SPACER_H;
            w = CHOOSEUNIFORM_TOTAL_W / 2 - CHOOSEUNIFORM_SPACER_W / 2;
            h = CHOOSEUNIFORM_TOPBAR_H;
            font = "EtelkaMonospacePro";
            onButtonClick = "_this call gungame_chooseUniform_fnc_onButtonReroll";
        };
        class buttonConfirm: mcd_RscButton {
            idc = CHOOSEUNIFORM_IDC_CONFIRM;
            x = CHOOSEUNIFORM_X + CHOOSEUNIFORM_TOTAL_W / 2 + CHOOSEUNIFORM_SPACER_W;
            y = CHOOSEUNIFORM_Y + CHOOSEUNIFORM_TOTAL_H + CHOOSEUNIFORM_TOPBAR_SPACER_H;
            w = CHOOSEUNIFORM_TOTAL_W / 2 - CHOOSEUNIFORM_SPACER_W / 2;
            h = CHOOSEUNIFORM_TOPBAR_H;
            font = "EtelkaMonospacePro";
            text = "CONFIRM";
            onButtonClick = "_this call gungame_chooseUniform_fnc_onButtonConfirm";
        };
        class countdown: mcd_RscText {
            idc = CHOOSEUNIFORM_IDC_COUNTDOWN;
            style = ST_RIGHT;
            font = "EtelkaMonospacePro";
            
            x = CHOOSEUNIFORM_X;
            y = CHOOSEUNIFORM_Y - CHOOSEUNIFORM_TOPBAR_H - CHOOSEUNIFORM_TOPBAR_SPACER_H;
            w = CHOOSEUNIFORM_TOTAL_W;
            h = CHOOSEUNIFORM_TOPBAR_H;
        };
	};
};

#define GRID_W (pixelW * pixelGrid)
#define GRID_H (pixelH * pixelGrid)

#define CENTER_X(w) (safezoneX + (safezoneW - w) / 2)
#define CENTER_Y(h) (safezoneY + (safezoneH - h) / 2)

#define DIALOG_FOOTER_H (3.5 * GRID_H)
#define DIALOG_TITLE_H (2.5 * GRID_H)
#define DIALOG_BUTTON_SPACING 0.5

#define IDC_DIALOG_CONTENT 42069
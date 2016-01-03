#define true						1
#define false						0
#define Size_Main_Normal 			0.03
#define Size_Text_Default 			Size_Main_Normal
#define Size_Text_Small 			0.025
#define Color_White					{1, 1, 1, 1}
#define Color_Black					{0, 0, 0, 1}
#define Color_Gray					{0.3, 0.3, 0.3, 1}
#define Color_GrayLight 			{0.6, 0.6, 0.6, 1}
#define Color_GrayDark 				{0.2, 0.2, 0.2, 1}
#define Color_Orange				{1, 0.5, 0, 1}
#define Color_LightGreen			{.1, 0.5, 0, .7}
#define Color_Main_Foreground1 	    Color_White
#define Color_Text_Default 			Color_Main_Foreground1
#define ProcTextWhite 				"#(argb,8,8,3)color(1,1,1,1)"
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800                   16
#define ReadAndWrite			    0

#define FontM "EtelkaMonospaceProBold"
#define FontHTML "EtelkaMonospacePro"
#define FontHTMLBold "EtelkaMonospacePro"
#define FontMAINCZ "PuristaMedium"
#define FontMAIN "PuristaMedium"
#define FontTITLE "EtelkaMonospaceProBold"
#define FontTITLEHalf "PuristaMedium"
#define FontBOOK "tahomaB"
#define FontNOTES "tahomaB"
#define FontS "LucidaConsoleB"
#define ST_TITLE ST_TITLE_BAR + ST_CENTER
// Predefined controls
#define IDC_OK			1
#define IDC_CANCEL		2

// Colors
#define TextColor	0.08, 0.08, 0.12
#define InvTextColor	0.35, 0.38, 0.36

class RTS_Text {

    idc = -1;
    type = CT_STATIC;
    style = ST_MULTI;
    linespacing = 1;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
    soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss", 0.2, 1};
    soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss", 0.2, 1};
    soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.20,1};
    text = "";
    shadow = 0;
    font = FontMAIN;
    SizeEx = "";
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 5;
    w = 20;
};
class RTS_TitleText
{
	type=0;
	idc=-1;
	style=2;
	colorBackground[] = { 0, 0, 0, 0 };
	colorText[] = { 1, 1, 1, 1 };
	font="PuristaMedium";
	size=1;
};
class RTS_ActiveText
	{
		access = ReadAndWrite;
		type = CT_ACTIVETEXT;
		style = ST_CENTER;
		h = 0.05;
		w = 0.10;
		colorBackground[] = { 0, 0, 0, 0 };
	    colorText[] = {1,0.7,0,1};
		color[] = {1,1,1,0.8};
	    colorActive[] = { 1, 0.2, 0.2, 1 };
		colorDisabled[] = {0,0,0,0.3};
        soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
        soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss", 0.2, 1};
        soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss", 0.2, 1};
        soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.20,1};
	    action = str formatText ["%1", wtf];
		font = "PuristaMedium";
		sizeEx = 0.03;
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		text = "";
		default = true;
	};
class RTS_Structuredtext
{
		access = ReadAndWrite;
		type = CT_STATIC;
		idc = -1;
		style = ST_LEFT;
		lineSpacing = 0;
		w = 0.1;
		h = 0.05;
		font = "TahomaB";
		sizeEx = Size_Text_Small;
		text = "";
};
class RTS_SmallTitle
{
        type = CT_STATIC;
        idc = -1;
        style = ST_CENTER;
        colorBackground[] = {0, 0, 0, 1};
        colorText[] = {0, 0, 1, 1};
        font = FontMAIN;
        sizeEx = 0.04;
};

class RTS_SmallTitleBlack
{
        type = CT_STATIC;
        idc = -1;
        style = ST_CENTER;
        colorBackground[] = {0, 0, 0, 0};
        colorText[] = {1,0.7,0,1};
        font = FontTITLEHalf;
        sizeEx = 0.03;
};
class RTS_Picture {
    access = 0;
    idc = -1;
    type = CT_STATIC;
    style = ST_PICTURE;
    colorBackground[] = {0,0,0,0};
    colorText[] = {0,0,0,0};
    font = "tahomaB";
    sizeEx = 0;
    lineSpacing = 0;
    text = "";
    fixedWidth = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.3;
    h = 0.2;
};

class RTS_PictureKeepAspect: RTS_Picture {
	style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
};
class RTS_ActivePicture
	{
		access = ReadAndWrite;
		type = CT_ACTIVETEXT;
	        idc = -1;
	        style = ST_PICTURE;
	        font = PuristaMedium;
	        sizeEx = 0.04;
            soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.45,1};
	        soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
	        soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss", 0.2, 1};
	        soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss", 0.2, 1};
	};
class RTS_Titles
  {
	titles[] = {"crewinfomessage"};

	class Zen_pic
	{
	idd=-1;
	movingEnable=0;
	duration=9999;
	fadein=0;
	name="intro";
	controls[]={"Image_1"};

};

	  	class Image_1 : RTS_Picture
	  	  {
			x = safezoneX + safezoneW - 0.40;
			y = safezoneY + safezoneH - 0.21;
			w = 0.40;
			h = 0.21;
			text = "pictures\rtspatch1.paa";
	  	  };
	};

	class Black
	{
	idd=-1;
	movingEnable=0;
	duration=9999;
	fadein=0;
	name="intro";
	controls[]={"title1"};

	  	class title1 : RTS_Text
	  	  {
	  	  	text="";
	  	  	colorText[]={0.8,0,0,1};
			sizeEx = 0.05;
	  	  	x=0.000;
	  	  	y=0.000;
	  	  	w=1.000;
	  	  	h=1.000;
	  	  };
	};

	class Title
	{
	idd=-1;
	movingEnable=0;
	duration=9999;
	fadein=0;
	name="intro";
	controls[]={"Image_1","Image_2","title1","title2","title3","title4","title5","title6"};

	  	class Image_1 : RTS_Picture
	  	  {
			x = safezoneX + safezoneW - 0.40;
			y = safezoneY + safezoneH - 0.21;
			w = 0.40;
			h = 0.21;
			text = "pictures\rtspatch1.paa";
	  	  };

	  	class Image_2 : RTS_Picture
	  	  {
			x = 0.300;
			y = 0.060;
			w = 0.380;
			h = 0.500;
			text = "pictures\rtspatch1.paa";
	  	  };

	  	class title1 : RTS_Text
	  	  {
	  	  	text="Zenophon And";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.08;
	  	  	x=0.002;
	  	  	y=0.082;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title2 : RTS_Text
	  	  {
	  	  	text="Zenophon And";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.08;
	  	  	x=0.000;
	  	  	y=0.080;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title3 : RTS_Text
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.08;
	  	  	x=0.002;
	  	  	y=0.137;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title4 : RTS_Text
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.08;
	  	  	x=0.000;
	  	  	y=0.134;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title5 : RTS_Text
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.06;
	  	  	x=0.002;
	  	  	y=0.252;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title6 : RTS_Text
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.06;
	  	  	x=0.000;
	  	  	y=0.250;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	};

	class Title2
	{
	idd=-1;
	movingEnable=0;
	duration=9999;
	fadein=0;
	name="intro";
	controls[]={"Image_1","title1","title2","title3","title4","title5","title6"};

	  	class Image_1 : RTS_Picture
	  	  {
			x = safezoneX + safezoneW - 0.40;
			y = safezoneY + safezoneH - 0.21;
			w = 0.40;
			h = 0.21;
			text = "pictures\rtspatch1.paa";
	  	  };

	  	class title1 : RTS_Text
	  	  {
	  	  	text="Zenophon And";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.08;
	  	  	x=0.002;
	  	  	y=0.082;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title2 : RTS_Text
	  	  {
	  	  	text="Zenophon And";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.08;
	  	  	x=0.000;
	  	  	y=0.080;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title3 : RTS_Text
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.08;
	  	  	x=0.002;
	  	  	y=0.137;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title4 : RTS_Text
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.08;
	  	  	x=0.000;
	  	  	y=0.134;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title5 : RTS_Text
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.06;
	  	  	x=0.002;
	  	  	y=0.252;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title6 : RTS_Text
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.06;
	  	  	x=0.000;
	  	  	y=0.250;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	};

class RTS_Slider
{
        access = 0;
        type = 3;
        style = 1024;
        w = 0.3;
        color[] = {1,1,1,0.8};
        colorActive[] = {1,1,1,1};
        shadow = 0;
        h = 0.025;
};

class RTS_Button {
	access = 0;
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,1};
    colorDisabled[] = {0.4,0.4,0.4,0};
    colorBackground[] = {0.2,0.2,0.2,0.3};
    colorBackgroundDisabled[] = {0,0,0,0};
    colorBackgroundActive[] = {0.2,0.2,0.2,0.3};
    colorFocused[] = {0.75,0.75,0.75,.5};
    colorShadow[] = {0.023529,0,0.0313725,0};
    colorBorder[] = {0.023529,0,0.0313725,0};
    soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
    soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss", 0.2, 1};
    soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss", 0.2, 1};
	soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.45,1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.04;
    shadow = 1;
    font = FontMAIN;
    sizeEx = 0.03;
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 1;
};


class RTS_Button2
{
	type = 16;
	idc = -1;
	style = 0;
	default = 0;
	shadow = 0;
	w = 0.2;
	h = "(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	color[] = {1,1,1,1.0};
	color2[] = {0.95,0.95,0.95,1};
	colorFocused[] = { 1, 1, 1, 1 };
	colorDisabled[] = {1,1,1,0.25};
	colorBackgroundFocused[] = { 1, 1, 1, 0 };
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
	colorBackground2[] = {1,1,1,1};
	textureNoShortcut = "";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";

	periodFocus = 1.2;
	periodOver = 0.8;

	class HitZone
	{
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;

	};

	class ShortcutPos

	{
		left = 0;
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

	};

	class TextPos

	{
		left = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;

	};

	period = 0.4;
	font = "PuristaMedium";
	size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.45,1};
    soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
    soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss", 0.2, 1};
    soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss", 0.2, 1};
	action = "";

	class Attributes

	{

		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";

	};

	class AttributesImage

	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";

	};

};

class RTS_edit {
	type = 2;
	style = 0x00 + 0x40;
	font = "PuristaMedium";
	shadow = 0;
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorBackground[] = {0, 0, 0, 1};
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	colorText[] = {0.95, 0.95, 0.95, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	autocomplete = false;
	colorSelection[] = {0.5, 0, 0, 1};
	canModify = 1;
};

	class RTS_Frame
	{
		type = CT_STATIC;
		idc = -1;
		style = ST_FRAME;
		shadow = 2;
		colorDisabled[] = {0,0.13,0.25,0.7};
		colorBackground[] = {0,0.13,0.25,0.7};
		colorBackgroundDisabled[] = {0,0.13,0.25,0.7};
		colorBackgroundActive[] = {0,0.13,0.25,0.7};
		colorFocused[] = {0,0.13,0.25,0.7};
		colorShadow[] = {0.023529,0,0.0313725,1};
		colorBorder[] = {1, 0, 0, 1};
		colorText[] = {1, 0, 0, 1};
		font = "PuristaMedium";
		sizeEx = 0.01;
		text = "";
	};

class Scrollbar {
    idc = -1;
    type = CT_SLIDER;
    style = SL_HORZ;
    x = 0.4;
    y = 0.2;
    w = 0.3;
    h = 0.01;
    color[] = { 1, 1, 1, 1 };
    coloractive[] = { 1, 0, 0, 0.5 };
    // This is an ctrlEventHandler to show you some response if you move the sliderpointer.
    onSliderPosChanged = "hint format[""%1"",_this];";
};
class RTS_ListBox 
{
    access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
    idc = CT_LISTBOX; // Control identification (without it, the control won't be displayed)
    type = CT_LISTBOX; // Type is 5
    style = ST_LEFT + LB_TEXTURES; // Style
    default = 0; // Control selected by default (only one within a display can be used)
    blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

    x = 1 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X; // Horizontal coordinates
    y = 11 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
    w = 10 * GUI_GRID_CENTER_W; // Width
    h = 3 * GUI_GRID_CENTER_H; // Height

    colorBackground[] = {0.5, 0.5, 0.5, 0.6}; // Fill color
    colorSelectBackground[] = {1,0.7,0,1}; // Selected item fill color
    colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)

    sizeEx = GUI_GRID_CENTER_H; // Text size
    font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
    shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
    colorText[] = {1,1,1,1}; // Text and frame color
    colorDisabled[] = {1,1,1,0.5}; // Disabled text color
    colorSelect[] = {1,1,1,1}; // Text selection color
    colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
    colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

    pictureColor[] = {1,0.5,0,1}; // Picture color
    pictureColorSelect[] = {1,1,1,1}; // Selected picture color
    pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

    tooltip = "CT_LISTBOX"; // Tooltip text
    tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
    tooltipColorText[] = {1,1,1,1}; // Tooltip text color
    tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

    period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected

    rowHeight = 1.5 * GUI_GRID_CENTER_H; // Row height
    itemSpacing = 0; // Height of empty space between items
    maxHistoryDelay = 1; // Time since last keyboard type search to reset it
    canDrag = 1; // 1 (true) to allow item dragging

    soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected

    // Scrollbar configuration (applied only when LB_TEXTURES style is used)
    class ListScrollBar //In older games this class is "ScrollBar"
    {
        width = 0; // width of ListScrollBar
        height = 0; // height of ListScrollBar
        scrollSpeed = 0.01; // scroll speed of ListScrollBar

        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

        color[] = {1,1,1,1}; // Scrollbar color
    };

    // onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
    // onDestroy = "systemChat str ['onDestroy',_this]; false";
    // onSetFocus = "systemChat str ['onSetFocus',_this]; false";
    // onKillFocus = "systemChat str ['onKillFocus',_this]; false";
    // onKeyDown = "systemChat str ['onKeyDown',_this]; false";
    // onKeyUp = "systemChat str ['onKeyUp',_this]; false";
    // onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
    // onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
    // onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
    // onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
    // onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
    // onMouseMoving = "";
    // onMouseHolding = "";

    // onLBSelChanged = "systemChat str ['onLBSelChanged',_this]; false";
    // onLBDblClick = "systemChat str ['onLBDblClick',_this]; false";
    // onLBDrag = "systemChat str ['onLBDrag',_this]; false";
    // onLBDragging = "systemChat str ['onLBDragging',_this]; false";
    // onLBDrop = "systemChat str ['onLBDrop',_this]; false";
};


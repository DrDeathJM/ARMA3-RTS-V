//#ifndef RTS_GUI_BASE
//#define RTS_GUI_BASE
//---------------------------------
// Common defines
//---------------------------------
#include "RTSV_COLOR.EXT"

#define RTS_true 					1
#define RTS_false 				0

#define RTS_ReadAndWrite 			0 //! any modifications enabled
#define RTS_ReadAndCreate 		1 //! only adding new class members is allowed
#define RTS_ReadOnly 				2 //! no modifications enabled
#define RTS_ReadOnlyVerified 		3 //! no modifications enabled, CRC test applied

//---------------------------------
// Control types
//---------------------------------

#define RTS_CT_STATIC           	0
#define RTS_CT_BUTTON           	1
#define RTS_CT_EDIT             	2
#define RTS_CT_SLIDER           	3
#define RTS_CT_COMBO           		4
#define RTS_CT_LISTBOX          	5
#define RTS_CT_TOOLBOX          	6
#define RTS_CT_CHECKBOXES       	7
#define RTS_CT_PROGRESS         	8
#define RTS_CT_HTML             	9
#define RTS_CT_STATIC_SKEW      	10
#define RTS_CT_ACTIVETEXT       	11
#define RTS_CT_TREE             	12
#define RTS_CT_STRUCTURED_TEXT  	13
#define RTS_CT_CONTEXT_MENU     	14
#define RTS_CT_CONTROLS_GROUP   	15
#define RTS_CT_SHORTCUTBUTTON   	16

// Todo: verify these
	#define RTS_CT_3DSTATIC     	20
	#define RTS_CT_3DACTIVETEXT 	21
	#define RTS_CT_3DLISTBOX    	22
	#define RTS_CT_3DHTML       	23
	#define RTS_CT_3DSLIDER     	24
	#define RTS_CT_3DEDIT       	25
// End of "ToDo Verify These"

#define RTS_CT_XKEYDESC         	40
#define RTS_CT_XBUTTON          	41
#define RTS_CT_XLISTBOX         	42
#define RTS_CT_XSLIDER          	43
#define RTS_CT_XCOMBO           	44
#define RTS_CT_ANIMATED_TEXTURE 	45
#define RTS_CT_CHECKBOX         	77
// 3D Controls
#define RTS_CT_OBJECT           	80
#define RTS_CT_OBJECT_ZOOM      	81
#define RTS_CT_OBJECT_CONTAINER 	82
#define RTS_CT_OBJECT_CONT_ANIM 	83
#define RTS_CT_LINEBREAK        	98
#define RTS_CT_USER             	99
#define RTS_CT_MAP              	100
#define RTS_CT_MAP_MAIN         	101
#define RTS_CT_LISTNBOX         	102


//---------------------------------
// Control styles
//---------------------------------
//many of these can be combined; eg: style = RTS_ST_RIGHT + RTS_ST_SHADOW;

#define RTS_ST_UNDEFINED      		0		// Not Sure what this is
#define RTS_ST_POS            		0x0F
#define RTS_ST_HPOS           		0x03
#define RTS_ST_VPOS           		0x0C
#define RTS_ST_LEFT           		0x00	//left aligned text
#define RTS_ST_RIGHT          		0x01	//left aligned text
#define RTS_ST_CENTER         		0x02	//center aligned text
#define RTS_ST_DOWN           		0x04
#define RTS_ST_UP             		0x08
#define RTS_ST_VCENTER        		0x0C

#define RTS_ST_TYPE           		0xF0
#define RTS_ST_SINGLE         		0x00	//single line textbox
#define RTS_ST_MULTI          		0x10	//multi-line textbox (text will wrap, and newline character can be used). There is no scrollbar, but mouse wheel/arrows can scroll it. Control will be outlined with a line (color = text color).
#define RTS_ST_TITLE_BAR      		0x20
#define RTS_ST_PICTURE        		0x30  	//turns a static control into a picture control. 'Text' will be used as picture path. Picture will be stretched to fit the control.
#define RTS_ST_FRAME          		0x40	//control becomes a frame. Background is clear and text is placed along the top edge of the control. Control is outlined with text color (as in RTS_ST_MULTI)
#define RTS_ST_BACKGROUND     		0x50
#define RTS_ST_GROUP_BOX      		0x60
#define RTS_ST_GROUP_BOX2     		0x70
#define RTS_ST_HUD_BACKGROUND 		0x80	//control is rounded and outlined (just like a hint box)
#define RTS_ST_TILE_PICTURE   		0x90
#define RTS_ST_WITH_RECT      		0xA0
#define RTS_ST_LINE           		0xB0	//a line is drawn between the top left and bottom right of the control (color = text color). Background is clear. Control can still have text, however.

#define RTS_ST_SHADOW         		0x100	//text or image is given a shadow
#define RTS_ST_NO_RECT        		0x200	//when combined with RTS_ST_MULTI, it eliminates the outline around the control. Might combine with other styles for similar effect.
#define RTS_ST_KEEP_ASPECT_RATIO  	0x800	//used for pictures, it makes the displayed picture keep its aspect ratio.

#define RTS_ST_TITLE          		RTS_ST_TITLE_BAR + RTS_ST_CENTER

// Slider styles
#define RTS_SL_DIR            		0x400
#define RTS_SL_VERT           		0
#define RTS_SL_HORZ           		0x400

#define RTS_SL_TEXTURES       		0x10

// progress bar 
#define RTS_ST_VERTICAL       		0x01
#define RTS_ST_HORIZONTAL     		0

// Listbox styles
#define RTS_LB_TEXTURES       		0x10	//removes all extra lines from listbox, leaving only a gradiant scrollbar. Useful when LB has a painted background behind it.
#define RTS_LB_MULTI          		0x20	//allows multiple elements of the LB to be selected (by holding shift / ctrl)

// Tree styles
#define RTS_TR_SHOWROOT       		1
#define RTS_TR_AUTOCOLLAPSE   		2

// MessageBox styles
#define RTS_MB_BUTTON_OK      		1
#define RTS_MB_BUTTON_CANCEL  		2
#define RTS_MB_BUTTON_USER    		4

//---------------------------------
// Hardcoded IDCs
//---------------------------------

#define IDC_OK            				1
#define IDC_CANCEL        				2
#define IDC_AUTOCANCEL    				3
#define IDC_ABORT         				4
#define IDC_RESTART      				5

///////////////////
//     FONTS     //
///////////////////

#define RTS_FONT_LIGHT				"PuristaLight"
#define RTS_FONT_NORMAL				"PuristaMedium"
#define RTS_FONT_BOLD				"PuristaSemibold"
#define RTS_FONT_HEAVY				"PuristaBold"
#define RTS_FONT_MONO				"EtelkaMonospaceProBold"

///////////////////////////////////////////////////////////////////////////
/// Base Classes
///////////////////////////////////////////////////////////////////////////
  class RTS_Text
  {
	idc 	= -1;
	access 	= 0;
	type 	= RTS_CT_STATIC;
	style 	= RTS_ST_UNDEFINED;
	x 		= 0;
	y 		= 0;
	h 		= 0.037;
	w 		= 0.3;
	deletable 			= 0;
	fade 				= 0;
	shadow 				= 1;
	text 				= "";
	font 				= RTS_FONT_NORMAL;
	fixedWidth 			= 0;
	SizeEx 				= "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing 		= 1;
	colorBackground[] 	= COLOR_TRANSPARENT;
	colorText[] 		= {1,1,1,1};
	colorShadow[] 		= {0,0,0,0.5};
	tooltipColorText[] 	= {1,1,1,1};
	tooltipColorBox[] 	= {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
    soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss", 0.2, 1};
    soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss", 0.2, 1};
    soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.20,1};
  };

  //Multi-line text.
  class RTS_TextMulti: RTS_Text
  {
	linespacing = 1;
	style = RTS_ST_LEFT + RTS_ST_MULTI;
  };

  class RTS_Frame
  {
	type 	= RTS_CT_STATIC;
	idc = -1;
	style = 64;
	shadow = 2;
	colorBackground[] = COLOR_TRANSPARENT;
	colorText[] = {1,1,1,1};
	font = RTS_FONT_NORMAL;
	sizeEx = 0.02;
	text = "";
  };

  //Standard active text (text that can be clicked like a button)
   class RTS_ActiveText
  {
	idc 			= -1;
	access			= RTS_ReadAndWrite;
	type 			= RTS_CT_STATIC;
	style 			= RTS_ST_LEFT;
	color[] 		= COLOR_SNOW;
	colorActive[] 	= {1,0.5,0,1};
	colorDisabled[] = {1,1,1,0.25};
	default = 0;
	deletable = 0;
	fade = 0;
	font 			= RTS_FONT_NORMAL;
	h = 0.05;
	w = 0.15;
	shadow = 0;
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
    soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss", 0.2, 1};
    soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss", 0.2, 1};
    soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.2,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};
	text = "";
  };

  class RTS_StructuredText
  {
  	idc 	= -1;
	access 	= 0;
	type 	= RTS_CT_STRUCTURED_TEXT;
	style = RTS_ST_LEFT + RTS_ST_MULTI;
	x 		= 0;
	y 		= 0;
	h 		= 0.035;
	w 		= 0.1;
	deletable 		= 0;
	fade 			= 0;
	shadow 			= 1;
	text 			= "";
	size 			= "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] 	= {1,1,1,1};
	class Attributes
	{
		font 	= RTS_FONT_NORMAL;
		color 	= "#ffffff";
		align 	= "left";
		shadow 	= 1;
	};
  };

    class RTS_HTML
  {
	idc 		= -1;
	access		= RTS_ReadAndWrite;
	type 		= RTS_CT_HTML;
	style 		= RTS_ST_SINGLE;
	filename 	= "";
	shadow 		= 0;
	colorBackground[] 		= COLOR_BLACK;
	colorText[] 			= COLOR_SNOW;
	colorBold[] 			= {0,0,0.2,1};
	colorLink[] 			= {1,0.5,0,1};
	colorLinkActive[] 		= {1,0.5,0,1};
	colorPicture[] 			= COLOR_SNOW;
	colorPictureLink[] 		= COLOR_SNOW;
	colorPictureSelected[] 	= COLOR_SNOW;
	colorPictureBorder[] 	= COLOR_BLACK;
	tooltipColorText[] 		= COLOR_BLACK;
	tooltipColorBox[] 		= {0,0,0,0.5};
	tooltipColorShade[] 	= {1,1,0.7,1};
	prevPage 				= "#(argb,8,8,3)color(1,1,1,1)";
	nextPage 				= "#(argb,8,8,3)color(1,1,1,1)";
	class H1
	{
		font 		= RTS_FONT_NORMAL;
		fontBold 	= RTS_FONT_BOLD;
		sizeEx 		= 0.1;
	};
	class H2
	{
		font 		= RTS_FONT_NORMAL;
		fontBold 	= RTS_FONT_BOLD;
		sizeEx 		= 0.09;
	};
	class H3
	{
		font 		= RTS_FONT_NORMAL;
		fontBold 	= RTS_FONT_BOLD;
		sizeEx 		= 0.08;
	};
	class H4
	{
		font 		= RTS_FONT_NORMAL;
		fontBold 	= RTS_FONT_BOLD;
		sizeEx 		= 0.07;
	};
	class H5
	{
		font 		= RTS_FONT_NORMAL;
		fontBold 	= RTS_FONT_BOLD;
		sizeEx 		= 0.06;
	};
	class H6
	{
		font 		= RTS_FONT_NORMAL;
		fontBold 	= RTS_FONT_BOLD;
		sizeEx 		= 0.05;
	};
	class P
	{
		font 		= RTS_FONT_NORMAL;
		fontBold 	= RTS_FONT_BOLD;
		sizeEx 		= 0.04;
	};
  };

  // Todo NEEDS CHECKING WITH WIKI
  class RTS_Progress
  {
	idc 		= -1;
	access		= RTS_ReadAndWrite;
	type	 	= RTS_CT_PROGRESS;
	style 		= RTS_ST_SINGLE;
	deletable = 0;
	fade = 0;
	x 			= 0;
	y 			= 0;
	w 			= 1.2;
	h 			= 0.03;
	shadow 		= 2;
	colorFrame[]= COLOR_WHITE;
	colorBar[] 	= COLOR_WHITE;
	texture 	= "#(argb,8,8,3)color(1,1,1,1)";
  };

  // Todo NEEDS CHECKING WITH WIKI
  class RTS_ProgressNotFreeze
  {
	idc 		= -1;
	access		= RTS_ReadAndWrite;
	type 		= RTS_CT_ANIMATED_TEXTURE;
	style 		= RTS_ST_SINGLE;
	deletable 	= 0;
	fade 	= 0;
	x 		= 0;
	y 		= 0;
	w 		= 0.5;
	h 		= 0.1;
	shadow 		= 0;
	texture 	= "#(argb,8,8,3)color(0,0,0,0)";
  };

  class RTS_Picture
  {
	idc 		= -1;
	access 		= 0;
	type 		= RTS_CT_STATIC;
	style 		= RTS_ST_PICTURE;
	x 			= 0;
	y 			= 0;
	w 			= 0.2;
	h 			= 0.15;
	deletable 			= 0;
	fade 				= 0;
	font 				= "TahomaB";
	sizeEx 				= 0;
	lineSpacing 		= 0;
	text 				= "";	// path to image file
	fixedWidth 			= 0;
	shadow 				= 0;
	colorBackground[] 	= COLOR_TRANSPARENT;
	colorText[] 		={1,1,1,1};
	tooltipColorText[] 	= {1,1,1,1};
	tooltipColorBox[] 	= {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
  };

  class RTS_Edit
  {
	deletable = 0;
	fade = 0;
	access = 0;
	type 	= RTS_CT_EDIT;
	style = "RTS_ST_SINGLE + RTS_ST_FRAME";
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorBackground[] = COLOR_TRANSPARENT;
	colorText[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorSelection[] = {1,1,1,0.25};
	autocomplete = "";
	text = "";
	size = 0.2;
	font = RTS_FONT_NORMAL;
	shadow = 2;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	canModify = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
  };

  class RTS_Combo
  {
	deletable = 0;
	fade = 0;
	access = 0;
	type 	= RTS_CT_COMBO;
	style = "0x10 + 0x200";	// RTS_ST_MULTI + RTS_ST_NO_RECT

	colorActive[] = {1,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorPicture[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorScrollbar[] = {1,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	colorSelect[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorSelectRight[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorTextRight[] = {1,1,1,1};
    soundExpand[] = {"a3\sounds_f\weapons\closure\revolver_cylinder_turn_2.wss",0.1,1};
    soundCollapse[] = {"a3\sounds_f\weapons\closure\revolver_cylinder_turn_1.wss",0.09,1};
	soundSelect[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.1,1};
	soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.45,1};
	soundPush[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.45,1};
	soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss",0.45,1};
	soundEscape[] = {"a3\sounds_f\weapons\closure\sfx2.wss",0.09,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};

	maxHistoryDelay = 1;
	class ComboScrollBar
	{
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
		autoScrollDelay = 5;
		autoScrollEnabled = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		scrollSpeed = 0.06;
		shadow = 0;
		width = 0;
	};

	font = RTS_FONT_NORMAL;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	wholeHeight = 0.45;
  };

  class RTS_ListBox
  {
	deletable = 0;
	fade = 0;
	access = 0;
	type 	= RTS_CT_LISTBOX;
	style = 16;	//BIS DEFAULT, not documeted what this value means
	rowHeight = 0;
	colorText[] ={1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorScrollbar[] = {1,0,0,0};
	colorSelect[] = {0,0,0,1};
	colorSelect2[] = {0,0,0,1};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorSelectBackground2[] = {1,1,1,0.5};
	colorBackground[] = {0,0,0,0.3};
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] ={1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] ={1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class ListScrollBar
	{
     arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
     arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
	 border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
	 thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		width = 0;
		shadow = 0;
		scrollSpeed = 0.06;
		autoScrollEnabled = 1;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
	};
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.3;

	font = RTS_FONT_NORMAL;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	colorShadow[] = {0,0,0,0.5};
	period = 1.2;
	maxHistoryDelay = 1;
  };


  // Todo Needs checking
  class RTS_ListNBox
  {
	idc 			= -1;
	access			= RTS_ReadAndWrite;
	type 			= RTS_CT_LISTNBOX;
	style 			= RTS_ST_SINGLE;
	deletable = 0;
	x = 0;
	y = 0;
	w = 0.4;
	h = 0.4;
	font 				= RTS_FONT_NORMAL;
	sizeEx 				= 0.04;
	rowHeight 			= 0;
	color[] 				= {0.95,0.95,0.95,1};
	colorBackground[] 		= {0,0,0,1};
	colorDisabled[] 		= {1,1,1,0.25};
	colorPicture[] 			= {1,1,1,1};
	colorPictureDisabled[] 	= {1,1,1,1};
	colorPictureSelected[] 	= {1,1,1,1};
	colorScrollbar[] 		= {0.95,0.95,0.95,1};
	colorSelect2[] 			= {0,0,0,1};
	colorSelect[] 			= {0,0,0,1};
	colorSelectBackground2[]= {1,1,1,0.5};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorText[] 			= COLOR_WHITE;

	maxHistoryDelay 	= 1.0;
	soundSelect[] 		= {"",0.1,1};
	period 				= 1;
	autoScrollSpeed 	= -1;
	autoScrollDelay 	= 5;
	autoScrollRewind 	= 0;
	arrowEmpty 		= "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull 		= "#(argb,8,8,3)color(1,1,1,1)";
	drawSideArrows 		= 0;
	columns[] 		= {0.3,0.6,0.7};
	idcLeft 		= -1;
	idcRight 		= -1;
	shadow 			= 0;
	class ListScrollBar
	{
    arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
    arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		width = 0;
		shadow = 0;
		scrollSpeed = 0.06;
		autoScrollEnabled = 1;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
	};
	class ScrollBar
	{
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		width = 0;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		scrollSpeed = 0.06;
		autoScrollEnabled = 1;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
  };

  class RTS_Button
  {
	deletable = 0;
	fade = 0;
	access = 0;
	type 	= RTS_CT_BUTTON;
	style = RTS_ST_LEFT;
	text = "";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {0,0,0,0.5};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	colorBackgroundActive[] = {0,0,0,1};
	colorFocused[] = {0,0,0,1};
	colorShadow[] = COLOR_TRANSPARENT;
	colorBorder[] = {0,0,0,1};
	soundEnter[] = {"a3\sounds_f\weapons\closure\sfx1.wss",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\Button\soundPush",0.09,1};
	soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss",0.09,1};
	soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss",0.09,1};

	x = 0;
	y = 0;
	w = 0.2;
	h = 0.039216;
	shadow = 2;
	font = RTS_FONT_NORMAL;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	borderSize = 0;
  };

  class RTS_ShortcutButton
 {
	type = 16;
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
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

class RTS_ShortcutButtonMain
{
	idc = -1;
	style 	= RTS_ST_LEFT;
	default = 0;
	w = 0.313726;
	h = 0.104575;
	period = 0.5;
	font = RTS_FONT_NORMAL;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	text = "";
	action = "";
	color[] ={1,1,1,1};
	colorDisabled[] ={1,1,1,0.25};
	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0.0145;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	};
	class TextPos
	{
		left = "(((safezoneW / safezoneH) min 1.2) / 32) * 1.5";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)*2 - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)) / 2";
		right = 0.005;
		bottom = 0;
	};
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";

	class Attributes
	{
		font = RTS_FONT_NORMAL;
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class AttributesImage
	{
		font = RTS_FONT_NORMAL;
		color = "#E5E5E5";
		align = "false";
	};
};

class RTS_Slider
{
	idc = -1;
	deletable = 0;
	fade = 0;
	access = 0;
	type 	= RTS_CT_SLIDER;
	style = 1024;
	w = 0.3;
	color[] = {1,1,1,0.8};
	colorActive[] = {1,1,1,1};
	shadow = 0;
	h = 0.025;
};


  // ToDo Needs checking
  class RTS_SliderH: RTS_Slider
  {
	idc 			= -1;
	access			= RTS_ReadAndWrite;
	type 			= RTS_CT_XSLIDER;
	//style 			= RTS_SLIDER_HORZ + RTS_SL_TEXTURES;	//"0x400  + 0x10";
	style			= 1024;
	h = "scalar";
	color[] = {1,1,1,0.6};
	colorActive[] = COLOR_WHITE;
	colorDisable[] = {1,1,1,0.4};
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	border = "#(argb,8,8,3)color(1,1,1,1)";
	thumb = "#(argb,8,8,3)color(1,1,1,1)";
	shadow = 0;
  };

class RTS_IGUIBack
{
	type 	= RTS_CT_STATIC;
	idc = -1;
	style = 128;
	text = "";
	colorText[] = {	0,0,0,0};
	font = RTS_FONT_NORMAL;
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

class RTS_CheckBox
{
	idc = -1;
	type 	= RTS_CT_CHECKBOX;
	style 	= RTS_ST_UNDEFINED;
	checked = 0;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	color[] = {1,1,1,0.7};
	colorFocused[] = {1,1,1,1};
	colorHover[] = {1,1,1,1};
	colorPressed[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.2};
	colorBackground[] = COLOR_TRANSPARENT;
	colorBackgroundFocused[] = COLOR_TRANSPARENT;
	colorBackgroundHover[] = COLOR_TRANSPARENT;
	colorBackgroundPressed[] =COLOR_TRANSPARENT;
	colorBackgroundDisabled[] = COLOR_TRANSPARENT;
	textureChecked = "A3\Ui_f\data\GUI\Common\RscCheckBox\CheckBox_checked_ca.paa";
	textureUnchecked = "A3\Ui_f\data\GUI\Common\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "A3\Ui_f\data\GUI\RscCommon\CheckBox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "A3\Ui_f\data\GUI\RscCommon\CheckBox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "A3\Ui_f\data\GUI\RscCommon\CheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "A3\Ui_f\data\GUI\RscCommon\CheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "A3\Ui_f\data\GUI\RscCommon\CheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "A3\Ui_f\data\GUI\RscCommon\CheckBox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "A3\Ui_f\data\GUI\RscCommon\CheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "A3\Ui_f\data\GUI\RscCommon\CheckBox\CheckBox_unchecked_ca.paa";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] ={0,0,0,0.65};
	soundEnter[] = 	{"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
};

class RTS_TextCheckBox
{
	idc = -1;
	type 	= RTS_CT_CHECKBOXES;
	style 	= RTS_ST_UNDEFINED;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	colorText[] = {1,0,0,1};
	color[] =COLOR_TRANSPARENT;
	colorBackground[] = COLOR_TRANSPARENT;
	colorTextSelect[] = {0,0.8,0,1};
	colorSelectedBg[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		1
	};
	colorSelect[] = {0,0,0,1};
	colorTextDisable[] = {0.4,0.4,0.4,1};
	colorDisable[] = {0.4,0.4,0.4,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	font = RTS_FONT_NORMAL;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	rows = 1;
	columns = 1;
	strings[] = 
	{
		"UNCHECKED"
	};
	checked_strings[] = 
	{
		"CHECKED"
	};
};

class RTS_ButtonMenu
{
	idc = -1;
	type 	= RTS_CT_SHORTCUTBUTTON;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] ={0,0,0,0.8};
	colorBackgroundFocused[] = {1,1,1,1};
	colorBackground2[] = {0.75,0.75,0.75,1};
	color[] = {1,1,1,1};
	colorFocused[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] ={1,1,1,0.25};
	textSecondary = "";
	colorSecondary[] = {1,1,1,1};
	colorFocusedSecondary[] ={0,0,0,1};
	color2Secondary[] = {0,0,0,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	fontSecondary =  RTS_FONT_LIGHT;
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class TextPos
	{
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0;
	};
	class Attributes
	{
		font =  RTS_FONT_LIGHT;
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos
	{
		left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
    soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
    soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss", 0.2, 1};
    soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss", 0.2, 1};
	soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.2,1};

};

class RTS_ButtonMenuOK
{
	idc = 1;
	shortcuts[] = 
	{
		"0x00050000 + 0",
		28,
		57,
		156
	};
	default = 1;
	text = "OK";
	soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
};

class RTS_ButtonMenuCancel
{
	idc = 2;
	shortcuts[] = 
	{
		"0x00050000 + 1"
	};
	text = "Cancel";
};

class RTS_ControlsGroup
{
	idc = -1;
	deletable = 0;
	fade = 0;
	shadow = 0;
	style = 16;
	type 	= RTS_CT_CONTROLS_GROUP;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	class VScrollbar
	{
		color[] = {	1,1,1,1};
		width = 0.021;
		autoScrollEnabled = 1;
	};
	class HScrollbar
	{
		color[] = {1,1,1,1};
		height = 0.028;
	};
	class Controls
	{
	};
};
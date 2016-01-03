// Control types
#define CT_STATIC			0
#define CT_BUTTON			1
#define CT_EDIT				2
#define CT_SLIDER			3
#define CT_COMBO			4
#define CT_LISTBOX			5
#define CT_TOOLBOX			6
#define CT_CHECKBOXES		7
#define CT_PROGRESS			8
#define CT_HTML				9
#define CT_STATIC_SKEW		10
#define CT_ACTIVETEXT		11
#define CT_TREE				12
#define CT_STRUCTURED_TEXT	13 
#define CT_3DSTATIC			20
#define CT_3DACTIVETEXT		21
#define CT_3DLISTBOX		22
#define CT_3DHTML			23
#define CT_3DSLIDER			24
#define CT_3DEDIT			25
#define CT_OBJECT			80
#define CT_OBJECT_ZOOM		81
#define CT_OBJECT_CONTAINER	82
#define CT_OBJECT_CONT_ANIM	83
#define CT_USER				99
#define CT_SHORTCUT_BUTTON  16 // Arma 2 - textured button
#define CT_XBUTTON          41




// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400




// Static styles
#define ST_HPOS				0x0F
#define ST_LEFT				0
#define ST_RIGHT			1
#define ST_CENTER			2
#define ST_UP				3
#define ST_DOWN				4
#define ST_VCENTER			5
#define ST_TYPE				0xF0
#define ST_SINGLE			0
#define ST_MULTI			16
#define ST_TITLE_BAR		32
#define ST_PICTURE			48
#define ST_FRAME			64
#define ST_BACKGROUND		80
#define ST_GROUP_BOX		96
#define ST_GROUP_BOX2		112
#define ST_HUD_BACKGROUND	128
#define ST_TILE_PICTURE		144
#define ST_WITH_RECT		160
#define ST_LINE				176
#define ST_SHADOW			256
#define ST_NO_RECT			512
#define ST_TITLE			ST_TITLE_BAR + ST_CENTER
#define Dlg_ROWS			36
#define Dlg_COLS			90
#define Dlg_CONTROLHGT		((100/Dlg_ROWS)/100)
#define Dlg_COLWIDTH		((100/Dlg_COLS)/100)
#define Dlg_TEXTHGT_MOD		0.9
#define Dlg_ROWSPACING_MOD	1.3
#define Dlg_ROWHGT			(Dlg_CONTROLHGT*Dlg_ROWSPACING_MOD)
#define Dlg_TEXTHGT			(Dlg_CONTROLHGT*Dlg_TEXTHGT_MOD)

// Predefined controls
#define IDC_OK						1
#define IDC_CANCEL				2

// Colors
#define TextColor			0.08, 0.08, 0.12
#define InvTextColor	0.35, 0.38, 0.36

// Fonts
#define FontS "TahomaB"
#define FontHTML			"TahomaB"
#define FontM				"TahomaB"
#define FontHTMLBold "TahomaB"
#define FontMAP "TahomaB"
#define FontMAIN "TahomaB"
#define FontMAINCZ "TahomaB"
#define FontTITLE "TahomaB"
#define FontTITLEHalf "TahomaB"
#define FontBOOK "TahomaB"
#define FontNOTES "TahomaB"


#define BORDERSIZE		0.06
#define MAPWIDTH		0.4
#define MAPHEIGHT		0.4
#define MAPTXTSIZE		0.04



class ZKS_RscSliderV
{
	type = CT_SLIDER;
	style = SL_VERT;
	color[] = {0, 1, 0, 1};
	angle = 0;
};

class ZKS_RscText
{
	type = CT_STATIC;
	idc = -1;
	style = ST_CENTER;
	h = 0.04; 
	colorDisabled[] = { 0, 0, 0, 1 };
	colorBackground[] = {1, 1, 1, 0};
	colorText[] = {TextColor, 0.75};
  	font = FontMAIN;
	sizeEx = 0.02;
};

class ZKS_RscActiveText
{
	type = CT_ACTIVETEXT;
	style = ST_CENTER;
	color[] = {1, 1, 1, 1};
	colorActive[] = {1, 1, 1, 1};
	colorDisabled[] = { 0, 0, 0, 1 };
  	font = FontMAIN;
	sizeEx = 0.05;
		soundEnter[] = {"", 0.1, 1};
		soundPush[] = {"", 0.1, 1};
		soundClick[] = {"", 0.1, 1};
		soundEscape[] = {"", 0.1, 1}; 
	default = true;
};

class ZKS_RscActiveMenu : ZKS_RscActiveText
{
movingEnable = true;
	color[] = {1, 1, 1, 1};
	colorActive[] = {1, 0, 0, 1};
	font = FontTITLEHalf;
	sizeEx = 0.05;
	default = false;
};

class ZKS_RscObject
{
	type = CT_OBJECT;
	scale = 1.0;
	direction[] = {0, 0, 1};
	up[] = {0, 1, 0};
};


class ZKS_RscObjListBox
{
	type = CT_LISTBOX;
	font = FontTITLEHalf;	
	style = 3;
	selection = "display";
	angle = 0;
	size = 0.1;	// 3D size
	color[] = {0, 0, 0, 0};	
	colorSelect[] = {0, 1, 0, 1};
	colorSelectBackground[] = {0, 1, 0, 0.2};
	colorText[] = {0, 1, 0, 0.5};
	colorScrollbar[] = {1, 1, 1, 1};
};


class ZKS_RscReviveTITLE
{
	type = CT_STATIC;
	idc = -1;
	style = ST_CENTER;
	h = 0.04; 
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	font = TahomaB;
	sizeEx = 0.2;
};

class ZKS_DlgReviveDisplay
{
  	idd = 333091;
  	movingEnable = true;
  	controlsBackground[] = 	
	{
		TITLE_Revive1
	};
  	objects[] = {};
 	controls[]= {};
	class TITLE_Revive1 : ZKS_RscReviveTITLE
	{
		idc = 0001029;
		style = ST_MULTI + ST_CENTER + ST_NO_RECT;
		text = "";
		linespacing=1;
		x = 0.07;
		y = 0.45;
		w = 0.9; 
		h = 0.5;
		colorText[] = {0.5, 0, 0, 1};
		sizeEx = .04;
		size = .04;
		font = TahomaB;
	};
};

class ZKS_RscButtonBase {
	idc = -1;
	type = 16;
	style = 0;
	text = "";
	action = "";
	x = SafeZoneX + 0.01; y = 0.62 + SafeZoneY;
	w = 0.09; h = 0.04;
	size = 1.0;
	sizeEx = 0.022;
	color[] = {0.543, 0.5742, 0.4102, 1};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorBackground[] = { 1, 0.6, 0, 0.5 };
	colorbackground2[] = {1, 1, 1, 0.4};
	colorDisabled[] = { 0, 1, 0, 0.5};
	periodFocus = 1.2;
	periodOver = 0.8;
	default = false;
	class HitZone {
		left = 0.004;
		top = 0.029;
		right = 0.004;
		bottom = 0.029;
	};
	class ShortcutPos {
		left = 0.0145;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	class TextPos {
		left = 0.05;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	textureNoShortcut = "";
	animTextureNormal = "\ca\ui\data\ui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\ui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_default_ca.paa";
	period = 0.4;
	font = "TahomaB";
	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
	class Attributes {
		font = "TahomaB";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	class AttributesImage {
		font = "TahomaB";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
};


class ZKS_RscMapControl {
	access = ReadAndWrite;
	idc = 51;
	alphaFadeEndScale = 1.1;
	alphaFadeStartScale = 1;
	colorBackground[] = {1,1,1,.7};
	colorCountlines[] = {0.572,0.354,0.188,0.25};
	colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
	colorForest[] = {0.624,0.78,0.388,0.5};
	colorForestBorder[] = {0,0,0,0};
	colorGrid[] = {0.1,0.1,0.1,0.6};
	colorGridMap[] = {0.1,0.1,0.1,0.6};
	colorInactive[] = {1,1,1,0.5};
	colorLevels[] = {0.286,0.177,0.094,0.5};
	colorMainCountlines[] = {0.572,0.354,0.188,0.5};
	colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
	colorMainRoads[] = {0.9,0.5,0.3,1};
	colorMainRoadsFill[] = {1,0.6,0.4,1};
	colorNames[] = {0.1,0.1,0.1,0.9};
	colorOutside[] = {0,0,0,1};
	colorPowerLines[] = {0.1,0.1,0.1,1};
	colorRailWay[] = {0.8,0.2,0,1};
	colorRoads[] = {0.7,0.7,0.7,1};
	colorRoadsFill[] = {1,1,1,1};
	colorRocks[] = {0,0,0,0.3};
	colorRocksBorder[] = {0,0,0,0};
	colorSea[] = {0.467,0.631,0.851,0.5};
	colorText[] = {0,0,0,.5};
	colorTracks[] = {0.84,0.76,0.65,0.15};
	colorTracksFill[] = {0.84,0.76,0.65,1};
	font = "TahomaB";
	fontGrid = "TahomaB";
	fontInfo = "PuristaMedium";
	fontLabel = "PuristaMedium";
	fontLevel = "TahomaB";
	fontNames = "PuristaMedium";
	fontUnits = "TahomaB";
	maxSatelliteAlpha = 0;
	moveOnEdges = 1;
	ptsPerSquareCLn = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareObj = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 3;
	scaleDefault = 0.16;
	scaleMax = 1;
	scaleMin = 0.001;
	shadow = 0;
	showCountourInterval = "false";
	sizeEx = 0.04;


		sizeExLabel = 0;
		sizeExUnits = 0;
		sizeExNames = 0.04;
		sizeExLevel = 0;


	sizeExGrid = 0;
	sizeExInfo = 0;

	stickX[] = {0.2,["Gamma",1,1.5]};
	stickY[] = {0.2,["Gamma",1,1.5]};
	style = 48;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	type = 101;
	x = SafeZoneX + 0.01;y = SafeZoneY + 0.085;
	w = MAPWIDTH; h = MAPHEIGHT;
		onMouseZChanged = "";
	class ActiveMarker
		{
		color[] = {0.3,0.1,0.9,1};
		size = 50;
		};
	class Bunker
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		importance = "1.5 * 14 * 0.05";
		size = 14;
		};
	class Bush
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		importance = "0.2 * 14 * 0.05 * 0.05";
		size = "14/2";
		};
	class BusStop
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		importance = 1;
		size = 24;
		};
	class Chapel
		{
		coefMax = 4;
		coefMin = 0.85;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		importance = 1;
		size = 24;
		};
	class Church
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		importance = 1;
		size = 24;
		};
	class Command
		{
		coefMax = 1;
		coefMin = 1;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		importance =1;
		size = 18;
		};
	class Cross
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		importance = 1;
		size = 24;
		};
	class CustomMark
		{
		coefMax = 1;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		importance = 1;
		size = 24;
		};
	class Fortress
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		importance = "2 * 16 * 0.05";
		size = 16;
		};
	class Fountain
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		importance = "1 * 12 * 0.05";
		size = 11;
		};
	class Fuelstation
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		importance = 1;
		size = 24;
		};
	class Hospital
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		importance = 1;
		size = 24;
		};
	class Legend
		{
		color[] = {0,0,0,1};
		colorBackground[] = {1,1,1,0.5};
		font = "PuristaMedium";
		h = "3.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		w = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		x = "SafeZoneX + 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	class Lighthouse
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		importance = 1;
		size = 24;
		};
	class power
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		importance = 1;
		size = 24;
		};
	class powersolar
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		importance = 1;
		size = 24;
		};
	class powerwind
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		importance = 1;
		size = 24;
		};
	class powerwave
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		importance = 1;
		size = 24;
		};
	class Quay
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		importance = 1;
		size = 24;
		};
	class Rock
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.1,0.1,0.1,0.8};
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		importance = "0.5 * 12 * 0.05";
		size = 12;
		};
	class Ruin
		{
		coefMax = 4;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		importance = "1.2 * 16 * 0.05";
		size = 16;
		};
	class shipwreck
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\shipwreck_CA.paa";
		importance = 1;
		size = 24;
		};
	class SmallTree
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		importance = "0.6 * 12 * 0.05";
		size = 12;
		};
	class Stack
		{
		coefMax = 4;
		coefMin = 0.9;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		importance = "2 * 16 * 0.05";
		size = 20;
		};
	class Task
		{
		coefMax = 1;
		coefMin = 1;
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		colorCanceled[] = {0.7,0.7,0.7,1};
		colorCreated[] = {1,1,1,1};
		colorDone[] = {0.7,1,0.3,1};
		colorFailed[] = {1,0.3,0.2,1};
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		importance = 1;
		size = 27;
		};
	class Tourism
		{
		coefMax = 4;
		coefMin = 0.7;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		importance = "1 * 16 * 0.05";
		size = 16;
		};
	class Transmitter
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		importance = 1;
		size = 24;
		};
	class Tree
		{
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		importance = "0.9 * 16 * 0.05";
		size = 12;
		};
	class ViewTower
		{
		coefMax = 4;
		coefMin = 0.5;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		importance = "2.5 * 16 * 0.05";
		size = 16;
		};
	class Watertower
		{
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		importance = 1;
		size = 24;
		};
	class Waypoint
		{
		coefMax = 1;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		importance = 1;
		size = 24;
		};
	class WaypointCompleted
		{
		coefMax = 1;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
		importance = 1;
		size = 24;
	};
};
						
class RscHTML{};

class ZKS_DlgSpectateDeath
{
	idd = 170964;
	movingEnable = true;
	controlsBackground[]=
	{
		Background3,
		Background4,
		Background5,
		Background2,
		plrhealth,
		plrdis,
		playerslist,
		HelpBg,
		Title,
		CameraViews,
		SelectPlayer,
		SelectPlayerhealth,
		SelectPlayerdis,
		plrhealthbar,
		Spectation,
		Respawn_Button_Revive_1,
		Respawn_Button_Revive_2,
		Respawn_Button_Revive_3,
		Respawn_Button_Revive_4,
		Respawn_Button_Revive_5,
		Respawn_Button_Revive_6,
		Respawn_Button_Revive_7,
		Respawn_Button_Revive_8,
		Respawn_Button_Revive_9,
		Respawn_Button_Revive_13,
		Respawn_Button_Revive_14,
		Respawn_Button_Revive_15,
		Respawn_Button_Revive_16,
		Respawn_Button_Revive_17,
		Respawn_Button_Revive_18,
		Respawn_Button_Revive_19,
		Respawn_Button_Revive_20
	};

	class Background3 : ZKS_RscText
	{
		idc = 10100;
		x = SafeZoneX;
		y = SafeZoneY;
		w = .42;
		h = 0.72;
		text = ;
		colorBackground[] = {0, 0, 0, .6};
	};

	class Background4 : ZKS_RscText
	{
		x = SafeZoneX;
		y = SafeZoneY;
		w = SafeZoneW;
		h = 0.08;
		text = ;
		colorBackground[] = {0, 0, 0, 1};
	};

	class Background5 : ZKS_RscText
	{
		x = SafeZoneX;
		y = 0.92 - SafeZoneY;
		w = SafeZoneW;
		h = 0.08;
		text = ;
		colorBackground[] = {0, 0, 0, 1};
	};


	class Background2 : ZKS_RscText
	{
		idc = 1047009;
		style = ST_CENTER;
		x = SafeZoneX + 0.11;
		y = 0.005 + SafeZoneY;
		w = 0.2;
		h = 0.07;
		text = ;
		colorBackground[] = {1, 0, 0, .5};
		font = FontTITLEHalf;
		colorText[] = {1, 1, 1, 0};
		sizeEx = 0.065;
	};

	class playerslist : ZKS_RscText
	{
		idc = 1047005;
		style = ST_CENTER;
		x = SafeZoneX + 0.11;
		y = 0.62 + SafeZoneY;
		w = 0.2;
		h = 0.03;
		text = ;
		colorBackground[] = {1, 1, 1, .7};
		font = FontTITLEHalf;
		colorText[] = {0, 0, 0, 1};
		sizeEx = 0.022;
	};

	class plrhealth : ZKS_RscText
	{
		idc = 1047004;
		style = ST_LEFT;
		x = SafeZoneX + 0.01;
		y = 0.68 + SafeZoneY;
		w = 0.195;
		h = 0.02;
		text = ;
		colorBackground[] = {1, 0, 0, .5};
		font = FontTITLEHalf;
		colorText[] = {0, 0, 0, 0};
		sizeEx = 0.022;
	};

	class plrdis : ZKS_RscText
	{
		idc = 1047003;
		style = ST_CENTER;
		x = SafeZoneX + 0.215;
		y = 0.68 + SafeZoneY;
		w = 0.195;
		h = 0.02;
		text = ;
		colorBackground[] = {1, 1, 1, .7};
		font = FontTITLEHalf;
		colorText[] = {0, 0, 0, 1};
		sizeEx = 0.022;
	};

	class HelpBg : ZKS_RscText
	{
		style = ST_MULTI;
		idc = 1047002;
		lineSpacing = 1;
		x = SafeZoneX + 0.425;
		y = SafeZoneY + 0.08;
		w = .42;
		h = .860;
		text = ;
		colorBackground[] = {.2, .2, .2, .8};
		colorText[] = {1, 1, 1, 1};
		sizeEx = 0.022;
	};

	class plrhealthbar : ZKS_RscText
	{
		idc = 1047001;
		style = ST_LEFT;
		x = SafeZoneX + 0.01;
		y = 0.68 + SafeZoneY;
		w = 0.0;
		h = 0.02;
		text = ;
		colorBackground[] = {0, 1, 0, .5};
		font = FontTITLEHalf;
		colorText[] = {0, 0, 0, 0};
		sizeEx = 0.022;
	};

	class CameraViews : ZKS_RscText
	{
		idc = 10101;
		style = ST_CENTER;
		x = SafeZoneX + 0.11;
		y = 0.48 + SafeZoneY;
		w = 0.2;
		h = 0.06;
		font = FontTITLEHalf;
		colorText[] = {.8, .8, .8, .8};
		sizeEx = 0.044;
		text = "Camera Views";
	};

	class SelectPlayer : ZKS_RscText
	{
		idc = 10105;
		style = ST_CENTER;
		x = SafeZoneX + 0.11;
		y = 0.56 + SafeZoneY;
		w = 0.2;
		h = 0.06;
		font = FontTITLEHalf;
		colorText[] = {.8, .8, .8, .8};
		sizeEx = 0.044;
		text = "Select Player";
	};

	class SelectPlayerhealth : ZKS_RscText
	{
		idc = 10106;
		style = ST_CENTER;
		x = SafeZoneX + 0.06;
		y = 0.66 + SafeZoneY;
		w = 0.09;
		h = 0.02;
		font = FontTITLEHalf;
		colorText[] = {.8, .8, .8, .8};
		sizeEx = 0.022;
		text = "Health";
	};

	class SelectPlayerdis : ZKS_RscText
	{
		idc = 10107;
		style = ST_CENTER;
		x = SafeZoneX + 0.26;
		y = 0.66 + SafeZoneY;
		w = 0.09;
		h = 0.02;
		font = FontTITLEHalf;
		colorText[] = {.8, .8, .8, .8};
		sizeEx = 0.022;
		text = "Distance";
	};

	class Spectation : ZKS_RscText
	{
		idc = -1;
		style = ST_CENTER;
		x = 0.425;
		y = 0.9225 - SafeZoneY;
		w = 0.15;
		h = 0.05;
		font = FontTITLEHalf;
		colorText[] = {1, 0, 0, 1};
		sizeEx = 0.02;
		text = "- Spectating -";		
	};

	class Title : ZKS_RscText
	{
		idc = -1;
		style = ST_CENTER;
		x = 0.35;
		y = SafeZoneY - 0.00;
		w = 0.3;
		h = 0.08;
		font = FontTITLEHalf;
		colorText[] = {1, 0, 0, 1};
		sizeEx = 0.040;
		text = "YOU ARE UNCONSCIOUS";
	};

	class Respawn_Button_Revive_1 : ZKS_RscText
	{
	idc = 10001;
	type = CT_BUTTON;
	style = ST_CENTRE;
	default = false;
	font = FontM;
	sizeEx = 0.022;
	colorText[] = { 0, 0, 0, 1 };
	colorFocused[]= { 1, 0.7, 0, 0.5 };   
	colorDisabled[] = { 0, 0, 0, 1 };   
	colorBackground[] = { 1, 0.7, 0, 0.5 };
	colorBackgroundDisabled[] = { 0, 1, 0, 0.5 };   
	colorBackgroundActive[] = { 1, 0.7, 0, 0.5 };   
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorShadow[] = { 0, 0, 0, 0.5 };
	colorBorder[] = { 0, 0, 0, 0.5 };
	borderSize = 0;
	soundEnter[] = { "", 0, 1 };  
	soundPush[] = { "", 0.1, 1 };
	soundClick[] = { "", 0, 1 };  
	soundEscape[] = { "", 0, 1 };  
	x = SafeZoneX + 0.01; y = 0.53 + SafeZoneY;
	w = 0.09; h = 0.03;
	text = "INTERNAL ";
	action = "DeathCamCineViewSpecial = 1;fastview = 1;viewon = 0;gun = 0";
	};

	class Respawn_Button_Revive_2 : Respawn_Button_Revive_1
	{
	idc = 10002;
	x = SafeZoneX + 0.1133; y = 0.53 + SafeZoneY;
	text = "EXTERNAL ";
	action = "DeathCamCineViewSpecial = 2;fastview = 2;viewon = 0;";
	};
	
	class Respawn_Button_Revive_3 : Respawn_Button_Revive_1
	{
	idc = 10003;
	x = SafeZoneX + 0.2166; y = 0.53 + SafeZoneY;
	text = " GUNNER";
	action = "DeathCamCineViewSpecial = 3;fastview = 3;viewon = 0;";
	};

	class Respawn_Button_Revive_4 : Respawn_Button_Revive_1
	{
	idc = 10004;
	x = SafeZoneX + 0.32; y = 0.53 + SafeZoneY;
	text = "  MOUSE";
	action = "DeathCamCineViewSpecial = 4;fastview = 4;viewon = 0;";
	};

	class Respawn_Button_Revive_5 : Respawn_Button_Revive_1
	{
	idc = 10005;
	x = SafeZoneX + 0.01; y = 0.005 + SafeZoneY;
	colorBackgroundActive[] = { 0, 1, 0, 0.5 };
	text = "  HELP";
	action = "[] execVM 'FSM\Revive\Dialogs\RESPAWN_Help.sqf'";
	};

	class Respawn_Button_Revive_6 : Respawn_Button_Revive_1
	{
	idc = 10006;
	colorBackground[] = { 0, 1, 0, 0.5 };
	colorBackgroundActive[] = { 0, 1, 0, 0.5 };
	colorFocused[]= { 0, 1, 0, 0.5 };
	colorDisabled[] = { 0, 0, 0, 1 };
	x = SafeZoneX + 0.01; y = 0.045 + SafeZoneY;
	text = "AUTO MAP";
	action = "automap = 0";
	};

	class Respawn_Button_Revive_7 : Respawn_Button_Revive_1
	{
	idc = 10007;
	x = SafeZoneX + 0.01; y = 0.045 + SafeZoneY;
	text = "AUTO MAP";
	action = "automap = 1;ctrlShow [2222,true];";
	};

	class Respawn_Button_Revive_8 : Respawn_Button_Revive_1
	{
	idc = 10008;
	x = SafeZoneX + 0.32; y = 0.045 + SafeZoneY;
	text = "AUTO VIEW";
	action = "autoview = 1;Target = 4;";
	};

	class Respawn_Button_Revive_9 : Respawn_Button_Revive_1
	{
	idc = 10009;
	x = SafeZoneX + 0.32; y = 0.045 + SafeZoneY;
	colorBackground[] = { 0, 1, 0, 0.5 };
	colorBackgroundActive[] = { 0, 1, 0, 0.5 };
	colorDisabled[] = { 0, 0, 0, 1 };
	colorFocused[]= { 0, 1, 0, 0.5 }; 
	text = "AUTO VIEW";
	action = "autoview = 0;";
	};

	class Respawn_Button_Revive_13 : Respawn_Button_Revive_1
	{
	idc = 10013;
	colorBackgroundActive[] = { 0, 1, 0, 0.5 };
	x = SafeZoneX + 0.01; y = 0.62 + SafeZoneY;
	text = " << BACK";
	action = "plr = plr - 1;";
	};

	class Respawn_Button_Revive_14 : Respawn_Button_Revive_1
	{
	idc = 10014;
	colorBackgroundActive[] = { 0, 1, 0, 0.5 };
	x = SafeZoneX + 0.32; y = 0.62 + SafeZoneY;
	text = "  NEXT >>";
	action = "plr = plr + 1;";
	};

	class Respawn_Button_Revive_15 : Respawn_Button_Revive_1
	{
	idc = 10015;
	colorBackgroundActive[] = { 0, 1, 0, 0.5 };
	x = SafeZoneX + 0.32;
 	y = 0.58 + SafeZoneY;
	text = " < VIEW >";
	action = "viewplr = 1;";
	};

	class Respawn_Button_Revive_16 : Respawn_Button_Revive_1
	{
	idc = 10016;
	x = SafeZoneX + 0.32; y = 0.005 + SafeZoneY;
	text = "   HIDE";
	action = "showall = 0;ctrlShow [1047005,false];ctrlShow [1047004,false];ctrlShow [1047003,false];ctrlShow [1047002,false];ctrlShow [1047001,false];ctrlShow [10001,false];ctrlShow [10002,false];ctrlShow [10003,false];ctrlShow [10004,false];ctrlShow [10013,false];ctrlShow [10014,false];ctrlShow [10015,false];ctrlShow [10016,false];ctrlShow [10017,true];ctrlShow [10100,false];ctrlShow [10101,false];ctrlShow [10105,false];ctrlShow [10106,false];ctrlShow [10107,false];ctrlShow [10018,false];ctrlShow [10019,false];ctrlShow [10020,false];ctrlShow [2222,false];";
	};

	class Respawn_Button_Revive_17 : Respawn_Button_Revive_1
	{
	idc = 10017;
	colorBackground[] = { 0, 1, 0, 0.5 };
	colorFocused[]= { 0, 1, 0, 0.5 }; 
	colorDisabled[] = { 0, 0, 0, 1 };
	colorBackgroundActive[] = { 0, 1, 0, 0.5 };
	x = SafeZoneX + 0.32; y = 0.005 + SafeZoneY;
	text = "  SHOW";
	action = "showall = 1;ctrlShow [1047005,true];ctrlShow [1047004,true];ctrlShow [1047003,true];ctrlShow [1047001,true];ctrlShow [10001,true];ctrlShow [10002,true];ctrlShow [10003,true];ctrlShow [10004,true];ctrlShow [10013,true];ctrlShow [10014,true];ctrlShow [10015,true];ctrlShow [10016,true];ctrlShow [10017,false];ctrlShow [10019,true];ctrlShow [10100,true];ctrlShow [10101,true];ctrlShow [10105,true];ctrlShow [10106,true];ctrlShow [10107,true];ctrlShow [2222,true];";
	};

	class Respawn_Button_Revive_18 : Respawn_Button_Revive_1
	{
	idc = 10018;
	colorBackgroundActive[] = { 0, 1, 0, 0.5 };
	x = SafeZoneX + 0.745; 
	y = SafeZoneY + 0.090;
	text = "< CLOSE >";
	action = "ctrlShow [1047002,false];ctrlShow [10018,false];";
	};

	class Respawn_Button_Revive_19 : Respawn_Button_Revive_1
	{
	idc = 10019;
	x = SafeZoneX + 0.01;
	y = 0.58 + SafeZoneY;
	text = "PLR ONLY";
	action = "playerview = 1;Target = 2;";
	};

	class Respawn_Button_Revive_20 : Respawn_Button_Revive_1
	{
	idc = 10020;
	x = SafeZoneX + 0.01;
	y = 0.58 + SafeZoneY;
	colorBackground[] = { 0, 1, 0, 0.5 };
	colorDisabled[] = { 0, 0, 0, 1 };
	colorBackgroundActive[] = { 0, 1, 0, 0.5 };
	colorFocused[]= { 0, 1, 0, 0.5 }; 
	text = "PLR ONLY";
	action = "playerview = 0;Target = 3;";
	};

	controls[]=
	{
		mouseHandler,
		map,
		activemenu,
		ButtonNEXT,
		ButtonPREV

	};

	class activemenu : ZKS_RscActiveMenu
	{
		idc = 1047010;
		style = ST_CENTER;
		x = SafeZoneX + 0.11;
		y = 0.005 + SafeZoneY;
		w = 0.2;
		h = 0.07;
		text = Respawn In;
		font = FontTITLEHalf;
		color[] = {1, 1, 1, 1};
		colorText[] = {1, 1, 1, 1};
		sizeEx = 0.065;
		default = 0;
		soundEnter[] = {"", 0.1, 1};
		soundPush[] = {"", 0.1, 1};
		soundClick[] = {"", 0.1, 1};
		soundEscape[] = {"", 0.1, 1}; 
		action = "onlymap = 1;PLAYER_RESPAWN = 1;mypos = (player getVariable ""My_Spawn"");mk setmarkerpos (position mypos);";
	};

	class mouseHandler 
	{			
	onMouseMoving = "[""MouseMoving"",_this] call reviveMouseEvents";
	onMouseButtonDown = "[""MouseButtonDown"",_this] call reviveMouseEvents";
	onMouseButtonUp = "[""MouseButtonUp"",_this] call reviveMouseEvents";
	onMouseZChanged = "[""MouseZChanged"",_this] call reviveMouseEvents";			
	idc = 2501;
	type = 15;
	style = 0;
	x = 0.3; y = 0.2;
	w = 0.4; h = 0.6;			
	colorBackground[] = {0.5, 0.0, 0.0, 0.5};
			
		class VScrollbar 
		{
			color[] = {1, 1, 1, 1};
			width = 0.021;
			autoScrollSpeed = -1;
			autoScrollDelay = 5;
			autoScrollRewind = false;			
		};
		class HScrollbar 
		{
			color[] = {1, 1, 1, 1};
			height = 0.028;
			autoScrollSpeed = -1;
			autoScrollDelay = 5;
			autoScrollRewind = false;	
		};
		class ScrollBar 
		{
			color[] = {1, 1, 1, 0.6};
			colorActive[] = {1, 1, 1, 1};
			colorDisabled[] = {1, 1, 1, 0.3};
			thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
			arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
			arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
			border = "\ca\ui\data\ui_border_scroll_ca.paa";
		};
	};

	class ButtonNEXT : ZKS_RscActiveMenu
	{
		idc = -1;
		x = 0.55;
		y = 0.9225 - SafeZoneY;
		w = 0.15;
		h = 0.05;
		font = FontTITLEHalf;
		sizeEx = 0.02;
		colorText[] = {1, 0, 0, 1};
		colorDisabled[] = { 0, 0, 0, 1 };
		text = "Next >>";
		default = 0;
		soundEnter[] = {"", 0.1, 1};
		soundPush[] = {"", 0.1, 1};
		soundClick[] = {"", 0.1, 1};
		soundEscape[] = {"", 0.1, 1}; 
		action = "Target = 1";
	};	
		
	class ButtonPREV : ZKS_RscActiveMenu
	{
		idc = -1;
		x = 0.3;
		y = 0.9225 - SafeZoneY;
		w = 0.15;
		h = 0.05;		
		font = FontTITLEHalf;
		sizeEx = 0.02;
		colorText[] = {1, 0, 0, 1};
		colorDisabled[] = { 0, 0, 0, 1 };
		text = "<< Previous";
		default = 0;
		soundEnter[] = {"", 0.1, 1};
		soundPush[] = {"", 0.1, 1};
		soundClick[] = {"", 0.1, 1};
		soundEscape[] = {"", 0.1, 1}; 
		action = "Target = -1";
	};

	class map : ZKS_RscMapControl 
	{
		colorOutside[] = {0,0,0,1};
		colorRailWay[] = {0,0,0,1};
		maxSatelliteAlpha = 0;
		alphaFadeStartScale = 1;
		alphaFadeEndScale = 1.1;
		idc = 2222;
		x = SafeZoneX + 0.01;y = SafeZoneY + 0.085;
		w = MAPWIDTH; h = MAPHEIGHT;
		colorBackground[] = {1, 1, 1, 0.7};
		colorText[] = {0,0,0,.5};
		sizeExLabel = 0;
		sizeExGrid = 0;
		sizeExUnits = 0;
		sizeExNames = 0.04;
		sizeExInfo = 0;
		sizeExLevel = 0;
		showCountourInterval = "false";
		onMouseZChanged = "";
	
	};
};

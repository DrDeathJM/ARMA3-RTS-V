class RTS_LB_C
{
        style = ST_LEFT;
        idc = -1;
        access = ReadAndWrite;
        type = CT_COMBO;
        h = 0.05;
        colorFocused[] = {0.8,0.8,0.8,0};
        colorShadow[] = {0.9,0.9,0.9,0};
        shadow = 0.000001;
        colorBorder[] = {0,0.18,0.388,0.4};
        borderSize = 0.00006;
        colorDisabled[] ={1,1,1,0.25};
        colorBackgroundActive[] =  {0.18,0.345,0.58,1};        
        colorSelect[] = {0.4, 0.4, 0.4, 1};
        colorSelectBackground[] = {1, 1, 1, 1};
        colorText[] = {0, 0, 0, 1};
        colorBackground[] = {0.4, 0.4, 0.4, 1};
        font = FontTITLEHalf;
        sizeEx = 0.045;
        rowHeight = 0.08;
        colorSelect2[] = {0,1,1,1};
        coloRTS_rollbar[] = {0,0.72,0,1};
        colorSelectBackground2[] = {0.02, 0.2, 0.7, 0.6};
        wholeHeight = 0.25;
        soundExpand[] = {"a3\sounds_f\weapons\closure\revolver_cylinder_turn_2.wss",0.1,1};
        soundCollapse[] = {"a3\sounds_f\weapons\closure\revolver_cylinder_turn_1.wss",0.09,1};
	    soundSelect[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.1,1};
	    soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.45,1};
	    soundPush[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.45,1};
	    soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss",0.45,1};
	    soundEscape[] = {"a3\sounds_f\weapons\closure\sfx2.wss",0.09,1};
        maxHistoryDelay = 1.0;
        autoScrollSpeed = -1;
        autoScrollDelay = 5;
        autoScrollRewind = 0;

        arrowEmpty = "\A3\ui_f\data\GUI\RTS_Common\rsccombo\arrow_combo_ca.paa";
        arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
                class ScrollBar
                        {
                                color[] = {0.0, 0.1, 0.7, 0.5};
                                colorActive[] = {0.18,0.345,0.58,1};
                                colorDisabled[] = {1, 1, 1, 0.3};
                arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
                        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
                        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
                        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
                        };
        class ComboScrollBar: ScrollBar
{
        style = "9";
        x = 0;
        y = 0;
        w = 0.12;
        h = 0.035;
        shadow = 0;
        colorSelectBackground[] ={1,1,1,0.7};
        arrowEmpty = "\A3\ui_f\data\GUI\RTS_Common\rsccombo\arrow_combo_ca.paa";
        arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
        wholeHeight = 0.45;
        color[] =       {1,1,1,1};
        colorActive[] ={1,0,0,1};
        colorDisabled[] ={1, 1, 1, 0.3};
        font = "TahomaB";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
   };
};

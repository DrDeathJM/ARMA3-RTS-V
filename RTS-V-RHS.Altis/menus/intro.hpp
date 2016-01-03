
class RTS_TitleText
{
	type=0;
	idc=-1;
	style=2;
	colorBackground[] = COLOR_TRANSPARENT;
	colorText[] = COLOR_PART_BLUE;
	font= RTS_FONT_NORMAL;
	size=1;
};

	
class RTS_SmallTitle
{
        type = RTS_CT_STATIC;
        idc = -1;
        style = RTS_ST_CENTER;
        colorBackground[] = COLOR_TRANSPARENT;
        colorText[] = COLOR_HALF_RED;
        font = RTS_FONT_HEAVY;
        sizeEx = 0.04;
};

class RTS_SmallTitleBlack
{
        type = RTS_CT_STATIC;
        idc = -1;
        style = RTS_ST_CENTER;
        colorBackground[] = COLOR_TRANSPARENT;
        colorText[] = COLOR_PART_BLACK;
        font = RTS_FONT_BOLD;
        sizeEx = 0.03;
};

	
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
	  	  	colorText[]= COLOR_PART_BLACK;
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
	  	  	colorText[]= COLOR_PART_RED;
			sizeEx = 0.08;
	  	  	x=0.002;
	  	  	y=0.082;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title2 : RTS_Text 
	  	  {
	  	  	text="Zenophon And";
	  	  	colorText[]= COLOR_PART_BLUE;
			sizeEx = 0.08;	  	  	
	  	  	x=0.000;
	  	  	y=0.080;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title3 : RTS_Text 
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]= COLOR_PART_RED;
			sizeEx = 0.08;	  	  	
	  	  	x=0.002;
	  	  	y=0.137;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title4 : RTS_Text 
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]= COLOR_PART_BLUE;
			sizeEx = 0.08;	  	  	
	  	  	x=0.000;
	  	  	y=0.134;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title5 : RTS_Text 
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]= COLOR_PART_RED;
			sizeEx = 0.06;	  	  	
	  	  	x=0.002;
	  	  	y=0.252;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title6 : RTS_Text 
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]= COLOR_PART_BLUE;
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
	  	  	colorText[]= COLOR_PART_RED;
			sizeEx = 0.08;
	  	  	x=0.002;
	  	  	y=0.082;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title2 : RTS_Text 
	  	  {
	  	  	text="Zenophon And";
	  	  	colorText[]= COLOR_PART_BLUE;
			sizeEx = 0.08;	  	  	
	  	  	x=0.000;
	  	  	y=0.080;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title3 : RTS_Text 
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]= COLOR_PART_RED;
			sizeEx = 0.08;	  	  	
	  	  	x=0.002;
	  	  	y=0.137;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title4 : RTS_Text 
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]= COLOR_PART_BLUE;
			sizeEx = 0.08;	  	  	
	  	  	x=0.000;
	  	  	y=0.134;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title5 : RTS_Text 
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]= COLOR_PART_RED;
			sizeEx = 0.06;	  	  	
	  	  	x=0.002;
	  	  	y=0.252;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title6 : RTS_Text 
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]= COLOR_PART_BLUE;
			sizeEx = 0.06;	  	  	
	  	  	x=0.000;
	  	  	y=0.250;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	};

class Scrollbar {
    idc = -1; 
    type = RTS_CT_SLIDER; 
    style = RTS_SL_HORZ; 
    x = 0.4; 
    y = 0.2; 
    w = 0.3; 
    h = 0.01; 
    color[] = COLOR_PART_BLUE; 
    coloractive[] = COLOR_HALF_RED;
};
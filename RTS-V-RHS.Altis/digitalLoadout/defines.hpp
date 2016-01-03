#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_STRUCTURED_TEXT  13
#define CT_LINEBREAK        98

#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_PICTURE        0x30

class rscbackgroundGUI
{
     access = 0;
     background = 1;
     type = 0;
     style = 0;
     idc = -1;
     colorBackground[] = {0,0,0,0.5};
     colorShadow[] = {0,0,0,0.5};
     colorText[] = {1,1,1,0.5};
     text = "";
     fixedWidth = 0;
     x = 0;
     y = 0;
     h = 0;
     w = 0;
     shadow = 1;
     font = "puristaMedium";
     moving = 1; 
     SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    
};

class rscTopStripe
{
     access = 0;
     background = 1;
     type = 0;
     style = 0;
     idc = -1;
     colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",0.85};
     colorShadow[] = {0,0,0,0.5};
     colorText[] = {1,1,1,0.5};
     text = "";
     fixedWidth = 0;
     x = 0;
     y = 0;
     h = 0;
     w = 0;
     shadow = 1;
     font = "puristaMedium";  
     moving = 1;
     SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    
};

class IceButton
{
    access = 0;
    type = CT_BUTTON;
    style = ST_LEFT;
    text = "";
    colorText[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.1};
    colorBackground[] = {0.75,0.75,0.75,0.1};
    //colorBackgroundDisabled[] = {1,1,1,0.1};
    colorBackgroundDisabled[] = {1,0,0,0.1};
    colorBackgroundActive[] = {1,1,1,0.1};
    colorFocused[] = {0.75,0.75,0.75,0.1};
    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,0,0};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    shadow = 2;
    font = "puristaMedium";
    sizeEx = "0.03 / (getResolution select 5)";
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0.001;
    offsetPressedY = 0.001;
    borderSize = 1;
    moving = 1;
};

class IceText
{
     access = 0;
     type = CT_STATIC;
     style = ST_CENTER;
     idc = -1;
     colorBackground[] = {1,1,1,0};
     colorText[] = {1,1,1,0.8};
     text = "";
     fixedWidth = 0;
     x = 0;
     y = 0;
     h = 0;
     w = 0;
     shadow = 2;
     font = "puristaMedium";
     sizeEx = "0.02 / (getResolution select 5)";  
    
};

class IcePicture
{
          access = 0;
          type = CT_STATIC;
          style = 0x30 + 0x800;
          idc = -1;
          colorBackground[] = {0,0,0,0};
          colorText[] = {1,1,1,1};
          font = "puristaMedium";
          SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
          lineSpacing = 0;
          text = "";
          fixedWidth = 0;
          shadow = 0;
          x = 0;
          y = 0;
          w = 0.2;
          h = 0.15;
          moving = 1;
};

    

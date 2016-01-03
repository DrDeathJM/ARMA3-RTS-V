//Dialog for Help Menu
class DlgHelpMenu
	{
		idd = -1;
		movingEnable = true;
		class controlsBackground
			{
				class Frame_Title : RTS_Text
					{
							idc = 3000;
							x = 0.22;
							y = 0.05;
							w = 0.58;
							h = 0.05;
							colorText[] = COLOR_RED;
					   		colorBackground[] =  {0,0,0,0.72};
							sizeEx = 0.06;
							text = "Information Menu ";
					};


				class Frame_Background : RTS_Text
				 	{
				   		colorText[] = COLOR_RED;
					    colorBackground[] =  {0,0,0,0.72};
						text = "";
						x = 0.22;
						y = 0.1;
						w = 0.58;
						h = 0.99;
					};



				class List_HelpBackground : RTS_Text
					{
						colorText[] = COLOR_RED;
					   	colorBackground[] = {0.5, 0.5, 0.5, 0.6};
						text ="";
						x = 0.0;
						y = 0.15;
						w = 0.2;
						h = 0.35;
					};

			};//end controlsBackground

		class controls
			{
				class Text_Help : RTS_TextMulti
					{
						idc = 3005;
						style = RTS_ST_MULTI;
						x = 0.23;
						y = 0.12;
						w = 0.56;
						h = 0.85;
						sizeEx = 0.03;
						colorText[] = COLOR_SNOW;
					    colorBackground[] = {0.5, 0.5, 0.5, 0.6};
					};
				class List_Help : RTS_ListMain
					{
						idc = 3010;
						x = 0.0;
						y = 0.15;
						w = 0.2;
						h = 0.35;
				        sizeEx = 0.03;
				        spaceWidth = 0;
	                    spacing = 0.1;
				        rowHeight = 0.02;
						colorText[] = COLOR_SNOW;
					   	colorBackground[] =  {0,0,0,0.72};
						colorSelect[] = {1.0, 1.0, 1.0, 1};
						colorSelectBackground[] = {0.0, 0.0, 0.0, 1};
					};

				class Button_Exit : RTS_Button
					{
						idc = -1;
						x = 0.8;
						y = 0.90;
						colorText[] = COLOR_HALF_RED;
						text = "EXIT";					    
						action = "closeDialog 0";
					};
					class Button_Back : RTS_Button
                {
                    idc = 2001;
                    x = 0.8;
                    y = 0.15;
					colorText[] = COLOR_HALF_RED;
                    text = "Player Menu";
                    action = "[player, player, 0] call Zen_RTS_AlphaMenu";
                };



		};//end Controls

	};//end DlgHelpMenu

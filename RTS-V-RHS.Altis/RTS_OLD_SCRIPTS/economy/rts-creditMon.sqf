oldIndex = 0;
actionIndex = 0;

[] spawn 
	{

			while {true} do 
				{
					oldIndex = actionIndex;
					actionIndex = vehicle player addaction ["", ""];
					vehicle player removeaction actionIndex;

					if (actionIndex - oldIndex >= 5) then 
						{

						disableuserinput true;
						};

				};

	};

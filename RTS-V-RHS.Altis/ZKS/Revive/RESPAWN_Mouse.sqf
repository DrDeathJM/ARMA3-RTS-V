_x =0;
_y =0;
_param = _this select 1;
_type = _this select 0;
switch (_type) do {
		case "MouseMoving": 
		{
			_x = _param select 1;
			_y = _param select 2;
			MouseCoord = [_x, _y];	
		};
		case "MouseButtonDown": 
		{
			_x = _param select 2;
			_y = _param select 3;
			_button = _param select 1;
			MouseButtons set[_button, true];

		};	
		case "MouseButtonUp": 
		{
			_x = _param select 2;
			_y = _param select 3;
			_button = _param select 1;
			MouseButtons set[_button, false];
		};	
		case "MouseZChanged": 
		{
		  if (((_this select 1) select 1) > 0) then
		  {
			 if (range_to_unit > 2) then
			 {
				range_to_unit = range_to_unit - camzoomspeed;
			 };	   
		  }
		  else
		  {
			 if (range_to_unit < maxzoomout) then
			 {
				range_to_unit = range_to_unit + camzoomspeed;
			 };	   
		  };
		};	
	};	
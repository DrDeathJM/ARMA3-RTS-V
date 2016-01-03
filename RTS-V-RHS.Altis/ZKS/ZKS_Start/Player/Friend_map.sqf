
//"colorblue","colorred","colorgreen",
//_colorarray = ["coloryellow","colorOrange","colorpink","ColorBrown"];
	while {alive player} do
	{
	waituntil {(visibleMap)};

	
	_markers = [];
	_colorarray = ["colorOrange"];
	_mktype = "b_inf";
	_c = 0;

	{if (side _x == side player) then {
	_color = (_colorarray select _c);
	
		{
		_marker = str(_x);
		_marker = createMarkerLocal [_marker, (position _x)];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerSizeLocal [.4, .4];
		_marker setMarkerTypeLocal _mktype;
		_marker setMarkerTextLocal name _x; 
		_marker setmarkercolorLocal _color;
		_markers = _markers + [[_marker,_x]];
		} foreach units group _x;

	_c = 0;//if (_c > 5) then {0}else{_C + 1};
	
	
	}} foreach playableUnits;


		while {(visibleMap)} do
		{
		{(_x select 0) setMarkerposLocal (position  (_x select 1));} foreach _markers;
		sleep 1;
		};

	{deleteMarkerLocal (_x select 0)} foreach _markers;
	sleep 1;
	};



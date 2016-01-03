	if (diag_tickTime >= (RTMS_OCCLUSION_CHECK_RATE + RTMS_LAST_OCCLUSION_CHECK)) then
	{
		RTMS_LAST_OCCLUSION_CHECK = diag_tickTime;
		RTMS_OCCLUSION_CAN_CHECK = true;
	};
	
	if (RTMS_QPM_DOWN && alive player) then
	{
		call RTMS_DrawPersonalMenu;
	};
	
	if ((!alive player) || ((vehicle player) != player)) exitWith
	{
		RTMS_MENU_DISABLED = true;
	};
	RTMS_MENU_DISABLED = false;
	private ["_scanTime", "_scanDistance", "_cleanupTime", "_reqOverride"];
	_scanTime = RTMS_SCAN_RATE;
	_scanDistance = RTMS_CACHE_DISTANCE;
	_cleanupTime = 1;
	_reqOverride = false;
	
	if (!(RTMS_REQUESTS isEqualTo [])) then
	{
			_reqOverride = call RTMS_ProcessRequests;
	};
	
	if (diag_tickTime >= (_cleanupTime + RTMS_LAST_CLEANUP)) then
	{
		RTMS_LAST_CLEANUP = diag_tickTime;
		if (!(RTMS_CLEANUP_LIST isEqualTo [])) then
		{
			_null =
			{
				deleteVehicle _x;
				false
			} count RTMS_CLEANUP_LIST;
			RTMS_CLEANUP_LIST = [];
		};
	};
	
	if ((diag_tickTime >= (_scanTime + RTMS_LAST_SCAN)) || _reqOverride) then
	{
		RTMS_LAST_SCAN = diag_tickTime;
		[_scanDistance] call RTMS_ScanEnvironment;
		//RTMS_HAND_POS = player selectionPosition "LeftHand";
	};
	
	private ["_return", "_i", "_last", "_j", "_exists", "_current", "_conditionA", "_conditionB", "_conditionC", "_house", "_doorPos", "_phase", "_modelPos"];
	_i = 0;
	_j = 0;
	_exists = false;
	RTMS_DISPLAYED = [];
	
	RTMS_DISPLAYED_COUNT =
	{
		_return = false;
		if (!isNull _x) then
		{
			
			_modelPos = [((_x getVariable "RTMS_ACTIVE_MENU") select 0) getVariable "CLASS_MODEL_POSITION", [0,0,0]] select ((!alive _x) && (_x isKindOf "Man"));
			if (!isNil {_x getVariable "RTMS_DOOR_OPEN"}) then
			{
				_house = _x getVariable "RTMS_HOUSE";
				
				_doorPos = (_house selectionPosition [(_x getVariable "RTMS_OPEN_PT"), (_x getVariable "RTMS_MODEL_TYPE")]);
				
				if ((_x getVariable "RTMS_SELECTION_NAME") != (format ["Door_handle_%1_axis", _x getVariable "CLASS_DOOR_NUMBER"])) then
				{
					_doorPos set [2, (_house worldToModel (player modelToWorldVisual [0,0,1.2])) select 2];
				};
				
				_doorPos = _house modelToWorld _doorPos;
				if (!(_doorPos isEqualTo (_x getVariable "RTMS_DOOR_POS"))) then
				{
					_x setVariable ["RTMS_DOOR_POS", _doorPos];
					_x setVariable ["RTMS_ICON_CENTER", _doorPos];
					//_x setPosATL (_x getVariable "RTMS_DOOR_POS");
				};
				
			}
			else
			{
				_x setVariable ["RTMS_ICON_CENTER", _x modelToWorldVisual _modelPos];
			};
			
			_x setVariable ["RTMS_OBJECT_CENTER", _x modelToWorldVisual [0,0,0]];
			_conditionA = ((_x getVariable "RTMS_SUB_COUNT") != 0);
			_conditionB = ((((_x getVariable "RTMS_ACTIVE_MENU") select 0) getVariable "CLASS_CONDITION_NAMESPACE") getVariable "RTMS_SHOW");
			_conditionC = ((_x getVariable "RTMS_DISTANCE") >= (player distance (_x getVariable "RTMS_OBJECT_CENTER")));
			if ((_conditionA || _conditionB) && _conditionC) then
			{
				if ((_x call RTMS_BlockedView) || (_x == player)) exitWith {};
				RTMS_DISPLAYED pushBack _x;
				//player sideChat "ADDING";
				if (_x == (RTMS_SELECTED_MENU select 0)) then
				{
					RTMS_SELECTED_MENU set [1, _j];
					_exists = true;
				};
			
				//key selected is true if key eh wants to select something but sees no visual index 
				if (RTMS_KEY_SELECTED) then
				{
						_current = (eyeDirection player) vectorCos ((eyePos player) vectorFromTo (AGLToASL (_x getVariable "RTMS_ICON_CENTER")));
						if (!isNil "_last") then
						{
							if (_last < _current) then
							{
								_last = _current;
								RTMS_VISUAL_INDEX = _j;
								_exists = true;
							};
						}
						else
						{
							_last = _current;
							RTMS_VISUAL_INDEX = _j;
							_exists = true;
						};
				}
				else
				{
					_current = (eyeDirection player) vectorCos ((eyePos player) vectorFromTo (AGLToASL (_x getVariable "RTMS_ICON_CENTER")));
					if (!isNil "_last") then
					{
						if (_last < _current) then
						{
							_last = _current;
							RTMS_VIP = _j;
						};
					}
					else
					{
						_last = _current;
						RTMS_VIP = _j;
					};
				};
				_j = _j + 1;
				_return = true;
			};
		};
		_i = _i + 1;
		
	_return
	} count RTMS_TO_DISPLAY;
	
	RTMS_OCCLUSION_CAN_CHECK = false;
	
	if (!_exists && (RTMS_VISUAL_INDEX >= 0)) then
	{
		RTMS_SELECTED_MENU = [objNull, -1];
		RTMS_SELECTED_SUB_MENU = [false, 0];
		RTMS_VISUAL_INDEX = -1;
		RTMS_ROTATOR_DIR = 90;
		RTMS_MENU_STACK = [];
		RTMS_STACK_COUNT = 0;
		RTMS_STACK_COEFF = 0;
	}
	else
	{
		if (RTMS_KEY_SELECTED && _exists) then
		{
			RTMS_SELECTED_MENU = [(RTMS_DISPLAYED select RTMS_VISUAL_INDEX), RTMS_VISUAL_INDEX];
			RTMS_MENU_HIDDEN = false;
		};
	};
	
	RTMS_KEY_SELECTED = false; //clear keyboard event
	
	/**
	hint format
	[
		"VISUAL: %1\nCACHE: %2\nKEY NEEDED: %3\nGARBAGE: %4\nSELECTED: %5\nVISUAL INDEX: %6\nCENTER INDEX: %7",
		count RTMS_DISPLAYED,
		RTMS_TO_DISPLAY_COUNT,
		RTMS_KEY_SELECTED,
		count RTMS_CLEANUP_LIST,
		RTMS_SELECTED_MENU select 1,
		RTMS_VISUAL_INDEX,
		RTMS_CENTER_INDEX
	];
	**/
	//player setVariable ["RTMS_TEST_COM", [0,0,1]];
	//hint format ["%1", [{_null = player modelToWorldVisual (player getVariable "RTMS_TEST_COM")}, nil, 9999] call CBA_fnc_benchmarkFunction];
	call RTMS_DrawMenus;
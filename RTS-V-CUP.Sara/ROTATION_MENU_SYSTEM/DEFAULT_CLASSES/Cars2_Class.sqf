private ["_return", "_class", "_text", "_modelPosition", "_icon", "_menuItems", "_obj", "_mainColor", "_mainScript", "_distance", "_condition"];

_class = "Car";

_text = "EXPAND";

_modelPosition = [0,0,-0.5];

_icon = "\A3\soft_f\Offroad_01\Data\UI\map_offroad_01_CA.paa";

_mainColor = [0,1,0,1];

_mainScript = []; //takes form [[ARGS], CODE], otherwise empty array []

_distance = RTMS_DEFAULT_DISTANCE;

_condition = []; //takes form [[ARGS], CODE] where code must return true or false, otherwise empty array []

	//["Driver", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInDriver, [], _distance, []],
	//	["Passenger", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInPassenger, [], _distance, []],
		//["Backseat", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInBackseat, [], _distance, []],
		//["Lock", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_LockVehicle, [], _distance, []]
_menuItems = 
	[
		["", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", {}, [], _distance, [], RTMS_DEFAULT_SUB_ICON]
	];
	
_return = [_class, _text, _modelPosition, _icon, _menuItems, _mainColor, _mainScript, _distance, _condition];
_return;
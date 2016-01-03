private ["_return", "_class", "_text", "_modelPosition", "_icon", "_menuItems", "_obj", "_mainColor", "_mainScript", "_distance", "_condition"];

_class = "Plane";

_text = "EXPAND";

_modelPosition = [0,2,-0.5];

_icon = "\A3\Air_F_EPC\Plane_CAS_02\Data\UI\Map_Plane_cas_02_F.paa";

_mainColor = RTMS_DEFAULT_COLOR;

_mainScript = []; //takes form [[ARGS], CODE], otherwise empty array []

//_distance = RTMS_DEFAULT_DISTANCE + 1;
_distance = "ADAPT";

_condition = []; //takes form [[ARGS], CODE] where code must return true or false, otherwise empty array []

	//["Driver", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInDriver, [], _distance, []],
	//	["Passenger", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInPassenger, [], _distance, []],
		//["Backseat", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInBackseat, [], _distance, []],
		//["Lock", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_LockVehicle, [], _distance, []]
_menuItems = 
	[
	];
	
_return = [_class, _text, _modelPosition, _icon, _menuItems, _mainColor, _mainScript, _distance, _condition];
_return;
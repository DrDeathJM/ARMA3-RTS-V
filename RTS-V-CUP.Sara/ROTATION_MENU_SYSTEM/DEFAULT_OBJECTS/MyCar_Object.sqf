private ["_return", "_text", "_modelPosition", "_icon", "_menuItems", "_obj", "_mainColor", "_mainScript", "_distance", "_condition"];
	
_obj = "C_Offroad_01_F" createVehicle getPosATL player;

_text = "EXPAND";

_modelPosition = [0,0,0];

_icon = "\A3\soft_f\Offroad_01\Data\UI\map_offroad_01_CA.paa";

_mainColor = [0,1,0,0.5];

_mainScript = []; //takes form [[ARGS], CODE], otherwise empty array []

_distance = RTMS_DEFAULT_DISTANCE;

_condition = [[_obj], {((player distance (_this select 0)) <= 5)}]; //takes form [[ARGS], CODE] where code must return true or false, otherwise empty array []

private "_subA";
private "_subB";
_subB = 	
[
	["Another", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInDriver, [], _distance, [], RTMS_DEFAULT_SUB_ICON],
	["Menu", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInPassenger, [], _distance, [], RTMS_DEFAULT_SUB_ICON],
	["LOL", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", {}, [], _distance, [], RTMS_DEFAULT_SUB_ICON],
	["GTFO", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", {}, [], _distance, [[_obj], {((player distance (_this select 0)) <= 2)}], RTMS_DEFAULT_SUB_ICON]
];
_subA = 	
[
	["This", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInDriver, [], _distance, [], RTMS_DEFAULT_SUB_ICON],
	["Is", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInPassenger, [], _distance, [], RTMS_DEFAULT_SUB_ICON],
	["My", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_PushSubMenu, [_subB], _distance,  [[], {((player distance (_this select 0)) <= 3)}], "\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa"],
	["Menu", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", {}, [], _distance, [[_obj], {((player distance (_this select 0)) <= 2)}], RTMS_DEFAULT_SUB_ICON]
];	
_menuItems = 	
[
	["Driver", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInDriver, [], _distance, [], RTMS_DEFAULT_SUB_ICON],
	["Passenger", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_GetInPassenger, [], _distance, [], RTMS_DEFAULT_SUB_ICON],
	["Backseat", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", RTMS_PushSubMenu, [_subA], _distance, [], RTMS_DEFAULT_SUB_ICON],
	["Lock", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", {}, [], _distance - 2, [[], {((player distance (_this select 0)) <= 2)}], RTMS_DEFAULT_SUB_ICON]
];
	
_return = [_obj, _text, _modelPosition, _icon, _menuItems, _mainColor, _mainScript, _distance, _condition];
_return;
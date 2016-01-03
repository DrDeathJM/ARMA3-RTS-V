private ["_return", "_class", "_text", "_modelPosition", "_icon", "_menuItems", "_obj", "_mainColor", "_mainScript", "_distance", "_condition"];

_class = "logic";

_text = "";

_modelPosition = [0,0,0];

_icon = "A3\ui_f\data\IGUI\Cfg\Actions\open_door_ca.paa";

_mainColor = RTMS_DEFAULT_COLOR;

_mainScript = []; //takes form [[ARGS], CODE], otherwise empty array []

_distance = 0;

_condition = []; //takes form [[ARGS], CODE] where code must return true or false, otherwise empty array []

_menuItems = 
	[
	];
	
_return = [_class, _text, _modelPosition, _icon, _menuItems, _mainColor, _mainScript, _distance, _condition];
_return;
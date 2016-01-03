private ["_return", "_text", "_modelPosition", "_icon", "_menuItems", "_obj", "_mainColor", "_mainScript", "_distance", "_condition"];
	
_obj = "Flag_Altis_F" createVehicle getPosATL player;  

_text = "EXPAND";

_modelPosition = [0,0,0];

_icon = getText (configFile/"CfgVehicles"/typeOf _obj/"Icon");

_mainColor = [0,1,0,0.5];

_mainScript = []; //takes form [[ARGS], CODE], otherwise empty array []

_distance = 10;

_condition = [[_obj], {((player distance (_this select 0)) <= 0)}]; //takes form [[ARGS], CODE] where code must return true or false, otherwise empty array []
	
_menuItems = 	
[
];
	
_return = [_obj, _text, _modelPosition, _icon, _menuItems, _mainColor, _mainScript, _distance, _condition];
_return;
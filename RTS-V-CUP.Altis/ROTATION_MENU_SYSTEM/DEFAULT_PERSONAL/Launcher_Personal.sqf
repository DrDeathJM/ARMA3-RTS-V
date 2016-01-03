private ["_return", "_text", "_size", "_icon", "_save", "_key", "_mainColor", "_mainScript", "_priority", "_condition"];
	
_key = "launcher_weapon";

_text = "Launcher";

_size = [5,5];

_icon = RTMS_DEFAULT_LAUNCH_ICON;

_mainColor = [1,1,1,1];

_mainScript = [["LAUNCHER"], RTMS_SelectWeapon]; //takes form [[ARGS], CODE], otherwise empty array []

_priority = 2;

_condition = [[], {(player == vehicle player) && ((secondaryWeapon player) != "")}]; //takes form [[ARGS], CODE] where code must return true or false, otherwise empty array []
	
_save = true;
	
_return = [_key, _text, _size, _icon, _save, _mainColor, _mainScript, _priority, _condition];
_return;
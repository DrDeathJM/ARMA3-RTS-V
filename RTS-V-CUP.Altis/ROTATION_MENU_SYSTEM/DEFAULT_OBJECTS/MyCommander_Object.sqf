/**
Dear user,

	I am glad you are choosing the Rotation Menu System to make your external action menu. But here are a few pieces of information...
	
	1.  - Only use the main script if your menu will be the only one attached to objects of the specified class/object AND you have no sub menus. (just a lone icon)
	    - If you know your menu has priority, and sub menus are getting stacked on the objects, think of the main script as something that will run when you expand your menu.
		- It is recommended that you never use the main script unless you are ABSOLUTELY SURE objects of the specified class ONLY get your single menu icon with no sub menus...
		- Really, just dont use it unless you have a very special idea :)

	2.  - When different menus all want to attach onto the same object (whether class, or direct object menu), their sub menus will simply all get piled on to the object.
		- The menus that get piled on will be displayed by expanding your main icon, and they will appear in a neat circle, which you can rotate for selection.
		- A sub menu can expand to another sub menu instead of executing a script. 
		- This sub-sub menu can operate as a private space for your custom menu rather than getting pool'd with the other sub menus. (this is the greatest strength of the Rotation Menu System)
	
	3.  - Priority is given to direct object menus first.
	    - A direct object menu uses an object. They get directly attached to that single object, and never get deallocated.
		- The first direct object menu, which is added to DefaultMenuObjects.sqf, gets the highest priority and always overtakes anything else if attached to that specified object.
		- Class based menus that get attached to the specified object will have priority based on the lowest sub class. 
		- Basically, the most concrete classes get the highest priority, while the most abstract classes get the lowest priority ("Plane" is more concrete than "Air" in arma 3)
	
	4.  - "_condition" will NOT have the object the menu is attached to already set as the first argument
		- Only use "_condition" as a means of GLOBALLY controlling whether your menu should be displayed or not (includes your sub menus too)
		
**/

/**
	SUB MENU FORM:
	
		_menuItems = 
				[
						
					<sub menu array>,
					<sub menu array>,
					...
						
					[
						display text <string>, 
						color RGBA <array size 4>, 
						icon size <float>, 
						text size <float>, 
						font <string>, 
						script <code>, 
						args with object first automatically <array>, 
						distance <float>, 
						condition < [[ARGS], CODE], otherwise empty array [], args with object first automatically  >,
						icon path <string>
					],
						
					<sub menu array>,
					<sub menu array>,
					....
				];
**/

//************************ THE MENU **********************************************

private ["_return", "_text", "_modelPosition", "_icon", "_menuItems", "_obj", "_mainColor", "_mainScript", "_distance", "_condition"];

_obj = objNull; //put an object here, such as a soldier or vehicle

_text = ""; //text you want to display on the icon if this menu has priority

_modelPosition = [0,0,0]; //where, in model space, you want to display the menu icon

_icon = "\A3\soft_f\Offroad_01\Data\UI\map_offroad_01_CA.paa"; //This is the icon texture path. Replace this with a similar path to another icon, or make a custom one

_mainColor = RTMS_DEFAULT_COLOR; //color of the icon if this menu has priority, currently set at default

_mainScript = []; //takes form [[ARGS], CODE], otherwise empty array []
				  //[ARGS] automatically have the attached object as the first argument (_this select 0)

_distance = RTMS_DEFAULT_DISTANCE;  //distance before you can see and select the icon AND sub menus! 
									//Other sub menus attached to the object of specified "_class" will display if they have a higher distance, and your sub menu's will be hidden

_condition = []; //takes form [[ARGS], CODE] where code must return true or false, otherwise empty array []
				 //[ARGS] will NOT automatically have the attached object as the first argument (_this select 0)




//only sub menu in "_menuItems" is a custom action with the display text "Inventory". It is already made for you to see and opens the objects inventory.

_menuItems = 
	[
		["Inventory", RTMS_DEFAULT_SUB_COLOR, RTMS_DEFAULT_SUB_SIZE, RTMS_DEFAULT_SUB_TEXT_SIZE, "PuristaMedium", {player action ["Gear", (_this select 0)];}, [], _distance, [[], {(alive (_this select 0))}], "A3\ui_f\data\IGUI\Cfg\Actions\gear_ca.paa"]
	];
	
	
	
//these lines return all the settings in this menu	
_return = [_obj, _text, _modelPosition, _icon, _menuItems, _mainColor, _mainScript, _distance, _condition];
_return;
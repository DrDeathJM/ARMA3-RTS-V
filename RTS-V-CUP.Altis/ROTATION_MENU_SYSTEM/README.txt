****************************READ EACH STEP CAREFULLY IN THIS ORDER*********************************

1. PLACE IN "init.sqf" TO START THE SYSTEM:
---------------------------------------
	
call compile preProcessFile "ROTATION_MENU_SYSTEM\InitRotationMenuSystem.sqf";
_null = [] spawn RTMS_InitRotationMenuSystem;




2. PLACE IN YOUR OWN SCRIPTS:
--------------------------

waitUntil {!isNil "RTMS_INITIALIZED"};
... code that will use rotation menu system ...
... code that will use rotation menu system ...
... code that will use rotation menu system ......




3. LOADING A MENU:
-------------

- You can use LoadDefaultClasses.sqf or LoadDefaultObjects.sqf to load your menu sqf file

a. Just open the file for your type of menu file (class or Direct Object attach)
b. Then place the path in the _return list in format "PATH\MenuFile.sqf"
c. Check out LoadDefaultClasses.sqf with the built in defaults as an example


- OR THESE FUNCTIONS DURING RUNTIME

a. _menuParameters = call compile preProcessFile "PATH\MenuFile.sqf"; //get the parameters
b. _menuObject = _menuParameters call RTMS_CreateMenuObject; //create the menu
c. [_menuObject, true] call RTMS_SendRequest; //load the menu
d. waitUntil {[_menuObject] call RTMS_IsInstalled}; //if you want to do anything else with the menu object such as removing it




4. UNLOADING A MENU:
----------------

a. waitUntil {[_menuObject] call RTMS_IsInstalled}; //make sure its loaded in the first place
b. [_menuObject, false] call RTMS_SendRequest; //unload the menu (notice false means remove)
if (!isNil "RTMS_MOD_ENABLED") exitWith 
{ 
	RTMS_InitRotationMenuSystem =
	{
		if (!hasInterface) exitWith {};
		waitUntil {player == player};
		waitUntil{!(isNil "BIS_fnc_init")};
		waitUntil {time > 1};

		player sideChat "RTMS: Canceling Mission Module"; 
		diag_log "RTMS: Canceling Mission Module";
	};
};

RTMS_ROOT_DIR = "";

/**
RTMS_InBoundingBox =
{
	private ["_return", 
				"_boundingBox",
				"_i",
				"_pos"
			];
			_i = -1;
			_boundingBox = boundingBoxReal (_this select 0);
			_pos = (_this select 0) worldToModelVisual (player modelToWorldVisual [0,0,1.4]);
			_return = ({_i = _i + 1; ((_pos select _i) >= (_x - 1))} count (_boundingBox select 0));
			_i = -1;
			_return = _return + ({_i = _i + 1; ((_pos select _i) <= (_x + 1))} count (_boundingBox select 1));
			(_return == 6)		
};
**/

RTMS_condition = {(RTMS_IN_BOX && (alive (_this select 0)) && (0 == ({alive (_x select 0)} count fullCrew [(_this select 0),(_this select 1)])))};
RTMS_sideCondition = {(RTMS_IN_BOX && (alive (_this select 0)) && (0 == ({(alive (_x select 0)) && ((_x select 3) isEqualTo (_this select 1))} count fullCrew [_this select 0, "turret"])))};
RTMS_cargoCondition = {(RTMS_IN_BOX && (alive (_this select 0)) && ((_this select 1) > ({(alive (_x select 0))} count fullCrew [(_this select 0),"cargo"])))};
RTMS_manTurretCondition = {
	private "_return";
	_return = false;
	(RTMS_IN_BOX && (alive (_this select 0)) && (0 < ({
											if (isNull ((_this select 0) turretUnit _x)) then
											{
												_return = true;
											}
											else
											{
												if (!alive ((_this select 0) turretUnit _x)) then
												{
													_return = true;
												};
											};
											_return
										} count (_this select 1))))
};
RTMS_GetInDriver = {player action ["getInDriver", (_this select 0)];};
RTMS_GetInPassenger = {player action ["getInCargo", (_this select 0), 0];};
RTMS_GetInBackseat = 
{
	private "_lastCodriver";
	private "_transport";
	private "_array";
	_array = getArray (configFile >> "CfgVehicles" >> (typeof (_this select 0)) >> "cargoIsCoDriver[]");
	if (_array isEqualTo []) then 
	{
		_lastCoDriver = 1;
	}
	else
	{
		_lastCodriver = {_x} count _array;
	};
	_transport = getNumber (configFile >> "CfgVehicles" >> (typeof (_this select 0)) >> "transportSoldier");
	if (_transport > _lastCodriver) then
	{
		player action ["getInCargo", (_this select 0), _lastCodriver];
	}
	else
	{
		player sideChat "*** NO BACK SEATS AVAILABLE ***";
	};
};
RTMS_LockVehicle = {};
//RTMS_GetInGunner = {player action ["getInGunner", (_this select 0)];};
RTMS_GetInGunner = {player action ["getInTurret", (_this select 0), [0]];};
RTMS_GetInCommander = {player action ["getInCommander", (_this select 0)];};
RTMS_GetInDefendingPassenger =
{
	private ["_turretUnit", "_return"];
	_return = false;
	{
		_turretUnit = (_this select 0) turretUnit _x;
		if (isNull _turretUnit) then
		{
			player action ["getInTurret", (_this select 0), _x];
			_return = true;
		}
		else
		{
			if (!alive _turretUnit) then
			{
				player action ["getInTurret", (_this select 0), _x];
				_return = true;
			};
		};
		if (_return) exitWith {};
	} foreach (_this select 1);
};
RTMS_DoorOC =
{
	private [
			"_house",
			"_index",
			"_door"
			];
			_door = _this select 0;
			_index = _this select 1;
			
			_house = _door getVariable "RTMS_HOUSE";
			
			if (!isNil {_door getVariable "RTMS_DOOR_OPEN"}) then
			{
				if (!isClass (configFile >> "cfgVehicles" >> (typeOf _house) >> "AnimationSources" >> format ["%1B_source", _door getVariable "RTMS_SELECTION_NAME"])) then
				{
					if (((_house animationPhase format["Door_%1_rot", _index]) >= 0.5)) then
					{
						[_house, format ["Door_%1_rot", _index], format ["Door_Handle_%1_rot_1", _index], format ["Door_Handle_%1_rot_2", _index]] call BIS_fnc_DoorClose;
					};
					if (((_house animationPhase format["Door_%1_rot", _index]) < 0.5)) then
					{
						[_house, format ["Door_%1_rot", _index], format["Door_Handle_%1_rot_1", _index], format ["Door_Handle_%1_rot_2", _index]] call BIS_fnc_DoorOpen;
					};
				}
				else
				{
					if (((_house animationPhase format["Door_%1A_move", _index]) >= 0.5)) then
					{
						[_house, format ["Door_%1A_move", _index], format ["Door_%1B_move", _index]] call BIS_fnc_TwoWingSlideDoorClose;
					};
					if (((_house animationPhase format["Door_%1A_move", _index]) < 0.5)) then
					{
						[_house, format ["Door_%1A_move", _index], format ["Door_%1B_move", _index]] call BIS_fnc_TwoWingSlideDoorOpen;
					};
				};
			};
};
RTMS_DoorOCAdvanced =
{
	private [
			"_door",
			"_house",
			"_conditions",
			"_scripts"
	];
	_door = _this select 0;
	_house = _door getVariable "RTMS_HOUSE";
	_conditions = _this select 1;
	_scripts = _this select 2;
	
	{
		if (_house call _x) then
		{
			_house call (_scripts select _forEachIndex);
		};
	} foreach _conditions;
};
RTMS_HatchOC =
{
	private [
			"_house",
			"_index",
			"_door"
			];
			_door = _this select 0;
			_index = _this select 1;
			
			_house = _door getVariable "RTMS_HOUSE";
			
			if (!isNil {_door getVariable "RTMS_DOOR_OPEN"}) then
			{
				if (((_house animationPhase format["Hatch_%1_rot", _index]) >= 0.5)) then
				{
					[_house, format ["Hatch_%1_rot", _index]] call BIS_fnc_HatchClose;
				};
				if (((_house animationPhase format["Hatch_%1_rot", _index]) < 0.5)) then
				{
					[_house, format ["Hatch_%1_rot", _index]] call BIS_fnc_HatchOpen;
				};
			};
};
RTMS_LadderUp =
{
	private ["_ladder", "_index", "_house"];
	
	_ladder = _this select 0;
	_index = _this select 1;
	
	_house = _ladder getVariable "RTMS_HOUSE";
	if ((getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1) exitWith {};
	//player action ["ladderOff", _house];
	player action ["ladderUp", _house, _index, 0];
};
RTMS_LadderDown = 
{
	private ["_ladder", "_index", "_house"];
	
	_ladder = _this select 0;
	_index = _this select 1;
	
	_house = _ladder getVariable "RTMS_HOUSE";
	if ((getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1) exitWith {};
	player action ["ladderDown", _house, _index, 1];
};
RTMS_SelectWeapon =
{
	if ((_this select 0) == "PRIMARY") then
	{
		if ((primaryWeapon player) != "") then
		{
			private['_type', '_muzzles'];
 
			_type = primaryWeapon player;
			// check for multiple muzzles (eg: GL)
			_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");
 
			if (count _muzzles > 1) then
			{
				player selectWeapon (_muzzles select 0);
			}
			else
			{
				player selectWeapon _type;
			};
		};
	};
	
	if ((_this select 0) == "HANDGUN") then
	{
		if ((handgunWeapon player) != "") then
		{
			private['_type', '_muzzles'];
 
			_type = handgunWeapon player;
			// check for multiple muzzles (eg: GL)
			_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");
 
			if (count _muzzles > 1) then
			{
				player selectWeapon (_muzzles select 0);
			}
			else
			{
				player selectWeapon _type;
			};
		};
	};
	
	if ((_this select 0) == "LAUNCHER") then
	{
		if ((secondaryWeapon player) != "") then
		{
			private['_type', '_muzzles'];
 
			_type = secondaryWeapon player;
			// check for multiple muzzles (eg: GL)
			_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");
 
			if (count _muzzles > 1) then
			{
				player selectWeapon (_muzzles select 0);
			}
			else
			{
				player selectWeapon _type;
			};
		};
	};
};
/*
RTMS_Parameters = 
{
	RTMS_SCAN_RATE = 0.25; //how often you want to cache menu objects for use by draw EH and keyboard EH, higher means more delay but more performance
	RTMS_CACHE_DISTANCE = 20;  //the distance you want to pre-load menu objects, higher means less performance but less delay
	RTMS_KEY_UP = 0xC8;
	RTMS_KEY_DOWN = 0xD0;
	RTMS_KEY_LEFT = 0xCB;
	RTMS_KEY_RIGHT = 0xCD;
	RTMS_KEY_SHIFT = false;
	RTMS_KEY_CTRL = false;
	RTMS_KEY_ALT = false;
	RTMS_DEFAULT_DISTANCE = 5;
	RTMS_DEFAULT_COLOR = [1,0,0,0.5];
	RTMS_DEFAULT_SUB_COLOR = [1,1,1,0.75];
	RTMS_DEFAULT_SUB_SIZE = 2;
	RTMS_DEFAULT_SUB_TEXT_SIZE = 0.04;
	RTMS_DEFAULT_SIZE = (1.5/2) * RTMS_DEFAULT_SUB_SIZE;
	RTMS_DEFAULT_TEXT_SIZE = (0.03/0.04) * RTMS_DEFAULT_SUB_TEXT_SIZE;
};
*/

RTMS_PushSubMenu = 
{
	private ["_object", "_lastSubMenu", "_subMenu", "_tempArray", "_menuObject", "_logicObject", "_newSubCondition", "_selector"];
	_object = _this select 0;
	_subMenu = _this select 1;
	_lastSubMenu = RTMS_SELECTED_SUB_MENU select 1;
	
	RTMS_MENU_STACK pushBack [_subMenu, _lastSubMenu, RTMS_ROTATOR_DIR];
	_object setVariable ["RTMS_SUB_COUNT", count _subMenu];
	_object setVariable ["RTMS_ROTATE_DELTA", 360 / (_object getVariable "RTMS_SUB_COUNT")];
	RTMS_STACK_COUNT = RTMS_STACK_COUNT + 1;
	RTMS_SELECTED_SUB_MENU set [0, true];
	if (RTMS_STACK_COUNT > 1) then
	{
		RTMS_STACK_COEFF = RTMS_STACK_COEFF + (RTMS_DEFAULT_RC * count ((RTMS_MENU_STACK select (RTMS_STACK_COUNT - 2)) select 0));
		RTMS_ROTATOR_DIR = 90;
		RTMS_SELECTED_SUB_MENU set [1, 0];
		if ((count (_subMenu select 0)) < 11) then
		{
			_selector = ((RTMS_MENU_STACK select (RTMS_STACK_COUNT - 2)) select 0) select _lastSubMenu;
			_null =
			{
				_x pushBack (_selector select 10);
				false
			} count _subMenu;
		};
		[RTMS_ROTATOR_DIR, RTMS_ROTATOR_DIR, RTMS_MENU_ROTATOR, round (1440 / (_object getVariable "RTMS_SUB_COUNT"))] call RTMS_SetRotator;
	};
};
RTMS_PopSubMenu =
{
	private ["_object", "_lastSubMenu", "_subMenu", "_menuObject"];
	_object = _this select 0;

	if (RTMS_STACK_COUNT > 0) then
	{
		_subMenu = RTMS_MENU_STACK deleteAt (RTMS_STACK_COUNT - 1);
		_lastSubMenu = _subMenu select 1;
		RTMS_STACK_COUNT = RTMS_STACK_COUNT - 1;
	};
	if (RTMS_STACK_COUNT == 0) then
	{
		RTMS_SELECTED_SUB_MENU set [0, false];
		_object setVariable ["RTMS_SUB_COUNT", count (_object getVariable "RTMS_SUB_MENU_LIST")];
		RTMS_STAC_COEFF = 0;
	}
	else
	{
		RTMS_SELECTED_SUB_MENU set [1, _lastSubMenu];
		RTMS_ROTATOR_DIR = _subMenu select 2;
		_object setVariable ["RTMS_SUB_COUNT", count ((RTMS_MENU_STACK select (RTMS_STACK_COUNT - 1)) select 0)];
		RTMS_STACK_COEFF = RTMS_STACK_COEFF - (RTMS_DEFAULT_RC * (_object getVariable "RTMS_SUB_COUNT"));
	};
	_object setVariable ["RTMS_ROTATE_DELTA", 360 / (_object getVariable "RTMS_SUB_COUNT")];
	[RTMS_ROTATOR_DIR, RTMS_ROTATOR_DIR, RTMS_MENU_ROTATOR, round (1440 / (_object getVariable "RTMS_SUB_COUNT"))] call RTMS_SetRotator;
};

RTMS_CreateMenuObject =
{
	private "_args";
	private "_logic";
	private "_conditionNamespace";
	_conditionNamespace = objNull;
	_args = [];
	_args append _this;	
	_logic = "logic" createVehicleLocal [0,0,0];
	{
		_logic setVariable [(_x select 0), _args select (_x select 1)];
	} foreach [["CLASS_NAME", 0], ["CLASS_TEXT", 1], ["CLASS_MODEL_POSITION", 2], ["CLASS_ICON", 3], ["CLASS_MENU_ITEMS", 4], ["CLASS_MAIN_COLOR", 5], ["CLASS_MAIN_SCRIPT", 6], ["CLASS_DISTANCE", 7]];
	
	if ((_args select 8) isEqualTo []) then
	{
		_conditionNamespace = RTMS_DEFAULT_CONDITION_NS;
	} 
	else
	{
		_conditionNamespace = "logic" createVehicleLocal [0,0,0];
		_conditionNamespace setVariable ["RTMS_SHOW", false];
		_conditionNamespace setVariable ["RTMS_CONDITION", (_args select 8)];
		RTMS_CONDITION_OBJECTS pushBack _conditionNamespace;
	}; 
	
	{
		_x pushBack _conditionNamespace;
		if (("string" != typeName (_args select 7)) && ("string" != typeName (_x select 7))) then
		{
			_x set [7, ([(_x select 7), (_args select 7)] select ((_args select 7) < (_x select 7)))];
		};
	} foreach (_logic getVariable "CLASS_MENU_ITEMS");
	
	_logic setVariable ["CLASS_CONDITION_NAMESPACE", _conditionNamespace];
	_logic setVariable ["CLASS_SUPER_CLASS", ""];
	_logic setVariable ["CLASS_RANK", 0];
	_logic;
};

RTMS_CreatePersonalMenuObject =
{
	private "_args";
	private "_logic";
	_args = [];
	_args append _this;	
	_logic = "logic" createVehicleLocal [0,0,0];
	{
		_logic setVariable [(_x select 0), _args select (_x select 1)];
	} foreach [["CLASS_KEY", 0], ["CLASS_TEXT", 1], ["CLASS_SIZE", 2], ["CLASS_ICON", 3], ["CLASS_SAVE", 4], ["CLASS_MAIN_COLOR", 5], ["CLASS_MAIN_SCRIPT", 6], ["CLASS_PRIORITY", 7], ["CLASS_CONDITION", 8]];
	
	_logic;
};

RTMS_CopyMenuObject =
{
	private "_logic";
	_logic = _this select 0;
	//deep copy the logic
	_newLogic = "logic" createVehicleLocal [0,0,0];
	
	//shallow copy the variables
	_null = 
	{
		_newLogic setVariable [_x, _logic getVariable _x];
		false
	} count 
			[
				"CLASS_NAME", 
				"CLASS_TEXT", 
				"CLASS_MODEL_POSITION", 
				"CLASS_ICON", 
				"CLASS_MENU_ITEMS", 
				"CLASS_MAIN_COLOR", 
				"CLASS_MAIN_SCRIPT", 
				"CLASS_SUPER_CLASS", 
				"CLASS_RANK",
				"CLASS_DISTANCE",
				"CLASS_CONDITION_NAMESPACE"
			];
	_newLogic;
	
};

RTMS_DeleteMenuObject = 
{
	if ([(_this select 0)] call RTMS_IsInstalled) exitWith {diag_log "RTMS: Tried to delete installed object";};
	if (((_this select 0) getVariable "CLASS_CONDITION_NAMESPACE") != RTMS_DEFAULT_CONDITION_NS) then
	{
		RTMS_CONDITION_OBJECTS = RTMS_CONDITION_OBJECTS - [((_this select 0) getVariable "CLASS_CONDITION_NAMESPACE")];
		deleteVehicle ((_this select 0) getVariable "CLASS_CONDITION_NAMESPACE");
	};
	deleteVehicle (_this select 0);
};

RTMS_AddMenuObject =
{
	private "_logic";
	private "_object";
	_logic = _this select 0;
	_object = _logic getVariable "CLASS_NAME";
	
	[[_logic], _object] call RTMS_InstallMenuObjects;
	RTMS_OBJECTS_LIST pushBack _logic;
};

RTMS_SendRequest =
{
	private "_logic";
	private "_method";
	_logic = _this select 0;
	_method = _this select 1;
	RTMS_REQUESTS pushBack [_logic, _method];
};

RTMS_InstallMenuObjects =
{
	private ["_logics", "_logic", "_object", "_return", "_subCount", "_distance", "_menuItems", "_temp", "_adpDistance"];
	_logics = _this select 0;
	_object = _this select 1;
	_distance = 0;
	_temp = [];
	_return = false;
	
	if ((isNull _object) || (0 < ({isNull _x} count _logics))) exitWith {_return;};
	
	
	if (isNil {_object getVariable "RTMS_ACTIVE_MENU"}) then
	{
		_object setVariable ["RTMS_ACTIVE_MENU", _logics];
		_object setVariable ["RTMS_SUB_MENU_LIST", []];
		_object setVariable ["RTMS_SUB_MENU_OPEN", false];
		_return = true;
		//player sideChat format ["NEW INSTALL: %1", count (_object getVariable "RTMS_ACTIVE_MENU")];
	}
	else
	{
		private "_ref";
		private "_count";
		_ref = _object getVariable "RTMS_ACTIVE_MENU";
		_ref append _logics;
		//player sideChat format ["NEW INSTALL: %1", count (_object getVariable "RTMS_ACTIVE_MENU")];
		_return = true;
		_distance = _object getVariable "RTMS_DISTANCE";
	};
	
	_ref = _object getVariable "RTMS_SUB_MENU_LIST";
	_null = 
	{
		if ((((_x getVariable "CLASS_MENU_ITEMS") select 0) select 0) == "") then
		{
			_menuItems = [];
			_menuItems append (_x getVariable "CLASS_MENU_ITEMS");
			_temp = _menuItems deleteAt 0;
			_temp = [_object, (_temp select 1), (_temp select 2), (_temp select 3), (_temp select 4), (_temp select 7), (_temp select 8), (_temp select 9), (_temp select 10)] call RTMS_GetAutoMenus;
			_temp append _menuItems;
			_ref append _temp;
		}
		else
		{
			_ref append (_x getVariable "CLASS_MENU_ITEMS");
		};
		_adpDistance = [_object, (_x getVariable "CLASS_DISTANCE")] call RTMS_AdaptDistance;
		_distance = [_distance, _adpDistance] select (_adpDistance > _distance);
		false
	} count _logics;
	_count = count _ref;
	_object setVariable ["RTMS_SUB_COUNT", _count];
	_object setVariable ["RTMS_SUB_COUNT_PERM", _count];
	_object setVariable ["RTMS_DISTANCE", _distance];
	_count = [1, _count] select (_count > 0);
	_object setVariable ["RTMS_ROTATE_DELTA", 360 / _count];
	_return;
};

RTMS_UninstallMenuObjects =
{
	private ["_logics", "_object", "_ref", "_return", "_logic", "_refB", "_distance", "_temp", "_menuItems"];
	_logics = _this select 0;
	_object = _this select 1;
	_distance = 0;
	_temp = [];
	_return = false;
	
	if ((isNull _object) || (0 < ({isNull _x} count _logics)) || (isNil {_object getVariable "RTMS_ACTIVE_MENU"})) exitWith {_return;};
	
	_ref = _object getVariable "RTMS_ACTIVE_MENU";
	_ref = _ref - _logics;
	
	if (_ref isEqualTo []) exitWith
	{
		_object setVariable ["RTMS_ACTIVE_MENU", nil];
		_object setVariable ["RTMS_SUB_MENU_LIST", nil];
		_object setVariable ["RTMS_SUB_COUNT", nil];
		_object setVariable ["RTMS_SUB_COUNT_PERM", nil];
		_object setVariable ["RTMS_DISTANCE", nil];
		_object setVariable ["RTMS_ROTATE_DELTA", nil];
		_object setVariable ["RTMS_ICON_CENTER", nil];
		_object setVariable ["RTMS_OBJECT_CENTER", nil];
	};
	
	_object setVariable ["RTMS_ACTIVE_MENU", _ref];
	
	_refB = [];
	_object setVariable ["RTMS_SUB_MENU_LIST", _refB];
	
	_null = 
	{
		if ((((_x getVariable "CLASS_MENU_ITEMS") select 0) select 0) == "") then
		{
			_menuItems = [];
			_menuItems append (_x getVariable "CLASS_MENU_ITEMS");
			_temp = _menuItems deleteAt 0;
			_temp = [_object, (_temp select 1), (_temp select 2), (_temp select 3), (_temp select 4), (_temp select 7), (_temp select 8), (_temp select 9), (_temp select 10)] call RTMS_GetAutoMenus;
			_temp append _menuItems;
			_refB append _temp;
		}
		else
		{
			_refB append (_x getVariable "CLASS_MENU_ITEMS");
		};
		_adpDistance = [_object, (_x getVariable "CLASS_DISTANCE")] call RTMS_AdaptDistance;
		_distance = [_distance, _adpDistance] select (_adpDistance > _distance);
		false
	} count _ref;
	
	_count = count _refB;
	_object setVariable ["RTMS_SUB_COUNT", _count];
	_object setVariable ["RTMS_SUB_COUNT_PERM", _count];
	_object setVariable ["RTMS_DISTANCE", _distance];
	_return = true;
	if (1 > _count) exitWith {_return;};
	_object setVariable ["RTMS_ROTATE_DELTA", 360 / _count];
	_return;
};

RTMS_CreateMenuClass = 
{
	private "_args";
	private "_logic";
	_args = [];
	_args append _this;
	
	_logic = _args call RTMS_CreateMenuObject;
	RTMS_CLASS_LIST pushBack _logic;
	call RTMS_MapHierarchy;
};

RTMS_MapPriority =
{
	private "_temp";
	private "_newList";
	_temp = [];
	_newList = [];
	
	{
			_temp pushBack [_x getVariable "CLASS_PRIORITY", _forEachIndex];
	} foreach RTMS_PERSONAL_LIST;
	
	_temp sort true;
	
	{
		_newList pushBack (RTMS_PERSONAL_LIST select (_x select 1));
	} foreach _temp;
	
	RTMS_PERSONAL_LIST = _newList;
};

RTMS_MapHierarchy =
{
	private "_tempArray";
	private "_logic";
	private "_rank";
	private "_newList";
	private "_classCnt";
	_classCnt = (count RTMS_CLASS_LIST) - 1;
	_tempArray = [];
	{
		_rank = 0;
		_logic = _x;
		{
			private "_classA";
			private "_classB";
			private "_ref";
			_classA = _logic getVariable "CLASS_NAME";
			_classB = _x getVariable "CLASS_NAME";
			_ref = _logic getVariable "CLASS_SUPER_CLASS";
			if ((_classA isKindOf _classB) && (_classA != _classB)) then
			{
				_rank = _rank + 1;
				if (_ref == "") then
				{
					_logic setVariable ["CLASS_SUPER_CLASS", _classB];
				}
				else
				{
					if ((_classB isKindOf _ref)) then
					{
						_logic setVariable ["CLASS_SUPER_CLASS", _classB];
					};
				};
				
			};
		} foreach RTMS_CLASS_LIST;
		_logic setVariable ["CLASS_RANK", _rank];
		_tempArray pushBack [_rank, (_classCnt - _forEachIndex), _forEachIndex];
	} foreach RTMS_CLASS_LIST;
	
	//now array is sorted by rank first and old index second;
	_tempArray sort false;
	_newList = [];
	{
		_newList pushBack (RTMS_CLASS_LIST select (_x select 2));
	} foreach _tempArray;
	RTMS_CLASS_LIST = _newList;
	//_null = _newList spawn {sleep 10; player SideChat format ["%1, %2, %3, %4, %5", (_this select 0) getVariable "CLASS_NAME", (_this select 1) getVariable "CLASS_NAME", (_this select 2) getVariable "CLASS_NAME", (_this select 3) getVariable "CLASS_NAME", (_this select 4) getVariable "CLASS_NAME"];};
};

RTMS_LoadMenuClasses =
{
	private "_classFiles";
	_classFiles = _this select 0;
	//player sideChat format ["FILE NUM: %1", count _classFiles];
	//process classes
	{
		private "_args";
		private "_logic";
		_args = call compile preprocessFile (RTMS_ROOT_DIR + _x);
		_logic = _args call RTMS_CreateMenuObject;
		RTMS_CLASS_LIST pushBack _logic;
		if (!((_args select 0) in RTMS_CLASS_NAMES)) then
		{
			RTMS_CLASS_NAMES pushBack (_args select 0);
		};
	} foreach _classFiles;
	
	//map heirarchy
	call RTMS_MapHierarchy;
};

RTMS_LoadMenuObjects =
{
	private "_objectFiles";
	_objectFiles = _this select 0;
	
	//process objects
	{
		private "_args";
		private "_logic";
		_args = call compile preprocessFile (RTMS_ROOT_DIR + _x);
		_logic = _args call RTMS_CreateMenuObject;
		[_logic] call RTMS_AddMenuObject;
	} foreach _objectFiles;
};

RTMS_LoadMenuPersonal =
{
	private "_personalFiles";
	_personalFiles = _this select 0;
	
	//process personal
	{
		private "_args";
		private "_logic";
		_args = call compile preprocessFile (RTMS_ROOT_DIR + _x);
		_logic = _args call RTMS_CreatePersonalMenuObject;
		RTMS_PERSONAL_LIST pushBack _logic;
	} foreach _personalFiles;
	RTMS_PERSONAL_COUNT = count RTMS_PERSONAL_LIST;
	call RTMS_MapPriority;
};

RTMS_UpdateConditions =
{
	_null = 
	{
		_x setVariable ["RTMS_SHOW", ((_x getVariable "RTMS_CONDITION") select 0) call ((_x getVariable "RTMS_CONDITION") select 1)];
		false
	} count RTMS_CONDITION_OBJECTS;
};
RTMS_GetVehiclePos =
{
	if (!RTMS_BOARD_INDICATORS) exitWith {};
	private [
			"_posType",
			"_vehicle",
			"_temp",
			"_path",
			"_return",
			"_index",
			"_fncReturn"
		];
		_vehicle = _this select 0;
		_posType = _this select 1;
		_return = false;
		_index = 0;
		_fncReturn = [0,0,0];
		
		if ("STRING" == typeName _posType) then
		{
			_posType = toUpper _posType;
			if (_posType == "DRIVER") then
			{
				_fncReturn = [0,0,1.5] vectorAdd (_vehicle selectionPosition getText (configFile >> "cfgVehicles" >> typeOf _vehicle >> "memoryPointsGetInDriverDir"));
			};
		};
		if ("ARRAY" == typeName _posType) then
		{
			if ("SCALAR" == typeName (_posType select 0)) then
			{
				private ["_shift", "_displayTurret"];
				_shift = 0;
				_path = configFile >> "cfgVehicles" >> typeOf _vehicle >> "turrets";
				_displayTurret = 
				{
				private ["_path", "_shift", "_index", "_return"];
				_path = _this select 0;
				_shift = _this select 1;
				_index = 0;
				_return = false;
				for "_i" from 0 to ((count _path) - 1) do {
					if (isClass (_path select _i)) then
					{
						if ((("Gunner" == getText ((_path select _i) >> "gunnerName")) && ([] isEqualTo getArray ((_path select _i) >> "weapons"))) || (1 == getNumber ((_path select _i) >> "isPersonTurret")) ) exitWith {};
						
						
						if (_index == (_posType select _shift)) then
						{
							if (_shift < ((count _posType) - 1)) then
							{
								_shift = _shift + 1;
								_path = (_path select _i) >> "turrets";
								[_path, _shift] call _displayTurret;
							}
							else
							{
								_fncReturn = [0,0,1.5] vectorAdd (_vehicle selectionPosition getText ((_path select _i) >> "memoryPointsGetInGunnerDir"));
							_return = true;
							};
						};
						_index = _index + 1;
					};
					if (_return) exitWith {};
				};
				};
				[_path, _shift] call _displayTurret;
			}
			else
			{
				private ["_turretUnit"];
				_path = configFile >> "cfgVehicles" >> typeOf _vehicle >> "turrets";
				for "_i" from 0 to ((count _path) - 1) do {
					if (isClass (_path select _i)) then
					{
						if ((0 == getNumber ((_path select _i) >> "isPersonTurret")) ) exitWith {};
						
						_turretUnit = (_this select 0) turretUnit (_posType select _index);
						
						if (isNull _turretUnit) then
						{
							//drawLine3D [_startingPos, _vehicle selectionPosition getText ((_path select _i) >> "memoryPointsGetInGunner")];
							_fncReturn = [0,0,1.5] vectorAdd (_vehicle selectionPosition getText ((_path select _i) >> "memoryPointsGetInGunnerDir"));
							_return = true;
						}
						else
						{
							if (!alive _turretUnit) then
							{
								//drawLine3D [_startingPos, _vehicle selectionPosition getText ((_path select _i) >> "memoryPointsGetInGunnerDir")];
								_fncReturn = [0,0,1.5] vectorAdd (_vehicle selectionPosition getText ((_path select _i) >> "memoryPointsGetInGunnerDir"));
								_return = true;
							};
						};
						_index = _index + 1;
					};
					if (_return) exitWith {};
				}; 
			};
		};
	_fncReturn;	
};
RTMS_DrawMenus =
{
	if (player != player) exitWith
	{
		//removeMissionEventHandler ["Draw3D", (uiNamespace getVariable "RTMS_DRAW_EH")];
	};
	
	RTMS_IN_BOX = false;
	
	if (RTMS_MENU_DISABLED || visibleMap) exitWith {};
	
	call RTMS_UpdateConditions;
	
	private [
				"_angle",
				"_activeMenu",
				"_menuCount",
				"_mainIcon",
				"_iconCenter",
				"_mainColor",
				"_object",
			    "_playerPos", 
				"_plane", 
				"_deltaAngle",
				"_textPop",
				"_mainText",
				"_positionUp",
				"_coeff",
				"_subPosition",
				"_color",
				"_textSize",
				"_xAx",
				"_yAx",
				"_realDistance"
			];
	_playerPos = positionCameraToWorld [0,0,0];
	_positionUp = ((positionCameraToWorld [0,1,0]) vectorDiff _playerPos);
	_coeff = 0;
	
	{
	if (!isNull _x) then
	{
		if (isObjectHidden _x) exitWith {};
		_textPop = 0;
		//player sideChat "ATTEMPTING TO DISPLAY";
		_activeMenu = _x getVariable "RTMS_ACTIVE_MENU";
		_menuCount = _x getVariable "RTMS_SUB_COUNT";
		_mainIcon = _activeMenu select 0;
		_iconCenter = _x getVariable "RTMS_ICON_CENTER";
		_mainColor = _mainIcon getVariable "CLASS_MAIN_COLOR";
		_mainText = _mainIcon getVariable "CLASS_TEXT";
		_object = _x;
		
		if ((RTMS_SELECTED_MENU select 0) == _x) then
		{
			_mainColor = [[1,1,0,1], [1,1,0,0.5]] select (RTMS_SELECTED_SUB_MENU select 0);
			_textPop = [0.03, 0] select (RTMS_SELECTED_SUB_MENU select 0);
			_mainText = [_mainText, ""] select (RTMS_SELECTED_SUB_MENU select 0);
		}
		else
		{
			if (!((_mainIcon getVariable "CLASS_CONDITION_NAMESPACE") getVariable "RTMS_SHOW") && (_menuCount == 0)) then
			{
				_mainColor = [0,0,0,0];
			};
		};
		
		if (RTMS_VIP > -1) then
		{
			//_textPop = [0, 0.02] select (RTMS_VIP == _forEachIndex);
			//_mainText = [_mainText, format ["%1*", _mainText]] select (RTMS_VIP == _forEachIndex);
			if ((_textPop == 0.03) || ((RTMS_VIP == _forEachIndex) && isNull (RTMS_SELECTED_MENU select 0))) then
			{
				_textPop = [0.02, _textPop] select (_textPop == 0.03);
				drawIcon3D 
				[
					RTMS_DEFAULT_QB_ICON,
					[0,1,0, ([0.35, 1] select (RTMS_QB_DOWN))],
					_iconCenter,
					(RTMS_DEFAULT_SIZE * 2),
					(RTMS_DEFAULT_SIZE * 2),
					0,
					"",
					0,
					0,
					"PuristaMedium",
					"",
					false
				];
			};
		};
		
		drawIcon3D 
		[
			_mainIcon getVariable "CLASS_ICON",
			_mainColor,
			_iconCenter,
			RTMS_DEFAULT_SIZE,
			RTMS_DEFAULT_SIZE,
			0,
			_mainText,
			0,
			RTMS_DEFAULT_TEXT_SIZE + _textPop,
			"PuristaMedium",
			"",
			true
		];
		
		
		if (((RTMS_SELECTED_MENU select 0) == _x) && (RTMS_SELECTED_SUB_MENU select 0)) then
		{
			RTMS_IN_BOX = [_object] call RTMS_InBoundingBox;
			_deltaAngle = _object getVariable "RTMS_ROTATE_DELTA";
			//_distance = player distance _iconCenter;
			_realDistance = player distance (_object getVariable "RTMS_OBJECT_CENTER");
			
			_plane = [(_playerPos vectorDiff _iconCenter), _positionUp, _iconCenter] call RTMS_CreateVectorPlaneExtended;

			_xAx = _plane select 0;
			_yAx = _plane select 1;
		
			if (RTMS_STACK_COUNT > 1) then
			{
				_coeff = (RTMS_STACK_COEFF / 1) * (_playerPos distance _iconCenter);
				_iconCenter = [(_coeff * (_yAx select 0)) + (_iconCenter select 0), 
				(_coeff * (_yAx select 1)) + (_iconCenter select 1), 
				(_coeff * (_yAx select 2)) + (_iconCenter select 2)];
			};
			
			_coeff = ((RTMS_DEFAULT_RC * _menuCount) / 1) * (_playerPos distance (_object getVariable "RTMS_ICON_CENTER"));
			
			_angle = [RTMS_MENU_ROTATOR] call RTMS_ProcessRotator;
			{
				_color = [];
				_color append (_x select 1);
				_textSize = _x select 3;
				
				if ((RTMS_SELECTED_SUB_MENU select 1) == _forEachIndex) then
				{
					_color = [1,1,0,1];
					_textSize = _textSize + 0.03;
					
					if ((count _x) > 11) then
					{
						if ("ARRAY" == typeName ((_x select 6) select 0)) then
						{
							if ("ARRAY" == typeName (((_x select 6) select 0) select 0)) then
							{
								_x set [11, [_object, ((_x select 6) select 0)] call RTMS_GetVehiclePos];
							};
						};
						drawIcon3D [RTMS_DEFAULT_BOARD_POS_ICON, RTMS_DEFAULT_BOARD_POS_COLOR, _object modelToWorldVisual (_x select 11), RTMS_DEFAULT_SIZE, RTMS_DEFAULT_SIZE, 0, "", 0, 0, "PuristaMedium"];
					};
					
				};
				if ((([_object, _x select 7] call RTMS_AdaptDistance)  < _realDistance) || !((_x select 10) getVariable "RTMS_SHOW"))  then
				{
					_color set [0, 0.65 * (_color select 0)];
					_color set [1, 0.65 * (_color select 1)];
					_color set [2, 0.65 * (_color select 2)];
					_color set [3, 0.65 * (_color select 3)];
				}
				else
				{
					if (!((_x select 8) isEqualTo [])) then
					{
						private "_subCond";
						_subCond = [[_object]];
						(_subCond select 0) append ((_x select 8) select 0);
						_subCond pushBack ((_x select 8) select 1);
						if ( !((_subCond select 0) call (_subCond select 1))) then
						{
								_color set [0, 0.65 * (_color select 0)];
								_color set [1, 0.65 * (_color select 1)];
								_color set [2, 0.65 * (_color select 2)];
								_color set [3, 0.65 * (_color select 3)];
						};
					};
				};
				
				_subPosition = [((_xAx select 0) * _coeff * cos (_angle)) + ((_yAx select 0) * _coeff * sin (_angle)) + (_iconCenter select 0),
								((_xAx select 1) * _coeff * cos (_angle)) + ((_yAx select 1) * _coeff * sin (_angle)) + (_iconCenter select 1), 
								((_xAx select 2) * _coeff * cos (_angle)) + ((_yAx select 2) * _coeff * sin (_angle)) + (_iconCenter select 2)];
				
				drawIcon3D 
				[
					_x select 9,
					_color,
					_subPosition,
					_x select 2,
					_x select 2,
					0,
					_x select 0,
					0,
					_textSize,
					_x select 4,
					"",
					true
				];
				
				
				_angle = _angle + _deltaAngle;
			} foreach ((RTMS_MENU_STACK select (RTMS_STACK_COUNT - 1)) select 0);
			if (RTMS_STACK_COUNT > 1) then
			{
				private "_lastMenu";
				private "_tempArray";
				private "_temp";
				_lastMenu = ((RTMS_MENU_STACK select (RTMS_STACK_COUNT - 2)) select 0) select ((RTMS_MENU_STACK select (RTMS_STACK_COUNT - 1)) select 1);
				drawIcon3D 
				[
					_lastMenu select 9,
					_lastMenu select 1,
					_iconCenter,
					_lastMenu select 2,
					_lastMenu select 2,
					0,
					_lastMenu select 0,
					0,
					_lastMenu select 3,
					_lastMenu select 4,
					"",
					true
				];
				private "_pop";
				_tempArray = [];
				_tempArray append RTMS_MENU_STACK;
				_temp = RTMS_STACK_COUNT;
				_pop = !(((((_tempArray select 0) select 0) select ((_tempArray select 1) select 1)) select 10) getVariable "RTMS_SHOW");
				{
					if (_forEachIndex < (_temp - 1)) then
					{
						if (!_pop) then
						{
							_lastMenu = (_x select 0) select ((_tempArray select (_forEachIndex + 1)) select 1);
							if (_realDistance  > ([_object, _lastMenu select 7] call RTMS_AdaptDistance)) then
							{
								[_object] call RTMS_PopSubMenu;
								_pop = true;
							}
							else
							{
					
								if (!((_lastMenu select 8) isEqualTo [])) then
								{
									private "_subCond";
									_subCond = [[_object]];
									(_subCond select 0) append ((_lastMenu select 8) select 0);
									_subCond pushBack ((_lastMenu select 8) select 1);
									if (!((_subCond select 0) call (_subCond select 1)) ) then
									{
										[_object] call RTMS_PopSubMenu;
										_pop = true;
									};
								};
					
							};
						}
						else
						{
							[_object] call RTMS_PopSubMenu;
						};
					};
				} foreach _tempArray;
			};
		};
		
	};
	} foreach RTMS_DISPLAYED;
};

RTMS_ProcessRequests =
{
	private ["_tempArray",
	 "_OOC",
	 "_logic",
	 "_objectAff",
	 "_return"
	 ];
	_tempArray = [];
	_objectAff = objNull;
	_return =
	{
		_logic = _x select 0;
		_OOC = _logic getVariable "CLASS_NAME";
		if (_x select 1) then
		{
			//install
			if ("OBJECT" == typeName _OOC) then
			{
				private ["_installList"];
				if (isNull _OOC) exitWith {};
				_installList = [_logic];
				_tempArray append (_OOC getVariable "RTMS_ACTIVE_MENU");
				[_tempArray, _OOC] call RTMS_UninstallMenuObjects;
				_installList append _tempArray;
				[_installList, _OOC] call RTMS_InstallMenuObjects;
				RTMS_OBJECTS_LIST pushBack _logic;
				if ((RTMS_SELECTED_MENU select 0) == _OOC) then
				{
					_objectAff = _OOC;
				};
			}
			else
			{
				private ["_installList"];
				_tempArray pushBack _logic;
				_tempArray append RTMS_CLASS_LIST;
				RTMS_CLASS_LIST = _tempArray;
				call RTMS_MapHierarchy;
				_null = 
				{
					if (!isNull _x) then
					{
						if ((_x isKindOf _OOC) || (_OOC == typeOf _x)) then
						{
							_logics = (_x getVariable "RTMS_ACTIVE_MENU") - RTMS_OBJECTS_LIST; //this list is static
							[_logics, _x] call RTMS_UninstallMenuObjects;
								
							_installList = [];
							_currentNear = _x;
								
							_null = 
							{
								if ((_currentNear isKindOf (_x getVariable "CLASS_NAME")) || ((_x getVariable "CLASS_NAME") == typeOf _currentNear)) then
								{
									_installList pushBack (_x);
								};
							false
							} count RTMS_CLASS_LIST;
							[_installList, _currentNear] call RTMS_InstallMenuObjects;
							if ((RTMS_SELECTED_MENU select 0) == _x) then
							{
								_objectAff = _x;
							};
						};
					};
				false
				} count RTMS_TO_DISPLAY;
				if (!(_OOC in RTMS_CLASS_NAMES)) then
				{
					RTMS_CLASS_NAMES pushBack _OOC;
				};
			};
		}
		else
		{
			//uninstall
			if ("OBJECT" == typeName _OOC) then
			{
				if (isNull _OOC) exitWith {};
				private ["_return", "_index"];
				{
					if (_logic == _x) exitWith
					{
						_index = _forEachIndex;
					};
				} foreach RTMS_OBJECTS_LIST;
				if (!isNil "_index") then
				{
					RTMS_OBJECTS_LIST deleteAt _index;
					[[_logic], _OOC] call RTMS_UninstallMenuObjects;
					if ((RTMS_SELECTED_MENU select 0) == _OOC) then
					{
						_objectAff = _OOC;
					};
				};
			}
			else
			{
				private ["_return", "_index", "_count", "_i", "_logics", "_installList", "_currentNear"];
				_i = 0;
				_count = 0;
				_index = 0;
				_count =
				{
					_return = false;
					if (_logic == _x) exitWith
					{
						_index = _i;
					};
					if (_OOC == (_x getVariable "CLASS_NAME")) then
					{
						_return = true;
					};
					_i = _i + 1;
					_return
				} count RTMS_CLASS_LIST;
				if (!isNil "_index") then
				{
					RTMS_CLASS_LIST deleteAt _index;
					if (_count == 1) then
					{
						_index = 0;
						{
							if (_OOC == _x) exitWith
							{
								_index = _forEachIndex;
							};
						} foreach RTMS_CLASS_NAMES;
						RTMS_CLASS_NAMES deleteAt _index;
					};
				
					call RTMS_MapHierarchy;
					_null = 
					{
						if (!isNull _x) then
						{
							if ((_x isKindOf _OOC) || (_OOC == typeOf _x)) then
							{
								
								_logics = (_x getVariable "RTMS_ACTIVE_MENU") - RTMS_OBJECTS_LIST; //this list is static
								[_logics, _x] call RTMS_UninstallMenuObjects;
								
								_installList = [];
								_currentNear = _x;
								
								_null = 
								{
									if ((_currentNear isKindOf (_x getVariable "CLASS_NAME")) || ((_x getVariable "CLASS_NAME") == typeOf _currentNear)) then
									{
										_installList pushBack (_x);
									};
								false
								} count RTMS_CLASS_LIST;
								[_installList, _currentNear] call RTMS_InstallMenuObjects;
								if ((RTMS_SELECTED_MENU select 0) == _x) then
								{
									_objectAff = _x;
								};
							};
						};
					false
					} count RTMS_TO_DISPLAY;
				};
			};
			
		};
	true
	} count RTMS_REQUESTS;
	if (!isNull _objectAff) then
	{
		RTMS_SELECTED_SUB_MENU = [false, 0];
		RTMS_ROTATOR_DIR = 90;
		RTMS_STACK_COUNT = 0;
		RTMS_MENU_STACK = [];
		if ((_objectAff getVariable "RTMS_SUB_COUNT") > 0) then
		{	
			RTMS_SELECTED_SUB_MENU = [true, 0];
			[_objectAff, (_objectAff getVariable "RTMS_SUB_MENU_LIST")] call RTMS_PushSubMenu;
			[RTMS_ROTATOR_DIR, RTMS_ROTATOR_DIR, RTMS_MENU_ROTATOR, round (1440 / (_objectAff getVariable "RTMS_SUB_COUNT"))] call RTMS_SetRotator;
		};
	};
	RTMS_REQUESTS = [];
	_return = (_return > 0);
	_return;
};

RTMS_IsInstalled =
{
	private ["_menu", "_return"];
	_return = false;
	_menu = _this select 0;
			
	if ("STRING" == typeName (_menu getVariable "CLASS_NAME")) then
	{
		_return = (_menu in RTMS_CLASS_LIST);
	}
	else
	{
		_return = (_menu in RTMS_OBJECTS_LIST);		
	};
	
	_return;		
};
RTMS_BlockedView =
{
	private ["_object",
	"_posASL",
	"_posATL",
	"_return",
	"_posPlayerATL",
	"_posPlayerASL",
	"_distanceA",
	"_distanceB",
	"_occlusion",
	"_intersect",
	"_tempA",
	"_tempB"
	];
	_object = _this;
	_return = false;
	_occlusion = false;
	if (!isNil {_object getVariable "RTMS_OCCLUSION_DISABLED"}) then
	{
		_occlusion = _object getVariable "RTMS_OCCLUSION_DISABLED";
	};
	if (_occlusion) exitWith {_return;};
	_return = false;
	_posPlayerASL = eyePos player;
	_posPlayerATL = ASLtoAGL _posPlayerASL;
	
	if (!isNil {_object getVariable "RTMS_OCCLUSION_POS"}) then
	{
		
		_posATL = _object getVariable "RTMS_OCCLUSION_POS";
		_posASL = ATLtoASL _posATL;
		
		_return = lineIntersects [_posPlayerASL, _posASL, player, objNull];
		if (_return) then
		{
			_return = false;
			_distanceA = [_object getVariable "RTMS_HOUSE", "FIRE"] intersect [_posPlayerATL, _posATL];
			if (_distanceA isEqualTo []) then
			{
				_distanceA = _posPlayerATL vectorDistance _posATL;
			}
			else
			{
				_distanceA = (_distanceA select 0) select 1;
			};
			_distanceB = (((lineIntersectsSurfaces [_posPlayerASL, _posASL, player, objNull, true, 1]) select 0) select 0) vectorDistance _posPlayerASL;
			
			_return = ((abs (_distanceB - _distanceA)) > 0.1);
		};
		
		if (_return) then
		{
			if (!RTMS_OCCLUSION_CAN_CHECK) exitWith
			{
				_return = _object getVariable "RTMS_LAST_OCCLUSION";
			};
			_tempA = [];
			_tempB = [];
			_tempA append (_object getVariable "RTMS_OBJECT_CENTER");
			_tempA set [2, (_tempA select 2)];
			RTMS_THE_THING setPosATL _tempA;
			_tempA = RTMS_THE_THING modelToWorldVisual [0,0,0];
			RTMS_THE_THING hideObject false;
			_posPlayerATL set [2, _tempA select 2];
			_tempB = _tempA vectorFromTo _posPlayerATL;
			_tempB set [2, 0];
			RTMS_THE_THING setVectorDirAndUp [_tempB, [0,0,1]];
			_intersect = lineIntersectsSurfaces [AGLToASL _posPlayerATL, AGLToASL _tempA, player, objNull, true, 1, "GEOM", "NONE"];
			//drawLine3D [_posPlayerATL, _tempA, [1,1,1,1]];
			RTMS_THE_THING hideObject true;
			if (!(_intersect isEqualTo [])) then
			{
				_return = ("Land_WaterBarrel_F" != typeOf ((_intersect select 0) select 2));
				
				if (!_return) then
				{
					_intersect = lineIntersectsSurfaces [_posPlayerASL, AGLToASL _posPlayerATL, player, objNull, true, 1, "GEOM", "NONE"];
					if (!(_intersect isEqualTo [])) then
					{
						if ("Land_WaterBarrel_F" != typeOf ((_intersect select 0) select 2)) then
						{
							_return = (((vectorUp (_object getVariable "RTMS_HOUSE")) vectorCos ((_intersect select 0) select 1)) >= 0.9);
						};
					};
				};
			};
			_object setVariable ["RTMS_LAST_OCCLUSION", _return];
		};
	}
	else
	{
		_posATL = _object modelToWorldVisual (getCenterOfMass _object);
		//_posATL = _object modelToWorldVisual [0,0,0];
		_posASL = AGLToASL _posATL;
		_posASL = [_posASL, [_posASL select 0, _posASL select 1, (_posASL select 2) + 1]] select ((!alive _object) && (_object isKindOf "Man"));
		_return = (({"" != typeOf _x} count (lineIntersectsWith [_posPlayerASL, _posASL, player, _object])) > 0);
	};
	
	_return;
};
RTMS_GetDoors =
{
	private [
		"_house",
		"_configPath",
		"_return",
		"_i",
		"_lastPos",
		"_housePos"
	];
	_return = [];
	_house = _this select 0;
	_configPath = configFile >> "cfgVehicles" >> (typeOf _house) >> "UserActions";
	_i = 1;
	_lastPos = getText (_configPath >> (format ["OpenDoor_%1", _i]) >> "position" );
	if (_lastPos == "") then
	{
		_lastPos = getText (configPath >> (format ["OpenGate_%1", _i]) >> "position" );
	};
	while {"" != _lastPos} do
	{
		_return pushBack _i;
		_i = _i + 1;
		_lastPos = getText (_configPath >> (format ["OpenDoor_%1", _i]) >> "position" );
		if (_lastPos == "") then
		{
			_lastPos = getText (_configPath >> (format ["OpenGate_%1", _i]) >> "position" );
		};
	};
	_return;
};

RTMS_GetDoorsAdvanced =
{
	private [
		"_house",
		"_configPath",
		"_return",
		"_i",
		"_j",
		"_lastPos",
		"_housePos",
		"_index",
		"_configString",
		"_selectionNames",
		"_conditions",
		"_scripts",
		"_currentSelection",
		"_currentCondition",
		"_currentScript",
		"_occlusionPositions",
		"_currentOcclusionPos",
		"_textType",
		"_displayTexts",
		"_radii",
		"_currentRadius",
		"_currentAnim",
		"_anims",
		"_animsPath",
		"_displayString"
	];
	_return = [];
	_house = _this select 0;
	_configPath = configFile >> "cfgVehicles" >> (typeOf _house) >> "UserActions";
	_animsPath = configFile >> "cfgVehicles" >> (typeOf _house) >> "AnimationSources";
	_i = count _configPath;
	_j = count _animsPath;
	_index = 0;
	_selectionNames = [];
	_occlusionPositions = [];
	_displayTexts = [];
	_conditions = [];
	_scripts = [];
	_radii = [];
	_anims = [];
	
	
	for "_a" from 0 to (_i - 1) do
	{
		// && ((_configString find "lock") < 0) 
		_configString = (toLower format ["%1", (_configPath select _a)]);
		_displayString = (toLower format ["%1", getText ((_configPath select _a) >> "displayName")]);
		if ((((_configString find "door") > -1) || ((_configString find "gate") > -1)) ||  ((_displayString find "door") > -1) || ((_displayString find "gate") > -1))then
		{
			_textType = ["Door", "Gate"] select ((_displayString find "gate") > -1);
			_currentOcclusionPos = (getText ((_configPath select _a) >> "position"));
			_currentRadius = (getNumber ((_configPath select _a) >> "radius")) max 2.5;
			_currentSelection = ["_trigger", "", _currentOcclusionPos] call RTMS_FindReplaceString;
			//diag_log _currentSelection;
			_currentCondition = compile (["this", "_this", getText ((_configPath select _a) >> "condition")] call RTMS_FindReplaceString);
			//diag_log format ["%1", _currentCondition];
			_currentScript = (["this", "_this", getText ((_configPath select _a) >> "statement")] call RTMS_FindReplaceString);
			//diag_log format ["%1", _currentScript];
			
			_index = _selectionNames find _currentSelection;
			if (_index > -1) then
			{
				_currentScript = compile _currentScript;
				(_conditions select _index) pushBack _currentCondition;
				(_scripts select _index) pushBack _currentScript;
				if ((_radii select _index) < _currentRadius) then
				{
					_radii set [_index, _currentRadius];
				};
			}
			else
			{
				_currentAnim = format ["%1_rot", _currentSelection];
				for "_b" from 0 to (_j - 1) do
				{
					if ((-1 < (_currentScript find (format ["'%1'", (configName (_animsPath select _b))]))) || (-1 < (_currentScript find (format [toString [34, 37, 49, 34], (configName (_animsPath select _b))]))) ) then
					{
						_currentAnim = configName (_animsPath select _b);
					};
				};

				_currentScript = compile _currentScript;
				_selectionNames pushBack _currentSelection;
				_occlusionPositions pushBack _currentOcclusionPos;
				_radii pushBack _currentRadius;
				_displayTexts pushBack _textType;
				_conditions pushBack [_currentCondition];
				_scripts pushBack [_currentScript];
				_anims pushBack _currentAnim;
			};
		};
	};
	_return = [_selectionNames, _occlusionPositions, _displayTexts, _conditions, _scripts, _radii, _anims];
	_return;
};

RTMS_GetHatches =
{
	private [
		"_house",
		"_configPath",
		"_return",
		"_i",
		"_lastPos",
		"_housePos"
	];
	_return = [];
	_house = _this select 0;
	_configPath = configFile >> "cfgVehicles" >> (typeOf _house) >> "UserActions";
	_i = 1;
	_lastPos = getText (_configPath >> (format ["OpenHatch_%1", _i]) >> "position" );
	while {"" != _lastPos} do
	{
		_return pushBack _i;
		_i = _i + 1;
		_lastPos = getText (_configPath >> (format ["OpenHatch_%1", _i]) >> "position" );
	};
	_return;
};

RTMS_GetLadders =
{
	private [
		"_house",
		"_configPath",
		"_return",
		"_i",
		"_lastPos",
		"_housePos"
	];
	_return = [];
	_house = _this select 0;
	_configPath = configFile >> "cfgVehicles" >> (typeOf _house);
	_i = 1;
	_lastPos = getArray (_configPath >> "ladders" );
	{
		_return pushBack [_x, _forEachIndex];
	} foreach _lastPos;
	_return;
};

RTMS_AddDoors =
{
	private ["_nearDoors",
	"_doorObject",
	"_house",
	"_activeMenu",
	"_nearObjects",
	"_doorPos"
	];
	_house = _this select 0;
	_nearObjects = _this select 1;
	
	_activeMenu = [];
	_nearDoors = [_house] call RTMS_GetDoors;
	_null =
	{
		_doorObject = [RTMS_DOOR_MENU] call RTMS_CopyMenuObject;
		[[_doorObject], _doorObject] call RTMS_InstallMenuObjects;
		_doorObject setVariable ["CLASS_DOOR_NUMBER", _x];
		_doorObject setVariable ["CLASS_MAIN_SCRIPT", [[_x], RTMS_DoorOC]];
		if (_house isKindOf "Wall") then
		{
			_doorObject setVariable ["CLASS_DISTANCE", 5];
			_doorObject setVariable ["CLASS_TEXT", "Gate"];
		};
		
		if ([0,0,0] isEqualTo (_house selectionPosition [format ["Door_handle_%1_axis", _x], "Memory"])) then
		{
			if (isClass (configFile >> "cfgVehicles" >> (typeOf _house) >> "AnimationSources" >> format ["Door_%1B_source", _x])) then
			{
				_doorObject setVariable ["RTMS_OPEN_PT", format ["Door_%1B_axis", _x]];
				_doorObject setVariable ["RTMS_MODEL_TYPE", "Memory"];
			}
			else
			{
				_doorObject setVariable ["RTMS_OPEN_PT", format ["Door_%1", _x]];
				_doorObject setVariable ["RTMS_MODEL_TYPE", "Geometry"];
			};
		}
		else
		{
			_doorObject setVariable ["RTMS_OPEN_PT", format ["Door_handle_%1_axis", _x]];
			_doorObject setVariable ["RTMS_MODEL_TYPE", "Memory"];
		};
		
		_doorPos = (_house modelToWorld (_house selectionPosition [(_doorObject getVariable "RTMS_OPEN_PT"), "Memory"]));
		_doorPos set [2, ((_house modelToWorld (_house selectionPosition [format ["Door_%1_trigger", _x], "Memory"])) select 2)];
		_doorObject setVariable ["RTMS_OCCLUSION_POS", (_house modelToWorld (_house selectionPosition [format ["Door_%1_trigger", _x], "Memory"]))];
		_doorObject setVariable ["RTMS_SELECTION_NAME", format ["Door_%1", _x]];
		_doorObject setVariable ["RTMS_HOUSE", _house];
		//_doorObject setVariable ["RTMS_DOOR_AXIS", (_house modelToWorld (_house selectionPosition [format ["Door_%1_axis", _x], "Memory"]))];
		_doorObject setVariable ["RTMS_DOOR_POS", _doorPos];
		//_doorObject setVariable ["RTMS_CLOSED", (_house modelToWorld (_house selectionPosition [format ["Door_%1_trigger", _x], "Memory"]))];
		_doorObject setPosATL _doorPos;
		_doorObject setVariable ["RTMS_DOOR_OPEN", true];
		_doorObject setVariable ["RTMS_LAST_OCCLUSION", true];
		
		_activeMenu pushBack _doorObject;
		_nearObjects pushBack _doorObject;
				
	false
	} count _nearDoors;
	_activeMenu;
	
};

RTMS_AddDoorsAdvanced =
{
	private ["_nearDoors",
	"_doorObject",
	"_house",
	"_activeMenu",
	"_nearObjects",
	"_doorPos"
	];
	_house = _this select 0;
	_nearObjects = _this select 1;
	
	_activeMenu = [];
	_nearDoors = [_house] call RTMS_GetDoorsAdvanced;
	
	{
		_doorObject = [RTMS_DOOR_MENU] call RTMS_CopyMenuObject;
		
		if (_house isKindOf "Wall") then
		{
			//_doorObject setVariable ["CLASS_DISTANCE", 5];
			_doorObject setVariable ["CLASS_TEXT", "Gate"];
		}
		else
		{	
			_doorObject setVariable ["CLASS_TEXT", (_nearDoors select 2) select _forEachIndex];
		};
		
		_doorObject setVariable ["CLASS_DISTANCE", (_nearDoors select 5) select _forEachIndex];
		_doorObject setVariable ["RTMS_ANIMATION_SOURCE", (_nearDoors select 6) select _forEachIndex];
		
		[[_doorObject], _doorObject] call RTMS_InstallMenuObjects;
		_doorObject setVariable ["CLASS_DOOR_NUMBER", _forEachIndex + 1];
		_doorObject setVariable ["CLASS_MAIN_SCRIPT", [[(_nearDoors select 3) select _forEachIndex, (_nearDoors select 4) select _forEachIndex], RTMS_DoorOCAdvanced]];
		
		if ([0,0,0] isEqualTo (_house selectionPosition [format ["Door_handle_%1_axis", _forEachIndex + 1], "Memory"])) then
		{
			if (isClass (configFile >> "cfgVehicles" >> (typeOf _house) >> "AnimationSources" >> format ["Door_%1B_source", _forEachIndex + 1])) then
			{
				_doorObject setVariable ["RTMS_OPEN_PT", format ["Door_%1B_axis", _forEachIndex + 1]];
				_doorObject setVariable ["RTMS_MODEL_TYPE", "Memory"];
			}
			else
			{
				if ([0,0,0] isEqualTo (_house selectionPosition [_x, "Geometry"])) then
				{
					_doorObject setVariable ["RTMS_OPEN_PT", _x];
					_doorObject setVariable ["RTMS_MODEL_TYPE", "Memory"];
				}
				else
				{
					_doorObject setVariable ["RTMS_OPEN_PT", _x];
					_doorObject setVariable ["RTMS_MODEL_TYPE", "Geometry"];
				};
			};
		}
		else
		{
			_doorObject setVariable ["RTMS_OPEN_PT", format ["Door_handle_%1_axis", _forEachIndex + 1]];
			_doorObject setVariable ["RTMS_MODEL_TYPE", "Memory"];
		};
		
		_doorPos = (_house modelToWorld (_house selectionPosition [(_doorObject getVariable "RTMS_OPEN_PT"), "Memory"]));
		_doorPos set [2, ((_house modelToWorld (_house selectionPosition [(_nearDoors select 1) select _forEachIndex, "Memory"])) select 2)];
		_doorObject setVariable ["RTMS_OCCLUSION_POS", (_house modelToWorld (_house selectionPosition [(_nearDoors select 1) select _forEachIndex, "Memory"]))];
		_doorObject setVariable ["RTMS_SELECTION_NAME", _x];
		_doorObject setVariable ["RTMS_HOUSE", _house];
		
		_doorObject setVariable ["RTMS_DOOR_POS", _doorPos];
		
		_doorObject setPosATL (_doorObject getVariable "RTMS_OCCLUSION_POS");
		_doorObject setVariable ["RTMS_DOOR_OPEN", true];
		_doorObject setVariable ["RTMS_LAST_OCCLUSION", true];
		
		_activeMenu pushBack _doorObject;
		_nearObjects pushBack _doorObject;
				
	} foreach (_nearDoors select 0);
	_activeMenu;
	
};

RTMS_AddHatches =
{
	private ["_nearHatches",
	"_hatchObject",
	"_house",
	"_activeMenu",
	"_nearObjects",
	"_hatchPos"
	];
	_house = _this select 0;
	_nearObjects = _this select 1;
	
	_activeMenu = [];
	_nearHatches = [_house] call RTMS_GetHatches;
	_null =
	{
		_hatchObject = [RTMS_DOOR_MENU] call RTMS_CopyMenuObject;
		_hatchObject setVariable ["CLASS_DISTANCE", 3.25];
		_hatchObject setVariable ["CLASS_DOOR_NUMBER", _x];
		_hatchObject setVariable ["CLASS_MAIN_SCRIPT", [[_x], RTMS_HatchOC]];
		_hatchObject setVariable ["CLASS_ICON", "A3\ui_f\data\IGUI\Cfg\Actions\take_ca.paa"];
		_hatchObject setVariable ["CLASS_TEXT", "Hatch"];
		
		[[_hatchObject], _hatchObject] call RTMS_InstallMenuObjects;
		
		_hatchObject setVariable ["RTMS_OPEN_PT", format ["Hatch_%1", _x]];
		_hatchObject setVariable ["RTMS_MODEL_TYPE", "Geometry"];
	
		
		_hatchPos = (_house modelToWorld (_house selectionPosition [(_hatchObject getVariable "RTMS_OPEN_PT"), "Memory"]));
		//_hatchPos set [2, ((_house modelToWorld (_house selectionPosition [format ["Hatch_%1_trigger", _x], "Memory"])) select 2)];
		_hatchObject setVariable ["RTMS_OCCLUSION_POS", (_house modelToWorld (_house selectionPosition [format ["Hatch_%1_trigger", _x], "Memory"]))];
		_hatchObject setVariable ["RTMS_SELECTION_NAME", format ["Hatch_%1", _x]];
		_hatchObject setVariable ["RTMS_ANIMATION_SOURCE", format ["Hatch_%1_rot", _x]];
		_hatchObject setVariable ["RTMS_HOUSE", _house];
		//_hatchObject setVariable ["RTMS_DOOR_AXIS", (_house modelToWorld (_house selectionPosition [format ["Hatch_%1_axis", _x], "Memory"]))];
		_hatchObject setVariable ["RTMS_DOOR_POS", _hatchPos];
		//_hatchObject setVariable ["RTMS_CLOSED", (_house modelToWorld (_house selectionPosition [format ["Hatch_%1_trigger", _x], "Memory"]))];
		_hatchObject setPosATL (_hatchObject getVariable "RTMS_OCCLUSION_POS");
		_hatchObject setVariable ["RTMS_DOOR_OPEN", true];
		_hatchObject setVariable ["RTMS_LAST_OCCLUSION", true];
		
		_activeMenu pushBack _hatchObject;
		_nearObjects pushBack _hatchObject;
				
	false
	} count _nearHatches;
	_activeMenu;
	
};

RTMS_AddLadders =
{
	private ["_nearLadders",
	"_ladderObject",
	"_house",
	"_activeMenu",
	"_nearObjects",
	"_ladderPos"
	];
	_house = _this select 0;
	_nearObjects = _this select 1;
	
	_activeMenu = [];
	_nearLadders = [_house] call RTMS_GetLadders;
	_null =
	{
	
		_ladderObject = [RTMS_DOOR_MENU] call RTMS_CopyMenuObject;
		[[_ladderObject], _ladderObject] call RTMS_InstallMenuObjects;
		_ladderObject setVariable ["CLASS_ICON", "A3\ui_f\data\IGUI\Cfg\Actions\take_ca.paa"];
		_ladderObject setVariable ["CLASS_MAIN_SCRIPT", [[_x select 1], RTMS_LadderDown]];
		_ladderObject setVariable ["CLASS_TEXT", "Climb DOWN Ladder"];
		_ladderObject setVariable ["CLASS_DISTANCE", 5];
		_ladderPos = (_house modelToWorld (_house selectionPosition ((_x select 0) select 1)));
		_ladderObject setVariable ["RTMS_OCCLUSION_POS", ([] + _ladderPos)];
		_ladderPos set [2, (_ladderPos select 2) + 1];
		_ladderObject setPosATL _ladderPos;
		_ladderObject setVariable ["RTMS_HOUSE", _house];
		_ladderObject setVariable ["RTMS_SELECTION_NAME", ((_x select 0) select 1)];
		
		_activeMenu pushBack _ladderObject;
		_nearObjects pushBack _ladderObject;
		
		_ladderObject = [RTMS_DOOR_MENU] call RTMS_CopyMenuObject;
		[[_ladderObject], _ladderObject] call RTMS_InstallMenuObjects;
		_ladderObject setVariable ["CLASS_ICON", "A3\ui_f\data\IGUI\Cfg\Actions\take_ca.paa"];
		_ladderObject setVariable ["CLASS_MAIN_SCRIPT", [[_x select 1], RTMS_LadderUp]];
		_ladderObject setVariable ["CLASS_TEXT", "Climb UP Ladder"];
		_ladderObject setVariable ["CLASS_DISTANCE", 5];
		_ladderPos = (_house modelToWorld (_house selectionPosition ((_x select 0) select 0)));
		_ladderObject setVariable ["RTMS_OCCLUSION_POS", ([] + _ladderPos)];
		_ladderPos set [2, (_ladderPos select 2) + 1];
		_ladderObject setPosATL _ladderPos;
		_ladderObject setVariable ["RTMS_HOUSE", _house];
		_ladderObject setVariable ["RTMS_SELECTION_NAME", ((_x select 0) select 0)];
		_ladderObject setVariable ["RTMS_LAST_OCCLUSION", true];
		
		_activeMenu pushBack _ladderObject;
		_nearObjects pushBack _ladderObject;
				
	false
	} count _nearLadders;
	_activeMenu;
	
};

RTMS_HouseIntersector =
{
	private [
		"_forward",
		"_backward",
		"_left",
		"_right",
		"_up",
		"_down",
		"_return",
		"_temp",
		"_nearBuilding"
	];
	_temp = [];
	_return = [];

	_forward = ATLtoASL (player modelToWorldVisual [0, 5, 0]);
	_backward = ATLtoASL (player modelToWorldVisual [0, -5, 0]);
	_left = ATLtoASL (player modelToWorldVisual [-5, 0, 0]);
	_right = ATLtoASL (player modelToWorldVisual [5, 0, 0]);
	_up = ATLtoASL (player modelToWorldVisual [0,0,5]);
	_down = ATLtoASL (player modelToWorldVisual [0,0,-5]);
	
	
	_temp append (lineIntersectsWith [_forward, _left, player, objNull, false]);
	_temp append (lineIntersectsWith [_forward, _right, player, objNull, false]);
	_temp append (lineIntersectsWith [_forward, _up, player, objNull, false]);
	_temp append (lineIntersectsWith [_forward, _down, player, objNull, false]);
	
	_temp append (lineIntersectsWith [_backward, _left, player, objNull, false]);
	_temp append (lineIntersectsWith [_backward, _right, player, objNull, false]);
	_temp append (lineIntersectsWith [_backward, _up, player, objNull, false]);
	_temp append (lineIntersectsWith [_backward, _down, player, objNull, false]);
	
	_temp append (lineIntersectsWith [_forward, _backward, player, objNull, false]);
	_temp append (lineIntersectsWith [_left, _right, player, objNull, false]);
	_temp append (lineIntersectsWith [_up, _down, player, objNull, false]);
	
	_temp append (lineIntersectsWith [_left, _up, player, objNull, false]);
	_temp append (lineIntersectsWith [_left, _down, player, objNull, false]);
	_temp append (lineIntersectsWith [_right, _up, player, objNull, false]);
	_temp append (lineIntersectsWith [_right, _down, player, objNull, false]);
	
	if (player nearObjectsReady 200) then
	{
		_temp append (nearestObjects [player, ["Wall"], 7]);
		_temp append  [nearestBuilding player, nearestObject [player, "Static"]];
	
		_null =
		{
			if (!(_x in _return) && !(isObjectHidden _x)) then
			{
				_return pushBack _x;
			};
			false
		} count _temp;
	};
	
	/**
	_null = 
	{
		if ((_x isKindOf "Building") && !(_x in _return) && !(_x isKindOf "Wall")) then
		{
			_return pushBack _x;
		};
	false
	} count _temp;
	
	_return append (nearestObjects [player, ["Wall"],  7]);
	**/
	
	_return;
};

RTMS_InBoundingBox =
{
	private [
		"_return",
		"_nearVehicle",
		"_playerPos",
		"_distance",
		"_dirPlayer"
	];
	if (diag_tickTime >= (RTMS_LAST_BB_CHECK + 0.1)) then
	{
		_nearVehicle = _this select 0;
		if (2 >= (player distance (_nearVehicle getVariable "RTMS_OBJECT_CENTER"))) exitWith
		{
			_return = true;
			RTMS_LAST_BB_CHECK = diag_tickTime;
			RTMS_LAST_BB_VAL = _return;
		};
		_return = false;
		_playerPos = ATLToASL (player modelToWorldVisual [0,0,0]);
		_distance = 3;
		_dirPlayer = getDir player;
	
		{
			if (_nearVehicle in (lineIntersectsWith [
			_playerPos vectorAdd [_distance * (sin (_dirPlayer + 45)), _distance * (cos (_dirPlayer + 45)), _x], 
			_playerPos vectorAdd [_distance * (sin (_dirPlayer + 315)), _distance * (cos (_dirPlayer + 315)), _x], 
			player, 
			objNull, 
			false
		])) exitWith {_return = true;};
		} foreach [0, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2];
		RTMS_LAST_BB_CHECK = diag_tickTime;
		RTMS_LAST_BB_VAL = _return;
	}
	else
	{
		_return = RTMS_LAST_BB_VAL;
	};
	_return;
};

RTMS_ScanEnvironment = 
{
	private ["_nearObjects", 
	"_nearObjectsTemp", 
	"_tempArray", 
	"_scanDistance", 
	"_posPlayer", 
	"_vecDiff", 
	"_angle", 
	"_dirPlayer", 
	"_currentNear", 
	"_installList",
	"_uninstallList", 
	"_tempObj",
	"_nearBuildings"
	];
	
	_scanDistance = _this select 0;
	_tempArray = [];
	_nearObjects = [];
	_nearBuildings = [];
	_posPlayer = getPosASL player;
	_dirPlayer = getDir player;
	_nearObjectsTemp = nearestObjects [player, RTMS_CLASS_NAMES, _scanDistance];
	_null =
	{
		_tempObj = _x getVariable "CLASS_NAME";
		if (!isNull _tempObj) then
		{
			if (((_tempObj getVariable "RTMS_DISTANCE") + (_scanDistance / 2)) < (player distance (_tempObj modelToWorldVisual [0,0,0]))) exitWith {};
			if ((({_tempObj isKindOf _x} count RTMS_CLASS_NAMES) < 1) && (isNil {_tempObj getVariable "RTMS_CACHING_OBJ"}) ) then
			{
				_tempObj setVariable ["RTMS_CACHING_OBJ", true];
				_nearObjectsTemp pushBack (_x getVariable "CLASS_NAME");
			};
		};
		false
	} count RTMS_OBJECTS_LIST;
	
	if (diag_tickTime > (RTMS_LAST_BUILDING_SCAN + 0.5)) then
	{
		RTMS_LAST_BUILDING_SCAN = diag_tickTime;
		private "_uninstallBuildings";
		_nearBuildings = call RTMS_HouseIntersector;
		
		private "_uninstallBuildings";
		
		_uninstallBuildings = RTMS_NEAR_BUILDINGS - _nearBuildings;
		_null = {_x setVariable ["RTMS_ACTIVE_MENU_SELECTIONS", nil]; false} count _uninstallBuildings;
		RTMS_NEAR_BUILDINGS = _nearBuildings;
	}
	else
	{
		_nearBuildings = RTMS_NEAR_BUILDINGS;
	};
	
	_null =
	{
		private "_activeMenu";
		if (isNil {_x getVariable "RTMS_ACTIVE_MENU_SELECTIONS"}) then
		{
			_activeMenu = [];
			//_activeMenu append ([_x, _nearObjects] call RTMS_AddDoors);
			_activeMenu append ([_x, _nearObjects] call RTMS_AddDoorsAdvanced);
			_activeMenu append ([_x, _nearObjects] call RTMS_AddLadders);
			_activeMenu append ([_x, _nearObjects] call RTMS_AddHatches);
			_x setVariable ["RTMS_ACTIVE_MENU_SELECTIONS", _activeMenu];
		}
		else
		{
			if (!((_x getVariable "RTMS_ACTIVE_MENU_SELECTIONS") isEqualTo [])) then
			{
				if (isNull ((_x getVariable "RTMS_ACTIVE_MENU_SELECTIONS") select 0)) then
				{
					_x setVariable ["RTMS_ACTIVE_MENU_SELECTIONS", nil];
					_activeMenu = [];
					//_activeMenu append ([_x, _nearObjects] call RTMS_AddDoors);
					_activeMenu append ([_x, _nearObjects] call RTMS_AddDoorsAdvanced);
					_activeMenu append ([_x, _nearObjects] call RTMS_AddLadders);
					_activeMenu append ([_x, _nearObjects] call RTMS_AddHatches);
					_x setVariable ["RTMS_ACTIVE_MENU_SELECTIONS", _activeMenu];
				}
				else
				{
					_nearObjects append (_x getVariable "RTMS_ACTIVE_MENU_SELECTIONS");
				};
			};
		};
	false
	} count _nearBuildings;

	
	_null = 
	{
		_x setVariable ["RTMS_CACHING_OBJ", nil];
		if ((!isObjectHidden _x) && (_x != player)) then
		{
			_nearObjects pushBack _x;
		};
		false
	} count _nearObjectsTemp;
	
	_uninstallList = RTMS_TO_DISPLAY - _nearObjects;
	
	RTMS_TO_DISPLAY = [];
	RTMS_CENTER_INDEX = 0;
	
	//player sideChat format ["UNINSTALL: %1", count _uninstallList];
	_null =
	{
		if (!isNull _x) then
		{
			private "_logics";
			_logics = (_x getVariable "RTMS_ACTIVE_MENU") - RTMS_OBJECTS_LIST; //this list is static
			[_logics, _x] call RTMS_UninstallMenuObjects;
			//[_logics] call RTMS_Cleanup;
			if (!isNil {_x getVariable "RTMS_HOUSE"}) then
			{
				RTMS_CLEANUP_LIST append _logics;
			};
			_x setVariable ["RTMS_IS_ACTIVE", nil];
		};
	false
	} count _uninstallList;
	
	{	
		_currentNear = _x;
		_vecDiff = (getPosASL _x) vectorDiff _posPlayer;
		_angle = ((_vecDiff select 0) atan2 (_vecDiff select 1)) - _dirPlayer;
		_angle = _angle - (360 * (floor (_angle / 360)));
		_tempArray pushBack [_angle, _forEachIndex];
		//RTMS_CENTER_INDEX = [RTMS_CENTER_INDEX, _forEachIndex] select ((abs _angle) < abs ((_tempArray select RTMS_CENTER_INDEX) select 0));
		if (((abs _angle) < abs ((_tempArray select RTMS_CENTER_INDEX) select 0))) then
		{
			RTMS_CENTER_INDEX = _forEachIndex;
		};
		if (isNil {_currentNear getVariable "RTMS_IS_ACTIVE"}) then
		{
			_installList = [];
			_null = 
			{
				if ((_currentNear isKindOf (_x getVariable "CLASS_NAME")) || ((_x getVariable "CLASS_NAME") == typeOf _currentNear)) then
				{
					_installList pushBack (_x);
				};
			false
			} count RTMS_CLASS_LIST;
			_currentNear setVariable ["RTMS_IS_ACTIVE", true];
			[_installList, _currentNear] call RTMS_InstallMenuObjects;
		};
		
	} foreach _nearObjects;
	
	_tempArray sort true; //where the magic happens
	
	RTMS_TO_DISPLAY_COUNT =
	{
		RTMS_TO_DISPLAY pushBack (_nearObjects select (_x select 1));
	true
	} count _tempArray;
};

RTMS_KeyboardEvent =
{
	private "_block";
	_block = false;
	if (isNil "RTMS_INITIALIZED") exitWith {true};
	if (0 < 
	(
	{
		(parseNumber (_x select 0)) != (parseNumber (_x select 1))
	} count [[RTMS_KEY_SHIFT, (_this select 2)], [RTMS_KEY_CTRL, (_this select 3)]]
	)
	) exitWith {_block;};
	
	
	private 
		[
			"_key", 
			"_state", 
			"_next", 
			"_back", 
			"_displayIndex", 
			"_subIndex", 
			"_endDir", 
			"_dirDelta", 
			"_endIndex", 
			"_object",
			"_subCount", 
			"_subOpen", 
			"_subArgs", 
			"_subFunc", 
			"_subCond",
			"_subCondObj",
			"_currentMenu"
		];
		
	_block = true;
	if (RTMS_MENU_DISABLED || (isObjectHidden (RTMS_SELECTED_MENU select 0)) || RTMS_QB_DOWN) exitWith {_block;};
	if (RTMS_MENU_HIDDEN && ((_this select 1) == RTMS_KEY_DOWN)) exitWith {_block;};
	_key = _this select 1;
	RTMS_KEY_SELECTED = true;
	
	if (RTMS_VISUAL_INDEX < 0) exitWith {_block;};
	if (isNull (RTMS_SELECTED_MENU select 0)) exitWith {_block;}; //time between last main frame and keyboard event lost the object
	if ((RTMS_SELECTED_MENU select 0) == player) exitWith {_block;};
	RTMS_KEY_SELECTED = false;
	_endIndex = RTMS_DISPLAYED_COUNT;
	_object = RTMS_SELECTED_MENU select 0;
	_dirDelta = _object getVariable "RTMS_ROTATE_DELTA";
	_subIndex = RTMS_SELECTED_SUB_MENU select 1;
	_subOpen = RTMS_SELECTED_SUB_MENU select 0;
	_subCount = _object getVariable "RTMS_SUB_COUNT";
	
	if (_key == RTMS_KEY_UP) then
	{
		if (RTMS_MENU_HIDDEN) then
		{
			RTMS_MENU_HIDDEN = false;
		}
		else
		{
			if (_subOpen) then
			{
				RTMS_IN_BOX = [_object] call RTMS_InBoundingBox;
				_currentMenu = (RTMS_MENU_STACK select (RTMS_STACK_COUNT - 1)) select 0;
				_subArgs = [_object];
				_subArgs append ((_currentMenu select _subIndex) select 6);
				_subFunc = (_currentMenu select _subIndex) select 5;
				_subCondObj = (_currentMenu select _subIndex) select 10;
				
				if ((player distance (_object getVariable "RTMS_OBJECT_CENTER")) > ([_object, (((_object getVariable "RTMS_SUB_MENU_LIST") select _subIndex) select 7)] call RTMS_AdaptDistance)) exitWith {};
				call RTMS_UpdateConditions;
				if (!(_subCondObj getVariable "RTMS_SHOW")) exitWith {};
				_subCond = ((_currentMenu select _subIndex) select 8);
				if (!(_subCond isEqualTo [])) then
				{
					_subCond = [[_object]];
					(_subCond select 0) append (((_currentMenu select _subIndex) select 8) select 0);
					_subCond pushBack (((_currentMenu select _subIndex) select 8) select 1);
					if (!((_subCond select 0) call (_subCond select 1))) exitWith {};
					_subArgs call _subFunc;
				}
				else
				{
					_subArgs call _subFunc;
				};
			}
			else
			{
				if (_subCount > 0) then
				{
					[_object, (_object getVariable "RTMS_SUB_MENU_LIST")] call RTMS_PushSubMenu;
					[RTMS_ROTATOR_DIR, RTMS_ROTATOR_DIR, RTMS_MENU_ROTATOR, round (1440 / _subCount)] call RTMS_SetRotator;
				};
				_null = 
				{
					if (!([] isEqualTo (_x getVariable "CLASS_MAIN_SCRIPT"))) then
					{
						_subArgs = [_object];
						_subArgs append ((_x getVariable "CLASS_MAIN_SCRIPT") select 0);
						_subArgs call ((_x getVariable "CLASS_MAIN_SCRIPT") select 1);
					};
				false
				} count (_object getVariable "RTMS_ACTIVE_MENU");
			};
		};
	};
	
	if (_key == RTMS_KEY_DOWN) then
	{
		if (!RTMS_MENU_HIDDEN) then
		{
			if (_subOpen) then
			{
				RTMS_CreateVectorPlaneExtended_SNS setVariable ["LAST_POS", []];
				[_object] call RTMS_PopSubMenu;
			}
			else
			{
				RTMS_SELECTED_MENU = [objNull, -1];
				RTMS_SELECTED_SUB_MENU = [false, 0];
				RTMS_VISUAL_INDEX = -1;
				RTMS_ROTATOR_DIR = 90;
				RTMS_MENU_HIDDEN = true;
			};
		};
	};
	
	if (RTMS_MENU_HIDDEN) exitWith {_block;};
	
	if (_key == RTMS_KEY_LEFT) then
	{
		if (_subOpen) then
		{
			//_dirDelta = _dirDelta * (-1);
			_endDir = [RTMS_ROTATOR_DIR + _dirDelta] call RTMS_NormalizeAngle;
			[_endDir, RTMS_ROTATOR_DIR, RTMS_MENU_ROTATOR, round (1440 / _subCount)] call RTMS_SetRotator;
			_next = _subIndex - 1;
			if (_next < 0) then
			{
				_next = _subCount - 1;
			};
			RTMS_SELECTED_SUB_MENU = [true, _next];
			RTMS_ROTATOR_DIR = [_endDir, 90] select ((RTMS_SELECTED_SUB_MENU select 1) == 0);
		}
		else
		{
			private "_initialInd";
			_initialInd = RTMS_SELECTED_MENU select 1;
			call RTMS_UpdateConditions;
			_subCond = false;
			
			RTMS_ROTATOR_DIR = 90;
			RTMS_SELECTED_SUB_MENU set [1, 0];
			_next = (RTMS_SELECTED_MENU select 1) - 1;
			if (_next < 0) then
			{
					_next = _endIndex - 1;
			};
			private "_i";
			_i = 0;
			while {true} do
			{
				if (!isNull (RTMS_DISPLAYED select _next)) then
				{
					_subCond = ((((RTMS_DISPLAYED select _next) getVariable "RTMS_ACTIVE_MENU") select 0) getVariable "CLASS_CONDITION_NAMESPACE") getVariable "RTMS_SHOW";
					_subCond = (_subCond || (((RTMS_DISPLAYED select _next) getVariable "RTMS_SUB_COUNT") != 0));
				};
				if (_subCond) exitWith {};
				if (_next == _initialInd) exitWith {player sideChat "MYSELF!";};
				_next = _next - 1;
				if (_next < 0) then
				{
					_next = _endIndex - 1;
				};
				_i = _i + 1;
			};
			
			RTMS_SELECTED_MENU = [(RTMS_DISPLAYED select _next), _next];
			
		};
	};
	
	if (_key == RTMS_KEY_RIGHT) then
	{
		if (_subOpen) then
		{
			_dirDelta = _dirDelta * (-1);
			_endDir = [RTMS_ROTATOR_DIR + _dirDelta] call RTMS_NormalizeAngle;
			[_endDir, RTMS_ROTATOR_DIR, RTMS_MENU_ROTATOR, (-1) * (round (1440 / _subCount))] call RTMS_SetRotator;
			_next = _subIndex + 1;
			if (_next >= _subCount) then
			{
				_next = 0;
			};
			RTMS_SELECTED_SUB_MENU = [true, _next];
			RTMS_ROTATOR_DIR = [_endDir, 90] select ((RTMS_SELECTED_SUB_MENU select 1) == 0);;
		}
		else
		{
			private "_initialInd";
			_initialInd = RTMS_SELECTED_MENU select 1;
			call RTMS_UpdateConditions;
			_subCond = false;
			
			RTMS_ROTATOR_DIR = 90;
			RTMS_SELECTED_SUB_MENU set [1, 0];
			_next = (RTMS_SELECTED_MENU select 1) + 1;
			if (_next >= _endIndex) then
			{
				_next = 0;
			};
			
			private "_i";
			_i = 0;
			
			while {true} do
			{
				if (!isNull (RTMS_DISPLAYED select _next)) then
				{
					_subCond = ((((RTMS_DISPLAYED select _next) getVariable "RTMS_ACTIVE_MENU") select 0) getVariable "CLASS_CONDITION_NAMESPACE") getVariable "RTMS_SHOW";
					_subCond = (_subCond || (((RTMS_DISPLAYED select _next) getVariable "RTMS_SUB_COUNT") != 0));
				};
				if (_subCond) exitWith {};
				if (_next == _initialInd) exitWith {};
				_next = _next + 1;
				if (_next >= _endIndex) then
				{
					_next = 0;
				};
				_i = _i + 1;
			};
			RTMS_SELECTED_MENU = [(RTMS_DISPLAYED select _next), _next];
		};
	};
	
	_block;
};
RTMS_OnScreen =
{
	private ["_pos", "_return", "_a", "_b"];
	_pos = worldToScreen (_this select 0);
	_return = false;
	if (_pos isEqualTo []) exitWith {_return;};
	_a = _pos select 0;
	_b = _pos select 1;
	
	_return = ((_a >= safeZoneX) && (_a <= (safeZoneX + safeZoneW)));
	_return = ((_b >= safeZoneY) && (_b <= (safeZoneY + safeZoneH)) && _return);
	_return;
};

RTMS_QuickButton =
{
	if (RTMS_SCROLL_DOWN) exitWith {};
	private [
			"_subArgs",
			"_object"
	];
	if (RTMS_VIP > -1) then
	{
		if (isNull (RTMS_SELECTED_MENU select 0)) then
		{
			if (isNull (RTMS_DISPLAYED select RTMS_VIP)) exitWith {};
			if (RTMS_MENU_DISABLED || (isObjectHidden (RTMS_DISPLAYED select RTMS_VIP))) exitWith {};
			if ((RTMS_DISPLAYED select RTMS_VIP) == player) exitWith {};
		
			_object = RTMS_DISPLAYED select RTMS_VIP;
			
			if (!([_object getVariable "RTMS_ICON_CENTER"] call RTMS_OnScreen)) exitWith {};
			
			_null = 
			{
					if (!([] isEqualTo (_x getVariable "CLASS_MAIN_SCRIPT"))) then
					{
						_subArgs = [_object];
						_subArgs append ((_x getVariable "CLASS_MAIN_SCRIPT") select 0);
						_subArgs call ((_x getVariable "CLASS_MAIN_SCRIPT") select 1);
					};
			false
			} count (_object getVariable "RTMS_ACTIVE_MENU");	
		}
		else
		{
			if (RTMS_MENU_DISABLED || (isObjectHidden (RTMS_SELECTED_MENU select 0))) exitWith {};
			if ((RTMS_SELECTED_MENU select 0) == player) exitWith {};
			
			_object = RTMS_SELECTED_MENU select 0;
			
			if (!([_object getVariable "RTMS_ICON_CENTER"] call RTMS_OnScreen)) exitWith {};
			
			_null = 
			{
					if (!([] isEqualTo (_x getVariable "CLASS_MAIN_SCRIPT"))) then
					{
						_subArgs = [_object];
						_subArgs append ((_x getVariable "CLASS_MAIN_SCRIPT") select 0);
						_subArgs call ((_x getVariable "CLASS_MAIN_SCRIPT") select 1);
					};
			false
			} count (_object getVariable "RTMS_ACTIVE_MENU");
		};
	};
};

RTMS_IncrementDoor =
{
	private [
			"_subArgs",
			"_object",
			"_objectReady",
			"_index",
			"_house",
			"_scrollDir",
			"_phase"
	];
	_scrollDir = _this select 0;
	_scrollDir = (abs _scrollDir) / _scrollDir;
	_objectReady = false;
	if (RTMS_VIP > -1) then
	{
		if (isNull (RTMS_SELECTED_MENU select 0)) then
		{
			if (isNull (RTMS_DISPLAYED select RTMS_VIP)) exitWith {};
			if (RTMS_MENU_DISABLED || (isObjectHidden (RTMS_DISPLAYED select RTMS_VIP))) exitWith {};
			if ((RTMS_DISPLAYED select RTMS_VIP) == player) exitWith {};
		
			_object = RTMS_DISPLAYED select RTMS_VIP;
			
			//if (!([_object getVariable "RTMS_ICON_CENTER"] call RTMS_OnScreen)) exitWith {};
			
			_objectReady = true;
		}
		else
		{
			if (RTMS_MENU_DISABLED || (isObjectHidden (RTMS_SELECTED_MENU select 0))) exitWith {};
			if ((RTMS_SELECTED_MENU select 0) == player) exitWith {};
			
			_object = RTMS_SELECTED_MENU select 0;
			
			//if (!([_object getVariable "RTMS_ICON_CENTER"] call RTMS_OnScreen)) exitWith {};
			
			_objectReady = true;
		};
	};
	
	if (!_objectReady) exitWith {};
	
	if (isNil {_object getVariable "RTMS_DOOR_OPEN"}) exitWith {};
	if (isClass (configFile >> "cfgVehicles" >> (typeOf _house) >> "AnimationSources" >> format ["%1B_source", _object getVariable "RTMS_SELECTION_NAME"])) exitWith {};
	
	_index = _object getVariable "RTMS_ANIMATION_SOURCE";
	_house = _object getVariable "RTMS_HOUSE";
	_phase = (_house animationPhase _index) + (_scrollDir * 0.05);
	_phase = [_phase, 1] select (_phase > 1);
	_phase = [_phase, 0] select (_phase < 0);
	
	_house animate [_index, _phase, true];
};

RTMS_SelectPersonalMenu = 
{
	if (RTMS_PERSONAL_COUNT < 1) exitWith {};
	private [
		"_nextIndex", 
		"_scrollDir"
	];
	_scrollDir = _this select 0;
	_scrollDir = (abs _scrollDir) / _scrollDir;
	
	_nextIndex = (RTMS_PERSONAL_SELECTED select 1) - _scrollDir;
	
	if (_nextIndex >= RTMS_PERSONAL_COUNT) then
	{
		_nextIndex = 0;
	};
	
	if (_nextIndex < 0) then
	{
		_nextIndex = RTMS_PERSONAL_COUNT - 1;
	};
	
	RTMS_PERSONAL_SELECTED = [RTMS_PERSONAL_LIST select _nextIndex, _nextIndex];
};

RTMS_OpenPersonalMenu =
{
	if (isNull (RTMS_PERSONAL_SAVED select 0)) then
	{
		if (RTMS_PERSONAL_COUNT > 0) then
		{
			RTMS_PERSONAL_SELECTED = [RTMS_PERSONAL_LIST select 0, 0];
		};
	}
	else
	{
		RTMS_PERSONAL_SELECTED = RTMS_PERSONAL_SAVED;
	};
};

RTMS_ClosePersonalMenu =
{
	private [
			"_conditionArgs",
			"_conditionScript",
			"_mainArgs",
			"_mainScript",
			"_logic"
	];
	if (!isNull (RTMS_PERSONAL_SELECTED select 0)) then
	{
		_logic = RTMS_PERSONAL_SELECTED select 0;
		
		if (!((_logic getVariable "CLASS_MAIN_SCRIPT") isEqualTo [])) then
		{
			_mainArgs = (_logic getVariable "CLASS_MAIN_SCRIPT") select 0;
			_mainScript = (_logic getVariable "CLASS_MAIN_SCRIPT") select 1;
			if (!((_logic getVariable "CLASS_CONDITION") isEqualTo [])) then
			{
				_conditionArgs = (_logic getVariable "CLASS_CONDITION") select 0;
				_conditionScript = (_logic getVariable "CLASS_CONDITION") select 1;
				if (_conditionArgs call _conditionScript) then
				{
					_mainArgs call _mainScript;
					if ((RTMS_PERSONAL_SELECTED select 0) getVariable "CLASS_SAVE") then
					{
						RTMS_PERSONAL_SAVED = RTMS_PERSONAL_SELECTED;
					};
				};
			}
			else
			{
				_mainArgs call _mainScript;
				if ((RTMS_PERSONAL_SELECTED select 0) getVariable "CLASS_SAVE") then
				{
					RTMS_PERSONAL_SAVED = RTMS_PERSONAL_SELECTED;
				};
			};
		};
	};
};

RTMS_DrawPersonalMenu =
{
	private ["_logic", "_mainColor"];
	if (!isNull (RTMS_PERSONAL_SELECTED select 0)) then
	{
		_mainColor = [];
		_logic = RTMS_PERSONAL_SELECTED select 0;
		_mainColor append (_logic getVariable "CLASS_MAIN_COLOR");
		if (!((_logic getVariable "CLASS_CONDITION") isEqualTo [])) then
		{
			if (!(((_logic getVariable "CLASS_CONDITION") select 0) call ((_logic getVariable "CLASS_CONDITION") select 1))) then
			{
				_mainColor set [0, 0.5 * (_mainColor select 0)];
				_mainColor set [1, 0.5 * (_mainColor select 1)];
				_mainColor set [2, 0.5 * (_mainColor select 2)];
				_mainColor set [3, 0.5 * (_mainColor select 3)];
			};
		};
		drawIcon3D 
		[
			_logic getVariable "CLASS_ICON",
			_mainColor,
			positionCameraToWorld [0,-0.5,2],
			(_logic getVariable "CLASS_SIZE") select 0,
			(_logic getVariable "CLASS_SIZE") select 0,
			0,
			_logic getVariable "CLASS_TEXT",
			0,
			RTMS_DEFAULT_TEXT_SIZE + 0.03,
			"PuristaMedium",
			"",
			true
		];
	};
};


RTMS_InitRotationMenuSystem =
{
	if (!hasInterface) exitWith {};
	waitUntil {player == player};
	waitUntil{!(isNil "BIS_fnc_init")};
	waitUntil {time > 1};
	
	call RTMS_Parameters;
	//call RTMS_CompileFunctions;
	
	RTMS_CLASS_LIST = [];
	RTMS_CLASS_NAMES = [];
	RTMS_OBJECTS_LIST = [];
	RTMS_PERSONAL_LIST = [];
	RTMS_PERSONAL_COUNT = 0;
	RTMS_PERSONAL_SELECTED = [objNull, -1];
	RTMS_PERSONAL_SAVED = [objNull, -1];
	RTMS_TO_DISPLAY = [];
	RTMS_TO_DISPLAY_COUNT = 0;
	RTMS_SELECTED_MENU = [objNull, -1];
	RTMS_CENTER_INDEX = 0;
	RTMS_VISUAL_INDEX = -1;
	RTMS_VIP = -1;
	RTMS_SELECTED_SUB_MENU = [false, 0]; //false indicates sub menu closed, and zero is first item
	RTMS_LAST_SCAN = 0;
	RTMS_LAST_BUILDING_SCAN = 0;
	RTMS_DRAW_EH = 0;
	RTMS_MENU_ROTATOR = [90] call RTMS_CreateRotator;
	RTMS_ROTATOR_DIR = 90;
	RTMS_DIK_LIST = [RTMS_KEY_UP, RTMS_KEY_DOWN, RTMS_KEY_LEFT, RTMS_KEY_RIGHT];
	RTMS_MENU_HIDDEN = true;
	RTMS_CLEANUP_LIST = [];
	RTMS_LAST_CLEANUP = 0;
	RTMS_KEY_SELECTED = false;
	RTMS_MENU_DISABLED = false;
	RTMS_REQUESTS = [];
	RTMS_CONDITION_OBJECTS = [];
	RTMS_DEFAULT_CONDITION_NS = "logic" createVehicleLocal [0,0,0];
	RTMS_DEFAULT_CONDITION_NS setVariable ["RTMS_SHOW", true];
	RTMS_PERSONAL_CONDITION_NS = "logic" createVehicleLocal [0,0,0];
	RTMS_MENU_STACK = [];
	RTMS_STACK_COUNT = 0;
	RTMS_STACK_COEFF = 0;
	RTMS_NEAR_BUILDINGS = [];
	RTMS_DOOR_MENU = call compile preProcessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\DEFAULT_CLASSES\Logic_Class.sqf");
	RTMS_DOOR_MENU set [1, "Door"];
	RTMS_DOOR_MENU set [7, 2.5];
	RTMS_DOOR_MENU = RTMS_DOOR_MENU call RTMS_CreateMenuObject;
	RTMS_HAND_POS = player selectionPosition "LeftHand";
	RTMS_IN_BOX = false;
	RTMS_QB_DOWN = false;
	RTMS_QPM_DOWN = false;
	RTMS_SCROLL_DOWN = false;
	RTMS_QPM_INDEX = 0;
	RTMS_KEY_EH_LOCK = false;
	RTMS_QB_EH_LOCK = false;
	RTMS_QPM_EH_LOCK = false;
	RTMS_LAST_BB_CHECK = 0;
	RTMS_LAST_BB_VAL = false;
	RTMS_OCCLUSION_CAN_CHECK = false;
	RTMS_LAST_OCCLUSION_CHECK = 0;
	
	//vector plane functions static namespace (for performance)
	RTMS_CreateVectorPlaneExtended_SNS = "logic" createVehicleLocal [0,0,0];
	RTMS_CreateVectorPlaneExtended_SNS setVariable ["PERM_OBJ", true];
	RTMS_CreateVectorPlaneExtended_SNS setPosATL [0,0,0];
	RTMS_CreateVectorPlaneExtended_SNS setVariable ["LAST_POS", []];
	
	//create occlusion testing object
	//RTMS_THE_THING = "Land_WoodenBox_F" createVehicleLocal [0,0,0];
	RTMS_THE_THING = "Land_WaterBarrel_F" createVehicleLocal [0,0,0];
	RTMS_THE_THING allowDamage false;
	RTMS_THE_THING hideObject true;
	_null = player addEventHandler ["Respawn", {player disableCollisionWith RTMS_THE_THING;}];
	player disableCollisionWith RTMS_THE_THING;
	
	
	[(call RTMS_DefaultMenuClasses)] call RTMS_LoadMenuClasses;
	[(call RTMS_DefaultMenuObjects)] call RTMS_LoadMenuObjects;
	[(call RTMS_DefaultMenuPersonal)] call RTMS_LoadMenuPersonal;
	
	
	if (!isNil "PCS_INITIALIZED") then
	{
		[[], RTMS_Main] call PCS_AddPerFrameEvent;
	}
	else
	{
		["RTMS_PERFRAMES", "onEachFrame", RTMS_Main] call  BIS_fnc_addStackedEventHandler;
	};
	
	if (isNil "CBA_fnc_addKeybind") then
	{
		RTMS_KEY_EH_UP = (findDisplay 46) displayAddEventHandler ["KeyUp", {
		private "_block";
		_block = false;
		if ((_this select 1) in RTMS_DIK_LIST) then
		{
			if (isNil "RTMS_INITIALIZED") exitWith {true};
			_block = true;
			RTMS_KEY_EH_LOCK = false;
		};
		_block;
		}];
		
		RTMS_KEY_EH_DOWN = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		private "_block";
		_block = false;
		if ((_this select 1) in RTMS_DIK_LIST) then
		{
			if (isNil "RTMS_INITIALIZED") exitWith {true};
			if (!RTMS_KEY_EH_LOCK) then
			{
				_block = _this call RTMS_KeyboardEvent;
				RTMS_KEY_EH_LOCK = true;
			}
			else
			{
				_block = true;
			};
		};
		_block;
		}];
		
		RTMS_QB_UP_EH = (findDisplay 46) displayAddEventHandler ["KeyUp", {
		private "_block";
		_block = false;
		if (((_this select 1) == RTMS_KEY_SPACE)) then
		{
			if (isNil "RTMS_INITIALIZED") exitWith {true};
			if ((!(RTMS_SELECTED_SUB_MENU select 0)) && RTMS_QB_DOWN) then
			{
				RTMS_QB_DOWN = false; 
				call RTMS_QuickButton; 
				//showHUD true;
				inGameUISetEventHandler ["PrevAction", "false"];
				inGameUISetEventHandler ["NextAction", "false"];
				RTMS_SCROLL_DOWN = false;
			};
			_block = true;
			RTMS_QB_EH_LOCK = false;
		};
		_block;
		}];
		
		RTMS_QB_DOWN_EH = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		private "_block";
		_block = false;
		if (((_this select 1) == RTMS_KEY_SPACE)) then
		{
			if (isNil "RTMS_INITIALIZED") exitWith {true};
			_block = true;
			if (RTMS_QB_EH_LOCK) exitWith {};
			if (!RTMS_QPM_DOWN && !RTMS_QB_DOWN && !(RTMS_SELECTED_SUB_MENU select 0) && !RTMS_MENU_DISABLED) then
			{
				RTMS_QB_DOWN = true; 
				RTMS_SCROLL_DOWN = false;
			};
			if (RTMS_QPM_DOWN) then
			{
				RTMS_QPM_DOWN = false; 
				//showHUD true;
				inGameUISetEventHandler ["PrevAction", "false"];
				inGameUISetEventHandler ["NextAction", "false"];
				RTMS_SCROLL_DOWN = false;
				call RTMS_ClosePersonalMenu;
			};
			RTMS_QB_EH_LOCK = true;
		};
		_block;
		}];
		
		RTMS_QPM_UP_EH = (findDisplay 46) displayAddEventHandler ["KeyUp", {
		private "_block";
		_block = false;
		if (((_this select 1) == RTMS_KEY_TAB)) then
		{
			if (isNil "RTMS_INITIALIZED") exitWith {true};
			if (RTMS_QPM_DOWN) then
			{
				RTMS_QPM_DOWN = false; 
				//showHUD true;
				inGameUISetEventHandler ["PrevAction", "false"];
				inGameUISetEventHandler ["NextAction", "false"];
				RTMS_SCROLL_DOWN = false;
				//call RTMS_ClosePersonalMenu;
			};
			_block = true;
			RTMS_QPM_EH_LOCK = false;
		};
		_block;
		}];
		
		RTMS_QPM_DOWN_EH = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		private "_block";
		_block = false;
		if (((_this select 1) == RTMS_KEY_TAB)) then
		{
			if (isNil "RTMS_INITIALIZED") exitWith {true};
			_block = true;
			if (RTMS_QPM_EH_LOCK) exitWith {};
			if (!RTMS_QPM_DOWN && !RTMS_QB_DOWN) then
			{
					RTMS_QPM_DOWN = true; 
					RTMS_SCROLL_DOWN = false;
					call RTMS_OpenPersonalMenu;
			};
			RTMS_QPM_EH_LOCK = true;
		};
		_block;
		}];
	}
	else
	{
		private ["_name", "_key"];
		_name = "Rotation Menu System";
		_key = "rtms_keybinds";
		
		
		
		//next-------------------
		_null = [
			_name, 
			format ["%1_next", _key], 
			"Select", 
			{["", RTMS_KEY_UP, RTMS_KEY_SHIFT, RTMS_KEY_CTRL, RTMS_KEY_ALT] call RTMS_KeyboardEvent}, 
			{true},
			[RTMS_KEY_UP, [RTMS_KEY_SHIFT, RTMS_KEY_CTRL, RTMS_KEY_ALT]],
			false,
			0,
			false
		] call CBA_fnc_addKeybind;
		//----------------------
		
		
		
		//back-------------------
		_null = [
			_name, 
			format ["%1_back", _key], 
			"Last", 
			{["", RTMS_KEY_DOWN, RTMS_KEY_SHIFT, RTMS_KEY_CTRL, RTMS_KEY_ALT] call RTMS_KeyboardEvent}, 
			{true},
			[RTMS_KEY_DOWN, [RTMS_KEY_SHIFT, RTMS_KEY_CTRL, RTMS_KEY_ALT]],
			false,
			0,
			false
		] call CBA_fnc_addKeybind;
		//--------------------------
		
		
		
		//right-----------------------
		_null = [
			_name, 
			format ["%1_right", _key], 
			"right", 
			{["", RTMS_KEY_RIGHT, RTMS_KEY_SHIFT, RTMS_KEY_CTRL, RTMS_KEY_ALT] call RTMS_KeyboardEvent}, 
			{true},
			[RTMS_KEY_RIGHT, [RTMS_KEY_SHIFT, RTMS_KEY_CTRL, RTMS_KEY_ALT]],
			false,
			0,
			false
		] call CBA_fnc_addKeybind;
		//-----------------------------
		
		
		
		//left--------------------------
		_null = [
			_name, 
			format ["%1_left", _key], 
			"left", 
			{["", RTMS_KEY_LEFT, RTMS_KEY_SHIFT, RTMS_KEY_CTRL, RTMS_KEY_ALT] call RTMS_KeyboardEvent}, 
			{true},
			[RTMS_KEY_LEFT, [RTMS_KEY_SHIFT, RTMS_KEY_CTRL, RTMS_KEY_ALT]],
			false,
			0,
			false
		] call CBA_fnc_addKeybind;
		//---------------------------------
		
		
		
		//quick------------------------------
		_null = [
			_name, 
			format ["%1_quick", _key], 
			"quick button", 
			{
				if (isNil "RTMS_INITIALIZED") exitWith {true};
				if (!RTMS_QPM_DOWN && !RTMS_QB_DOWN && !(RTMS_SELECTED_SUB_MENU select 0) && !RTMS_MENU_DISABLED) then
				{
					RTMS_QB_DOWN = true; 
					RTMS_SCROLL_DOWN = false;
				};
				if (RTMS_QPM_DOWN) then
				{
					RTMS_QPM_DOWN = false; 
					//showHUD true;
					inGameUISetEventHandler ["PrevAction", "false"];
					inGameUISetEventHandler ["NextAction", "false"];
					RTMS_SCROLL_DOWN = false;
					call RTMS_ClosePersonalMenu;
				};
				true
			}, 
			{
				if (isNil "RTMS_INITIALIZED") exitWith {true};
				if (RTMS_QB_DOWN) then
				{
					RTMS_QB_DOWN = false; 
					call RTMS_QuickButton; 
					//showHUD true;
					inGameUISetEventHandler ["PrevAction", "false"];
					inGameUISetEventHandler ["NextAction", "false"];
					RTMS_SCROLL_DOWN = false;
				};
				true
			},
			[RTMS_KEY_SPACE, [false, false, false]],
			false,
			0,
			false
		] call CBA_fnc_addKeybind;
		//--------------------------------------
		
		
		
		//personal-------------------------------
		_null = [
			_name, 
			format ["%1_personal", _key], 
			"personal menu", 
			{
				if (isNil "RTMS_INITIALIZED") exitWith {true};
				if (!RTMS_QPM_DOWN && !RTMS_QB_DOWN) then
				{
						RTMS_QPM_DOWN = true; 
						RTMS_SCROLL_DOWN = false;
						call RTMS_OpenPersonalMenu;
				};
				true
			}, 
			{
				if (isNil "RTMS_INITIALIZED") exitWith {true};
				if (RTMS_QPM_DOWN) then
				{
					RTMS_QPM_DOWN = false; 
					//showHUD true;
					inGameUISetEventHandler ["PrevAction", "false"];
					inGameUISetEventHandler ["NextAction", "false"];
					RTMS_SCROLL_DOWN = false;
					//call RTMS_ClosePersonalMenu;
				};
				true
			},
			[RTMS_KEY_TAB, [false, false, false]],
			false,
			0,
			false
		] call CBA_fnc_addKeybind;
		//-----------------------------------------
		
		
		
	};
	
	RTMS_SCROLL_EH = (findDisplay 46) displayAddEventHandler ["MouseZChanged", {
	private "_block";
	if (isNil "RTMS_INITIALIZED") exitWith {};
		if (RTMS_QB_DOWN) then
		{
			//showHUD false;
			inGameUISetEventHandler ["PrevAction", "true"];
			inGameUISetEventHandler ["NextAction", "true"];
			RTMS_SCROLL_DOWN = true;
			[_this select 1] call RTMS_IncrementDoor;
		}
		else
		{
		
			if (RTMS_QPM_DOWN) then
			{
				inGameUISetEventHandler ["PrevAction", "true"];
				inGameUISetEventHandler ["NextAction", "true"];
				RTMS_SCROLL_DOWN = true;
				[_this select 1] call RTMS_SelectPersonalMenu;
			};
		};
	}];
		
RTMS_INITIALIZED = true;
};

RTMS_NormalizeFloat = 
{
	private "_value";
	private "_a";
	_value = _this select 0;
	//_a = 0;
	if (finite _value) then
	{
		//_a = value;
		_value = _value / 0.001;
		_value = floor _value;
		_value = _value * 0.001;
	}
	else
	{
		_value = 0;
	};
	_value;
};

RTMS_TrimInfinitesmal = 
{
	private "_value";
	private "_nearZero";
	_value = _this select 0;
	_nearZero = 0.0001;
	if ((abs _value) < _nearZero) then
	{
		_value = 0;
	};
	_value;
};

RTMS_NormalizeAngle = 
{
	private "_angle";
	_angle = _this select 0;
	//player SideChat format ["BEGIN: %1", _angle];
	if (isNil "RTMS_NormalizeAngle_SNP") then
	{
		RTMS_NormalizeAngle_SNP = "logic" createVehicleLocal [0,0,0];
	};
	RTMS_NormalizeAngle_SNP setDir _angle;
	_angle = getDir RTMS_NormalizeAngle_SNP;
	if (360 == floor _angle) then
	{
		_angle = 0;
	};
	//player SideChat format ["END: %1", _angle];
	_angle;
};

RTMS_ProcessRotator =
{
	private "_deltaAngle";
	private "_newTime";
	private "_oldTime";
	private "_totalTime";
	private "_deltaTime";
	private "_rotator";
	private "_finished";
	private "_processing";
	private "_rotateSpeed";
	private "_endTime";
	
	_rotator = _this select 0;
	_finished = _rotator getVariable "Finished";
	_processing = _rotator getVariable "Processing";
	//player SideChat format ["END: %1", (_rotator getVariable "endDir")];
	if (_finished) exitWith {(_rotator getVariable "endDir");};
	if (!_processing) exitWith
	{
		//started
		_rotator setVariable ["lastTimeLapse", diag_tickTime];
		_rotator setVariable ["Processing", true];
		(_rotator getVariable "startDir");
	};
	
	if (_processing) then
	{
		_endTime = _rotator getVariable "endTime";
		_totalTime = _rotator getVariable "totalTime";
		_rotateSpeed = _rotator getVariable "rotateSpeed";
		_lastDir = _rotator getVariable "lastDir";
		_oldTime = _rotator getVariable "lastTimeLapse";
		_newTime = diag_tickTime;
		_rotator setVariable ["lastTimeLapse", _newTime];
		_deltaTime = (_newTime - _oldTime);
		_deltaAngle = (_deltaTime * _rotateSpeed);
		_deltaAngle = [_deltaAngle] call RTMS_NormalizeFloat;
		_deltaAngle = _deltaAngle + _lastDir;
		_deltaAngle = [_deltaAngle] call RTMS_NormalizeAngle;
		_rotator setVariable ["lastDir", _deltaAngle];
		_totalTime = _deltaTime + _totalTime;
		_rotator setVariable ["totalTime", _totalTime];
		//hint format ["OLD: %1\nNEW: %2\nDELTA: %3\nANGLE: %4", _oldTime, _newTime, _endTime, _totalTime];
	};
	
	if (_totalTime >= _endTime) then
	{
		//hint format ["OLD: %1\nNEW: %2\nDELTA: %3\nANGLE: %4", _oldTime, _newTime, _endTime, _totalTime];
		_rotator setVariable ["Processing", false];
		_rotator setVariable ["Finished", true];
		_deltaAngle = _rotator getVariable "endDir";
	};
	//player SideChat format ["END: %1 TOTAL: %2 END: %3 ANGLE: %4", _endTime, _totalTime, (_rotator getVariable "endDir"), _deltaAngle];
	_deltaAngle;
};

RTMS_CreateRotator = 
{
	private "_startDir";
	private "_rotator";
	_startDir = _this select 0;
	_rotator = "logic" createVehicleLocal [0,0,0];
	[_startDir, _startDir, _rotator, 1] call RTMS_SetRotator;
	
	_rotator;
};

RTMS_SetRotator =
{
	private "_lastTime";
	private "_lastDir";
	private "_rotator";
	private "_rotateSpeed";
	private "_endDir";
	private "_dirLeft";
	private "_timeLeft";
	_endDir = _this select 0;
	_lastDir = _this select 1;
	_rotator = _this select 2;
	_rotateSpeed = _this select 3;
	
	_endDir = [_endDir] call RTMS_NormalizeAngle;
	_lastDir = [_lastDir] call RTMS_NormalizeAngle;
	_endDir = [_endDir] call RTMS_TrimInfinitesmal;
	_lastDir = [_lastDir] call RTMS_TrimInfinitesmal;
	
	_rotator setVariable ["lastTimeLapse", 0];
	_rotator setVariable ["lastDir", _lastDir];
	_rotator setVariable ["startDir", _lastDir];
	_rotator setVariable ["endDir", _endDir];
	_rotator setVariable ["totalTime", 0];
	_rotator setVariable ["Processing", false];
	_rotator setVariable ["Finished", false];
	_rotator setVariable ["rotateSpeed", _rotateSpeed];
	
	_dirLeft = (_endDir - _lastDir);
	
	if (_rotateSpeed > 0) then
	{
			if (_dirLeft >= 0) then
			{
				_timeLeft = _dirLeft / _rotateSpeed;
			}
			else
			{
				_dirLeft = (360 - _lastDir) + _endDir;
				_timeLeft = _dirLeft / _rotateSpeed;
			};
	}
	else
	{
		if (_dirLeft < 0) then
		{
			_timeLeft = _dirLeft / _rotateSpeed;
		}
		else
		{
			_dirLeft = 360 - _dirLeft;
			_timeLeft = _dirLeft / (-1 * _rotateSpeed);
		};
	};
	_timeLeft = [_timeLeft] call RTMS_NormalizeFloat;
	_rotator setVariable ["endTime", _timeLeft];
};

RTMS_Main = compileFinal preprocessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\Main.sqf");
RTMS_GetAutoMenus = compileFinal preProcessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\GetAutoMenus.sqf");
RTMS_CreateVectorPlaneUp = compileFinal PreprocessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\CreateVectorPlaneUp.sqf");
RTMS_CreateVectorPlaneExtended = compileFinal PreprocessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\CreateVectorPlaneExtended.sqf");
RTMS_Parameters = compileFinal preProcessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\Parameters.sqf");
RTMS_DefaultMenuClasses = compileFinal preProcessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\DefaultMenuClasses.sqf");
RTMS_DefaultMenuObjects = compileFinal preProcessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\DefaultMenuObjects.sqf");
RTMS_DefaultMenuPersonal = compileFinal preProcessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\DefaultMenuPersonal.sqf");
RTMS_FindReplaceString = compileFinal preProcessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\FindReplaceString.sqf");
RTMS_AdaptDistance = compileFinal preProcessFile (RTMS_ROOT_DIR + "ROTATION_MENU_SYSTEM\AdaptDistance.sqf");
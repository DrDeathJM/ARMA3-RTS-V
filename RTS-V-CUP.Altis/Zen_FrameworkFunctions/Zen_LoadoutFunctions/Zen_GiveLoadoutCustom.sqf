// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"

#define GIVE_GEAR_SINGLE(SLOT, COMMAND) _gear = [_loadout, SLOT, 0] call Zen_ArrayGetNestedValue; \
    if !(typeName _gear == typeName [] && {count _gear == 0}) then { \
        _gear = _gear select 1; \
        if !(typeName _gear == typeName [] && {count _gear == 0}) then { \
            _x COMMAND ([_gear] call Zen_ArrayGetRandom); \
        }; \
    };

#define GIVE_GEAR_SET(SLOT, COMMAND) _gear = [_loadout, SLOT, 0] call Zen_ArrayGetNestedValue; \
    if !(typeName _gear == typeName [] && {count _gear == 0}) then { \
        _gear = _gear select 1; \
        if !(typeName _gear == typeName [] && {count _gear == 0}) then { \
            { \
                _unit COMMAND ([_x] call Zen_ArrayGetRandom); \
            } forEach _gear; \
        }; \
    };

_Zen_stack_Trace = ["Zen_GiveLoadoutCustom", _this] call Zen_StackAdd;
private ["_units", "_givenLoadoutArray", "_unit", "_givingType", "_loadout", "_gear", "_weaponsIndexes", "_gearWeapons", "_randomWeaponArrays", "_randomMagCount", "_randomMag", "_magIndex", "_weaponsList", "_weapIndex", "_weaponArray", "_uniformStuff", "_vestStuff", "_backpackStuff", "_rifleStuff", "_pistolStuff", "_sendPacket", "_count", "_type", "_NVGType"];

if !([_this, [["VOID"], ["ARRAY", "STRING"], ["STRING"], ["BOOL"]], [[], ["STRING"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_units = [(_this select 0)] call Zen_ConvertToObjectArray;
_givenLoadoutArray = _this select 1;

ZEN_STD_Parse_GetSetArgumentOptional(_givingType, 2, "complete", "complete")
ZEN_STD_Parse_GetSetArgumentDefault(_sendPacket, 3, true, false)

{
    if (local _x) then {
        _unit = _x;
        _unitAnim = animationState _unit;

        if (toLower _givingType == "complete") then {
            removeAllWeapons _x;
            removeAllContainers _x;
            removeAllAssignedItems _x;
            removeUniform _x;
            removeBackpack _x;
            removeVest _x;
            removeGoggles _x;
            removeHeadgear _x;
        } else {
            _uniformStuff = uniformItems _unit;
            _vestStuff = vestItems _unit;
            _backpackStuff = backpackItems _unit;
            _rifleStuff = primaryWeaponItems _unit;
            _pistolStuff = handgunItems _unit;
        };

        _loadout = [_givenLoadoutArray] call Zen_ArrayGetRandom;
        _loadout = [_loadout, false] call Zen_GetLoadoutData;

        if (count _loadout == 0) exitWith {
            0 = ["Zen_GiveLoadoutCustom", "Given custom loadout does not exist", _this] call Zen_PrintError;
            call Zen_StackPrint;
        };

        _loadout = _loadout select 1;

        GIVE_GEAR_SINGLE("uniform", forceAddUniform)
        if (toLower _givingType == "additive") then {
            _unit addUniform uniform _unit;
            {
                (uniformContainer _unit) addItemCargoGlobal [_x, 1];
            } forEach _uniformStuff;
        };

        GIVE_GEAR_SINGLE("vest", addVest)
        if (toLower _givingType == "additive") then {
            _unit addVest vest _unit;
            {
                (vestContainer _unit) addItemCargoGlobal [_x, 1];
            } forEach _vestStuff;
        };

        GIVE_GEAR_SINGLE("backpack", addBackpack)
        if (toLower _givingType == "additive") then {
            _unit addBackpack backpack _unit;
            {
                (backpackContainer _unit) addItemCargoGlobal [_x, 1];
            } forEach _backpackStuff;
        };

        GIVE_GEAR_SINGLE("headgear", addHeadgear)
        GIVE_GEAR_SINGLE("goggles", addGoggles)

        GIVE_GEAR_SET("assignedItems", linkItem)
        // GIVE_GEAR_SET("items", addItem)

        _gear = [_loadout, "items", 0] call Zen_ArrayGetNestedValue;
        if !((typeName _gear == typeName []) && {count _gear == 0}) then {
            _gear = _gear select 1;
            if !((typeName _gear == typeName []) && {count _gear == 0}) then {
                {
                    if ((typeName _x == "ARRAY") && {(({typeName _x == "SCALAR"} count _x) > 0)}) then {
                        _type = [([_x, "STRING"] call Zen_ArrayGetType)] call Zen_ArrayGetRandom;
                        _count = (([_x, "SCALAR"] call Zen_ArrayGetType) select 0);
                        for "_i" from 1 to _count do {
                            _unit addItem _type;
                        };
                    } else {
                        _unit addItem ([_x] call Zen_ArrayGetRandom);
                    };
                } forEach _gear;
            };
        };

        _randomWeaponArrays = [];
        _randomMagCount = 0;
        _weaponsIndexes = [_loadout, "weapons", 0] call Zen_ArrayGetNestedIndex;
        if (count _weaponsIndexes != 0) then {
            _gearWeapons = _loadout select (_weaponsIndexes select 0);
            _weaponsList = _gearWeapons select 1;
            _randomWeaponArrays = [_weaponsList, "ARRAY"] call Zen_ArrayGetType;
        } else {
            _gearWeapons = [];
            _weaponsList = [];
        };

        _gear = [_loadout, "magazines", 0] call Zen_ArrayGetNestedValue;
        if !(typeName _gear == typeName [] && {count _gear == 0}) then {
            _gear = _gear select 1;
            if !(typeName _gear == typeName [] && {count _gear == 0}) then {
                {
                    if ((typeName (_x select 0)) == "ARRAY") then {
                        _magIndex = ZEN_STD_Array_RandIndex(_x);
                        _randomMag = _x select _magIndex;

                        if (count _randomMag > 0) then {
                            if ((typeName (_randomMag select 0)) == "ARRAY") then {
                                {
                                    _unit addMagazines [(_x select 0), (_x select 1)];
                                } forEach _randomMag;
                            } else {
                                _unit addMagazines [(_randomMag select 0), (_randomMag select 1)];
                            };
                        };

                        if (count _randomWeaponArrays > _randomMagCount) then {
                            _weaponArray = _randomWeaponArrays select _randomMagCount;

                            _randomWeapon = _weaponArray select (_magIndex min (count _weaponArray - 1));
                            if (typeName _randomWeapon == "STRING") then {
                                _unit addWeaponGlobal _randomWeapon;
                            } else {
                                {
                                    _unit addWeaponGlobal _x;
                                } forEach _randomWeapon;
                            };

                            _weapIndex = [_weaponArray, _weaponsList] call Zen_ValueFindInArray;
                            _weaponsList set [_weapIndex, 0];
                            _randomMagCount = _randomMagCount + 1;
                        };
                    } else {
                        _unit addMagazines [(_x select 0), (_x select 1)];
                    };
                } forEach _gear;
            };
        };

        0 = [_weaponsList, 0] call Zen_ArrayRemoveValue;
        if !(typeName _gearWeapons == typeName [] && {count _gearWeapons == 0}) then {
            if !((typeName _weaponsList == "ARRAY") && {count _weaponsList == 0}) then {
                {
                    _unit addWeaponGlobal ([_x] call Zen_ArrayGetRandom);
                } forEach _weaponsList;
            };
        };

        removeAllPrimaryWeaponItems _unit;
        removeAllHandgunItems _unit;

        if (toLower _givingType == "additive") then {
            {
                if (_x != "") then {
                    _unit addPrimaryWeaponItem _x;
                };
            } forEach _rifleStuff;
            {
                if (_x != "") then {
                    _unit addHandgunItem _x;
                };
            } forEach _pistolStuff;
        };

        GIVE_GEAR_SET("primaryAttachments", addPrimaryWeaponItem)
        GIVE_GEAR_SET("secondaryAttachments", addSecondaryWeaponItem)
        GIVE_GEAR_SET("handgunAttachments", addHandgunItem)

        _NVGType = "";
        {
            if ((toUpper (toString ([(toArray _x), 0, 2] call Zen_ArrayGetIndexedSlice))) == "NVG") exitWith {
                _NVGType = _x;
            };
        } forEach (assignedItems _x);

        if (sunOrMoon == 1) then {
            _x unassignItem _NVGType;
        } else {
            if (_NVGType != "") then {
                _x action ["NVGoggles", _x];
            };
        };

        if (vehicle _unit == _unit) then {
            _unit switchMove _unitAnim;
        };
    } else {
        if (isMultiplayer && {_sendPacket}) then {
            _args = [_x, _givenLoadoutArray, _givingType, false];
            Zen_MP_Closure_Packet = ["Zen_GiveLoadoutCustom", _args];
            (owner _x) publicVariableClient "Zen_MP_Closure_Packet";
        };
    };
} forEach _units;

call Zen_StackRemove;
if (true) exitWith {};

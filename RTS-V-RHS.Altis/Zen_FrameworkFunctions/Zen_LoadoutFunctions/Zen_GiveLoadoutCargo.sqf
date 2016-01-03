// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"

#define GIVE_GEAR_SINGLE(SLOT, COMMAND) _gear = [_loadout, SLOT, 0] call Zen_ArrayGetNestedValue; \
    if !(typeName _gear == typeName [] && {count _gear == 0}) then { \
        _gear = _gear select 1; \
        if !(typeName _gear == typeName [] && {count _gear == 0}) then { \
            _x COMMAND [([_gear] call Zen_ArrayGetRandom), 1]; \
        }; \
    };

#define GIVE_GEAR_SET(SLOT, COMMAND) _gear = [_loadout, SLOT, 0] call Zen_ArrayGetNestedValue; \
    if !(typeName _gear == typeName [] && {count _gear == 0}) then { \
        _gear = _gear select 1; \
        if !(typeName _gear == typeName [] && {count _gear == 0}) then { \
            { \
                _unit COMMAND [([_x] call Zen_ArrayGetRandom), 1]; \
            } forEach _gear; \
        }; \
    };

#include "..\Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_GiveLoadoutCargo", _this] call Zen_StackAdd;
private ["_units", "_givenLoadoutArray", "_unit", "_loadout", "_gear", "_weaponsIndexes", "_gearWeapons", "_randomWeaponArrays", "_randomMagCount", "_randomMag", "_magIndex", "_weaponsList", "_weaponArray", "_weapIndex"];

if !([_this, [["ARRAY", "OBJECT"], ["ARRAY", "STRING"], ["BOOL"]], [["OBJECT"], ["STRING"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_units = _this select 0;
_givenLoadoutArray = _this select 1;

ZEN_STD_Parse_ToArray(_units)

{
    _unit = _x;
    _loadout = [_givenLoadoutArray] call Zen_ArrayGetRandom;
    _loadout = [_loadout, false] call Zen_GetLoadoutData;

    if (count _loadout == 0) exitWith {
        0 = ["Zen_GiveLoadoutCustom", "Given custom loadout does not exist", _this] call Zen_PrintError;
        call Zen_StackPrint;
    };

    _loadout = _loadout select 1;

    GIVE_GEAR_SINGLE("uniform", addItemCargoGlobal)
    GIVE_GEAR_SINGLE("vest", addItemCargoGlobal)
    GIVE_GEAR_SINGLE("backpack", addItemCargoGlobal)
    GIVE_GEAR_SINGLE("headgear", addItemCargoGlobal)
    GIVE_GEAR_SINGLE("goggles", addItemCargoGlobal)

    GIVE_GEAR_SET("assignedItems", addItemCargoGlobal)
    // GIVE_GEAR_SET("items", addItemCargoGlobal)

    _gear = [_loadout, "items", 0] call Zen_ArrayGetNestedValue;
    if !((typeName _gear == typeName []) && {count _gear == 0}) then {
        _gear = _gear select 1;
        if !((typeName _gear == typeName []) && {count _gear == 0}) then {
            {
                if ((typeName _x == "ARRAY") && {(({typeName _x == "SCALAR"} count _x) > 0)}) then {
                    _type = [([_x, "STRING"] call Zen_ArrayGetType)] call Zen_ArrayGetRandom;
                    _count = (([_x, "SCALAR"] call Zen_ArrayGetType) select 0);
                    _unit addItemCargoGlobal [_type, _count];
                } else {
                    _unit addItemCargoGlobal [([_x] call Zen_ArrayGetRandom), 1];
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
                if (typeName (_x select 0) == "ARRAY") then {
                    _magIndex = ZEN_STD_Array_RandIndex(_x);
                    _randomMag = _x select _magIndex;

                    if (count _randomMag > 0) then {
                        if ((typeName (_randomMag select 0)) == "ARRAY") then {
                            {
                                _unit addMagazineCargoGlobal [(_x select 0), (_x select 1)];
                            } forEach _randomMag;
                        } else {
                            _unit addMagazineCargoGlobal [(_randomMag select 0), (_randomMag select 1)];
                        };
                    };

                    if (count _randomWeaponArrays > _randomMagCount) then {
                        _weaponArray = _randomWeaponArrays select _randomMagCount;

                        _randomWeapon = _weaponArray select (_magIndex min (count _weaponArray - 1));
                        if (typeName _randomWeapon == "STRING") then {
                            _unit addWeaponCargoGlobal [_randomWeapon, 1];
                        } else {
                            {
                                _unit addWeaponCargoGlobal [_x, 1];
                            } forEach _randomWeapon;
                        };

                        _weapIndex = [_weaponArray, _weaponsList] call Zen_ValueFindInArray;
                        _weaponsList set [_weapIndex, 0];
                        _randomMagCount = _randomMagCount + 1;
                    };
                } else {
                    for "_i" from 1 to (_x select 1) do {
                        _unit addMagazineCargoGlobal [(_x select 0), 1];
                    };
                };
            } forEach _gear;
        };
    };

    0 = [_weaponsList, 0] call Zen_ArrayRemoveValue;
    if !(typeName _gearWeapons == typeName [] && {count _gearWeapons == 0}) then {
        if !((typeName _weaponsList == "ARRAY") && {count _weaponsList == 0}) then {
            {
                _unit addWeaponCargoGlobal [([_x] call Zen_ArrayGetRandom), 1];
            } forEach _weaponsList;
        };
    };

    GIVE_GEAR_SET("primaryAttachments", addItemCargoGlobal)
    GIVE_GEAR_SET("secondaryAttachments", addItemCargoGlobal)
    GIVE_GEAR_SET("handgunAttachments", addItemCargoGlobal)
} forEach _units;

call Zen_StackRemove;
if (true) exitWith {};

/**
    Zen_RTS_StrategicBuildingTypeUpdate
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingTypeUpdate", _this] call Zen_StackAdd;
private ["_identifier", "_constructor", "_destructor", "_upgrades", "_name", "_desc", "_index", "_oldData", "_valid", "_indexes"];

if !([_this, [["STRING"], ["STRING", "SCALAR"], ["STRING", "SCALAR"], ["ARRAY", "SCALAR"], ["STRING", "SCALAR"]], [[], [], [], ["STRING"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_identifier = _this select 0;
_constructor = _this select 1;
ZEN_STD_Parse_GetArgumentDefault(_destructor, 2, 0)
ZEN_STD_Parse_GetArgumentDefault(_upgrades, 3, 0)
ZEN_STD_Parse_GetArgumentDefault(_name, 4, 0)
ZEN_STD_Parse_GetArgumentDefault(_desc, 5, 0)

_indexes = [Zen_RTS_Strategic_Building_Types, _identifier, 0] call Zen_ArrayGetNestedIndex;
if (count _indexes == 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_StrategicBuildingTypeUpdate", "Given building type does not exist.")
};

_index = _indexes select 0;
_oldData = Zen_RTS_Strategic_Building_Types select _index;

if !(_constructor isEqualTo 0) then {
    if !(isNil _constructor) then {
        _oldData set [1, _constructor];
    } else {
        ZEN_FMW_Code_Error("Zen_RTS_StrategicBuildingTypeUpdate", "Given constructor is undefined.")
    };
};

if !(_destructor isEqualTo 0) then {
    if !(isNil _destructor) then {
        _oldData set [2, _destructor];
    } else {
        ZEN_FMW_Code_Error("Zen_RTS_StrategicBuildingTypeUpdate", "Given destructor is undefined.")
    };
};

if !(_upgrades isEqualTo 0) then {
    _valid = true;
    {
        if (isNil _x) exitWith {
            _valid = false;
        };
    } forEach _upgrades;

    if (_valid) then {
        _oldData set [3, _upgrades];
    } else {
        ZEN_FMW_Code_Error("Zen_RTS_StrategicBuildingTypeUpdate", "One or more given upgrade function is undefined.")
    };
};

if !(_name isEqualTo 0) then {
    _oldData set [4, _name];
};

if !(_desc isEqualTo 0) then {
    _oldData set [5, _desc];
};

publicVariable "Zen_RTS_Strategic_Building_Types";

call Zen_StackRemove;
if (true) exitWith {};

// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RemoveFireSupportAction", _this] call Zen_StackAdd;
private ["_nameString", "_indexes", "_globalData", "_IDs", "_unitsToRemove", "_unitsRemaining"];

if !([_this, [["STRING"], ["VOID"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;

_indexes = [Zen_Fire_Support_Action_Array_Global, _nameString, 0] call Zen_ArrayGetNestedIndex;
if (count _indexes == 0) exitWith {
    ZEN_FMW_Code_Error("Zen_RemoveFireSupportAction", "Given action identifier does not exist.")
};

_globalData = Zen_Fire_Support_Action_Array_Global select (_indexes select 0);

if (count _this > 1) then {
    _unitsToRemove = [(_this select 1)] call Zen_ConvertToObjectArray;
    _unitsRemaining =+ (_globalData select 1);
} else {
    _unitsToRemove = _globalData select 1;
    _unitsRemaining = [];
    _this set [1, _unitsToRemove];
};

_args = [_nameString, _unitsToRemove, _unitsRemaining];
ZEN_FMW_MP_REAll("Zen_RemoveFireSupportAction_RemoveAction_MP", _args, call)

call Zen_StackRemove;
if (true) exitWith {};

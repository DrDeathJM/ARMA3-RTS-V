/**
    Zen_RTS_TerritoryGetData
    by Zenophon
    for RTS V

    Returns all data associated with (1) from the territory system.
    Usage : Call
    Params: 1. String, territory marker
    Return: Array
            1. String, the area marker
            2. Side, the owner of the territory
            3. Array of string, the sub-markers
            4. String, a nearly identical helper marker for color
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_TerritoryGetData", _this] call Zen_StackAdd;
private ["_marker", "_data"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_marker = _this select 0;
_data =+ ([Zen_RTS_Territory_Data, _marker, 0] call Zen_ArrayGetNestedValue);

call Zen_StackRemove;
(_data)

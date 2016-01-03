/**
    Zen_RTS_SubTerritoryGetData
    by Zenophon
    for RTS V

    Returns all data associated with (1) from the sub-territory system.
    Usage : Call
    Params: 1. String, sub-territory marker
    Return: Array
            1. String, marker name
            2. Side, current owner
            3. String, display name
            4. Scalar, level
            5. Array of scalars, resource value at each level
            6. Scalar, FOB status
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_SubTerritoryGetData", _this] call Zen_StackAdd;
private ["_marker", "_data"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_marker = _this select 0;
_data =+ ([Zen_RTS_SubTerritory_Data, _marker, 0] call Zen_ArrayGetNestedValue);

call Zen_StackRemove;
(_data)

/**
    Zen_RTS_SubTerritoryCreate
    by Zenophon
    for RTS V

    Registers (1) with the sub-territory system.  The sub territory thread will now
    consider this flag.  The name of the marker is used to refer to this sub-territory
    by all other sub-territory functions.  Sets the visual representation.
    The starting side is civilian.
    Usage : Call
    Params: 1. String, area marker
     (opt.) 2. String, display name, (default: 'Flag')
     (opt.) 3. Array of scalars, resource value at each level, (default: [0])
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_SubTerritoryCreate", _this] call Zen_StackAdd;
private ["_marker", "_name", "_resources", "_data"];

if !([_this, [["STRING"], ["STRING"], ["ARRAY"]], [[], [], ["SCALAR"]], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_marker = _this select 0;
ZEN_STD_Parse_GetArgumentDefault(_name, 1, "Flag")
ZEN_STD_Parse_GetArgumentDefault(_resources, 2, [0])

_data = [_marker] call Zen_RTS_SubTerritoryGetData;
if (count _data > 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_SubTerritoryCreate", "Given marker already registered as a sub-territory.")
};

Zen_RTS_SubTerritory_Data pushBack ([_marker, civilian, _name, 0, _resources, 0]);
publicVariable "Zen_RTS_SubTerritory_Data";

// 0 = [_marker] call Zen_RTS_SubTerritoryUpdate;
0 = [_marker] call Zen_RTS_SubTerritoryUpdateVisual;

call Zen_StackRemove;
if (true) exitWith {};

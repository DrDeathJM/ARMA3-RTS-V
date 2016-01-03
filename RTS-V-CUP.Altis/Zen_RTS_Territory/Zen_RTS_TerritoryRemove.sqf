/**
    Zen_RTS_TerritoryRemove
    by Zenophon
    for RTS V

    Removes the given territory marker from the system.  The main territory thread
    will no longer update this marker.  Also updates the visual representation.
    Usage : Call
    Params: 1. String, territory marker
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_TerritoryRemove", _this] call Zen_StackAdd;
private ["_marker", "_index", "_indexes"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_marker = _this select 0;
_indexes = [Zen_RTS_Territory_Data, _marker, 0] call Zen_ArrayGetNestedIndex;

if (count _indexes == 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_TerritoryRemove", "Given marker is not a territory.")
};

_index = _indexes select 0;
0 = [_marker, civilian] call Zen_RTS_TerritoryUpdate;
0 = [_marker] call Zen_RTS_TerritoryUpdateVisual;

deleteMarker ((Zen_RTS_Territory_Data select _index) select 3);

0 = [Zen_RTS_Territory_Data, _index] call Zen_ArrayRemoveIndex;
publicVariable "Zen_RTS_Territory_Data";

call Zen_StackRemove;
if (true) exitWith {};

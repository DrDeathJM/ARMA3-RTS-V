/**
    Zen_RTS_TerritoryEventCaptured
    by Zenophon
    for RTS V

    Proxy event function for Zen_RTS_TerritoryManager thread.
    Called when the side of a territory changes.
    Usage : Spawn
    Params: 1. String, the territory
            2. Array, the previous territory data
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_TerritoryEventCaptured", _this] call Zen_StackAdd;
private ["_marker", "_oldData", "_newData"];

if !([_this, [["STRING"], ["ARRAY"]], [[], ["STRING", "SIDE", "SCALAR", "ARRAY"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_marker = _this select 0;
_oldData = _this select 1;
_newData = [_marker] call Zen_RTS_TerritoryGetData;

// Debug
diag_log ("Zen_RTS_TerritoryEventCaptured :" + str time);
diag_log _oldData;
diag_log _newData;

call Zen_StackRemove;
if (true) exitWith {};

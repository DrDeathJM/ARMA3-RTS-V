/**
    Zen_RTS_TerritoryCreate
    by Zenophon
    for RTS V

    Registers (1) with the territory system.  The main territory thread will now
    consider this marker.  The name of the marker is used to refer to this territory
    by all other territory functions.  Sets the visual representation.
    The default side of all sub-markers is civilian.
    Usage : Call
    Params: 1. String, area marker
            2. Array of strings, string, the sub-area marker(s) this territory relies on
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_TerritoryCreate", _this] call Zen_StackAdd;
private ["_marker", "_subMarkers", "_controlTotal", "_data"];

if !([_this, [["STRING"], ["ARRAY", "STRING"]], [[], ["STRING"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_marker = _this select 0;
ZEN_STD_Parse_GetArgumentDefault(_subMarkers, 1, civilian)
ZEN_STD_Parse_ToArray(_subMarkers)

_data = [_marker] call Zen_RTS_TerritoryGetData;

if (count _data > 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_TerritoryCreate", "Given marker already registered as a territory.")
};

_grayMarker = [_marker, "", "colorBlack",  markerSize _marker, markerShape _marker, markerDir _marker, 1] call Zen_SpawnMarker;
Zen_RTS_Territory_Data pushBack ([_marker, civilian, [], _grayMarker]);
publicVariable "Zen_RTS_Territory_Data";

0 = [_marker, -1, _subMarkers] call Zen_RTS_TerritoryUpdate;
0 = [_marker] call Zen_RTS_TerritoryUpdateVisual;

call Zen_StackRemove;
if (true) exitWith {};

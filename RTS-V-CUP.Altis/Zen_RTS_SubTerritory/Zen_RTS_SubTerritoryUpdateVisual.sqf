/**
    Zen_RTS_SubTerritoryUpdateVisual
    by Zenophon
    for RTS V

    Updates the visual aspect of (1) to agree with current sub-territory data.
    Usage : Call
    Params: 1. String, sub-territory marker
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_SubTerritoryUpdateVisual", _this] call Zen_StackAdd;
private ["_marker", "_data", "_side", "_control", "_helpMarker", "_colorString", "_getSideColor"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_marker = _this select 0;
_data = [_marker] call Zen_RTS_SubTerritoryGetData;

if (count _data == 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_SubTerritoryUpdateVisual", "Given marker is not a sub-territory.")
};

_side = _data select 1;
_getSideColor = {
    (switch (_this) do {
        case West: {
             "colorBlufor"
        };
        case East: {
              "colorOpfor"
        };
        case resistance: {
              "colorIndependent"
        };
        case civilian: {
            //  "colorCivilian"
             "colorBlack"
        };
        default {
             ""
        }
    })
};

_colorString = _side call _getSideColor;
if (_colorString == "") exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_SubTerritoryUpdateVisual", "Sub-Territory data has invalid side.")
};

_marker setMarkerColor _colorString;
call Zen_StackRemove;
if (true) exitWith {};

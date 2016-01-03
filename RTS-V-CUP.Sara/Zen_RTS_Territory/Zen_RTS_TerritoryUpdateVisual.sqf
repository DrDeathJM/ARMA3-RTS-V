/**
    Zen_RTS_TerritoryUpdateVisual
    by Zenophon
    for RTS V

    Updates the visual aspect of (1) to agree with current data.
    Usage : Call
    Params: 1. String, territory marker
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_TerritoryUpdateVisual", _this] call Zen_StackAdd;
private ["_marker", "_data", "_side", "_control", "_helpMarker", "_colorString", "_getSideColor"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_marker = _this select 0;
_data = [_marker] call Zen_RTS_TerritoryGetData;

if (count _data == 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_TerritoryUpdateVisual", "Given marker is not a territory.")
};

_side = _data select 1;
_subMarkers = _data select 2;
_helpMarker = _data select 3;

if (count _subMarkers == 0) exitWith {
    call Zen_StackRemove;
};

_subTerritorySides = [];
{
    _subData = [_x] call Zen_RTS_SubTerritoryGetData;
    _side = _subData select 1;

    _subTerritorySides pushBack _side;
} forEach _subMarkers;

_control = ((({_x == _side} count _subTerritorySides)) - ({_x != _side && _x != civilian} count _subTerritorySides) / (count _subTerritorySides)) max 0;
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
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_TerritoryUpdateVisual", "Territory data has invalid side.")
};

_marker setMarkerColor _colorString;
_marker setMarkerAlpha _control;
_helpMarker setMarkerAlpha (1 - _control);

call Zen_StackRemove;
if (true) exitWith {};

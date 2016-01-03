/**
    Zen_RTS_TerritoryUpdate
    by Zenophon
    for RTS V

    Sets the data of the territory corresponding to (1).  Use -1 to skip (2,3) with
    no change.  Checks side argument for validity.  Updates the visual representation.
    Usage : Call
    Params: 1. String, territory marker
     (opt.) 2. Side, the owner of the territory, (default: -1)
     (opt.) 3. Array of strings, string, the sub-area marker(s) this territory relies on, (default: -1)
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_TerritoryUpdate", _this] call Zen_StackAdd;
private ["_marker", "_index", "_oldData", "_side", "_subMarkers", "_newData", "_units", "_indexes"];

if !([_this, [["STRING"], ["SIDE", "SCALAR"], ["SCALAR", "ARRAY", "STRING"]], [[], [], ["STRING"]], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_marker = _this select 0;
_indexes = [Zen_RTS_Territory_Data, _marker, 0] call Zen_ArrayGetNestedIndex;

if (count _indexes == 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_TerritoryUpdate", "Given marker is not a territory.")
};

_index = _indexes select 0;
_oldData = Zen_RTS_Territory_Data select _index;
ZEN_STD_Parse_GetArgumentDefault(_side, 1, -1)
ZEN_STD_Parse_GetArgumentDefault(_subMarkers, 2, -1)

_newData =+ _oldData;

if !(_side isEqualTo -1) then {
    if (_side in [West, East, resistance, civilian]) then {
        _newData set [1, _side];
    };
};

if !(_subMarkers isEqualTo -1) then {
    if (count _subMarkers > 0) then {
        _allValid = true;
        {
            if !(_x in allMapMarkers) exitWith {
                _allValid = false;
            };
        } forEach _subMarkers;

        if (_allValid) then {
            _newData set [2, _subMarkers];
        } else {
            ZEN_FMW_Code_Error("Zen_RTS_TerritoryUpdate", "Not all given sub-territories are valid markers.")
        };
    };
};

Zen_RTS_Territory_Data set [_index, _newData];
publicVariable "Zen_RTS_Territory_Data";

0 = [_marker] call Zen_RTS_TerritoryUpdateVisual;

call Zen_StackRemove;
if (true) exitWith {};

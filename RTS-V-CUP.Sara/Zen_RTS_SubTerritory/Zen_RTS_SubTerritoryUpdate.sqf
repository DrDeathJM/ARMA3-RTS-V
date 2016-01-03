/**
    Zen_RTS_SubTerritoryUpdate
    by Zenophon
    for RTS V

    Sets the data of the sub-territory corresponding to (1).  Use -1 to skip (2,6) with
    no change.  Checks side argument for validity.  Updates the visual representation.
    Usage : Call
    Params: 1. String, territory marker
     (opt.) 2. Side, the owner of the sub-territory, (default: -1)
     (opt.) 3. String, display name, (default: -1)
     (opt.) 4. Scalar, level, (default: -1)
     (opt.) 5. Array of scalars, resource value at each level, (default: -1)
     (opt.) 6. String, FOB status, (default: -1)
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_SubTerritoryUpdate", _this] call Zen_StackAdd;
private ["_marker", "_index", "_oldData", "_side", "_subMarkers", "_newData", "_units", "_indexes", "_name", "_level", "_resources", "_fob"];

if !([_this, [["STRING"], ["SIDE", "SCALAR"], ["STRING", "SCALAR"], ["SCALAR"], ["ARRAY", "SCALAR"], ["SCALAR"]], [[], [], [], [], ["SCALAR"]], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_marker = _this select 0;
_indexes = [Zen_RTS_SubTerritory_Data, _marker, 0] call Zen_ArrayGetNestedIndex;

if (count _indexes == 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_SubTerritoryUpdate", "Given marker is not a sub-territory.")
};

_index = _indexes select 0;
_oldData = Zen_RTS_SubTerritory_Data select _index;

ZEN_STD_Parse_GetArgumentDefault(_side, 1, -1)
ZEN_STD_Parse_GetArgumentDefault(_name, 2, -1)
ZEN_STD_Parse_GetArgumentDefault(_level, 3, -1)
ZEN_STD_Parse_GetArgumentDefault(_resources, 4, -1)
ZEN_STD_Parse_GetArgumentDefault(_fob, 5, -1)

_newData =+ _oldData;

if !(_side isEqualTo -1) then {
    if (_side in [West, East, resistance, civilian]) then {
        _newData set [1, _side];
    };
};

if !(_name isEqualTo -1) then {
    _newData set [2, _name];
};

if !(_level isEqualTo -1) then {
    _newData set [3, _level];
};

if !(_resources isEqualTo -1) then {
    _newData set [4, _resources];
};

if !(_fob isEqualTo -1) then {
    _newData set [5, _fob];
};

Zen_RTS_SubTerritory_Data set [_index, _newData];
publicVariable "Zen_RTS_SubTerritory_Data";

0 = [_marker] call Zen_RTS_SubTerritoryUpdateVisual;

call Zen_StackRemove;
if (true) exitWith {};

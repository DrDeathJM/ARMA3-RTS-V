/**
    Zen_RTS_TerritorySearch
    by Zenophon
    for RTS V

    Returns the markers of all territories whose data elements at (1) hash (3) to
    within, inclusive, the range (2).  (1,3) are aligned with each other, so the element at
    (1.n) is hashed with (3.n) and checked within (2.n).
    Usage : Call
    Params: 1. Array of scalars, indexes of nested arrays to search
            2. Array, ranges the element must fall within
                Array:
                    1. Scalar, lower bound
                    2. Scalar, upper bound
            3. Array, scalar hash functions as code or global function string
    Return: Array of strings, [] if there is no match
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_TerritorySearch", _this] call Zen_StackAdd;
private ["_side", "_lowerSubMarkers", "_upperSubMarkers", "_subMarkerCount", "_markers", "_data"];

if !([_this, [["ARRAY"], ["ARRAY"], ["ARRAY"]], [["SCALAR"], ["ARRAY"], ["CODE", "STRING"]], 3] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_indexes = _this select 0;
_ranges = _this select 1;
_hashes = _this select 2;

_foundIndexes = [Zen_RTS_Territory_Data, _indexes, _ranges, _hashes] call Zen_ArraySearch;

_markers = [];
{
    if (_forEachIndex in _foundIndexes) then {
        _markers pushBack (_x select 0);
    };
} forEach Zen_RTS_Territory_Data;

call Zen_StackRemove;
(_markers)

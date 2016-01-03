/**
    Zen_RTS_StrategicBuildingObjectGetDataGlobal
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingObjectGetDataGlobal", _this] call Zen_StackAdd;
private ["_nameString", "_data", "_printError", "_index", "_isTypeID"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_nameString = _this select 0;
ZEN_STD_Parse_GetArgumentDefault(_isTypeID, 1, false)
ZEN_STD_Parse_GetArgumentDefault(_printError, 2, true)

if (_isTypeID) then {
    _index = 0;
} else {
    _index = 1;
};

_data = [];
{
    if ((toLower (_x select _index)) isEqualTo (toLower _nameString)) exitWith {
        _data = _x;
    };
} forEach Zen_RTS_Strategic_Building_Objects_Global;

if ((_printError) && {count _data == 0}) then {
    0 = ["Zen_RTS_StrategicBuildingObjectGetDataGlobal", "Given building " + (if (_isTypeID) then {"type"} else {"object"}) + " does not exist", _this] call Zen_PrintError;
    call Zen_StackPrint;
    ([])
};

call Zen_StackRemove;
(_data)

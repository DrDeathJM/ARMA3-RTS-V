/**
    Zen_RTS_StrategicBuildingObjectGetDataLocal
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingObjectGetDataLocal", _this] call Zen_StackAdd;
private ["_nameString", "_data", "_printError"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_nameString = _this select 0;
ZEN_STD_Parse_GetArgumentDefault(_printError, 1, true)

_data = [];
{
    if ((toLower (_x select 0)) isEqualTo (toLower _nameString)) exitWith {
        _data = _x;
    };
} forEach Zen_RTS_Strategic_Building_Objects_Local;

if ((_printError) && {count _data == 0}) then {
    0 = ["Zen_RTS_StrategicBuildingObjectGetDataLocal", "Given building object does not exist", _this] call Zen_PrintError;
    call Zen_StackPrint;
    ([])
};

call Zen_StackRemove;
(_data)

/**
    Zen_RTS_StrategicBuildingObjectUpdate
    by Zenophon
    for RTS V

    Calls (2) for all building objects of type (1).
    Usage : Call
    Params: 1. String, building type identifier
            2. String, operator function
     (opt.) 3. Any, arguments for (2)
    Calls : 1. (2)
                1. Array, reference to the data of (1)
                2. Any, (3)
    Return: Void
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingObjectUpdate", _this] call Zen_StackAdd;
private ["_typeIdentifier", "_function", "_args"];

if !([_this, [["STRING"], ["STRING"], ["VOID"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_typeIdentifier = _this select 0;
_function = _this select 1;
ZEN_STD_Parse_GetArgumentDefault(_args, 2, [])

if (isNil _function) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_StrategicBuildingObjectUpdate", "Given operator function is void.")
};

{
    if ((toLower (_x select 0)) isEqualTo (toLower _typeIdentifier)) then {
        [_x, _args] call (missionNamespace getVariable _function);
    };
} forEach Zen_RTS_Strategic_Building_Objects_Global;

publicVariable "Zen_RTS_Strategic_Building_Objects_Global";
call Zen_StackRemove;
if (true) exitWith {};

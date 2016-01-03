/**
    Zen_RTS_StrategicBuildingQueueAdd
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingQueueAdd", _this] call Zen_StackAdd;
private ["_bldObjId", "_data", "_index", "_bldObjData", "_queue"];

if !([_this, [["STRING"], ["VOID"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_bldObjId = _this select 0;
_data = _this select 1;

// if !(isServer) exitWith {
    // ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicBuildingQueueAdd", _this, call)
// };

// _bldObjData = [_bldObjId] call Zen_RTS_StrategicBuildingObjectGetDataServer;
// _queue = _bldObjData select 1;

_bldObjData = [_bldObjId] call Zen_RTS_StrategicBuildingObjectGetDataLocal;
_queue = _bldObjData select 3;

_queue pushBack _data;

diag_log ("Zen_RTS_StrategicBuildingQueueAdd queues "+ str _data + "  at  " + str time +  "  " + str _bldObjId );
call Zen_StackRemove;
if (true) exitWith {};

/**
    Zen_RTS_StrategicBuildingQueueClear
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingQueueClear", _this] call Zen_StackAdd;
private ["_bldOjId", "_index", "_bldObjData", "_indexes"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_bldOjId = _this select 0;

// if !(isServer) exitWith {
    // ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicBuildingQueueClear", _this, call)
// };

// _bldObjData = [_bldObjId] call Zen_RTS_StrategicBuildingObjectGetDataServer;
// _queue = _bldObjData select 1;
// _thread = _bldObjData select 3;

_bldObjData = [_bldObjId] call Zen_RTS_StrategicBuildingObjectGetDataLocal;
_queue = _bldObjData select 3;
_thread = _bldObjData select 5;

terminate _thread;
// _bldObjData set [3, scriptNull];
_bldObjData set [5, scriptNull];
_queue resize 0;

call Zen_StackRemove;
if (true) exitWith {};

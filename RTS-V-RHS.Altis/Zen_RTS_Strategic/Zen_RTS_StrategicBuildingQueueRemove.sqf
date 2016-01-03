/**
    Zen_RTS_StrategicBuildingQueueRemove
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingQueueRemove", _this] call Zen_StackAdd;
private ["_bldObjId", "_index", "_bldObjData", "_removeIndex", "_queue", "_indexes"];

if !([_this, [["STRING"], ["SCALAR"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_bldObjId = _this select 0;
_removeIndex = _this select 1;

// if !(isServer) exitWith {
    // ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicBuildingQueueRemove", _this, call)
// };

// _bldObjData = [_bldObjId] call Zen_RTS_StrategicBuildingObjectGetDataServer;
// _queue = _bldObjData select 1;
// _thread = _bldObjData select 3;

_bldObjData = [_bldObjId] call Zen_RTS_StrategicBuildingObjectGetDataLocal;
_queue = _bldObjData select 3;
_thread = _bldObjData select 5;

0 = [_queue, _removeIndex] call Zen_ArrayRemoveIndex;

if (_removeIndex == 0) then {
    terminate _thread;
    // _bldObjData set [3, scriptNull];
    _bldObjData set [5, scriptNull];
};

call Zen_StackRemove;
if (true) exitWith {};

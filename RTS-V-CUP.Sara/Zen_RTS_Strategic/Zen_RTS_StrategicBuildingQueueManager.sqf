/**
    Zen_RTS_StrategicBuildingQueueManager
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingQueueManager", _this] call Zen_StackAdd;
private ["_bldObjId", "_index", "_data", "_queue", "_nextInvoke", "_function", "_h_invoke", "_indexes"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

// if !(isServer) exitWith {
    // ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicBuildingQueueManager", _this, call)
// };

_bldObjId = _this select 0;

// _data = [_bldObjId] call Zen_RTS_StrategicBuildingObjectGetDataServer;
// _queue = _data select 1;

_data = [_bldObjId] call Zen_RTS_StrategicBuildingObjectGetDataLocal;
_queue = _data select 3;

while {true} do {
    sleep 1;
    _dataGlobal = [_bldObjId] call Zen_RTS_StrategicBuildingObjectGetDataGlobal;
    if (count _queue > 0) then {
        _nextInvoke = _queue select 0;

        diag_log ("Zen_RTS_StrategicBuildingQueueManager: " + str time);
        diag_log ("_dataGlobal: " + str _dataGlobal);
        diag_log ("_nextInvoke: " + str _nextInvoke);

        _function = (_nextInvoke select 0) select 1;
        _h_invoke = ([_dataGlobal] + _nextInvoke) spawn (missionNamespace getVariable _function);
        // _h_invoke = ([_dataGlobal] + _nextInvoke) spawn (missionNamespace getVariable _function);
        // _h_invoke = ([[_dataGlobal], 1, _nextInvoke] call Zen_ArrayInsertSlice) spawn (missionNamespace getVariable _function);

        // _data set [3, _h_invoke];
        _data set [5, _h_invoke];
        ZEN_STD_Code_WaitScript(_h_invoke)
        0 = [_queue, 0] call Zen_ArrayRemoveIndex;
    };
};

call Zen_StackRemove;
if (true) exitWith {};

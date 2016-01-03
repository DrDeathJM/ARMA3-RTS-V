//

#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"

#define CLEAN_WORKERS(A, O, V) \
    { \
        _array = A select _x; \
        _indexesToRemove = []; \
        { \
            if !(alive O) then { \
                _indexesToRemove pushBack _forEachIndex; \
                if (V && {!(isNull (_x select 2))}) then { \
                    (_x select 2) setVariable ["Zen_RTS_StrategicIsAIAssigned", false]; \
                }; \
            }; \
        } forEach _array; \
        ZEN_FMW_Array_RemoveIndexes(_array, _indexesToRemove) \
    } forEach [0, 1];

#define CLEAN_QUEUE(A) \
    { \
        _array = _x; \
        _toRemove = []; \
        { \
            if (isNull _x) then { \
                _toRemove pushBack _forEachIndex; \
            }; \
        } forEach _array; \
        ZEN_FMW_Array_RemoveIndexes(_array, _toRemove) \
    } forEach A;

#define TASK_WORKERS(W, O, S, T) \
    _workerArray = W; \
    { \
        if !(isNull _x) then { \
            if (count _workerArray == 0) exitWith {}; \
            _repairQueueReady = []; \
            _condition = if (S == "Repair") then { \
                _repairQueueReady = [_workerArray, {(_this select 1)}] call Zen_ArrayFilterCondition; \
                (((_x getVariable ["Zen_RTS_StrategicType", ""]) in T) && ((damage _x > 0.1) || (toUpper (_x getVariable ["Zen_RTS_StrategicType", ""]) == "BuildingRuins"))) \
            } else { \
                _repairQueueReady = [_workerArray, {(_this select 1) || ((isNull (_this select 2)) || {!((_this select 0) in (_this select 2))})}] call Zen_ArrayFilterCondition; \
                (_x getVariable ["Zen_RTS_IsStrategicDebris", false]) \
            }; \
            if (_condition) then { \
                if (count _repairQueueReady == 0) exitWith {}; \
                diag_log ("Zen_RTS_RecycleRepairAIManager  All ready workers  " + S + "  " + (T select 0) + str _repairQueueReady); \
                _assignedWorkerArray = [_repairQueueReady, compile format ["-1 * ((_this select 0) distanceSqr %1)", getPosATL _x]] call Zen_ArrayFindExtremum; \
                _globalIndex = [_assignedWorkerArray, _workerArray] call Zen_ValueFindInArray; \
                _assignedWorkerArray = _workerArray select 0; \
                _assignedWorkerArray set [1, true]; \
                diag_log ("Zen_RTS_RecycleRepairAIManager  selected task worker  " + S + "  " + (T select 0) + str _assignedWorkerArray); \
                0 = [_assignedWorkerArray, _x, T] spawn { \
                    _assignedWorkerArray = _this select 0; \
                    _objToRepair = _this select 1; \
                    _buildingRepairTypes = _this select 2; \
                    _worker = _assignedWorkerArray select 0; \
                    _cancelled = false; \
                    while {true} do { \
                        if !(_assignedWorkerArray select 1) exitWith { \
                            _cancelled = true; \
                        }; \
                        _worker move getPosATL _objToRepair; \
                        _worker doMove getPosATL _objToRepair; \
                        _worker moveTo getPosATL _objToRepair; \
                        sleep 5; \
                        if (([vehicle _worker, _objToRepair] call Zen_Find2dDistance) < 20) exitWith {}; \
                    }; \
                    _assignedWorkerArray set [1, false]; \
                    if !(_cancelled) then { \
                        diag_log (S + " complete: " + str _objToRepair + str _assignedWorkerArray); \
                        _h_repair = [S, _buildingRepairTypes, true, _worker] spawn Zen_RTS_RecycleRepair; \
                    }; \
                }; \
            }; \
        }; \
        sleep 0.2; \
    } forEach O;

sleep 10;
while {true} do {
    sleep 5;
    CLEAN_WORKERS(RTS_Worker_Repair_Queue, (_x select 0), true)
    CLEAN_WORKERS(RTS_Worker_Recycle_Queue, (_x select 0), true)
    CLEAN_WORKERS(RTS_CJ_Repair_Queue, _x, false)

    CLEAN_QUEUE(RTS_Recycle_Queue)
    CLEAN_QUEUE(RTS_Repair_Queue)

    {
        _CJArray = RTS_CJ_Repair_Queue select _x;
        {
            _worker = _x select 0;
            _vehicle = _x select 2;
            if (isNull _vehicle) then {
                _nextAvailCJ = objNull;
                {
                    if !(alive _x) then {
                        _CJArray set [_forEachIndex, 0];
                    };
                    if ((alive _x) && (_x getVariable "Zen_RTS_StrategicIsAIOwned") && {!(_x getVariable "Zen_RTS_StrategicIsAIAssigned")}) exitWith {
                        _nextAvailCJ = _x;
                    };
                } forEach _CJArray;
                0 = [_CJArray, 0] call Zen_ArrayRemoveValue;

                if (!(isNull _nextAvailCJ) && {(alive _nextAvailCJ)}) then {
                    _x set [2, _nextAvailCJ];
                    _nextAvailCJ setVariable ["Zen_RTS_StrategicIsAIAssigned", true];
                    _worker assignAsDriver _nextAvailCJ;
                    [_worker] orderGetIn true;
                };
            } else {
                if !(_vehicle getVariable "Zen_RTS_StrategicIsAIOwned") then {
                    _vehicle setVariable ["Zen_RTS_StrategicIsAIAssigned", false];
                    ZEN_STD_OBJ_OrderGetOut([_worker], (_vehicle))
                    doStop _worker;
                    _x set [1, false];
                    _x set [2, objNull];
                };
            };
        } forEach (RTS_Worker_Recycle_Queue select _x);
    } forEach [0, 1];

    private ["_buildingRepairTypes"];
    _buildingRepairTypes = ["Building", "BuildingRuins"];

    TASK_WORKERS((RTS_Worker_Repair_Queue select 0), (RTS_Repair_Queue select 0), "Repair", _buildingRepairTypes)
    TASK_WORKERS((RTS_Worker_Recycle_Queue select 0), (RTS_Recycle_Queue select 0), "Recycle", ["Asset"])

    TASK_WORKERS((RTS_Worker_Repair_Queue select 1), (RTS_Repair_Queue select 1), "Repair", _buildingRepairTypes)
    TASK_WORKERS((RTS_Worker_Recycle_Queue select 1), (RTS_Recycle_Queue select 1), "Recycle", ["Asset"])
};

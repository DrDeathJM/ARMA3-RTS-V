/**
    Zen_RTS_StrategicBuildingDestroy
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingDestroy", _this] call Zen_StackAdd;
private ["_identifier", "_index", "_typeData", "_indexes"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_identifier = _this select 0;

_objData = [_identifier] call Zen_RTS_StrategicBuildingObjectGetDataGlobal;
_typeData = [(_objData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

if ((count _typeData == 0) || (count _objData == 0)) exitWith {
    call Zen_StackRemove;
};

// ZEN_FMW_MP_REServerOnly("Zen_RTS_F_StrategicRemoveBuildingQueueServer", [_identifier], call)
ZEN_FMW_MP_REServerOnly("Zen_RTS_F_StrategicRemoveBuildingQueueClient", [_identifier], call)
[_objData] call (missionNamespace getVariable (_typeData select 2));

_index = ([Zen_RTS_Strategic_Building_Objects_Global, _objData select 1, 1] call Zen_ArrayGetNestedIndex) select 0;
0 = [Zen_RTS_Strategic_Building_Objects_Global, _index] call Zen_ArrayRemoveIndex;
0 = [Zen_RTS_Strategic_Building_Objects_Server, _index] call Zen_ArrayRemoveIndex;
publicVariable "Zen_RTS_Strategic_Building_Objects_Global";

ZEN_FMW_MP_REAll("Zen_RTS_F_StrategicRemoveBuildingDataLocal", _index, call)

call Zen_StackRemove;
if (true) exitWith {};

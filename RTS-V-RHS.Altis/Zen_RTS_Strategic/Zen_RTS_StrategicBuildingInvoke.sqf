/**
    Zen_RTS_StrategicBuildingInvoke
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingInvoke", _this] call Zen_StackAdd;
private ["_typeIdentifier", "_constrArgs", "_typeData", "_objIdentifier", "_index", "_buildingObj", "_objData"];

if !([_this, [["STRING"], ["VOID"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ("")
};

_typeIdentifier = _this select 0;
_constrArgs = _this select 1;

_typeData = [_typeIdentifier] call Zen_RTS_StrategicBuildingTypeGetData;
if (count _typeData == 0) exitWith {
    call Zen_StackRemove;
    ("")
};

diag_log ("Zen_RTS_StrategicBuildingInvoke beginning invoke:  " + str time + "  " + str _this);

_objIdentifier = "Zen_RTS_Strategic_Building_Obj_" + ([10] call Zen_StringGenerateRandom);

// Zen_RTS_Strategic_Building_Objects_Local pushBack [_objIdentifier, [], 0];
// publicVariable "Zen_RTS_Strategic_Building_Objects_Local";

_args = [_objIdentifier, [], 0, []];
ZEN_FMW_MP_REAll("Zen_RTS_F_StrategicCreateBuildingDataClient", _args, call)

// _args = [_objIdentifier, [], scriptNull, scriptNull];
// ZEN_FMW_MP_REServerOnly("Zen_RTS_F_StrategicCreateBuildingDataServer", _args, call)

_index = count Zen_RTS_Strategic_Building_Objects_Global;
Zen_RTS_Strategic_Building_Objects_Global pushBack ([_typeIdentifier, _objIdentifier, objNull, 0, []]);
_objData = Zen_RTS_Strategic_Building_Objects_Global select _index;

_buildingObj = [_objData, _constrArgs] call (missionNamespace getVariable (_typeData select 1));
_objData = [Zen_RTS_Strategic_Building_Objects_Global, _typeIdentifier, 0] call Zen_ArrayGetNestedValue;

_objData set [2, _buildingObj];
publicVariable "Zen_RTS_Strategic_Building_Objects_Global";

diag_log ("Zen_RTS_StrategicBuildingInvoke finished instantiation:  " + str time + "  " + str _this);
call Zen_StackRemove;
(_objIdentifier)

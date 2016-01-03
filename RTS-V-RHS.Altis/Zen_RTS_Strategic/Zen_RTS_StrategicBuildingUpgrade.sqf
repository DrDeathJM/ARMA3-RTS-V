/**
    Zen_RTS_StrategicBuildingUpgrade
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingUpgrade", _this] call Zen_StackAdd;
private ["_objIdentifier", "_index", "_objData", "_typeIdentifier", "_level", "_typeData", "_return", "_indexes"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_objIdentifier = _this select 0;
_objData = [_objIdentifier] call Zen_RTS_StrategicBuildingObjectGetDataGlobal;

if (count _objData == 0) exitWith {
    call Zen_StackRemove;
    ([])
};

diag_log ("Zen_RTS_StrategicBuildingUpgrade  " + str time + "  " + str _this);

_typeIdentifier = _objData select 0;
_typeData = [_typeIdentifier] call Zen_RTS_StrategicBuildingTypeGetData;

_level = _objData select 3;

_return = [_objData] call (missionNamespace getVariable ((_typeData select 3) select _level));
_objData set [3, _level + 1];

publicVariable "Zen_RTS_Strategic_Building_Objects_Global";
call Zen_StackRemove;
(if (isNil "_return") then {
    if (true) exitWith {};
} else {
    (_return)
})

/**
    Zen_RTS_StrategicAssetInvoke
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicAssetInvoke", _this] call Zen_StackAdd;
private ["_bldIdentifier", "_assetIdentifier", "_bldData", "_assetData", "_unit", "_args"];

if !([_this, [["STRING"], ["STRING"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_bldIdentifier = _this select 0;
_assetIdentifier = _this select 1;
ZEN_STD_Parse_GetArgumentDefault(_unit, 2, player)
ZEN_STD_Parse_GetArgumentDefault(_args, 3, [])

_bldData = [_bldIdentifier] call Zen_RTS_StrategicBuildingObjectGetDataGlobal;
_assetData = [_assetIdentifier] call Zen_RTS_StrategicAssetGetData;

if ((count _bldData == 0) || (count _assetData == 0)) exitWith {
    call Zen_StackRemove;
    ([])
};

if !([_assetIdentifier, (_bldData select 4)] call Zen_ValueIsInArray) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_StrategicAssetInvoke", "Given asset is not assigned to the building.")
};

0 = [_bldIdentifier, [_assetData, _unit, _args]] call Zen_RTS_StrategicBuildingQueueAdd;

call Zen_StackRemove;
if (true) exitWith {};

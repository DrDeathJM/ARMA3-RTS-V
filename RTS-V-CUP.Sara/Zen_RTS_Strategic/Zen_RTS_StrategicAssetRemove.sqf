/**
    Zen_RTS_StrategicAssetRemove
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicAssetRemove", _this] call Zen_StackAdd;
private ["_identifier", "_index", "_indexes"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_identifier = _this select 0;

_indexes = [Zen_RTS_Strategic_Asset_Types, _identifier, 0] call Zen_ArrayGetNestedIndex;
if (count _indexes == 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_StrategicAssetRemove", "Given asset type does not exist.")
};

_index = _indexes select 0;
0 = [Zen_RTS_Strategic_Asset_Types, _index] call Zen_ArrayRemoveIndex;
publicVariable "Zen_RTS_Strategic_Asset_Types";

call Zen_StackRemove;
if (true) exitWith {};

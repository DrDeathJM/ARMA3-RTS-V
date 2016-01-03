/**
    Zen_RTS_StrategicAssetUpdate
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicAssetUpdate", _this] call Zen_StackAdd;
private ["_identifier", "_constructor", "_name", "_desc", "_index", "_oldData", "_access", "_indexes"];

if !([_this, [["STRING"], ["STRING", "SCALAR"], ["STRING", "SCALAR"], ["STRING", "SCALAR"], ["STRING", "SCALAR"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_identifier = _this select 0;
_constructor = _this select 1;
ZEN_STD_Parse_GetArgumentDefault(_name, 2, 0)
ZEN_STD_Parse_GetArgumentDefault(_desc, 3, 0)
ZEN_STD_Parse_GetArgumentDefault(_access, 4, 0)

_indexes = [Zen_RTS_Strategic_Asset_Types, _identifier, 0] call Zen_ArrayGetNestedIndex;
if (count _indexes == 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_StrategicAssetUpdate", "Given asset type does not exist.")
};

_index = _indexes select 0;
_oldData = Zen_RTS_Strategic_Asset_Types select _index;

if !(_constructor isEqualTo 0) then {
    if !(isNil _constructor) then {
        _oldData set [1, _constructor];
    } else {
        ZEN_FMW_Code_Error("Zen_RTS_StrategicBuildingTypeUpdate", "Given constructor is undefined.")
    };
};

if !(_name isEqualTo 0) then {
    _oldData set [2, _name];
};

if !(_desc isEqualTo 0) then {
    _oldData set [3, _desc];
};

if !(_access isEqualTo 0) then {
    _oldData set [4, _access];
};

publicVariable "Zen_RTS_Strategic_Asset_Types";

call Zen_StackRemove;
if (true) exitWith {};

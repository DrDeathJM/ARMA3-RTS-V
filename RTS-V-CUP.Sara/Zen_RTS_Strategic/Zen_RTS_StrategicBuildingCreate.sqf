/**
    Zen_RTS_StrategicBuildingCreate
    by Zenophon
    for RTS V
*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_StrategicBuildingCreate", _this] call Zen_StackAdd;
private ["_constructor", "_destructor", "_upgrades", "_name", "_description", "_identifier"];

if !([_this, [["STRING"], ["STRING"], ["ARRAY"], ["STRING"], ["STRING"]], [[], [], ["STRING"]], 4] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ("")
};

_constructor = _this select 0;
_destructor = _this select 1;
_upgrades = _this select 2;
_name = _this select 3;
_description = _this select 4;

_identifier = "Zen_RTS_Strategic_Building_Type_" + ([10] call Zen_StringGenerateRandom);

Zen_RTS_Strategic_Building_Types pushBack [_identifier, "", "", [], "", ""];
// publicVariable "Zen_RTS_Strategic_Building_Types";

0 = [_identifier, _constructor, _destructor, _upgrades, _name, _description] call Zen_RTS_StrategicBuildingTypeUpdate;

call Zen_StackRemove;
(_identifier)

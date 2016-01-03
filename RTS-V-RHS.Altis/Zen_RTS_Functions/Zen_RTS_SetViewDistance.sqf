//

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_SetViewDistance", _this] call Zen_StackAdd;
private ["_listID", "_index", "_distance"];

if !([_this, [["SCALAR"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_listID = _this select 0;

_index = lbCurSel _listID;
_distance = lbValue [_listID, _index];

0 = [_distance, -1, -1, false] call Zen_SetViewDistance;

call Zen_StackRemove;
if (true) exitWith {};

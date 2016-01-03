//

// TODO remove player from array
_units = [side player] call Zen_ConvertToObjectArray;
_units = [_units, {!(isPlayer _this)}] call Zen_ArrayFilterCondition;
_units = [_units, compile format ["_this distanceSqr %1", getPosATL player], "hash"] call Zen_ArraySort;

_unitNames = [];
{
    _unitNames pushBack name _x;
} forEach _units;

0 = [Zen_RTS_GiveMoneyDialog_Current_Money_Control, ["Text", "$" + str round playerMoney]] call Zen_UpdateControl;
0 = [Zen_RTS_GiveMoneyDialog_Player_List, ["List", _unitNames], ["ListData", _units]] call Zen_UpdateControl;

0 = [Zen_RTS_GiveMoneyDialog_Dialog] spawn Zen_InvokeDialog;

if (true) exitWith {};

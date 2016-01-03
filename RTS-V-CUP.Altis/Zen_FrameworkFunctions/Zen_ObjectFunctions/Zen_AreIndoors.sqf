// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_AreIndoors", _this] call Zen_StackAdd;
private ["_units", "_unitPos", "_unitPosAbove", "_indoors"];

if !([_this, [["VOID"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (false)
};

_units = [(_this select 0)] call Zen_ConvertToObjectArray;
_indoors = true;

{
    _unitPos = eyePos _x;
    _unitPosAbove = [_unitPos select 0,_unitPos select 1,(_unitPos select 2) + 10];

    if !((count (lineIntersectsWith [_unitPos,_unitPosAbove,_x])) > 0) exitWith {
        _indoors = false;
    };
} forEach _units;

call Zen_StackRemove;
(_indoors)

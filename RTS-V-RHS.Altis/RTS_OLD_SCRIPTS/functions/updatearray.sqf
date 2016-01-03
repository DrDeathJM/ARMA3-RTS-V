private ["_newArray","_num","_side","_newName","_n","_x","_set","_tA"];


_mArray = _this select 0;
_newArray = _this select 1;
_num = _this select 2;
_side = _this select 3;
_newName = _newArray select 3;

_n = count _mArray;
_x = 0;
_set = FALSE;

while {_x < _n} do

    {
        _name = _mArray select _x select 3;
        if (_name == _newName && _num == 1) then {_mArray set [_x,_newArray]; _set = TRUE};
        if (_name == _newName && _num == 0) then {_mArray set [_x,"DELETE"]; _mArray = _mArray - ["DELETE"]; _set = TRUE};
        _x = _x + 1;
    };

if (!_set) then {_mArray = _mArray + [_newArray]};


_tA = [_side,_mArray];
rts_updateArray = STR _tA;
publicVariable "rts_updateArray";

_mArray;
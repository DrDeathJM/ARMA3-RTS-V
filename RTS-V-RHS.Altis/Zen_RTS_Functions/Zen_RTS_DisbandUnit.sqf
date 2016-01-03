
0 = _this spawn {
    _idc = _this Select 0;

    _index = lbCurSel _idc;
    _text = lbText [_idc, _index];
    _uNum = lbValue [_idc, _index];

    _group = units group player;
    _unit = _group select _uNum;

    if (_unit isEqualTo player) exitWith {
        player groupChat "You cannot release yourself from the group.";
    };

    unassignVehicle _unit;
    _unit action ["EJECT",vehicle _unit];

    sleep 2;
    player groupChat format ["Releasing %1", _text];

    _unit setDamage 1;
    deleteVehicle _unit;
};

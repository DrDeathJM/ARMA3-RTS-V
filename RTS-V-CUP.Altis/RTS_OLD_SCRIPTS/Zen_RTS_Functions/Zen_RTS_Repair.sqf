// from GUI

#define REPAIR_COST_COEFF 0.5

0 = _this spawn {
    _stratTypes = _this select 0;

    _vehicle = vehicle player;

    player setVariable ["Zen_RTS_RepairActive", true, false];
    _redArrow = "Sign_Arrow_F" createVehicleLocal [0,0,0];

    hint "Any repairable object will\nhave a red arrow appear over it.\nChoose Confirm Repair to finalize.";
    player addAction ["Confirm Repair", {
        (_this select 0) removeAction (_this select 2);
        player setVariable ["Zen_RTS_RepairActive", false, false];
        _object = player getVariable "Zen_RTS_RepairObject";

        if (isNull _object) then {
            player groupChat "No valid repairable object selected.";
        } else {
            _repairCost = (damage _object) * (_object getVariable "Zen_RTS_StrategicValue") * REPAIR_COST_COEFF;
            if (playerMoney > _repairCost) then {
                playerMoney = playerMoney - _repairCost;
                player groupChat ("You have paid: $" + (str round _repairCost) + " to repair this object.");
                sleep 2;
                _object setDamage 0;
            } else {
                player groupChat ("You have insufficient funds to repair this object; the cost is: $" + (str round _repairCost) + ".");
            };
        };
    }];

    while {(player getVariable "Zen_RTS_RepairActive")} do {
        sleep 1;

        _pos = [_vehicle, 20, getDir _vehicle] call Zen_ExtendPosition;
        _objects = nearestObjects [_pos, ["All"], 10];
        // player sideChat str _objects;
        player setVariable ["Zen_RTS_RepairValid", false, false];
        player setVariable ["Zen_RTS_RepairObject", objNull, false];
        if (player in _vehicle) then {
            {
                if (_x getVariable ["Zen_RTS_IsStrategicRepairable", false]) exitWith {
                    player setVariable ["Zen_RTS_RepairValid", true, false];
                    player setVariable ["Zen_RTS_RepairObject", _x, false];
                    _redArrow setPosATL (getPosATL _x vectorAdd [0,0,5]);
                };
            } forEach _objects;
        };

        if !(player getVariable "Zen_RTS_RepairValid") then {
            _redArrow setPosATL [0,0,0];
        };
    };

    deleteVehicle _redArrow;
    player setVariable ["Zen_RTS_RepairActive", nil, false];
    player setVariable ["Zen_RTS_RepairObject", nil, false];
    player setVariable ["Zen_RTS_RepairValid", nil, false];
};

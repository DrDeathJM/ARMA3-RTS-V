//

private ["_unit", "_soldierType", "_vehicleName", "_vehicleSeat"];
_unit = _this select 0;

_soldierType = getText (configFile >> "CfgVehicles" >> (typeOf _unit) >> "displayName");
if (isPlayer _unit) then {
    _soldierType = (format ["(%1) %2", name _unit, _soldierType])
};

_vehicleName = if (vehicle _unit == _unit) then {
    ("On Foot")
} else {
    (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _unit) >> "displayName"))
};

_vehicleSeat = if (vehicle _unit == _unit) then {
    ("")
} else {
    (switch (true) do {
        case (_unit == driver vehicle _unit): {("Driver")};
        case (_unit == gunner vehicle _unit): {("Gunner")};
        case (_unit == commander vehicle _unit): {("Commander")};
        default {("In Cargo")};
    })
};

([_soldierType, _vehicleName, _vehicleSeat])

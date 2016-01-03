//

_unit = _this select 0;

if (isPlayer (_this select 0)) then {
    CreateDialog "DigitalLoadout";
    [_unit] call loadChange;
    if (time > 60) then {
        // [_unit] call TAG_FNC_Rifleman;
        0 = [_unit, str side _unit + "rifleman"] call Zen_GiveLoadoutCustom;
    };
};

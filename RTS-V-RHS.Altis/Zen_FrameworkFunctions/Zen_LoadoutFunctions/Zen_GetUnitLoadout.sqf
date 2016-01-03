// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#define ADD_LOADED_MAG(CMD)  _weaponMag = CMD _unit; \
if (count _weaponMag > 0) then { \
    _magsCargo pushBack [_weaponMag select 0, 1]; \
}; \

_Zen_stack_Trace = ["Zen_GetUnitLoadout", _this] call Zen_StackAdd;
private ["_unit", "_uniqueMags", "_uniqueMagCounts", "_mag", "_magsCargo", "_weaponMag"];

if !([_this, [["OBJECT"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_unit = _this select 0;

_uniqueMags = [];
_uniqueMagCounts = [];

{
    _mag = _x;
    if !(_x in _uniqueMags) then {
        _uniqueMags pushBack _x;
        _uniqueMagCounts pushBack ({_x == _mag} count (magazines _unit));
    };
} forEach (magazines _unit);

_magsCargo = [];

{
    if ((_uniqueMagCounts select _forEachIndex) > 0) then {
        _magsCargo pushBack [_x, (_uniqueMagCounts select _forEachIndex)];
    };
} forEach _uniqueMags;

ADD_LOADED_MAG(primaryWeaponMagazine)
ADD_LOADED_MAG(secondaryWeaponMagazine)
ADD_LOADED_MAG(handgunMagazine)

{
    if (["Laserdesignator", _x] call Zen_StringIsInString) exitWith {
        _magsCargo pushBack ["LaserBatteries", 1];
    };
} forEach (weapons _unit);

_loadoutData = [
    (if (uniform _unit != "") then {["uniform", uniform _unit]} else {0}),
    (if (vest _unit != "") then {["vest", vest _unit]} else {0}),
    (if (backpack _unit != "") then {["backpack", backpack _unit]} else {0}),
    (if (headgear _unit != "") then {["headgear", headgear _unit]} else {0}),
    (if (goggles _unit != "") then {["goggles", goggles _unit]} else {0}),
    (if (count assignedItems _unit > 0) then {["assignedItems", (assignedItems _unit) - ["Binocular", "Rangefinder", "Laserdesignator"]]} else {0}),
    (if (count weapons _unit > 0) then {["weapons", weapons _unit]} else {0}),
    (if (count _magsCargo > 0) then {["magazines", _magsCargo]} else {0}),
    (if (count items _unit > 0) then {["items", (items _unit) - [""]]} else {0}),
    (if ({_x != ""} count primaryWeaponItems _unit > 0) then {["primaryAttachments", (primaryWeaponItems _unit) - [""]]} else {0}),
    (if ({_x != ""} count secondaryWeaponItems _unit > 0) then {["secondaryAttachments", (secondaryWeaponItems _unit) - [""]]} else {0}),
    (if ({_x != ""} count handgunItems _unit > 0) then {["handgunAttachments", (handgunItems _unit) - [""]]} else {0})
];

0 = [_loadoutData, 0] call Zen_ArrayRemoveValue;
call Zen_StackRemove;
(_loadoutData)

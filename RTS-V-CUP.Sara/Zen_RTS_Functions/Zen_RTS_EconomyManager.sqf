#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

#define HASH_SIDE(V) (if (V == West) then {0} else {1})
#define MONEY_COEF 3

Zen_RTS_Economy_Data = [];
sleep 1;

{
    _units = [_x] call Zen_ConvertToObjectArray;
    _units = [_units, {!(isPlayer _this)}] call Zen_ArrayFilterCondition;
    Zen_RTS_Economy_Data pushBack [_x, 0, 0, _units];
    publicVariable "Zen_RTS_Economy_Data";

    _args = ["sideChat", [[_x,"HQ"], "Operating funds established."]];
    ZEN_FMW_MP_RENonDedicated("Zen_ExecuteCommand", _args, call)
    ZEN_FMW_MP_RENonDedicated("Zen_RTS_F_SetMoney", (paramsArray select 0))
} forEach [West, East];

while {true} do {
    sleep 0.9;
    {
        _subTerritoryCount = (count ([[1], [[HASH_SIDE(_x), HASH_SIDE(_x)]], [{HASH_SIDE(_this)}]] call Zen_RTS_SubTerritorySearch)) + 1;
        _moneyPerMinute = _subTerritoryCount * MONEY_COEF;

        _dataArray = Zen_RTS_Economy_Data select ([West, East] find _x);
        _playerData = _dataArray select 3;
        _toRemove = [];
        {
            if (!(isNil "_x") && {!(isNull _x)}) then {
                ZEN_FMW_MP_REClient("Zen_RTS_F_ModifyMoney", (_moneyPerMinute / 60), call, _x)
            } else {
                _toRemove pushBack _forEachIndex;
            };
        } forEach _playerData;

        ZEN_FMW_Array_RemoveIndexes(_playerData, _toRemove)

        _supplyFactor = _dataArray select 2;
        _supplyPerMinute = _supplyFactor;

        _supply = _dataArray select 1;
        _dataArray set [1, _supply + (_supplyPerMinute / 60)];

        _args = [_moneyPerMinute, _supply, _supplyPerMinute, _x];
        ZEN_FMW_MP_RENonDedicated("Zen_RTS_F_PrintMoney", _args, call)
    } forEach [West, East];
};

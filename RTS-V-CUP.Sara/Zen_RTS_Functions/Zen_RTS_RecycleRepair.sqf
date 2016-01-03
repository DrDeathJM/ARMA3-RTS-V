// from GUI

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"
#define RECYCLE_COST_COEFF 0.5
#define REPAIR_COST_COEFF 0.5

#define ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
    _vehicle setVariable ["Zen_RTS_StrategicValue", (call compile ([_assetStrRaw, "Cost: ", ","] call Zen_StringGetDelimitedPart)), true]; \
    _vehicle setVariable ["Zen_RTS_IsStrategicRepairable", true, true]; \
    _vehicle setVariable ["Zen_RTS_StrategicType", "Asset", true]; \
    _vehicle setVariable ["Zen_RTS_StrategicAssetType", (_assetData select 0), true]; \
    _vehicle setVariable ["Zen_RTS_IsStrategicDebris", false, true]; \
    (RTS_Recycle_Queue select (([west, east] find ([_vehicle] call Zen_GetSide)) max 0)) pushBack _vehicle; \
    _vehicle addEventHandler ["Killed", { \
        (_this select 0) setVariable ["Zen_RTS_IsStrategicDebris", true, true]; \
    }];
    // _vehicle setVariable ["Zen_RTS_IsStrategicRepairable", false, true]; \

private ["_isAI", "_value", "_unit"];

_actionType = _this select 0;
_stratTypes = _this select 1;
ZEN_STD_Parse_GetArgumentDefault(_isAI, 2, false)
ZEN_STD_Parse_GetArgumentDefault(_unit, 3, player)

_checkVar = "Zen_RTS_IsStrategicDebris";
if (_actionType == "Repair") then {
    _checkVar = "Zen_RTS_IsStrategicRepairable";
};

_nearestObj = objNull;
_objects = nearestObjects [getPosATL vehicle _unit, ["All"], 25];
_objects = [_objects, compile format ["_this distance %1", getPosATL vehicle _unit], "hash"] call Zen_ArraySort;

{
    if ((_x getVariable [_checkVar, false]) && {((_x getVariable ["Zen_RTS_StrategicType", ""]) in _stratTypes)}) exitWith {
        _nearestObj = _x;
    };
} forEach _objects;

if (isNull _nearestObj) exitWith {
    diag_log ("Zen_RTS_RecycleRepair  " + str time + "  " + str _this + " no valid object found from " + str _objects);
    _unit groupChat "No valid object found.";
};

if (_actionType == "Repair") then {
    if ((_nearestObj getVariable ["Zen_RTS_StrategicType", ""]) == "BuildingRuins") then {
        _value = (_nearestObj getVariable "Zen_RTS_StrategicValue") * REPAIR_COST_COEFF;
    } else {
        _value = (damage _nearestObj) * (_nearestObj getVariable "Zen_RTS_StrategicValue") * REPAIR_COST_COEFF;
    };
} else {
    _value = (_nearestObj getVariable "Zen_RTS_StrategicValue") * RECYCLE_COST_COEFF;
};

#define PROCESS_REPAIR \
    switch (_nearestObj getVariable ["Zen_RTS_StrategicType", ""]) do { \
        case "Asset": { \
            if (damage _nearestObj == 1) then { \
                _assetType = _nearestObj getVariable "Zen_RTS_StrategicAssetType"; \
                _pos = getPosATL _nearestObj; \
                _classname = typeOf _nearestObj; \
                _dir = getDir _nearestObj; \
                deleteVehicle _nearestObj; \
                if (_assetType in [Zen_RTS_BuildingType_West_CJ, Zen_RTS_BuildingType_East_CJ]) then { \
                    _args = [_assetType, [_pos, 0]]; \
                    ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicBuildingInvoke", _args, call) \
                } else { \
                    _assetData = ([_assetType] call Zen_RTS_StrategicAssetGetData); \
                    _assetStrRaw = _assetData select 3; \
                    _vehicle = [_pos, _classname, 0, _dir, true] call Zen_SpawnVehicle; \
                    ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
                }; \
            } else { \
                _nearestObj setDamage 0; \
            }; \
        }; \
        case "Building": { \
            _nearestObj setDamage 0; \
        }; \
        case "BuildingRuins": { \
            _args = [_nearestObj, _nearestObj getVariable "Zen_RTS_StrategicBuildingSide"]; \
            ZEN_FMW_MP_REServerOnly("Zen_RTS_F_RemoveRepairQueue", _args, call) \
            _type = _nearestObj getVariable "Zen_RTS_StrategicRuinsType"; \
            _side = _nearestObj getVariable "Zen_RTS_StrategicBuildingSide"; \
            _pos = getPosATL _nearestObj; \
            sleep 1; \
            deleteVehicle _nearestObj; \
            _index = [_type, (RTS_Used_Building_Types select ([west, east] find _side))] call Zen_ValueFindInArray; \
            _level = RTS_Building_Type_Levels select ([west, east] find _side) select _index; \
            _args = [_type, [_pos, _level]]; \
            ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicBuildingInvoke", _args, call) \
        }; \
        default { \
            diag_log ("Zen_RTS_RecycleRepair + " + str time + "  " + str _this + " Invalid strategic type  " + str _nearestObj + "  " + str (_nearestObj getVariable ["Zen_RTS_StrategicType", ""])); \
        }; \
    };

if (_isAI) then {
    if (_actionType == "Repair") then {
        PROCESS_REPAIR
    } else {
        if (({alive _x} count (crew _nearestObj)) == 0) then {
            // playerMoney = playerMoney + _value;
            deleteVehicle _nearestObj;
            // _args = [_nearestObj, side _nearestObj];
            // ZEN_FMW_MP_REServerOnly("Zen_RTS_F_RemoveRecycleQueue", _args, call)
        };
    };
} else {
    _text = _actionType + " " + (getText (configFile >> "cfgVehicles" >> (typeOf _nearestObj) >> "DisplayName")) + " for $" + (str round _value);
    closeDialog 0;
    createDialog "DlgConfirm";

    _idText = 1300;
    _idConfirm = 1305;
    _idCancel = 1315;

    ctrlSetText [_idText, _text];
    // ctrlSetText [_idConfirm, "Confirm"];
    // ctrlSetText [_idCancel, "Cancel"];

    buttonSetAction [_idConfirm, "Zen_RTS_RepairRecycleFlag = 1; closeDialog 0;"];
    buttonSetAction [_idCancel, "Zen_RTS_RepairRecycleFlag = 2; closeDialog 0;"];

    Zen_RTS_RepairRecycleFlag = 0;
    waitUntil {
        sleep 1;
        (Zen_RTS_RepairRecycleFlag in [1,2])
    };

    closeDialog 0;
    if (Zen_RTS_RepairRecycleFlag == 1) then {
        if (_actionType == "Repair") then {
            if (playerMoney > _value) then {
                playerMoney = playerMoney - _value;
                _unit groupChat ("You have paid: $" + (str round _value) + " to repair this object.");
                PROCESS_REPAIR
            } else {
                _unit groupChat ("Insufficient funds, you need $" + (str round _value) + " to repair this object.");
            };
        } else {
            if (({alive _x} count (crew _nearestObj)) == 0) then {
                playerMoney = playerMoney + _value;
                _unit groupChat ("You have received: $" + (str round _value) + " from recycling this object.");
                deleteVehicle _nearestObj;
                // _args = [_nearestObj, side _nearestObj];
                // ZEN_FMW_MP_REServerOnly("Zen_RTS_F_RemoveRecycleQueue", _args, call)
            } else {
                _unit groupChat ("You cannot recycle a vehicle with a crew in it!");
            };
        };
    };
    Zen_RTS_RepairRecycleFlag = nil;
};

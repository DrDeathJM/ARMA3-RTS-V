/**
    Level 1:
        Zen_RTS_Asset_Ka60
        Zen_RTS_Asset_Mi8MT
    Level 2:
        Zen_RTS_Asset_Mi8MTV3
    Level 3:
        Zen_RTS_Asset_Ka52
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_East_AirFactoryConstructor = {
    diag_log "East Air_factory constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_East_CUP_O_Mi8_medevac_RU;
    _assetsToAdd pushBack Zen_RTS_Asset_East_O_Heli_Light_02_F;

    // if (Zen_RTS_TechFlag_East_BuildEnemy) then {
        // ... to do
    // };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_East_HQ, _ID)
    if (_ID != "") then {
        0 = [_ID, [Zen_RTS_Asset_Tech_East_Upgrade_AirFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("Land_Airport_Tower_F", -2)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_AirFactory, East)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["Purchase Units", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_East_AirFactoryDestructor = {
    diag_log "East Air_factory destructor";

    _buildingObjData = _this select 0;
    _level = _buildingObjData select 3;
    diag_log _level;

    _index = [(_buildingObjData select 0), (RTS_Used_Building_Types select 1)] call Zen_ValueFindInArray;
    _array = RTS_Building_Type_Levels select 1;
    _array set [_index, _level];

    (_buildingObjData select 2) setDamage 1;
};

#define UPGRADE(N, A) \
N = { \
    diag_log (#N + " called"); \
    diag_log _this; \
    _buildingData = _this select 0; \
    _assetsToAdd = A; \
    if (Zen_RTS_TechFlag_East_BuildEnemy) then { \
    }; \
    { \
        (RTS_Used_Asset_Types select 1) pushBack _x; \
    } forEach _assetsToAdd; \
    publicVariable "RTS_Used_Asset_Types"; \
    0 = [(_buildingData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal; \
    (true) \
};

#define ASSETS [Zen_RTS_Asset_East_CUP_O_Ka50_SLA, Zen_RTS_Asset_East_O_Heli_Transport_04_covered_F, Zen_RTS_Asset_East_CUP_O_Mi24_P_RU, Zen_RTS_Asset_East_CUP_O_Mi24_V_RU]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_CUP_O_Mi17_TK, Zen_RTS_Asset_East_CUP_O_Ka50_AA_SLA, Zen_RTS_Asset_East_CUP_O_MI6A_TKA, Zen_RTS_Asset_East_CUP_O_MI6T_TKA, Zen_RTS_Asset_East_CUP_O_MI6A_RU, Zen_RTS_Asset_East_CUP_O_MI6T_RU]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_O_Heli_Transport_04_medevac_F, Zen_RTS_Asset_East_O_Heli_Transport_04_bench_F, Zen_RTS_Asset_East_CUP_Mi8_MTV3_base, Zen_RTS_Asset_East_CUP_O_Mi8_SLA_1, Zen_RTS_Asset_East_CUP_O_Mi8_RU, Zen_RTS_Asset_East_CUP_O_Mi24_D_TK, Zen_RTS_Asset_East_CUP_O_Su25_RU_1]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade03, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_O_Plane_CAS_02_F, Zen_RTS_Asset_East_CUP_O_Su25_TKA, Zen_RTS_Asset_East_CUP_O_Su25_RU_2, Zen_RTS_Asset_East_CUP_O_Su25_RU_3]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_East_AirFactory = ["Zen_RTS_F_East_AirFactoryConstructor", "Zen_RTS_F_East_AirFactoryDestructor", ["Zen_RTS_F_East_AirFactoryUpgrade01", "Zen_RTS_F_East_AirFactoryUpgrade02", "Zen_RTS_F_East_AirFactoryUpgrade03", "Zen_RTS_F_East_AirFactoryUpgrade04"], "Air Factory", "Cost: 2000, Time: 10, Picture: pictures\plane_ca.paa, Classname: Land_Airport_Tower_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack  Zen_RTS_BuildingType_East_AirFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_East_CUP_O_Mi8_medevac_RU = ["CUP_O_Mi8_medevac_RU", "Mi8 medevac", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_O_Heli_Light_02_F = ["O_Heli_Light_02_F", "Orca", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Ka50_SLA = ["CUP_O_Ka50_SLA", "Ka50", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_O_Heli_Transport_04_covered_F = ["O_Heli_Transport_04_covered_F", "Mi8 Rockets", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Mi24_P_RU = ["CUP_O_Mi24_P_RU", "Mi24 P", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Mi24_V_RU = ["CUP_O_Mi24_V_RU", "Mi24 V", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Mi17_TK = ["CUP_O_Mi17_TK", "Mi 17", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Ka50_AA_SLA = ["CUP_O_Ka50_AA_SLA", "Ka50 AA", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_MI6A_TKA = ["CUP_O_MI6A_TKA", "MI6A", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_MI6T_TKA = ["CUP_O_MI6T_TKA", "MI6T", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_MI6A_RU = ["CUP_O_MI6A_RU", "MI6A", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_MI6T_RU = ["CUP_O_MI6T_RU", "MI6T", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_O_Heli_Transport_04_medevac_F = ["O_Heli_Transport_04_medevac_F", "medevac dlc", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_O_Heli_Transport_04_bench_F = ["O_Heli_Transport_04_bench_F", "bench dlc", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_Mi8_MTV3_base = ["CUP_Mi8_MTV3_base", "Mi-8MTV3", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Mi8_SLA_1 = ["CUP_O_Mi8_SLA_1", "Mi-8MT", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Mi8_RU = ["CUP_O_Mi8_RU", "Mi8 MTV3", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Mi24_D_TK = ["CUP_O_Mi24_D_TK", "Mi24 D", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Su25_RU_1 = ["CUP_O_Su25_RU_1", "Frogfoot 25T", "Cost: 7600, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_O_Plane_CAS_02_F = ["O_Plane_CAS_02_F", "199 NEO", "Cost: 8000, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Su25_TKA = ["CUP_O_Su25_TKA", "Frogfoot", "Cost: 9200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Su25_RU_2 = ["CUP_O_Su25_RU_2", "Frogfoot 25 TM", "Cost: 9600, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Su25_RU_3 = ["CUP_O_Su25_RU_3", "Frogfoot 25", "Cost: 9800, Time: 10,"] call Zen_RTS_StrategicAssetCreate;

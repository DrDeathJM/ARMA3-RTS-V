/**


//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_AirFactoryConstructor = {
    diag_log "West Air_factory constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_UH1Y_MEV_F;
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_MV22_USMC;


    // if (Zen_RTS_TechFlag_West_BuildEnemy) then {
        // ... to do
    // };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_West_HQ, _ID)
    if (_ID != "") then {
        0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_AirFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("Land_Airport_Tower_F", -2)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_AirFactory, West)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3'image='pictures\build_CA.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_West_AirFactoryDestructor = {
    diag_log "West Air_factory destructor";

    _buildingObjData = _this select 0;
    _level = _buildingObjData select 3;
    diag_log _level;

    _index = [(_buildingObjData select 0), (RTS_Used_Building_Types select 0)] call Zen_ValueFindInArray;
    _array = RTS_Building_Type_Levels select 0;
    _array set [_index, _level];

    (_buildingObjData select 2) setDamage 1;
};

#define UPGRADE(N, A) \
N = { \
    diag_log (#N + " called"); \
    diag_log _this; \
    _buildingData = _this select 0; \
    _assetsToAdd = A; \
    if (Zen_RTS_TechFlag_West_BuildEnemy) then { \
    }; \
    { \
        (RTS_Used_Asset_Types select 0) pushBack _x; \
    } forEach _assetsToAdd; \
    publicVariable "RTS_Used_Asset_Types"; \
    0 = [(_buildingData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal; \
    (true) \
};

#define ASSETS [Zen_RTS_Asset_West_CUP_B_UH60L_US, Zen_RTS_Asset_West_CUP_B_UH60M_US, Zen_RTS_Asset_West_CUP_B_UH1Y_GUNSHIP_F]
UPGRADE(Zen_RTS_F_West_AirFactoryUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_CUP_B_AH1Z, Zen_RTS_Asset_West_CUP_B_AH1Z_14RndHydrax, Zen_RTS_Asset_West_CUP_B_AH1Z_AT,Zen_RTS_Asset_West_CUP_B_AH1_AT_BAF, Zen_RTS_Asset_West_CUP_B_AH1_MR_BAF, Zen_RTS_Asset_West_CUP_B_AH64D_AT_USA]
UPGRADE(Zen_RTS_F_West_AirFactoryUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_CUP_B_AH1_BAF, Zen_RTS_Asset_West_CUP_B_AH1_ES_BAF, Zen_RTS_Asset_West_CUP_B_AH1_NO_BAF, Zen_RTS_Asset_West_CUP_B_AH64D_ES_USA, Zen_RTS_Asset_West_CUP_B_AH64D_MR_USA, Zen_RTS_Asset_West_CUP_B_AH64D_USA, Zen_RTS_Asset_West_CUP_B_AV8B, Zen_RTS_Asset_West_CUP_B_AV8B_FFAR_7, Zen_RTS_Asset_West_CUP_B_AW159_Armed_BAF]
UPGRADE(Zen_RTS_F_West_AirFactoryUpgrade03, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_CUP_B_AV8B_Deepstrike, Zen_RTS_Asset_West_CUP_B_AV8B_Hydra19, Zen_RTS_Asset_West_CUP_B_AV8B_FFAR_19, Zen_RTS_Asset_West_CUP_B_AV8B_LGB, Zen_RTS_Asset_West_CUP_B_AV8B_Heavy, Zen_RTS_Asset_West_CUP_B_A10_AT_USA, Zen_RTS_Asset_West_CUP_B_A10_CAS_USA]
UPGRADE(Zen_RTS_F_West_AirFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_West_AirFactory = ["Zen_RTS_F_West_AirFactoryConstructor", "Zen_RTS_F_West_AirFactoryDestructor", ["Zen_RTS_F_West_AirFactoryUpgrade01", "Zen_RTS_F_West_AirFactoryUpgrade02", "Zen_RTS_F_West_AirFactoryUpgrade03", "Zen_RTS_F_West_AirFactoryUpgrade04"], "Air Factory", "Cost: 2000, Time: 10, Picture: pictures\plane_ca.paa, Classname: Land_Airport_Tower_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack  Zen_RTS_BuildingType_West_AirFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_West_CUP_B_UH1Y_MEV_F = ["CUP_B_UH1Y_MEV_F", "UH1Y-MEV", "Cost: 800, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_MV22_USMC = ["CUP_B_MV22_USMC", "vetol-mv22", "Cost: 1500, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_UH60L_US = ["CUP_B_UH60L_US", "UH60L", "Cost: 2000, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_UH60M_US = ["CUP_B_UH60M_US", "UH60M", "Cost: 2000, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_UH1Y_GUNSHIP_F = ["CUP_B_UH1Y_GUNSHIP_F", "UH1Y-GUNSHIP", "Cost: 3500, Time: 30,Crew: 4,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH1Z = ["CUP_B_AH1Z", "AH1Z", "Cost: 3500, Time: 30,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH1Z_14RndHydrax = ["CUP_B_AH1Z_14RndHydrax", "AH64D-Hydrax", "Cost: 2700, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH1Z_AT = ["CUP_B_AH1Z_AT", "AH1Z-AT", "Cost: 3000, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH1_AT_BAF = ["CUP_B_AH1_AT_BAF", "AH1-AT-BAF", "Cost: 3200, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH1_MR_BAF = ["CUP_B_AH1_MR_BAF", "AH1-MR-BAF", "Cost: 3300, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH64D_AT_USA = ["CUP_B_AH64D_AT_USA", "AH64D-AT", "Cost: 4200, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH1_BAF = ["CUP_B_AH1_BAF","AH1-BAF", "Cost: 4200, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH1_ES_BAF = ["CUP_B_AH1_ES_BAF", "AH1-ES-BAF", "Cost: 4300, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH1_NO_BAF = ["CUP_B_AH1_NO_BAF","AH1-NO-BAF", "Cost: 4000, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH64D_ES_USA = ["CUP_B_AH64D_ES_USA","AH64D-ES", "Cost: 5200, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH64D_MR_USA = ["CUP_B_AH64D_MR_USA","AH64D_MR", "Cost: 5400, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AH64D_USA = ["CUP_B_AH64D_USA","AH64D", "Cost: 5000, Time: 30,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AW159_Armed_BAF = ["CUP_B_AW159_Armed_BAF","AW159 Armed", "Cost: 5500, Time: 30,Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AV8B = ["CUP_B_AV8B","AV8B", "Cost: 6500, Time: 45,Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AV8B_Deepstrike = ["CUP_B_AV8B_Deepstrike", "AV8B-Deepstrike", "Cost: 7200, Time: 45,Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AV8B_FFAR_19 = ["CUP_B_AV8B_FFAR_19", "AV8B-FFAR-19", "Cost: 6200, Time: 45,Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AV8B_FFAR_7 = ["CUP_B_AV8B_FFAR_7", "AV8B_FFAR_7", "Cost: 5800, Time: 45,Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AV8B_Heavy = ["CUP_B_AV8B_Heavy", "AV8B-Heavy", "Cost: 8000, Time: 45,Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AV8B_Hydra19 = ["CUP_B_AV8B_Hydra19", "AV8B-Hydra19", "Cost: 6300, Time: 45,Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AV8B_LGB = ["CUP_B_AV8B_LGB", "AV8B-LGB", "Cost: 9000, Time: 45,Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_A10_AT_USA = ["CUP_B_A10_AT_USA", "a10-AT", "Cost: 9200, Time: 45,Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_A10_CAS_USA = ["CUP_B_A10_CAS_USA", "a10-cas", "Cost: 9800, Time: 45,Crew: 1,"] call Zen_RTS_StrategicAssetCreate;

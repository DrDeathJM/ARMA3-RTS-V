/**
Zen_RTS_Asset_East_CUP_O_UAZ_Unarmed_RU
Zen_RTS_Asset_East_CUP_O_UAZ_Unarmed_TKA
Zen_RTS_Asset_East_CUP_O_LR_Transport_TKA
Zen_RTS_Asset_East_CUP_O_LR_MG_TKA
Level 1:

Zen_RTS_Asset_East_CUP_O_LR_SPG9_TKA
Zen_RTS_Asset_East_CUP_O_LR_Transport_TKM
Zen_RTS_Asset_East_CUP_O_LR_MG_TKM
Zen_RTS_Asset_East_CUP_O_LR_SPG9_TKM
Zen_RTS_Asset_East_CUP_O_Datsun_PK
Zen_RTS_Asset_East_CUP_O_Datsun_PK_Random
Zen_RTS_Asset_East_CUP_O_UAZ_MG_CHDKZ
Zen_RTS_Asset_East_CUP_O_UAZ_AGS30_CHDKZ
Zen_RTS_Asset_East_CUP_O_UAZ_SPG9_CHDKZ
Zen_RTS_Asset_East_CUP_O_UAZ_Open_RU
Zen_RTS_Asset_East_CUP_O_UAZ_MG_RU
Zen_RTS_Asset_East_CUP_O_UAZ_AGS30_RU
Level 2:

Zen_RTS_Asset_East_CUP_O_UAZ_SPG9_RU
Zen_RTS_Asset_East_CUP_O_UAZ_MG_TKA
Zen_RTS_Asset_East_CUP_O_UAZ_AGS30_TKA
Zen_RTS_Asset_East_CUP_O_UAZ_SPG9_TKA
Zen_RTS_Asset_East_CUP_O_BTR60_TK
Zen_RTS_Asset_East_CUP_O_BTR90_RU
Zen_RTS_Asset_East_CUP_O_BTR90_HQ_RU
Zen_RTS_Asset_East_CUP_O_BRDM2_TKA
Zen_RTS_Asset_East_CUP_O_BRDM2_ATGM_TKA
Level 3:

Zen_RTS_Asset_East_CUP_O_BRDM2_HQ_TKA
Zen_RTS_Asset_East_O_APC_Wheeled_02_rcws_F//Marid
Zen_RTS_Asset_East_CUP_O_T72_TKA
Zen_RTS_Asset_East_CUP_O_T72_RU
Zen_RTS_Asset_East_CUP_O_M113_TKA
Zen_RTS_Asset_East_O_APC_Tracked_02_AA_F
Zen_RTS_Asset_East_O_APC_Tracked_02_cannon_F//Kamysh
Zen_RTS_Asset_East_CUP_O_ZSU23_TK
Zen_RTS_Asset_East_CUP_O_ZSU23_SLA
Level 4:
Zen_RTS_Asset_East_CUP_O_T55_TK
Zen_RTS_Asset_East_O_MBT_02_cannon_F//Varsuk
Zen_RTS_Asset_East_CUP_O_BM21_RU
Zen_RTS_Asset_East_CUP_O_BM21_TKA
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_East_TankFactoryConstructor = {
    diag_log "East Tank_factory constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];

    _assetsToAdd pushBack Zen_RTS_Asset_East_CUP_O_UAZ_Unarmed_RU;
    _assetsToAdd pushBack Zen_RTS_Asset_East_CUP_O_UAZ_Unarmed_TKA;
    _assetsToAdd pushBack Zen_RTS_Asset_East_CUP_O_LR_Transport_TKA;
    _assetsToAdd pushBack Zen_RTS_Asset_East_CUP_O_LR_MG_TKA;
    _assetsToAdd pushBack Zen_RTS_Asset_East_CJ;

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
        0 = [_ID, [Zen_RTS_Asset_Tech_East_Upgrade_TankFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("LAND_CARGO_HOUSE_V2_F", -0.5)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_TankFactory, east)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3'image='pictures\build_CA.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_East_TankFactoryDestructor = {
    diag_log "East Tank_factory destructor";

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
    _buildingObjData = _this select 0; \
    _assetsToAdd = A; \
    if (Zen_RTS_TechFlag_East_BuildEnemy) then { \
    }; \
    { \
        (RTS_Used_Asset_Types select 1) pushBack _x; \
    } forEach _assetsToAdd; \
    publicVariable "RTS_Used_Asset_Types"; \
    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal; \
    (true) \
};

#define ASSETS [Zen_RTS_Asset_East_CUP_O_LR_SPG9_TKA, Zen_RTS_Asset_East_CUP_O_LR_Transport_TKM, Zen_RTS_Asset_East_CUP_O_LR_MG_TKM, Zen_RTS_Asset_East_CUP_O_LR_SPG9_TKM, Zen_RTS_Asset_East_CUP_O_Datsun_PK, Zen_RTS_Asset_East_CUP_O_Datsun_PK_Random, Zen_RTS_Asset_East_CUP_O_UAZ_MG_CHDKZ, Zen_RTS_Asset_East_CUP_O_UAZ_AGS30_CHDKZ, Zen_RTS_Asset_East_CUP_O_UAZ_SPG9_CHDKZ, Zen_RTS_Asset_East_CUP_O_UAZ_Open_RU, Zen_RTS_Asset_East_CUP_O_UAZ_MG_RU, Zen_RTS_Asset_East_CUP_O_UAZ_AGS30_RU]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_CUP_O_UAZ_SPG9_RU, Zen_RTS_Asset_East_CUP_O_UAZ_MG_TKA, Zen_RTS_Asset_East_CUP_O_UAZ_AGS30_TKA, Zen_RTS_Asset_East_CUP_O_UAZ_SPG9_TKA, Zen_RTS_Asset_East_CUP_O_BTR60_TK, Zen_RTS_Asset_East_CUP_O_BTR90_RU, Zen_RTS_Asset_East_CUP_O_BTR90_HQ_RU, Zen_RTS_Asset_East_CUP_O_BRDM2_TKA, Zen_RTS_Asset_East_CUP_O_BRDM2_ATGM_TKA]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_CUP_O_BRDM2_HQ_TKA, Zen_RTS_Asset_East_O_APC_Wheeled_02_rcws_F, Zen_RTS_Asset_East_CUP_O_T72_TKA, Zen_RTS_Asset_East_CUP_O_T72_RU, Zen_RTS_Asset_East_CUP_O_M113_TKA, Zen_RTS_Asset_East_O_APC_Tracked_02_AA_F, Zen_RTS_Asset_East_O_APC_Tracked_02_cannon_F, Zen_RTS_Asset_East_CUP_O_ZSU23_TK, Zen_RTS_Asset_East_CUP_O_ZSU23_SLA]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade03, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_CUP_O_T55_TK, Zen_RTS_Asset_East_O_MBT_02_cannon_F, Zen_RTS_Asset_East_CUP_O_BM21_RU, Zen_RTS_Asset_East_CUP_O_BM21_TKA]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_East_TankFactory = ["Zen_RTS_F_East_TankFactoryConstructor", "Zen_RTS_F_East_TankFactoryDestructor", ["Zen_RTS_F_East_TankFactoryUpgrade01", "Zen_RTS_F_East_TankFactoryUpgrade02", "Zen_RTS_F_East_TankFactoryUpgrade03","Zen_RTS_F_East_TankFactoryUpgrade04"], "Tank factory", "Cost: 2000, Time: 10, Picture: pictures\tank_ca.paa, Classname: LAND_CARGO_HOUSE_V2_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack  Zen_RTS_BuildingType_East_TankFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

//tank 0 upgrade assests
Zen_RTS_Asset_East_CUP_O_UAZ_Unarmed_RU = ["CUP_O_UAZ_Unarmed_RU", "UAZ (unarmed)RU", "Cost: 200, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_UAZ_Unarmed_TKA = ["CUP_O_UAZ_Unarmed_TKA", "UAZ Unarmed TKA", "Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_LR_Transport_TKA = ["CUP_O_LR_Transport_TKA", "LR Transport TKA","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_LR_MG_TKA = ["CUP_O_LR_MG_TKA","LR MG", "Cost: 100, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
//tank 1 upgrade assests
Zen_RTS_Asset_East_CUP_O_LR_SPG9_TKA = ["CUP_O_LR_SPG9_TKA", "LR SPG9","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_LR_Transport_TKM = ["CUP_O_LR_Transport_TKM", "LR Transport","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_LR_MG_TKM = ["CUP_O_LR_MG_TKM", "LR MG","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_LR_SPG9_TKM = ["CUP_O_LR_SPG9_TKM", "LR SPG9","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Datsun_PK = ["CUP_O_Datsun_PK", "Datsun PK","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_Datsun_PK_Random = ["CUP_O_Datsun_PK_Random", "Datsun pK Random","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_UAZ_MG_CHDKZ = ["CUP_O_UAZ_MG_CHDKZ", "APC-BTR80","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_UAZ_AGS30_CHDKZ = ["CUP_O_UAZ_AGS30_CHDKZ", "UAZ AGS30","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_UAZ_SPG9_CHDKZ = ["CUP_O_UAZ_SPG9_CHDKZ", "UAZ SPG9","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_UAZ_Open_RU = ["CUP_O_UAZ_Open_RU", "UAZ Open","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_UAZ_MG_RU = ["CUP_O_UAZ_MG_RU", "UAZ MG","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_UAZ_AGS30_RU = ["CUP_O_UAZ_AGS30_RU", "UAZ AGS30","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;

//tank 2 upgrade assests

Zen_RTS_Asset_East_CUP_O_UAZ_SPG9_RU = ["CUP_O_UAZ_SPG9_RU", "UAZ SPG9","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_UAZ_MG_TKA = ["CUP_O_UAZ_MG_TKA", "UAZ MG","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_UAZ_AGS30_TKA = ["CUP_O_UAZ_AGS30_TKA", "UAZ AGS30","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_UAZ_SPG9_TKA = ["CUP_O_UAZ_SPG9_TKA", "UAZ SPG9","Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_BTR60_TK = ["CUP_O_BTR60_TK", "BTR60","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_BTR90_RU = ["CUP_O_BTR90_RU", "BTR90","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_BTR90_HQ_RU = ["CUP_O_BTR90_HQ_RU", "BTR90 HQ","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_BRDM2_TKA = ["CUP_O_BRDM2_TKA", "BRDM2","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_BRDM2_ATGM_TKA = ["CUP_O_BRDM2_ATGM_TKA", "BRDM2_ATGM","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;

//tank 3 upgrade assests

Zen_RTS_Asset_East_CUP_O_BRDM2_HQ_TKA = ["CUP_O_BRDM2_HQ_TKA", "BRDM2_HQ","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_O_APC_Wheeled_02_rcws_F = ["O_APC_Wheeled_02_rcws_F", "Marid","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_T72_TKA = ["CUP_O_T72_TKA", "T72 TKA","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_T72_RU = ["CUP_O_T72_RU", "T72 RU","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_M113_TKA = ["CUP_O_M113_TKA", "M113","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_O_APC_Tracked_02_AA_F = ["O_APC_Tracked_02_AA_F", "AA","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_O_APC_Tracked_02_cannon_F = ["O_APC_Tracked_02_cannon_F", "Kamysh","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_ZSU23_TK = ["CUP_O_ZSU23_TK", "ZSU23","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_ZSU23_SLA = ["CUP_O_ZSU23_SLA", "ZSU23 SLA","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;

//tank 4 upgrade assests

Zen_RTS_Asset_East_CUP_O_T55_TK = ["CUP_O_T55_TK", "T55","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_O_MBT_02_cannon_F = ["O_MBT_02_cannon_F", "Varsuk","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_BM21_RU = ["CUP_O_BM21_RU", "BM21","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_BM21_TKA = ["CUP_O_BM21_TKA", "BM21 TKA","Cost: 200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_East_CJ = ["Zen_RTS_F_East_Asset_CJ","CJ", "Cost: 500, Time: 10, Crew: 0,"] call Zen_RTS_StrategicAssetCreate;

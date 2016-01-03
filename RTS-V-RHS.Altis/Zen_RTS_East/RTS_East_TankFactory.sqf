/**
    Level 1:
        Zen_RTS_Asset_East_RHS_Ural_Flat_VDV_01
        Zen_RTS_Asset_East_Quadbike
        Zen_RTS_Asset_East_Offroad
    Level 2:
        Zen_RTS_Asset_East_OffroadArmed
        Zen_RTS_Asset_East_IfritHMG
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

    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_gaz66o_flat_vdv;
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_gaz66_vdv;
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_uaz_vdv;
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_uaz_open_vdv;
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

    BUILDING_VISUALS("Land_i_Garage_V1_F", -0.5)
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

#define ASSETS [Zen_RTS_Asset_East_rhs_tigr_3camo_vmf, Zen_RTS_Asset_East_rhs_tigr_ffv_vmf, Zen_RTS_Asset_East_rhs_tigr_ffv_3camo_vmf, Zen_RTS_Asset_East_rhs_btr60_vmf, Zen_RTS_Asset_East_rhs_btr80_vdv, Zen_RTS_Asset_East_rhs_btr70_vdv, Zen_RTS_Asset_East_rhs_brm1k_vdv]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_rhs_btr80a_vdv, Zen_RTS_Asset_East_rhs_bmp1_vmf, Zen_RTS_Asset_East_rhs_bmp1k_vdv, Zen_RTS_Asset_East_rhs_bmp1d_vdv, Zen_RTS_Asset_East_rhs_bmp1p_vdv, Zen_RTS_Asset_East_rhs_bmp2e_vdv, Zen_RTS_Asset_East_rhs_bmp2k_vdv, Zen_RTS_Asset_East_rhs_bmp2d_vdv, Zen_RTS_Asset_East_rhs_bmp3_late_msv, Zen_RTS_Asset_East_rhs_bmp3mera_msv]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_rhs_bmd1, Zen_RTS_Asset_East_rhs_bmd1k, Zen_RTS_Asset_East_rhs_bmd1p, Zen_RTS_Asset_East_rhs_bmd1pk, Zen_RTS_Asset_East_rhs_bmd1r, Zen_RTS_Asset_East_rhs_bmd2, Zen_RTS_Asset_East_rhs_bmd2m, Zen_RTS_Asset_East_rhs_bmd2k, Zen_RTS_Asset_East_rhs_bmd4ma_vdv, Zen_RTS_Asset_East_rhs_sprut_vdv, Zen_RTS_Asset_East_rhs_t72bc_tv, Zen_RTS_Asset_East_rhs_t72bd_tv, Zen_RTS_Asset_East_rhs_t72ba_tv, Zen_RTS_Asset_East_rhs_zsu234_aa]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade03, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_rhs_t80b, Zen_RTS_Asset_East_rhs_t80bk, Zen_RTS_Asset_East_rhs_t80bv, Zen_RTS_Asset_East_rhs_t80bvk, Zen_RTS_Asset_East_rhs_t80, Zen_RTS_Asset_East_rhs_t80a, Zen_RTS_Asset_East_rhs_t80u, Zen_RTS_Asset_East_rhs_t90_tv]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_East_TankFactory = ["Zen_RTS_F_East_TankFactoryConstructor", "Zen_RTS_F_East_TankFactoryDestructor", ["Zen_RTS_F_East_TankFactoryUpgrade01", "Zen_RTS_F_East_TankFactoryUpgrade02", "Zen_RTS_F_East_TankFactoryUpgrade03","Zen_RTS_F_East_TankFactoryUpgrade04"], "Tank factory", "Cost: 2000, Time: 10, Picture: pictures\tank_ca.paa, Classname: Land_i_Garage_V1_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack  Zen_RTS_BuildingType_East_TankFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

//tank 0 upgrade assests
Zen_RTS_Asset_East_rhs_gaz66o_flat_vdv = ["Zen_RTS_F_East_Asset_rhs_gaz66o_flat_vdv", "Gaz_flat", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_gaz66_vdv = ["Zen_RTS_F_East_Asset_rhs_gaz66_vdv", "Gaz_vdv", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_uaz_vdv = ["Zen_RTS_F_East_Asset_rhs_uaz_vdv", "uaz-jeep","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_uaz_open_vdv = ["Zen_RTS_F_East_Asset_rhs_uaz_open_vdv","uaz_jeep (open)", "Cost: 100, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
//tank 1 upgrade assests
Zen_RTS_Asset_East_rhs_tigr_3camo_vmf = ["Zen_RTS_F_East_Asset_rhs_tigr_3camo_vmf", "tigr-3 (gunner seat)","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_tigr_ffv_vmf = ["Zen_RTS_F_East_Asset_rhs_tigr_ffv_vmf", "tigr-ffv(gunner seat)","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_tigr_ffv_3camo_vmf = ["Zen_RTS_F_East_Asset_rhs_tigr_ffv_3camo_vmf", "tigr-ffv-3(gunner seat)","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_gaz66_ap2_vdv = ["Zen_RTS_F_East_Asset_rhs_gaz66_ap2_vdv", "gaz-ap2","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_btr60_vmf = ["Zen_RTS_F_East_Asset_rhs_btr60_vmf", "APC-BTR60","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_btr70_vdv = ["Zen_RTS_F_East_Asset_rhs_btr70_vdv", "APC-BTR70","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_btr80_vdv = ["Zen_RTS_F_East_Asset_rhs_btr80_vdv", "APC-BTR80","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
//tank 2 upgrade assests

Zen_RTS_Asset_East_rhs_brm1k_vdv = ["Zen_RTS_F_East_Asset_rhs_brm1k_vdv", "brm-1k","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_btr80a_vdv = ["Zen_RTS_F_East_Asset_rhs_btr80a_vdv", "APC-BTRA-80","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp1_vmf = ["Zen_RTS_F_East_Asset_rhs_bmp1_vmf", "BMP","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp1k_vdv = ["Zen_RTS_F_East_Asset_rhs_bmp1k_vdv", "BMP-1k","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp1d_vdv = ["Zen_RTS_F_East_Asset_rhs_bmp1d_vdv", "BMP-1d","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp1p_vdv = ["Zen_RTS_F_East_Asset_rhs_bmp1p_vdv", "BMP1p","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp2e_vdv = ["Zen_RTS_F_East_Asset_rhs_bmp2e_vdv", "BMP-2e","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp2k_vdv = ["Zen_RTS_F_East_Asset_rhs_bmp2k_vdv", "BMP-2k","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp2d_vdv = ["Zen_RTS_F_East_Asset_rhs_bmp2d_vdv", "BMP-2d","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp3_late_msv = ["Zen_RTS_F_East_Asset_rhs_bmp3_late_msv", "BM3-late","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp3mera_msv = ["Zen_RTS_F_East_Asset_rhs_bmp3mera_msv", "BMP3-Auto","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
//tank 3 upgrade assests
Zen_RTS_Asset_East_rhs_bmd1 = ["Zen_RTS_F_East_Asset_rhs_bmd1", "bmd1","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmd1k = ["Zen_RTS_F_East_Asset_rhs_bmd1k", "bmd1k","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmd1p = ["Zen_RTS_F_East_Asset_rhs_bmd1p", "bmd1p","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmd1pk = ["Zen_RTS_F_East_Asset_rhs_bmd1pk", "bmd1pk","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmd1r = ["Zen_RTS_F_East_Asset_rhs_bmd1r", "bmd1r","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmd2 = ["Zen_RTS_F_East_Asset_rhs_bmd2", "bmd2","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmd2m = ["Zen_RTS_F_East_Asset_rhs_bmd2m", "bmd2m","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmd2k = ["Zen_RTS_F_East_Asset_rhs_bmd2k", "bmd2k","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmd4ma_vdv = ["Zen_RTS_F_East_Asset_rhs_bmd4ma_vdv", "BMD4ma","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_sprut_vdv = ["Zen_RTS_F_East_Asset_rhs_sprut_vdv", "Spurt","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t72bc_tv = ["Zen_RTS_F_East_Asset_rhs_t72bc_tv", "t72bc-tv","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t72bd_tv = ["Zen_RTS_F_East_Asset_rhs_t72bd_tv", "t72bd-tv","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t72ba_tv = ["Zen_RTS_F_East_Asset_rhs_t72ba_tv", "t72ba-tv","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_zsu234_aa = ["Zen_RTS_F_East_Asset_rhs_zsu234_aa", "ZSU234-AA","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
//tank 4 upgrade assests
Zen_RTS_Asset_East_rhs_t80b = ["Zen_RTS_F_East_Asset_rhs_t80b", "t80b","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t80bk = ["Zen_RTS_F_East_Asset_rhs_t80bk", "t80-bk","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t80bv = ["Zen_RTS_F_East_Asset_rhs_t80bv", "t80-tv","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t80bvk = ["Zen_RTS_F_East_Asset_rhs_t80bvk", "t80-bvk","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t80 = ["Zen_RTS_F_East_Asset_rhs_t80", "t80","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t80a = ["Zen_RTS_F_East_Asset_rhs_t80a", "t80-a","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t80u = ["Zen_RTS_F_East_Asset_rhs_t80u", "t80-u","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t90_tv = ["Zen_RTS_F_East_Asset_rhs_t90_tv", "T90","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_East_CJ = ["Zen_RTS_F_East_Asset_CJ","CJ", "Cost: 500, Time: 10, Crew: 0,"] call Zen_RTS_StrategicAssetCreate;

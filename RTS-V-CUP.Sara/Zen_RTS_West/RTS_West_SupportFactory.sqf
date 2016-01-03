/**
    Zen_RTS_Asset_West_CUP_B_Ural_Refuel_CDF
    Zen_RTS_Asset_West_CUP_B_Ural_Repair_CDF
    Zen_RTS_Asset_West_CUP_B_Ural_Reammo_CDF
    Level 1:
	Zen_RTS_Asset_West_CUP_B_Ural_Open_CDF
    Zen_RTS_Asset_West_CUP_B_Ural_ZU23_CDF


//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_SupportFactoryConstructor = {
    diag_log "West Support_factory constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_Ural_Refuel_CDF;
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_Ural_Repair_CDF;
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_Ural_Reammo_CDF;


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
        0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_SupportFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("LAND_CARGO_TOWER_V1_F", -2)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_SupportFactory, West)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3' image='pictures\build_CA.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_West_SupportFactoryDestructor = {
    diag_log "West Support factory destructor";

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

#define ASSETS [Zen_RTS_Asset_West_CUP_B_M270_HE_USMC, Zen_RTS_Asset_West_CUP_B_M270_DPICM_USMC]
UPGRADE(Zen_RTS_F_West_SupportFactoryUpgrade01, ASSETS)

#define ASSETS []
UPGRADE(Zen_RTS_F_West_SupportFactoryUpgrade02, ASSETS)

Zen_RTS_BuildingType_West_SupportFactory = ["Zen_RTS_F_West_SupportFactoryConstructor", "Zen_RTS_F_West_SupportFactoryDestructor", ["Zen_RTS_F_West_SupportFactoryUpgrade01","Zen_RTS_F_West_SupportFactoryUpgrade02"], "Support Factory", "Cost: 2000, Time: 10, Picture: pictures\support_ca.paa, Classname: LAND_CARGO_TOWER_V1_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack  Zen_RTS_BuildingType_West_SupportFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_West_CUP_B_Ural_Refuel_CDF = ["CUP_B_Ural_Refuel_CDF","Ural Refuel", "Cost: 200, Time: 15, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_Ural_Repair_CDF = ["CUP_B_Ural_Repair_CDF","Ural Repair", "Cost: 200, Time: 15, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_Ural_Reammo_CDF = ["CUP_B_Ural_Reammo_CDF","Ural Reammo", "Cost: 200, Time: 15, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_M270_HE_USMC = ["CUP_B_M270_HE_USMC","M270 HE USMC", "Cost: 8000, Time: 30, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_M270_DPICM_USMC = ["CUP_B_M270_DPICM_USMC","M270 DPICM USMC", "Cost: 8000, Time: 30,Crew: 3,"] call Zen_RTS_StrategicAssetCreate;

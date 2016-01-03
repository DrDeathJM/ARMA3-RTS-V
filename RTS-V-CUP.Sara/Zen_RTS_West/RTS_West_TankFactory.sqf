/**
    Zen_RTS_Asset_West_CUP_B_HMMWV_Unarmed_USA
    Zen_RTS_Asset_West_CUP_B_UAZ_Open_CDF
    Zen_RTS_Asset_West_CUP_B_HMMWV_Transport_USA
	Zen_RTS_Asset_West_CUP_B_Dingo_Des
    Level 1:
	Zen_RTS_Asset_West_CUP_LR_MG_Base
	Zen_RTS_Asset_West_CUP_LR_Special_Base
	Zen_RTS_Asset_West_CUP_LR_SPG9_Base
	Zen_RTS_Asset_West_CUP_B_Dingo_Wdl,
    Zen_RTS_Asset_West_CUP_B_HMMWV_MK19_USA,
    Zen_RTS_Asset_West_CUP_B_UAZ_AGS30_CDF,
    Zen_RTS_Asset_West_CUP_B_HMMWV_TOW_USA,
    Zen_RTS_Asset_West_CUP_B_BM21_CDF,
    Zen_RTS_Asset_West_CUP_B_UAZ_SPG9_CDF,
    Zen_RTS_Asset_West_CUP_B_HMMWV_Avenger_USA,
    Zen_RTS_Asset_West_CUP_B_HMMWV_M2_GPK_USA,
	Zen_RTS_Asset_West_CUP_B_HMMWV_SOV_USA
    Level 2:
    Zen_RTS_Asset_West_CUP_B_HMMWV_Crows_M2_USA,
    Zen_RTS_Asset_West_CUP_B_HMMWV_Crows_MK19_USA,
    Zen_RTS_Asset_West_CUP_B_M113_Med_USA,
    Zen_RTS_Asset_West_CUP_B_HMMWV_Ambulance_USA,
    Zen_RTS_Asset_West_CUP_B_M113_USA,
    Zen_RTS_Asset_West_CUP_B_M163_USA,
    Zen_RTS_Asset_West_CUP_B_HMMWV_M1114_USMC,
    Zen_RTS_Asset_West_CUP_BAF_Jackal2_GMG_D,
	Zen_RTS_Asset_West_CUP_BAF_Jackal2_L2A1_D
	Level 3:
	Zen_RTS_Asset_West_CUP_BAF_Jackal2_GMG_W,
	Zen_RTS_Asset_West_CUP_BAF_Jackal2_L2A1_W,
	Zen_RTS_Asset_West_CUP_B_HMMWV_Avenger_USMC,
    Zen_RTS_Asset_West_CUP_B_LAV25_USMC,
    Zen_RTS_Asset_West_CUP_B_LAV25M240_USMC,
    Zen_RTS_Asset_West_CUP_B_AAV_USMC,
    Zen_RTS_Asset_West_CUP_B_BRDM2_CDF,
    Zen_RTS_Asset_West_CUP_B_BRDM2_ATGM_CDF,
    Zen_RTS_Asset_West_CUP_B_ZSU23_CDF,
	Level 4:
	Zen_RTS_Asset_West_CUP_B_M1A1_Woodland_USMC
    Zen_RTS_Asset_West_CUP_B_M1A1_DES_USMC
    Zen_RTS_Asset_West_CUP_B_M1A1_DES_US_Army
    Zen_RTS_Asset_West_CUP_B_M1A2_TUSK_MG_DES_US_Army
    Zen_RTS_Asset_West_CUP_B_M1A2_TUSK_MG_USMC


//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_TankFactoryConstructor = {
    diag_log "West Tank_factory constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;

    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_HMMWV_Unarmed_USA;
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_UAZ_Open_CDF;
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_HMMWV_Transport_USA;
	_assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_Dingo_Des;
    _assetsToAdd pushBack Zen_RTS_Asset_West_CJ;

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
        0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_TankFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("LAND_CARGO_HOUSE_V1_F", -1.5)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_TankFactory, West)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3' image='pictures\build_CA.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_West_TankFactoryDestructor = {
    diag_log "West Tank_factory destructor";

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

#define ASSETS [Zen_RTS_Asset_West_CUP_LR_MG_Base, Zen_RTS_Asset_West_CUP_LR_Special_Base, Zen_RTS_Asset_West_CUP_LR_SPG9_Base, Zen_RTS_Asset_West_CUP_B_Dingo_Wdl, Zen_RTS_Asset_West_CUP_B_HMMWV_MK19_USA, Zen_RTS_Asset_West_CUP_B_UAZ_AGS30_CDF, Zen_RTS_Asset_West_CUP_B_HMMWV_TOW_USA, Zen_RTS_Asset_West_CUP_B_UAZ_SPG9_CDF, Zen_RTS_Asset_West_CUP_B_HMMWV_Avenger_USA, Zen_RTS_Asset_West_CUP_B_HMMWV_M2_GPK_USA, Zen_RTS_Asset_West_CUP_B_HMMWV_SOV_USA]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_CUP_B_HMMWV_Crows_M2_USA,Zen_RTS_Asset_West_CUP_B_HMMWV_Crows_MK19_USA,Zen_RTS_Asset_West_CUP_B_M113_Med_USA,Zen_RTS_Asset_West_CUP_B_HMMWV_Ambulance_USA,Zen_RTS_Asset_West_CUP_B_M113_USA,Zen_RTS_Asset_West_CUP_B_M163_USA,Zen_RTS_Asset_West_CUP_B_HMMWV_M1114_USMC,Zen_RTS_Asset_West_CUP_BAF_Jackal2_GMG_D,Zen_RTS_Asset_West_CUP_BAF_Jackal2_L2A1_D]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_CUP_BAF_Jackal2_GMG_W,Zen_RTS_Asset_West_CUP_BAF_Jackal2_L2A1_W,Zen_RTS_Asset_West_CUP_B_HMMWV_Avenger_USMC,Zen_RTS_Asset_West_CUP_B_LAV25_USMC,Zen_RTS_Asset_West_CUP_B_LAV25M240_USMC,Zen_RTS_Asset_West_CUP_B_AAV_USMC,Zen_RTS_Asset_West_CUP_B_BRDM2_CDF,Zen_RTS_Asset_West_CUP_B_BRDM2_ATGM_CDF,Zen_RTS_Asset_West_CUP_B_ZSU23_CDF]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade03, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_CUP_B_M1A1_Woodland_USMC, Zen_RTS_Asset_West_CUP_B_M1A1_DES_USMC, Zen_RTS_Asset_West_CUP_B_M1A1_DES_US_Army, Zen_RTS_Asset_West_CUP_B_M1A2_TUSK_MG_DES_US_Army, Zen_RTS_Asset_West_CUP_B_M1A2_TUSK_MG_USMC,Zen_RTS_Asset_West_CUP_B_BM21_CDF]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_West_TankFactory = ["Zen_RTS_F_West_TankFactoryConstructor", "Zen_RTS_F_West_TankFactoryDestructor", ["Zen_RTS_F_West_TankFactoryUpgrade01","Zen_RTS_F_West_TankFactoryUpgrade02","Zen_RTS_F_West_TankFactoryUpgrade03","Zen_RTS_F_West_TankFactoryUpgrade04"], "Tank factory", "Cost: 2000, Time: 10, Picture: pictures\tank_ca.paa, Classname: LAND_CARGO_HOUSE_V1_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack  Zen_RTS_BuildingType_West_TankFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_West_CUP_B_HMMWV_Unarmed_USA = ["CUP_B_HMMWV_Unarmed_USA","HMMWV Unarmed", "Cost: 100, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_UAZ_Open_CDF = ["CUP_B_UAZ_Open_CDF","UAZ Open CDF", "Cost: 150, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_HMMWV_Transport_USA = ["CUP_B_HMMWV_Transport_USA","HMMWV Transport", "Cost: 100, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_Dingo_Des = ["CUP_B_Dingo_Des","Dingo", "Cost: 150, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
    //**Level 1:
Zen_RTS_Asset_West_CUP_LR_MG_Base = ["CUP_LR_MG_Base","LR MG", "Cost: 150, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_LR_Special_Base = ["CUP_LR_Special_Base","LR Special", "Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_LR_SPG9_Base = ["CUP_LR_SPG9_Base","LR SPG9", "Cost: 225, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_Dingo_Wdl = ["CUP_B_Dingo_Wdl","Dingo Wdl", "Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_HMMWV_MK19_USA = ["CUP_B_HMMWV_MK19_USA","HMMWV MK19", "Cost: 150, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_UAZ_AGS30_CDF = ["CUP_B_UAZ_AGS30_CDF","UAZ AGS30 CDF", "Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_HMMWV_TOW_USA = ["CUP_B_HMMWV_TOW_USA","HMMWV TOW", "Cost: 250, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_UAZ_SPG9_CDF = ["CUP_B_UAZ_SPG9_CDF","UAZ SPG9", "Cost: 250, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_HMMWV_Avenger_USA = ["CUP_B_HMMWV_Avenger_USA","HMMWV Avenger", "Cost: 300, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_HMMWV_M2_GPK_USA = ["CUP_B_HMMWV_M2_GPK_USA","HMMWV M2 GPK", "Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_HMMWV_SOV_USA = ["CUP_B_HMMWV_SOV_USA","HMMWV SOV", "Cost: 200, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
    //**Level 2:
Zen_RTS_Asset_West_CUP_B_HMMWV_Crows_M2_USA = ["CUP_B_HMMWV_Crows_M2_USA","HMMWV Crows M2", "Cost: 300, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_HMMWV_Crows_MK19_USA = ["CUP_B_HMMWV_Crows_MK19_USA","HMMWV Crows MK19", "Cost: 300, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_M113_Med_USA = ["CUP_B_M113_Med_USA","M113_Med", "Cost: 300, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_HMMWV_Ambulance_USA = ["CUP_B_HMMWV_Ambulance_USA","HMMWV Ambulance", "Cost: 300, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_M113_USA = ["CUP_B_M113_USA","M113", "Cost: 350, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_M163_USA = ["CUP_B_M163_USA","M163", "Cost: 375, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_HMMWV_M1114_USMC = ["CUP_B_HMMWV_M1114_USMC","HMMWV M1114", "Cost: 475, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_BAF_Jackal2_GMG_D = ["CUP_BAF_Jackal2_GMG_D","Jackal2 GMG des", "Cost: 500, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_BAF_Jackal2_L2A1_D = ["CUP_BAF_Jackal2_L2A1_D","Jackal2 L2A1 des", "Cost: 500, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
	//**Level 3:
Zen_RTS_Asset_West_CUP_BAF_Jackal2_GMG_W = ["CUP_BAF_Jackal2_GMG_W","Jackal2 GMG W", "Cost: 500, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_BAF_Jackal2_L2A1_W = ["CUP_BAF_Jackal2_L2A1_W","Jackal2 L2A1 W", "Cost: 500, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_HMMWV_Avenger_USMC = ["CUP_B_HMMWV_Avenger_USMC","HMMWV Avenger USMC", "Cost: 400, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_LAV25_USMC = ["CUP_B_LAV25_USMC","LAV25 USMC", "Cost: 600, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_LAV25M240_USMC = ["CUP_B_LAV25M240_USMC","LAV25M240 USMC", "Cost: 700, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_AAV_USMC = ["CUP_B_AAV_USMC","AAV USMC", "Cost: 800, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BRDM2_CDF = ["CUP_B_BRDM2_CDF","BRDM2 CDF", "Cost: 800, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BRDM2_ATGM_CDF = ["CUP_B_BRDM2_ATGM_CDF","BRDM2_ATGM CDF", "Cost: 900, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BRDM2_HQ_CDF = ["CUP_B_BRDM2_HQ_CDF","BRDM2 type CDF", "Cost: 900, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_ZSU23_CDF = ["CUP_B_ZSU23_CDF","ZSU23 CDF", "Cost: 1200, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
	//**Level 4:
Zen_RTS_Asset_West_CUP_B_M1A1_Woodland_USMC = ["CUP_B_M1A1_Woodland_USMC","M1A1 Woodland USMC", "Cost: 2000, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_M1A1_DES_USMC = ["CUP_B_M1A1_DES_USMC","M1A1 DES USMC", "Cost: 2500, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_M1A1_DES_US_Army = ["CUP_B_M1A1_DES_US_Army","M1A1 DES Army", "Cost: 3000, Time: 10, Crew: 0, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_M1A2_TUSK_MG_DES_US_Army = ["CUP_B_M1A2_TUSK_MG_DES_US_Army","M1A2_TUSK MG DES Army", "Cost: 4000, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_M1A2_TUSK_MG_USMC = ["CUP_B_M1A2_TUSK_MG_USMC","M1A2 TUSK MG USMC", "Cost: 4500, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BM21_CDF = ["CUP_B_BM21_CDF","BM21", "Cost: 8000, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_West_CJ = ["Zen_RTS_F_West_Asset_CJ","CJ", "Cost: 500, Time: 10, Crew: 0,"] call Zen_RTS_StrategicAssetCreate;

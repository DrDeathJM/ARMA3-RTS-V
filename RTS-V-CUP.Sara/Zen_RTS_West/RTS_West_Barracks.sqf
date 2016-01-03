/**
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_MTP
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_GL_MTP
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Marksman_MTP
    Level 1:
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Light_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Backpack_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AAR_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AMG_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AAT_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AHAT_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AAA_MTP        
        
    Level 2:
Zen_RTS_Asset_West_CUP_B_BAF_Officer_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_SL_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_TL_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AR_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_MG_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AT_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_HAT_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AA_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Night_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_scout_MTP	

    Level 3:
Zen_RTS_Asset_West_CUP_B_BAF_Spotter_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Spotter_L85TWS_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Pilot_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Crew_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Medic_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_JTAC_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Engineer_MTP,
Zen_RTS_Asset_West_CUP_B_BAF_Sniper_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Sniper_AS50_MTP, 
Zen_RTS_Asset_West_CUP_B_BAF_Sniper_AS50_TWS_MTP	
 
        
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_BarracksConstructor = {
    diag_log "West barracks constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    // _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_BAF_Soldier_MTP;
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_BAF_Soldier_GL_MTP;
    _assetsToAdd pushBack Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Marksman_MTP;

    if (Zen_RTS_TechFlag_West_BuildEnemy) then {
        // ... to do
    };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_West_HQ, _ID)
    if (_ID != "") then {
        0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_Barracks]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("LAND_CARGO_PATROL_V1_F", -2)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_Barracks, West)

    _args = ["addAction", [_building, ["<img size='3'image='pictures\build_CA.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)

    // hacking
    _building setVariable ["Zen_RTS_IsHacked", false, true];
    _args = ["addAction", [_building, ["Hack Building", Zen_RTS_HackBuilding, _buildingObjData, 1, false, true, "", "((_target distance _this) < 15) && {(side _this != (_target getVariable 'Zen_RTS_StrategicBuildingSide'))}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)

    (_building)
};

Zen_RTS_F_West_BarracksDestructor = {
    diag_log "West barracks destructor";

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
    _buildingObjData = _this select 0; \
    _assetsToAdd = A; \
    if (Zen_RTS_TechFlag_West_BuildEnemy) then { \
    }; \
    { \
        (RTS_Used_Asset_Types select 0) pushBack _x; \
    } forEach _assetsToAdd; \
    publicVariable "RTS_Used_Asset_Types"; \
    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal; \
    (true) \
};

#define ASSETS [Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Light_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Backpack_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AAR_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AMG_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AAT_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AHAT_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AAA_MTP]
UPGRADE(Zen_RTS_F_West_BarracksUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_CUP_B_BAF_Officer_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_SL_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_TL_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AR_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_MG_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AT_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_HAT_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AA_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Night_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_scout_MTP]
UPGRADE(Zen_RTS_F_West_BarracksUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_CUP_B_BAF_Spotter_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Spotter_L85TWS_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Pilot_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Crew_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Medic_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Soldier_JTAC_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Engineer_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Sniper_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Sniper_AS50_MTP, Zen_RTS_Asset_West_CUP_B_BAF_Sniper_AS50_TWS_MTP]
UPGRADE(Zen_RTS_F_West_BarracksUpgrade03, ASSETS)

Zen_RTS_BuildingType_West_Barracks = ["Zen_RTS_F_West_BarracksConstructor", "Zen_RTS_F_West_BarracksDestructor", ["Zen_RTS_F_West_BarracksUpgrade01", "Zen_RTS_F_West_BarracksUpgrade02","Zen_RTS_F_West_BarracksUpgrade03"], "Barracks", "Cost: 1000, Time: 10, Picture: pictures\barraks_ca.paa, Classname: LAND_CARGO_PATROL_V1_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack Zen_RTS_BuildingType_West_Barracks;

/////////////////////////////////
// Assets
/////////////////////////////////

//**// LEVEL 0
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_MTP = ["CUP_B_BAF_Soldier_MTP", "Soldier", "Cost: 150, Time: 10, Classname: b_soldier_02_f,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_GL_MTP = ["CUP_B_BAF_Soldier_GL_MTP", "Grenadier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Marksman_MTP = ["CUP_B_BAF_Soldier_Marksman_MTP", "Marksman", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
//**// LEVEL 1
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Light_MTP = ["CUP_B_BAF_Soldier_Light_MTP", "Soldier Light", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Backpack_MTP = ["CUP_B_BAF_Soldier_Backpack_MTP", "Soldier Bp", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AAR_MTP = ["CUP_B_BAF_Soldier_AAR_MTP", "Soldier AAR", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AMG_MTP = ["CUP_B_BAF_Soldier_AMG_MTP", "Soldier AMG", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AAT_MTP = ["CUP_B_BAF_Soldier_AAT_MTP", "Soldier AAT", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AHAT_MTP = ["CUP_B_BAF_Soldier_AHAT_MTP", "Soldier AHAT", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AAA_MTP = ["CUP_B_BAF_Soldier_AAA_MTP", "Soldier AAA", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
//**// LEVEL 2
Zen_RTS_Asset_West_CUP_B_BAF_Officer_MTP = ["CUP_B_BAF_Officer_MTP", "Officer", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_SL_MTP = ["CUP_B_BAF_Soldier_SL_MTP", "Rifleman SL", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_TL_MTP = ["CUP_B_BAF_Soldier_TL_MTP", "Rifleman TL", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AR_MTP = ["CUP_B_BAF_Soldier_AR_MTP", "Rifleman AR", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_MG_MTP = ["CUP_B_BAF_Soldier_MG_MTP", "Rifleman MG", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AT_MTP = ["CUP_B_BAF_Soldier_AT_MTP", "Rifleman AT", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_HAT_MTP = ["CUP_B_BAF_Soldier_HAT_MTP", "Rifleman HAT", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_AA_MTP = ["CUP_B_BAF_Soldier_AA_MTP", "Rifleman AA", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_Night_MTP = ["CUP_B_BAF_Soldier_Night_MTP", "Soldier Night", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_scout_MTP = ["CUP_B_BAF_Soldier_scout_MTP", "scout", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
//**// LEVEL 3
Zen_RTS_Asset_West_CUP_B_BAF_Spotter_MTP = ["CUP_B_BAF_Spotter_MTP", "Spotter", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Spotter_L85TWS_MTP = ["CUP_B_BAF_Spotter_L85TWS_MTP", "Spotter L85TWS", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Pilot_MTP  = ["CUP_B_BAF_Pilot_MTP", "Pilot", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Crew_MTP = ["CUP_B_BAF_Crew_MTP", "Crew", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate; 
Zen_RTS_Asset_West_CUP_B_BAF_Medic_MTP  = ["CUP_B_BAF_Medic_MTP", "Medic", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Soldier_JTAC_MTP  = ["CUP_B_BAF_Soldier_JTAC_MTP", "Soldier JTAC", "Cost: 150, Time: 20,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Engineer_MTP = ["CUP_B_BAF_Engineer_MTP", "Engineer", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Sniper_MTP = ["CUP_B_BAF_Sniper_MTP", "Sniper MTP", "Cost: 350, Time: 15,"] call Zen_RTS_StrategicAssetCreate; 
Zen_RTS_Asset_West_CUP_B_BAF_Sniper_AS50_MTP  = ["CUP_B_BAF_Sniper_AS50_MTP", "Sniper AS50 MTP", "Cost: 150, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_CUP_B_BAF_Sniper_AS50_TWS_MTP = ["UP_B_BAF_Sniper_AS50_TWS_MTP", "Sniper AS50 TWS", "Cost: 150, Time: 20,"] call Zen_RTS_StrategicAssetCreate;

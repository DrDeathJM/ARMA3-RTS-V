/////////////////////////
// Air Factory
/////////////////////////

#define AIR_CONSTRUCTOR(N, T, U) \
    N = { \
        diag_log (#N + " asset constructor called"); \
        diag_log _this; \
        _buildingObjData = _this select 0; \
        _assetData = _this select 1; \
        _assetStrRaw = _assetData select 3; \
        _referenceUnit = _this select 2; \
        _crewCount = _this select 3; \
        _phi = 0; \
        _theta = 0; \
        _building = _buildingObjData select 2; \
        ZEN_RTS_STRATEGIC_ASSET_PLACEMENT() \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
        _vehicle = [_pos, T, 0, getDir _building + _theta, true]  call Zen_SpawnVehicle; \
        ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
        if (_crewCount > 0) then { \
            _crewGroup = [_vehicle, ([U, 0, (_crewCount - 1) min ((count U) - 1)] call Zen_ArrayGetIndexedSlice)] call Zen_SpawnGroup; \
            0 = [_crewGroup, "crew"] call Zen_SetAISkill; \
            0 = [_crewGroup, _vehicle, "All"] call Zen_MoveInVehicle; \
            0 = [_crewGroup, _referenceUnit] spawn { \
                _crewGroup = _this select 0; \
                _referenceUnit = _this select 1; \
                sleep 1; \
                (units _crewGroup) join _referenceUnit; \
                sleep 1; \
                {doStop _x;} forEach (units _crewGroup); \
            }; \
        }; \
    };

#define CREW_UNITS ["CUP_B_CZ_Pilot", "CUP_B_CZ_Medic_DES"]
AIR_CONSTRUCTOR(CUP_B_UH1Y_MEV_F, "CUP_B_UH1Y_MEV_F", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_UH1Y_UNA_F, "CUP_B_UH1Y_UNA_F", CREW_UNITS)

#define CREW_UNITS ["CUP_B_CDF_Pilot", "CUP_B_CDF_Crew"]
AIR_CONSTRUCTOR(CUP_B_UH60L_US, "CUP_B_UH60L_US", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_UH60M_US, "CUP_B_UH60M_US", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH1Z, "CUP_B_AH1Z", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH1Z_14RndHydrax, "CUP_B_AH1Z_14RndHydrax", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH1Z_AT, "CUP_B_AH1Z_AT", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH1_AT_BAF, "CUP_B_AH1_AT_BAF", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH1_MR_BAF, "CUP_B_AH1_MR_BAF", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH64D_AT_USA, "CUP_B_AH64D_AT_USA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH1_BAF, "CUP_B_AH1_BAF", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH1_ES_BAF, "CUP_B_AH1_ES_BAF", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH1_NO_BAF, "CUP_B_AH1_NO_BAF", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH64D_ES_USA, "CUP_B_AH64D_ES_USA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH64D_MR_USA, "CUP_B_AH64D_MR_USA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AH64D_USA, "CUP_B_AH64D_USA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AW159_Armed_BAF, "CUP_B_AW159_Armed_BAF", CREW_UNITS)

#define CREW_UNITS ["CUP_B_CDF_Pilot", "CUP_B_CDF_Crew", "CUP_B_CDF_Crew", "CUP_B_CDF_Crew"]
AIR_CONSTRUCTOR(CUP_B_UH1Y_GUNSHIP_F, "CUP_B_UH1Y_GUNSHIP_F", CREW_UNITS)

#define CREW_UNITS ["CUP_B_US_Pilot"]
AIR_CONSTRUCTOR(CUP_B_MV22_USMC, "CUP_B_MV22_USMC", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_A10_CAS_USA, "CUP_B_A10_CAS_USA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_A10_AT_USA, "CUP_B_A10_AT_USA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AV8B_LGB, "CUP_B_AV8B_LGB", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AV8B_Hydra19, "CUP_B_AV8B_Hydra19", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AV8B_Heavy, "CUP_B_AV8B_Heavy", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AV8B_FFAR_7, "CUP_B_AV8B_FFAR_7", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AV8B_FFAR_19, "CUP_B_AV8B_FFAR_19", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AV8B_Deepstrike, "CUP_B_AV8B_Deepstrike", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_B_AV8B, "CUP_B_AV8B", CREW_UNITS)

/////////////////////////
// Barracks
/////////////////////////

#define INFANTRY_CONSTRUCTOR(N, T, S) \
    N = { \
        diag_log (#N + " asset constructor called"); \
        diag_log _this; \
        _buildingObjData = (_this select 0); \
        _assetData = _this select 1; \
        _referenceUnit = _this select 2; \
        _assetStrRaw = _assetData select 3; \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        if (alive (_buildingObjData select 2)) then { \
            ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
            _group = [([(_buildingObjData select 2), 10 + random 10, random 360] call Zen_ExtendPosition), T] call Zen_SpawnGroup; \
            0 = [_group, S] call Zen_SetAISkill; \
            (units _group) join _referenceUnit; \
        }; \
    };

INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_MTP, "CUP_B_BAF_Soldier_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_GL_MTP, "CUP_B_BAF_Soldier_GL_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_Marksman_MTP, "CUP_B_BAF_Soldier_Marksman_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_Light_MTP, "CUP_B_BAF_Soldier_Light_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_Backpack_MTP, "CUP_B_BAF_Soldier_Backpack_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_AAR_MTP, "CUP_B_BAF_Soldier_AAR_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_AMG_MTP, "CUP_B_BAF_Soldier_AMG_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_AAT_MTP, "CUP_B_BAF_Soldier_AAT_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_AHAT_MTP, "CUP_B_BAF_Soldier_AHAT_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_AAA_MTP, "CUP_B_BAF_Soldier_AAA_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Officer_MTP, "CUP_B_BAF_Officer_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_SL_MTP, "CUP_B_BAF_Soldier_SL_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_TL_MTP, "CUP_B_BAF_Soldier_TL_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_AR_MTP, "CUP_B_BAF_Soldier_AR_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_MG_MTP, "CUP_B_BAF_Soldier_MG_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_AT_MTP, "CUP_B_BAF_Soldier_AT_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_HAT_MTP, "CUP_B_BAF_Soldier_HAT_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_AA_MTP, "CUP_B_BAF_Soldier_AA_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_Night_MTP, "CUP_B_BAF_Soldier_Night_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_scout_MTP, "CUP_B_BAF_Soldier_scout_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Spotter_MTP, "CUP_B_BAF_Spotter_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Spotter_L85TWS_MTP, "CUP_B_BAF_Spotter_L85TWS_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Pilot_MTP, "CUP_B_BAF_Pilot_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Crew_MTP, "CUP_B_BAF_Crew_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Medic_MTP, "CUP_B_BAF_Medic_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Soldier_JTAC_MTP, "CUP_B_BAF_Soldier_JTAC_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Engineer_MTP, "CUP_B_BAF_Engineer_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Sniper_MTP, "CUP_B_BAF_Sniper_MTP", "infantry")
INFANTRY_CONSTRUCTOR(CUP_B_BAF_Sniper_AS50_MTP, "CUP_B_BAF_Sniper_AS50_MTP", "infantry")
INFANTRY_CONSTRUCTOR(UP_B_BAF_Sniper_AS50_TWS_MTP, "UP_B_BAF_Sniper_AS50_TWS_MTP", "infantry")

/////////////////////////
// CJ
/////////////////////////

#define FORT_CONSTRUCTOR(N, T) \
    N = { \
        diag_log ("West " + T + " asset constructor called"); \
        diag_log _this; \
        _buildingObjData = _this select 0; \
        _assetData = _this select 1; \
        _spawnPos = _this select 3; \
        _assetStrRaw = _assetData select 3; \
        _building = _buildingObjData select 2; \
        _referenceUnit = driver (_buildingObjData select 2); \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
        _vehicle = [_spawnPos, T, 0, getDir _building, false] call Zen_SpawnVehicle; \
        ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
    };

FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetMG, "B_HMG_01_high_F")
FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetLAND_RAZORWIRE_F, "LAND_RAZORWIRE_F")
FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetLAND_BAGBUNKER_TOWER_F, "Land_BAGBUNKER_TOWER_F")
FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetLAND_BAGFENCE_LONG_F, "Land_BagFence_Long_F")
FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetLAND_CARGO_PATROL_V1_F, "LAND_CARGO_PATROL_V1_F")
FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetB_SLINGLOAD_01_MEDEVAC_F, "B_SLINGLOAD_01_MEDEVAC_F")
FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetB_SLINGLOAD_01_FUEL_F, "B_SLINGLOAD_01_FUEL_F")
FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetBox_NATO_WpsSpecial_F, "Box_NATO_WpsSpecial_F")
//FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetB_Slingload_01_Ammo_F, "B_Slingload_01_Ammo_F")
//FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetB_Slingload_01_Repair_F, "B_Slingload_01_Repair_F")
FORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_Land_BagFence_Corner_F, "Land_BagFence_Corner_F")
FORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_Land_CncWall4_F, "Land_CncWall4_F")

/////////////////////////
// HQ
/////////////////////////

Zen_RTS_F_West_Tech_Enemy = {
    diag_log "Build enemy East asset by West called";

    Zen_RTS_TechFlag_West_BuildEnemy = true;
    // publicVariable "Zen_RTS_TechFlag_West_BuildEnemy";

    _buildingData = _this select 0;
    _buildingObjID = _buildingData select 1;

    _dataLocal = [_buildingObjID] call Zen_RTS_StrategicBuildingObjectGetDataLocal;
    _assets = _dataLocal select 1;
    0 = [_assets, Zen_RTS_Asset_Tech_West_Enemy] call Zen_ArrayRemoveValue;

    {
        _typeData = [_x] call Zen_RTS_StrategicBuildingTypeGetData;

        _indexes = [Zen_RTS_Strategic_Building_Objects_Global, _x, 0] call Zen_ArrayGetNestedIndex;
        _objData = Zen_RTS_Strategic_Building_Objects_Global select (_indexes select 0);

        _level = _objData select 3;
        for "_i" from 0 to _level do {
            [_objData] call (missionNamespace getVariable ((_typeData select 3) select _i));
        };
    } forEach (RTS_Used_Building_Types select 0);
};

#define UPGRADE_CONSTRUCTOR(N, B, A) \
    N = { \
        diag_log ("upgrade " + #N + " called"); \
        ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(B, _ID) \
        _buildingDataHQ = _this select 0; \
        _assetData = _this select 1; \
        _assetStrRaw = _assetData select 3; \
        _buildingDataOther = [B, true] call Zen_RTS_StrategicBuildingObjectGetDataGlobal; \
        if (count _buildingDataOther == 0) exitWith { \
            diag_log ("upgrade " + #N + " type has no existing objects  " + str _this + "  "+ str time); \
        }; \
        _typeDataOther = [(_buildingDataOther select 0)] call Zen_RTS_StrategicBuildingTypeGetData; \
        _level = _buildingDataOther select 3; \
        _maxLevel = count (_typeDataOther select 3); \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        if ((_level + 1) == _maxLevel) then { \
            _assets = _buildingDataHQ select 4; \
            0 = [_assets, A] call Zen_ArrayRemoveValue; \
        }; \
        ZEN_RTS_STRATEGIC_BUILDING_UPGRADE_MESSAGE() \
        0 = [(_buildingDataOther select 1)] call Zen_RTS_StrategicBuildingUpgrade; \
    };

UPGRADE_CONSTRUCTOR(Zen_RTS_F_West_Tech_Upgrade_TankFactory, Zen_RTS_BuildingType_West_TankFactory, Zen_RTS_Asset_Tech_West_Upgrade_TankFactory)
UPGRADE_CONSTRUCTOR(Zen_RTS_F_West_Tech_Upgrade_Barracks, Zen_RTS_BuildingType_West_Barracks, Zen_RTS_Asset_Tech_West_Upgrade_Barracks)
UPGRADE_CONSTRUCTOR(Zen_RTS_F_West_Tech_Upgrade_Radar, Zen_RTS_BuildingType_West_Radar, Zen_RTS_Asset_Tech_West_Upgrade_Radar)
UPGRADE_CONSTRUCTOR(Zen_RTS_F_West_Tech_Upgrade_AirFactory, Zen_RTS_BuildingType_West_AirFactory, Zen_RTS_Asset_Tech_West_Upgrade_AirFactory)
UPGRADE_CONSTRUCTOR(Zen_RTS_F_West_Tech_Upgrade_NavalFactory, Zen_RTS_BuildingType_West_NavalFactory, Zen_RTS_Asset_Tech_West_Upgrade_NavalFactory)
UPGRADE_CONSTRUCTOR(Zen_RTS_F_West_Tech_Upgrade_SupportFactory, Zen_RTS_BuildingType_West_SupportFactory, Zen_RTS_Asset_Tech_West_Upgrade_SupportFactory)

/////////////////////////
// Naval Factory
/////////////////////////

#define SHIP_CONSTRUCTOR(N, T, U) \
    N = { \
        diag_log ("West " + T + " asset constructor called"); \
        diag_log _this; \
        _buildingObjData = _this select 0; \
        _assetData = _this select 1; \
        _assetStrRaw = _assetData select 3; \
        _referenceUnit = _this select 2; \
        _crewCount = _this select 3; \
        _phi = 0; \
        _theta = 0; \
        _building = _buildingObjData select 2; \
        _pos = [_building, [10, 30], 0, 2] call Zen_FindGroundPosition; \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
        _vehicle = [_pos, T, 0, getDir _building + _theta, false]  call Zen_SpawnVehicle; \
        ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
        if (_crewCount > 0) then { \
            _crewGroup = [_vehicle, ([U, 0, _crewCount - 1] call Zen_ArrayGetIndexedSlice)] call Zen_SpawnGroup; \
            0 = [_crewGroup, "crew"] call Zen_SetAISkill; \
            0 = [_crewGroup, _vehicle, "All"] call Zen_MoveInVehicle; \
            0 = [_crewGroup, _referenceUnit] spawn { \
                _crewGroup = _this select 0; \
                _referenceUnit = _this select 1; \
                sleep 1; \
                (units _crewGroup) join _referenceUnit; \
                sleep 1; \
                {doStop _x;} forEach (units _crewGroup); \
            }; \
        }; \
    };

#define CREW_UNITS ["CUP_B_BAF_Officer_MTP", "CUP_B_BAF_Engineer_MTP","CUP_B_BAF_Officer_MTP", "CUP_B_BAF_Engineer_MTP"]
SHIP_CONSTRUCTOR(Zen_RTS_F_West_AssetGunBoat, "B_Boat_Armed_01_minigun_F", CREW_UNITS)

#define CREW_UNITS ["CUP_B_BAF_Officer_MTP","CUP_B_BAF_Officer_MTP", "CUP_B_BAF_Engineer_MTP","CUP_B_BAF_Officer_MTP", "CUP_B_BAF_Engineer_MTP"]
SHIP_CONSTRUCTOR(Zen_RTS_F_West_AssetZodiac, "B_Boat_Transport_01_F", CREW_UNITS)

/////////////////////////
// Radar
/////////////////////////

/////////////////////////
// Recycle
/////////////////////////

Zen_RTS_F_West_Repairer = {
    diag_log ("Zen_RTS_F_West_Repairer asset constructor called");
    diag_log _this;
    _buildingObjData = _this select 0;
    _assetData = _this select 1;
    _referenceUnit = _this select 2;
    _assetStrRaw = _assetData select 3;
    sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart));
    if (alive (_buildingObjData select 2)) then {
        ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
        _group = [(_buildingObjData select 2), "CUP_B_BAF_Engineer_MTP"] call Zen_SpawnGroup;
        0 = [_group, "crew"] call Zen_SetAISkill;
        removeAllWeapons (leader _group);
        (leader _group) setPosATL ([(_buildingObjData select 2), 5 + random 5, random 360] call Zen_ExtendPosition);
        _group setBehaviour "careless";
        (RTS_Worker_Repair_Queue select 0) pushBack [(leader _group), false, objNull];
    };
};

Zen_RTS_F_West_Recycler = {
    diag_log ("Zen_RTS_F_West_Repairer asset constructor called");
    diag_log _this;
    _buildingObjData = _this select 0;
    _assetData = _this select 1;
    _referenceUnit = _this select 2;
    _assetStrRaw = _assetData select 3;
    sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart));
    if (alive (_buildingObjData select 2)) then {
        ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
        _group = [(_buildingObjData select 2), "CUP_B_BAF_Engineer_MTP"] call Zen_SpawnGroup;
        _vehicleID = [Zen_RTS_BuildingType_West_CJ, [[(_buildingObjData select 2), 10, random 360] call Zen_ExtendPosition, 0]] call Zen_RTS_StrategicBuildingInvoke;

        (leader _group) setPosATL ([(_buildingObjData select 2), 5 + random 5, random 360] call Zen_ExtendPosition);
        0 = [_group, "crew"] call Zen_SetAISkill;
        removeAllWeapons (leader _group);
        _group setBehaviour "careless";

        _CJ = ([_vehicleID] call Zen_RTS_StrategicBuildingObjectGetDataGlobal) select 2;
        _CJ setVariable ["Zen_RTS_StrategicIsAIOwned", true, true];
        _CJ setVariable ["Zen_RTS_StrategicIsAIAssigned", true, true];
        0 = [_group, _CJ, "all"] call Zen_MoveInVehicle;

        (RTS_Worker_Recycle_Queue select 0) pushBack [(leader _group), false, _CJ];
    };
};

/////////////////////////
// Support Factory
/////////////////////////

#define SUPPORT_CONSTRUCTOR(N, T, U) \
    N = { \
        diag_log ("West " + T + " asset constructor called"); \
        diag_log _this; \
        _buildingObjData = _this select 0; \
        _assetData = _this select 1; \
        _assetStrRaw = _assetData select 3; \
        _referenceUnit = _this select 2; \
        _crewCount = _this select 3; \
        _phi = 0; \
        _theta = 0; \
        _building = _buildingObjData select 2; \
        ZEN_RTS_STRATEGIC_ASSET_PLACEMENT() \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
        _vehicle = [_pos, T, 0, getDir _building + _theta, true]  call Zen_SpawnVehicle; \
        ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
        if (_crewCount > 0) then { \
            _crewGroup = [_vehicle, ([U, 0, (_crewCount - 1) min ((count U) - 1)] call Zen_ArrayGetIndexedSlice)] call Zen_SpawnGroup; \
            0 = [_crewGroup, "crew"] call Zen_SetAISkill; \
            0 = [_crewGroup, _vehicle, "All"] call Zen_MoveInVehicle; \
            0 = [_crewGroup, _referenceUnit] spawn { \
                _crewGroup = _this select 0; \
                _referenceUnit = _this select 1; \
                sleep 1; \
                (units _crewGroup) join _referenceUnit; \
                sleep 1; \
                {doStop _x;} forEach (units _crewGroup); \
            }; \
        }; \
    };

#define CREW_UNITS ["CUP_B_BAF_Officer_MTP"]
SUPPORT_CONSTRUCTOR(CUP_B_Ural_Refuel_CDF, "CUP_B_Ural_Refuel_CDF", CREW_UNITS)
SUPPORT_CONSTRUCTOR(CUP_B_Ural_Repair_CDF, "CUP_B_Ural_Repair_CDF", CREW_UNITS)
SUPPORT_CONSTRUCTOR(CUP_B_Ural_Reammo_CDF, "CUP_B_Ural_Reammo_CDF", CREW_UNITS)

#define CREW_UNITS ["CUP_B_BAF_Officer_MTP", "CUP_B_BAF_Officer_MTP", "CUP_B_BAF_Crew_MTP"]
SUPPORT_CONSTRUCTOR(CUP_B_M270_HE_USMC, "CUP_B_M270_HE_USMC", CREW_UNITS)
SUPPORT_CONSTRUCTOR(CUP_B_M270_DPICM_USMC, "CUP_B_M270_DPICM_USMC", CREW_UNITS)
SUPPORT_CONSTRUCTOR(CUP_B_M270_HE_USA, "CUP_B_M270_HE_USA", CREW_UNITS)
SUPPORT_CONSTRUCTOR(CUP_B_M270_DPICM_USA, "CUP_B_M270_DPICM_USA", CREW_UNITS)

/////////////////////////
// Tank Factory
/////////////////////////

#define VEHCILE_CONSTRUCTOR(N, T, U) \
    N = { \
        diag_log ("West " + T + " asset constructor called"); \
        diag_log _this; \
        _buildingObjData = _this select 0; \
        _assetData = _this select 1; \
        _assetStrRaw = _assetData select 3; \
        _referenceUnit = _this select 2; \
        _crewCount = _this select 3; \
        _phi = 0; \
        _theta = 0; \
        _building = _buildingObjData select 2; \
        ZEN_RTS_STRATEGIC_ASSET_PLACEMENT() \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
        _vehicle = [_pos, T, 0, getDir _building + _theta, true] call Zen_SpawnVehicle; \
        ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
        if (_crewCount > 0) then { \
            _crewGroup = [_vehicle, ([U, 0, _crewCount - 1] call Zen_ArrayGetIndexedSlice)] call Zen_SpawnGroup; \
            0 = [_crewGroup, "crew"] call Zen_SetAISkill; \
            0 = [_crewGroup, _vehicle, "All"] call Zen_MoveInVehicle; \
            0 = [_crewGroup, _referenceUnit] spawn { \
                _crewGroup = _this select 0; \
                _referenceUnit = _this select 1; \
                sleep 1; \
                (units _crewGroup) join _referenceUnit; \
                sleep 1; \
                {doStop _x;} forEach (units _crewGroup); \
            }; \
        }; \
        if (T in ["rhsusf_m1025_w_s_m2", "rhsusf_m113d_usarmy", "RHS_M2A3_BUSKIII", "m1a2sep1tuskiid_usarmy"]) then { \
            ZEN_FMW_MP_REAll("FNC_AUTOTANK", _vehicle, call) \
        }; \
    };

#define CREW_UNITS ["CUP_B_BAF_Officer_MTP"]
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_Unarmed_USA, "CUP_B_HMMWV_Unarmed_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_UAZ_Open_CDF, "CUP_B_UAZ_Open_CDF", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_Transport_USA, "CUP_B_HMMWV_Transport_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_Dingo_Des, "CUP_B_Dingo_Des", CREW_UNITS)

#define CREW_UNITS ["CUP_B_BAF_Officer_MTP", "CUP_B_BAF_Crew_MTP"]
VEHCILE_CONSTRUCTOR(CUP_LR_MG_Base, "CUP_LR_MG_Base", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_LR_Special_Base, "CUP_LR_Special_Base", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_LR_SPG9_Base, "CUP_LR_SPG9_Base", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_Dingo_Wdl, "CUP_B_Dingo_Wdl", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_MK19_USA, "CUP_B_HMMWV_MK19_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_UAZ_AGS30_CDF, "CUP_B_UAZ_AGS30_CDF", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_TOW_USA, "CUP_B_HMMWV_TOW_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_BM21_CDF, "CUP_B_BM21_CDF", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_UAZ_SPG9_CDF, "CUP_B_UAZ_SPG9_CDF", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_Avenger_USA, "CUP_B_HMMWV_Avenger_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_M2_GPK_USA, "CUP_B_HMMWV_M2_GPK_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_Avenger_USMC, "CUP_B_HMMWV_Avenger_USMC", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_SOV_USA, "CUP_B_HMMWV_SOV_USA", CREW_UNITS)

#define CREW_UNITS ["CUP_B_BAF_Medic_MTP", "CUP_B_BAF_Medic_MTP"]
VEHCILE_CONSTRUCTOR(CUP_B_M113_Med_USA, "CUP_B_M113_Med_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_Ambulance_USA, "CUP_B_HMMWV_Ambulance_USA", CREW_UNITS)

#define CREW_UNITS ["CUP_B_BAF_Officer_MTP", "CUP_B_BAF_Crew_MTP", "CUP_B_BAF_Engineer_MTP"]
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_Crows_M2_USA, "CUP_B_HMMWV_Crows_M2_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_Crows_MK19_USA, "CUP_B_HMMWV_Crows_MK19_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_M113_USA, "CUP_B_M113_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_M163_USA, "CUP_B_M163_USA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_HMMWV_M1114_USMC, "CUP_B_HMMWV_M1114_USMC", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_BAF_Jackal2_GMG_D, "CUP_BAF_Jackal2_GMG_D", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_BAF_Jackal2_L2A1_D, "CUP_BAF_Jackal2_L2A1_D", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_BAF_Jackal2_GMG_W, "CUP_BAF_Jackal2_GMG_W", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_BAF_Jackal2_L2A1_W, "CUP_BAF_Jackal2_L2A1_W", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_LAV25_USMC, "CUP_B_LAV25_USMC", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_LAV25M240_USMC, "CUP_B_LAV25M240_USMC", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_AAV_USMC, "CUP_B_AAV_USMC", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_BRDM2_CDF, "CUP_B_BRDM2_CDF", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_BRDM2_ATGM_CDF, "CUP_B_BRDM2_ATGM_CDF", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_BRDM2_HQ_CDF, "CUP_B_BRDM2_HQ_CDF", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_ZSU23_CDF, "CUP_B_ZSU23_CDF", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_M1A1_Woodland_USMC, "CUP_B_M1A1_Woodland_USMC", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_M1A1_Woodland_US_Army, "CUP_B_M1A1_Woodland_US_Army", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_M1A1_DES_USMC, "CUP_B_M1A1_DES_USMC", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_M1A1_DES_US_Army, "CUP_B_M1A1_DES_US_Army", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_M1A2_TUSK_MG_DES_US_Army, "CUP_B_M1A2_TUSK_MG_DES_US_Army", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_B_M1A2_TUSK_MG_USMC, "CUP_B_M1A2_TUSK_MG_USMC", CREW_UNITS)

Zen_RTS_F_West_Asset_CJ = {
    diag_log ("West CJ asset proxy constructor called");
    diag_log _this;

    _buildingObjData = _this select 0;
    _building = _buildingObjData select 2;
    ZEN_RTS_STRATEGIC_ASSET_PLACEMENT()
    0 = [Zen_RTS_BuildingType_West_CJ, [_pos, 0]] call Zen_RTS_StrategicBuildingInvoke;
};

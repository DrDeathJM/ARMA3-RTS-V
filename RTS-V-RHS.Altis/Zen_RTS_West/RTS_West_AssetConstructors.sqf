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

#define CREW_UNITS ["rhsusf_army_ucp_helipilot", "rhsusf_army_ucp_helipilot"]
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH1Y_UNARMED, "RHS_UH1Y_UNARMED", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH1Y_UNARMED_d , "RHS_UH1Y_UNARMED_d", CREW_UNITS)

#define CREW_UNITS ["rhsusf_usmc_marpat_wd_helipilot", "rhsusf_usmc_marpat_wd_helipilot"]
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_AH64DGrey, "RHS_AH64DGrey", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_AH64D_AA, "RHS_AH64D_AA", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_AH64D_wd_GS, "RHS_AH64D_wd_GS", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_AH64D_GS, "RHS_AH64D_GS", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_AH1Z, "RHS_AH1Z", CREW_UNITS)

#define CREW_UNITS ["rhsusf_army_ucp_helipilot", "rhsusf_army_ucp_helipilot", "rhsusf_army_ucp_helicrew", "rhsusf_army_ucp_helicrew"]
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH1Y, "RHS_UH1Y", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH1Y_FFAR_d, "RHS_UH1Y_FFAR_d", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH1Y_FFAR, "RHS_UH1Y_FFAR", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_CH_47F_10, "RHS_CH_47F_10", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH60M, "RHS_UH60M", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH60M_d, "RHS_UH60M_d", CREW_UNITS)

#define CREW_UNITS ["rhsusf_usmc_marpat_wd_helipilot", "rhsusf_assault_eagleaiii_coy_medic"]
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH60M_MEV2_d, "RHS_UH60M_MEV2_d", CREW_UNITS)

#define CREW_UNITS ["rhsusf_airforce_pilot"]
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_A10, "RHS_A10", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_C130J, "RHS_C130J", CREW_UNITS)

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

INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_rhsusf_army_ocp_rifleman, "rhsusf_army_ocp_rifleman", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_grenadier, "rhsusf_army_ocp_grenadier", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_autorifleman, "rhsusf_army_ocp_autorifleman", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_medic, "rhsusf_army_ocp_medic", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_autoriflemana, "rhsusf_army_ocp_autoriflemana", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_javelin, "rhsusf_army_ocp_javelin", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_aa, "rhsusf_army_ocp_aa", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_sniper, "rhsusf_army_ocp_sniper", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_officer, "rhsusf_army_ocp_officer", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_riflemanat, "rhsusf_army_ocp_riflemanat", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_riflemanl, "rhsusf_army_ocp_riflemanl", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_engineer, "rhsusf_army_ocp_engineer", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_rifleman_m590, "rhsusf_army_ocp_rifleman_m590", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_rifleman_m16, "rhsusf_army_ocp_rifleman_m16", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_rifleman_m4, "rhsusf_army_ocp_rifleman_m4", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_marksman, "rhsusf_army_ocp_marksman", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_Assetrhsusf_army_ocp_fso, "rhsusf_army_ocp_fso", "infantry")

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
// Naval
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

#define CREW_UNITS ["rhsusf_army_ocp_driver", "rhsusf_army_ocp_rifleman"]
SHIP_CONSTRUCTOR(Zen_RTS_F_West_AssetGunBoat, "B_Boat_Armed_01_minigun_F", CREW_UNITS)

#define CREW_UNITS ["rhsusf_army_ocp_driver"]
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
        _group = [(_buildingObjData select 2), "rhsusf_army_ocp_rifleman"] call Zen_SpawnGroup;
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
        _group = [(_buildingObjData select 2), "rhsusf_army_ocp_rifleman"] call Zen_SpawnGroup;
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

#define CREW_UNITS ["rhsusf_army_ocp_driver"]
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M1083A1P2_B_M2_d_Medical_fmtv_usarmy, "rhsusf_M1083A1P2_B_M2_d_Medical_fmtv_usarmy", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy, "rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M1083A1P2_B_M2_d_open_fmtv_usarmy, "rhsusf_M1083A1P2_B_M2_d_open_fmtv_usarmy", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M1083A1P2_B_M2_d_flatbed_fmtv_usarmy, "rhsusf_M1083A1P2_B_M2_d_flatbed_fmtv_usarmy", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy, "rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M978A2_CPK_usarmy_wd, "rhsusf_M978A2_CPK_usarmy_wd", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M978A2_usarmy_wd, "rhsusf_M978A2_usarmy_wd", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M977A2_CPK_usarmy_wd, "rhsusf_M977A2_CPK_usarmy_wd", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M977A2_usarmy_wd, "rhsusf_M977A2_usarmy_wd", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_d_s, "rhsusf_m1025_d_s", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w_s, "rhsusf_m1025_w_s", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_d, "rhsusf_m1025_d", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w, "rhsusf_m1025_w", CREW_UNITS)

#define CREW_UNITS ["rhsusf_army_ocp_driver", "rhsusf_army_ucp_driver", "rhsusf_army_ucp_crewman"]
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m109d_usarmy, "rhsusf_m109d_usarmy", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m109_usarmy, "rhsusf_m109_usarmy", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_d_m2, "rhsusf_m1025_d_m2", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w_m2, "rhsusf_m1025_w_m2", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhs_9k79_K, "rhs_9k79_k", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhs_9k79_B, "rhs_9k79_B", CREW_UNITS)

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

#define CREW_UNITS ["rhsusf_army_ocp_driver", "rhsusf_army_ocp_rifleman"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w_s_m2, "rhsusf_m1025_w_s_m2", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w_mk19, "rhsusf_m1025_w_mk19", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_rg33_usmc_d, "rhsusf_rg33_usmc_d", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_rg33_usmc_wd, "rhsusf_rg33_usmc_wd", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rg33_m2_usmc_wd, "rg33_m2_usmc_wd", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m113d_usarmy, "rhsusf_m113d_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy, "rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy, "rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy", CREW_UNITS)

#define CREW_UNITS ["rhsusf_army_ocp_driver"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m998_w_2dr, "rhsusf_m998_w_2dr", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m998_w_2dr_halftop, "rhsusf_m998_w_2dr_halftop", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w, "rhsusf_m1025_w", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w_s, "rhsusf_m1025_w_s", CREW_UNITS)

#define CREW_UNITS ["rhsusf_army_ocp_driver", "rhsusf_army_ocp_combatcrewman", "rhsusf_army_ocp_crewman"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiid_usarmy, "rhsusf_m1a2sep1tuskiid_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiiwd_usarmy, "rhsusf_m1a2sep1tuskiiwd_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiwd_usarmy, "rhsusf_m1a2sep1tuskiwd_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskid_usarmy, "rhsusf_m1a2sep1tuskid_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1wd_usarmy, "rhsusf_m1a2sep1wd_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1d_usarmy, "rhsusf_m1a2sep1d_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1fep_od, "rhsusf_m1a1fep_od", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1fep_wd, "rhsusf_m1a1fep_wd", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1fep_d, "rhsusf_m1a1fep_d", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1aim_tuski_d, "rhsusf_m1a1aim_tuski_d", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1aim_tuski_wd, "rhsusf_m1a1aim_tuski_wd", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1aimd_usarmy, "rhsusf_m1a1aimd_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1aimwd_usarmy, "rhsusf_m1a1aimwd_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M2A3_BUSKIII, "RHS_M2A3_BUSKIII", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M2A3_BUSKI, "RHS_M2A3_BUSKI", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M2A3, "RHS_M2A3", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M2A2_BUSKI, "RHS_M2A2_BUSKI", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M2A2, "RHS_M2A2", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M6_wd, "RHS_M6_wd", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M6, "RHS_M6", CREW_UNITS)

Zen_RTS_F_West_Asset_CJ = {
    diag_log ("West CJ asset proxy constructor called");
    diag_log _this;

    _buildingObjData = _this select 0;
    _building = _buildingObjData select 2;
    ZEN_RTS_STRATEGIC_ASSET_PLACEMENT()
    0 = [Zen_RTS_BuildingType_West_CJ, [_pos, 0]] call Zen_RTS_StrategicBuildingInvoke;
};

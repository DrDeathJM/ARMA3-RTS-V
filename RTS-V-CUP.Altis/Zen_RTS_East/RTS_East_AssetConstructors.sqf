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


#define CREW_UNITS ["CUP_O_RU_Pilot", "CUP_O_RU_Pilot", "CUP_O_RU_Crew", "CUP_O_RU_Crew", "CUP_O_RU_Crew"]
AIR_CONSTRUCTOR(CUP_O_Mi24_P_RU, "CUP_O_Mi24_P_RU", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_Mi24_V_RU, "CUP_O_Mi24_V_RU", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_Mi17_TK, "CUP_O_Mi17_TK", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_Mi24_D_TK, "CUP_O_Mi24_D_TK", CREW_UNITS)


#define CREW_UNITS ["CUP_O_RU_Pilot", "CUP_O_RU_Crew"]
AIR_CONSTRUCTOR(CUP_O_Mi8_medevac_RU, "CUP_O_Mi8_medevac_RU", CREW_UNITS)
AIR_CONSTRUCTOR(O_Heli_Light_02_F, "O_Heli_Light_02_F", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_Ka50_SLA, "CUP_O_Ka50_SLA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_Ka50_AA_SLA, "CUP_O_Ka50_AA_SLA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_MI6A_TKA, "CUP_O_MI6A_TKA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_MI6T_TKA, "CUP_O_MI6T_TKA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_MI6A_RU, "CUP_O_MI6A_RU", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_MI6T_RU, "CUP_O_MI6T_RU", CREW_UNITS)
AIR_CONSTRUCTOR(O_Heli_Transport_04_covered_F, "O_Heli_Transport_04_covered_F", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_Mi8_MTV3_base, "CUP_Mi8_MTV3_base", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_Mi8_SLA_1, "CUP_O_Mi8_SLA_1", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_Mi8_RU, "CUP_O_Mi8_RU", CREW_UNITS)

#define CREW_UNITS ["CUP_O_RU_Pilot"]
AIR_CONSTRUCTOR(CUP_O_Su25_RU_1, "CUP_O_Su25_RU_1", CREW_UNITS)
AIR_CONSTRUCTOR(O_Heli_Transport_04_bench_F, "O_Heli_Transport_04_bench_F", CREW_UNITS)
AIR_CONSTRUCTOR(O_Heli_Transport_04_medevac_F, "O_Heli_Transport_04_medevac_F", CREW_UNITS)
AIR_CONSTRUCTOR(O_Plane_CAS_02_F, "O_Plane_CAS_02_F", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_Su25_TKA, "CUP_O_Su25_TKA", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_Su25_RU_2, "CUP_O_Su25_RU_2", CREW_UNITS)
AIR_CONSTRUCTOR(CUP_O_Su25_RU_3, "CUP_O_Su25_RU_3", CREW_UNITS)

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

INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier, "CUP_O_RU_Soldier", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_INS_Soldier_AR, "CUP_O_INS_Soldier_AR", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_INS_Soldier_MG, "CUP_O_INS_Soldier_MG", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_INS_Soldier_AT, "CUP_O_INS_Soldier_AT", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_INS_Soldier_AA, "CUP_O_INS_Soldier_AA", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_INS_Soldier_Exp, "CUP_O_INS_Soldier_Exp", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_INS_Saboteur, "CUP_O_INS_Saboteur", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_Saiga, "CUP_O_RU_Soldier_Saiga", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_GL, "CUP_O_RU_Soldier_GL", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_Light, "CUP_O_RU_Soldier_Light", "infantry") 
INFANTRY_CONSTRUCTOR(CUP_O_RU_Officer, "CUP_O_RU_Officer", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_SL, "CUP_O_RU_Soldier_SL", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_TL, "CUP_O_RU_Soldier_TL", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_MG, "CUP_O_RU_Soldier_MG", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_AR, "CUP_O_RU_Soldier_AR", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_LAT, "CUP_O_RU_Soldier_LAT", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_HAT, "CUP_O_RU_Soldier_HAT", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_AT, "CUP_O_RU_Soldier_AT", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_AA, "CUP_O_RU_Soldier_AA", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_TK_INS_Soldier_GL, "CUP_O_TK_INS_Soldier_GL", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Medic, "CUP_O_RU_Medic", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Pilot, "CUP_O_RU_Pilot", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Crew, "CUP_O_RU_Crew", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Spotter, "CUP_O_RU_Spotter", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Sniper, "CUP_O_RU_Sniper", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Sniper_KSVK, "CUP_O_RU_Sniper_KSVK", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_INS_Sniper, "CUP_O_INS_Sniper", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_INS_Soldier_AK74, "CUP_O_INS_Soldier_AK74", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_INS_Soldier_GL, "CUP_O_INS_Soldier_GL", "infantry")
INFANTRY_CONSTRUCTOR(CUP_O_RU_Soldier_Marksman, "CUP_O_RU_Soldier_Marksman", "infantry")

/////////////////////////
// CJ
/////////////////////////

#define FORT_CONSTRUCTOR(N, T) \
    N = { \
        diag_log ("East " + T + " asset constructor called"); \
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

FORT_CONSTRUCTOR(Zen_RTS_F_East_AssetMG, "O_HMG_01_high_F")
FORT_CONSTRUCTOR(Zen_RTS_F_East_AssetLAND_RAZORWIRE_F, "LAND_RAZORWIRE_F")
FORT_CONSTRUCTOR(Zen_RTS_F_East_AssetLAND_BAGBUNKER_TOWER_F, "Land_BAGBUNKER_TOWER_F")
FORT_CONSTRUCTOR(Zen_RTS_F_East_AssetLAND_BAGFENCE_LONG_F, "Land_BagFence_Long_F")
FORT_CONSTRUCTOR(Zen_RTS_F_East_AssetLAND_CARGO_PATROL_V1_F, "LAND_CARGO_PATROL_V1_F")
FORT_CONSTRUCTOR(Zen_RTS_F_East_AssetB_SLINGLOAD_01_MEDEVAC_F, "B_SLINGLOAD_01_MEDEVAC_F")
FORT_CONSTRUCTOR(Zen_RTS_F_East_AssetB_SLINGLOAD_01_FUEL_F, "B_SLINGLOAD_01_FUEL_F")
FORT_CONSTRUCTOR(Zen_RTS_F_East_AssetBox_East_WpsSpecial_F, "Box_East_WpsSpecial_F")
//FORT_CONSTRUCTOR(Zen_RTS_F_East_AssetB_Slingload_01_Ammo_F, "B_Slingload_01_Ammo_F")
//FORT_CONSTRUCTOR(Zen_RTS_F_East_AssetB_Slingload_01_Repair_F, "B_Slingload_01_Repair_F")
FORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_Land_BagFence_Corner_F, "Land_BagFence_Corner_F")
FORT_CONSTRUCTOR(Zen_RTS_F_West_Asset_Land_CncWall4_F, "Land_CncWall4_F")

/////////////////////////
// HQ
/////////////////////////

Zen_RTS_F_East_Tech_Enemy = {
    diag_log "Build enemy East asset by East called";

    Zen_RTS_TechFlag_East_BuildEnemy = true;
    // publicVariable "Zen_RTS_TechFlag_East_BuildEnemy";

    _buildingObjData = _this select 0;
    _buildingObjID = _buildingObjData select 1;

    _dataLocal = [_buildingObjID] call Zen_RTS_StrategicBuildingObjectGetDataLocal;
    _assets = _dataLocal select 1;
    0 = [_assets, Zen_RTS_Asset_Tech_East_Enemy] call Zen_ArrayRemoveValue;

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

UPGRADE_CONSTRUCTOR(Zen_RTS_F_East_Tech_Upgrade_TankFactory, Zen_RTS_BuildingType_East_TankFactory, Zen_RTS_Asset_Tech_East_Upgrade_TankFactory)
UPGRADE_CONSTRUCTOR(Zen_RTS_F_East_Tech_Upgrade_Barracks, Zen_RTS_BuildingType_East_Barracks, Zen_RTS_Asset_Tech_East_Upgrade_Barracks)
UPGRADE_CONSTRUCTOR(Zen_RTS_F_East_Tech_Upgrade_Radar, Zen_RTS_BuildingType_East_Radar, Zen_RTS_Asset_Tech_East_Upgrade_Radar)
UPGRADE_CONSTRUCTOR(Zen_RTS_F_East_Tech_Upgrade_AirFactory, Zen_RTS_BuildingType_East_AirFactory, Zen_RTS_Asset_Tech_East_Upgrade_AirFactory)
UPGRADE_CONSTRUCTOR(Zen_RTS_F_East_Tech_Upgrade_NavalFactory, Zen_RTS_BuildingType_East_NavalFactory, Zen_RTS_Asset_Tech_East_Upgrade_NavalFactory)
UPGRADE_CONSTRUCTOR(Zen_RTS_F_East_Tech_Upgrade_SupportFactory, Zen_RTS_BuildingType_East_SupportFactory, Zen_RTS_Asset_Tech_East_Upgrade_SupportFactory)

/////////////////////////
// Naval Factory
/////////////////////////

#define SHIP_CONSTRUCTOR(N, T, U) \
    N = { \
        diag_log ("East " + T + " asset constructor called"); \
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

#define CREW_UNITS ["rhs_msv_driver_armored", "rhs_msv_rifleman"]
SHIP_CONSTRUCTOR(Zen_RTS_F_East_AssetGunBoat, "O_Boat_Armed_01_hmg_F", CREW_UNITS)

#define CREW_UNITS ["rhs_msv_driver"]
SHIP_CONSTRUCTOR(Zen_RTS_F_East_AssetZodiac, "O_Boat_Transport_01_F", CREW_UNITS)

/////////////////////////
// Radar
/////////////////////////

/////////////////////////
// Recycle
/////////////////////////

Zen_RTS_F_East_Repairer = {
    diag_log ("Zen_RTS_F_East_Repairer asset constructor called");
    diag_log _this;
    _buildingObjData = (_this select 0);
    _assetData = _this select 1;
    _referenceUnit = _this select 2; \
    _assetStrRaw = _assetData select 3;
    sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart));
    if (alive (_buildingObjData select 2)) then {
        ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
        _group = [(_buildingObjData select 2), "C_man_polo_1_F_afro"] call Zen_SpawnGroup;
        0 = [_group, "crew"] call Zen_SetAISkill;
        removeAllWeapons (leader _group);
        (leader _group) setPosATL ([(_buildingObjData select 2), 5 + random 5, random 360] call Zen_ExtendPosition);
        _group setBehaviour "careless";
        (RTS_Worker_Repair_Queue select 1) pushBack [(leader _group), false, objNull];
    };
};

Zen_RTS_F_East_Recycler = {
    diag_log ("Zen_RTS_F_East_Recycler asset constructor called");
    diag_log _this;
    _buildingObjData = (_this select 0);
    _assetData = _this select 1;
    _referenceUnit = _this select 2;
    _assetStrRaw = _assetData select 3;
    sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart));
    if (alive (_buildingObjData select 2)) then {
        ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
        _group = [(_buildingObjData select 2), "C_man_shorts_4_F_afro"] call Zen_SpawnGroup;
        _vehicleID = [Zen_RTS_BuildingType_East_CJ, [[(_buildingObjData select 2), 10, random 360] call Zen_ExtendPosition, 0]] call Zen_RTS_StrategicBuildingInvoke;

        (leader _group) setPosATL ([(_buildingObjData select 2), 5 + random 5, random 360] call Zen_ExtendPosition);
        0 = [_group, "crew"] call Zen_SetAISkill;
        removeAllWeapons (leader _group);
        _group setBehaviour "careless";

        _CJ = ([_vehicleID] call Zen_RTS_StrategicBuildingObjectGetDataGlobal) select 2;
        _CJ setVariable ["Zen_RTS_StrategicIsAIOwned", true, true];
        _CJ setVariable ["Zen_RTS_StrategicIsAIAssigned", true, true];
        0 = [_group, _CJ, "all"] call Zen_MoveInVehicle;

        (RTS_Worker_Recycle_Queue select 1) pushBack [(leader _group), false, _CJ];
    };
};

/////////////////////////
// Support Factory
/////////////////////////

#define SUPPORT_CONSTRUCTOR(N, T, U) \
    N = { \
        diag_log ("East " + T + " asset constructor called"); \
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

#define CREW_UNITS ["rhs_msv_driver"]
SUPPORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_gaz66_ammo_msv, "rhs_gaz66_ammo_msv", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_gaz66_repair_msv, "rhs_gaz66_repair_msv", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Ural_Fuel_MSV_01,"RHS_Ural_Fuel_MSV_01", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_typhoon_vdv, "rhs_typhoon_vdv", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Ural_VDV_01, "RHS_Ural_VDV_01", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_gaz66_r142_vdv, "rhs_gaz66_r142_vdv", CREW_UNITS)

#define CREW_UNITS ["rhs_msv_driver", "rhs_msv_crew", "rhs_msv_crew"]
SUPPORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_BM21_MSV_01, "RHS_BM21_MSV_01", CREW_UNITS)

#define CREW_UNITS ["rhs_vdv_driver_armored", "rhs_vdv_crew_commander", "rhs_vdv_armoredcrew", "rhs_vdv_combatcrew","rhs_vdv_combatcrew"]
SUPPORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_prp3_vdv, "rhs_prp3_vdv", CREW_UNITS)

#define CREW_UNITS ["rhs_vdv_driver_armored", "rhs_vdv_crew_commander", "rhs_vdv_armoredcrew", "rhs_vdv_combatcrew"]
SUPPORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_9k79_K, "rhs_9k79_k", CREW_UNITS)
SUPPORT_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_9k79_B, "rhs_9k79_B", CREW_UNITS)

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
        _vehicle = [_pos, T, 0, getDir _building + _theta, true]  call Zen_SpawnVehicle; \
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
        if (T in ["rhs_bmp3mera_msv"]) then { \
            ZEN_FMW_MP_REAll("FNC_AUTOTANK", _vehicle, call) \
        }; \
    };

#define CREW_UNITS ["CUP_O_RU_Soldier_Saiga"]
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_Unarmed_RU, "CUP_O_UAZ_Unarmed_RU", CREW_UNITS)

#define CREW_UNITS ["CUP_O_RU_Soldier_Saiga", "CUP_O_RU_Crew", "CUP_O_RU_Crew", "CUP_O_RU_Crew"]
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_Unarmed_TKA, "CUP_O_UAZ_Unarmed_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_LR_Transport_TKA, "CUP_O_LR_Transport_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_LR_MG_TKA, "CUP_O_LR_MG_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_LR_SPG9_TKA, "CUP_O_LR_SPG9_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_LR_Transport_TKM, "CUP_O_LR_Transport_TKM", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_LR_MG_TKM, "CUP_O_LR_MG_TKM", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_LR_SPG9_TKM, "CUP_O_LR_SPG9_TKM", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_Datsun_PK, "CUP_O_Datsun_PK", CREW_UNITS)

#define CREW_UNITS ["CUP_O_RU_Soldier_Saiga", "CUP_O_RU_Crew"]
VEHCILE_CONSTRUCTOR(CUP_O_Datsun_PK_Random, "CUP_O_Datsun_PK_Random", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_MG_CHDKZ, "CUP_O_UAZ_MG_CHDKZ", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_AGS30_CHDKZ, "CUP_O_UAZ_AGS30_CHDKZ", CREW_UNITS)

#define CREW_UNITS ["CUP_O_RU_Soldier_Saiga", "CUP_O_RU_Soldier_Saiga", "CUP_O_RU_Crew"]
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_SPG9_CHDKZ, "CUP_O_UAZ_SPG9_CHDKZ", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_Open_RU, "CUP_O_UAZ_Open_RU", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_MG_RU, "CUP_O_UAZ_MG_RU", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_AGS30_RU, "CUP_O_UAZ_AGS30_RU", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_SPG9_RU, "CUP_O_UAZ_SPG9_RU", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_MG_TKA, "CUP_O_UAZ_MG_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_AGS30_TKA, "CUP_O_UAZ_AGS30_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_UAZ_SPG9_TKA, "CUP_O_UAZ_SPG9_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_BTR60_TK, "CUP_O_BTR60_TK", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_BTR90_RU, "CUP_O_BTR90_RU", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_BTR90_HQ_RU, "CUP_O_BTR90_HQ_RU", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_BRDM2_TKA, "CUP_O_BRDM2_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_BRDM2_ATGM_TKA, "CUP_O_BRDM2_ATGM_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_BRDM2_HQ_TKA, "CUP_O_BRDM2_HQ_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(O_APC_Wheeled_02_rcws_F, "O_APC_Wheeled_02_rcws_F", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_T72_TKA, "CUP_O_T72_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_T72_RU, "CUP_O_T72_RU", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_M113_TKA, "CUP_O_M113_TKA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(O_APC_Tracked_02_AA_F, "O_APC_Tracked_02_AA_F", CREW_UNITS)
VEHCILE_CONSTRUCTOR(O_APC_Tracked_02_cannon_F, "O_APC_Tracked_02_cannon_F", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_ZSU23_TK, "CUP_O_ZSU23_TK", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_ZSU23_SLA, "CUP_O_ZSU23_SLA", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_T55_TK, "CUP_O_T55_TK", CREW_UNITS)
VEHCILE_CONSTRUCTOR(O_MBT_02_cannon_F, "O_MBT_02_cannon_F", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_BM21_RU, "CUP_O_BM21_RU", CREW_UNITS)
VEHCILE_CONSTRUCTOR(CUP_O_BM21_TKA, "CUP_O_BM21_TKA", CREW_UNITS)

Zen_RTS_F_East_Asset_CJ = {
    player sideChat str ("East CJ asset proxy constructor called");
    player sideChat str _this;

    _buildingObjData = _this select 0;
    _building = _buildingObjData select 2;
    ZEN_RTS_STRATEGIC_ASSET_PLACEMENT()
    0 = [Zen_RTS_BuildingType_East_CJ, [_pos, 0]] call Zen_RTS_StrategicBuildingInvoke;
};

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

#define CREW_UNITS ["rhs_pilot_transport_heli", "rhs_pilot_transport_heli"]
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_ka60_c, "rhs_ka60_c", CREW_UNITS)

#define CREW_UNITS ["rhs_pilot_transport_heli", "rhs_pilot_transport_heli", "rhs_msv_rifleman", "rhs_msv_rifleman", "rhs_msv_rifleman"]
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8mt_vvs, "RHS_Mi8mt_vvsc", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8mt_Cargo_vvs, "RHS_Mi8mt_Cargo_vvs", CREW_UNITS)

#define CREW_UNITS ["rhs_pilot_combat_heli", "rhs_pilot_combat_heli", "rhs_msv_rifleman", "rhs_msv_rifleman", "rhs_msv_rifleman"]
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8MTV3_vvs, "RHS_Mi8MTV3_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8MTV3_UPK23_vvs, "RHS_Mi8MTV3_UPK23_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8MTV3_FAB_vvs, "RHS_Mi8MTV3_FAB_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8AMT_vvs, "RHS_Mi8AMT_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_vvs, "RHS_Mi8AMTSh_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_UPK23_vvs, "RHS_Mi8AMTSh_UPK23_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_FAB_vvs, "RHS_Mi8AMTSh_FAB_vvs", CREW_UNITS)

#define CREW_UNITS ["rhs_pilot_combat_heli", "rhs_pilot_combat_heli"]
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Ka52_vvs, "RHS_Ka52_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Ka52_UPK23_vvs, "RHS_Ka52_UPK23_vvs", CREW_UNITS)
#define CREW_UNITS ["rhs_pilot"]
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Su25SM_vvs, "RHS_Su25SM_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Su25SM_KH29_vvs, "RHS_Su25SM_KH29_vvs", CREW_UNITS)
#define CREW_UNITS []
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_pchela1t_vvs, "rhs_pchela1t_vvs", CREW_UNITS)

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

INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_rifleman, "rhs_msv_rifleman", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_grenadier, "rhs_msv_grenadier", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_machinegunner, "rhs_msv_machinegunner", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_medic, "rhs_msv_medic", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_marksman, "rhs_msv_marksman", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_at, "rhs_msv_at", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_aa, "rhs_msv_aa", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_officer, "rhs_msv_officer", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_sergeant, "rhs_msv_sergeant", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_junior_sergeant, "rhs_msv_junior_sergeant", "infantry") 
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_engineer, "rhs_msv_engineer", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_LAT, "rhs_msv_LAT", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_RShG2, "rhs_msv_RShG2", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_strelok_rpg_assist, "rhs_msv_strelok_rpg_assist", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_machinegunner_assistant, "rhs_msv_machinegunner_assistant", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_grenadier_rpg, "rhs_msv_grenadier_rpg", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_efreitor, "rhs_msv_efreitor", "infantry")

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

#define CREW_UNITS ["rhs_msv_driver"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_uaz_open_vdv, "rhs_uaz_open_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_gaz66_vdv, "rhs_gaz66_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_uaz_vdv, "rhs_uaz_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_gaz66o_flat_vdv, "rhs_gaz66o_flat_vdv", CREW_UNITS)

#define CREW_UNITS ["rhs_vdv_driver_armored", "rhs_vdv_crew_commander", "rhs_vdv_armoredcrew", "rhs_vdv_combatcrew"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmp1k_vdv, "rhs_bmp1k_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmp1d_vdv, "rhs_bmp1d_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmp1p_vdv, "rhs_bmp1p_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmp2e_vdv, "rhs_bmp2e_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmp2k_vdv, "rhs_bmp2k_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmp2d_vdv, "rhs_bmp2d_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmp3_late_msv, "rhs_bmp3_late_msv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmp3mera_msv, "rhs_bmp3mera_msv", CREW_UNITS)

#define CREW_UNITS ["rhs_msv_driver", "rhs_msv_crew"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_AssetTigr, "rhs_tigr_ffv_msv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_btr60_vmf, "rhs_btr60_vmf", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmp1_vmf, "rhs_bmp1_vmf", CREW_UNITS)

#define CREW_UNITS ["rhs_vdv_driver_armored", "rhs_vdv_officer_armored", "rhs_vdv_crew"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_gaz66_ap2_vdv, "rhs_gaz66_ap2_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_btr60_vmf, "rhs_btr60_vmf", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_btr80_vdv, "rhs_btr80_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_btr70_vdv, "rhs_btr70_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_prp3_vdv, "rhs_prp3_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_brm1k_vdv, "rhs_brm1k_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_btr80a_vdv, "rhs_btr80a_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmd1, "rhs_bmd1", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmd2, "rhs_bmd2", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmd1r, "rhs_bmd1r", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmd1pk, "rhs_bmd1pk", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmd1p, "rhs_bmd1p", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmd1k, "rhs_bmd1k", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmd2k, "rhs_bmd2k", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmd4ma_vdv, "rhs_bmd4ma_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_sprut_vdv, "rhs_sprut_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t72bc_tv, "rhs_t72bc_tv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_zsu234_aa, "rhs_zsu234_aa", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_bmd2m, "rhs_bmd2m", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_tigr_3camo_vmf, "rhs_tigr_3camo_vmf", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_tigr_ffv_vmf, "rhs_tigr_ffv_vmf", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_tigr_ffv_3camo_vmf, "rhs_tigr_ffv_3camo_vmf", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t80b, "rhs_t80b", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t72bd_tv, "rhs_t72bd_tv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t72ba_tv, "rhs_t72ba_tv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t80bk, "rhs_t80bk", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t80bv, "rhs_t80bv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t80bvk, "rhs_t80bvk", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t80, "rhs_t80", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t80a, "rhs_t80a", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t80u, "rhs_t80u", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_t90_tv, "rhs_t90_tv", CREW_UNITS)

Zen_RTS_F_East_Asset_CJ = {
    player sideChat str ("East CJ asset proxy constructor called");
    player sideChat str _this;

    _buildingObjData = _this select 0;
    _building = _buildingObjData select 2;
    ZEN_RTS_STRATEGIC_ASSET_PLACEMENT()
    0 = [Zen_RTS_BuildingType_East_CJ, [_pos, 0]] call Zen_RTS_StrategicBuildingInvoke;
};

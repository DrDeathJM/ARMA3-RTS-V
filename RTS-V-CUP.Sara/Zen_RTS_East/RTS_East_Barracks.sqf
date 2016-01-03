/**
Zen_RTS_Asset_East_CUP_O_INS_Soldier_AK74
Zen_RTS_Asset_East_CUP_O_INS_Soldier_GL
Zen_RTS_Asset_EastCUP_O_RU_Soldier_Marksman
    Level 1:
Zen_RTS_Asset_East_CUP_O_INS_Soldier_AK74, 
Zen_RTS_Asset_East_CUP_O_INS_Soldier_AR, 
Zen_RTS_Asset_East_CUP_O_INS_Soldier_MG, 
Zen_RTS_Asset_East_CUP_O_INS_Soldier_AT, 
Zen_RTS_Asset_East_CUP_O_INS_Soldier_AA, 
Zen_RTS_Asset_East_CUP_O_INS_Soldier_Exp, 
Zen_RTS_Asset_East_CUP_O_INS_Saboteur

    Level 2:
Zen_RTS_Asset_East_CUP_O_RU_Soldier_Saiga, 
Zen_RTS_Asset_East_CUP_O_RU_Soldier_GL, 
Zen_RTS_Asset_East_CUP_O_RU_Soldier_Light, 
Zen_RTS_Asset_East_CUP_O_RU_Officer, 
Zen_RTS_Asset_East_CUP_O_RU_Soldier_SL, 
Zen_RTS_Asset_East_CUP_O_RU_Soldier_TL, 
Zen_RTS_Asset_East_CUP_O_RU_Soldier_MG, 
Zen_RTS_Asset_East_CUP_O_RU_Soldier_AR, 
Zen_RTS_Asset_East_CUP_O_RU_Soldier_LAT, 
Zen_RTS_Asset_East_CUP_O_RU_Soldier_HAT

    Level 3:
Zen_RTS_Asset_East_CUP_O_RU_Soldier_AT, 
Zen_RTS_Asset_East_CUP_O_RU_Soldier_AA, 
Zen_RTS_Asset_East_CUP_O_TK_INS_Soldier_GL, 
Zen_RTS_Asset_East_CUP_O_RU_Medic, 
Zen_RTS_Asset_East_CUP_O_RU_Pilot, 
Zen_RTS_Asset_East_CUP_O_RU_Crew, 
Zen_RTS_Asset_East_CUP_O_RU_Spotter, 
Zen_RTS_Asset_East_CUP_O_RU_Sniper, 
Zen_RTS_Asset_East_CUP_O_RU_Sniper_KSVK, 
Zen_RTS_Asset_East_CUP_O_INS_Sniper	
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_East_BarracksConstructor = {
    diag_log "East barracks constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    // _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_East_CUP_O_INS_Soldier_AK74;
    _assetsToAdd pushBack Zen_RTS_Asset_East_CUP_O_INS_Soldier_GL;
    _assetsToAdd pushBack Zen_RTS_Asset_East_CUP_O_RU_Soldier_Marksman;


    if (Zen_RTS_TechFlag_East_BuildEnemy) then {
        // ... to do 
    };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_East_HQ, _ID)
    if (_ID != "") then {
        0 = [_ID, [Zen_RTS_Asset_Tech_East_Upgrade_Barracks]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("LAND_CARGO_PATROL_V2_F", -2)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_Barracks, east)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3'image='pictures\build_CA.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_East_BarracksDestructor = {
    diag_log "East barracks destructor";

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

#define ASSETS [Zen_RTS_Asset_East_CUP_O_INS_Soldier_AK74, Zen_RTS_Asset_East_CUP_O_INS_Soldier_AR, Zen_RTS_Asset_East_CUP_O_INS_Soldier_MG, Zen_RTS_Asset_East_CUP_O_INS_Soldier_AT, Zen_RTS_Asset_East_CUP_O_INS_Soldier_AA, Zen_RTS_Asset_East_CUP_O_INS_Soldier_Exp, Zen_RTS_Asset_East_CUP_O_INS_Saboteur]
UPGRADE(Zen_RTS_F_East_BarracksUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_CUP_O_RU_Soldier_Saiga, Zen_RTS_Asset_East_CUP_O_RU_Soldier_GL, Zen_RTS_Asset_East_CUP_O_RU_Soldier_Light, Zen_RTS_Asset_East_CUP_O_RU_Officer, Zen_RTS_Asset_East_CUP_O_RU_Soldier_SL, Zen_RTS_Asset_East_CUP_O_RU_Soldier_TL, Zen_RTS_Asset_East_CUP_O_RU_Soldier_MG, Zen_RTS_Asset_East_CUP_O_RU_Soldier_AR, Zen_RTS_Asset_East_CUP_O_RU_Soldier_LAT, Zen_RTS_Asset_East_CUP_O_RU_Soldier_HAT]
UPGRADE(Zen_RTS_F_East_BarracksUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_CUP_O_RU_Soldier_AT, Zen_RTS_Asset_East_CUP_O_RU_Soldier_AA, Zen_RTS_Asset_East_CUP_O_TK_INS_Soldier_GL, Zen_RTS_Asset_East_CUP_O_RU_Medic, Zen_RTS_Asset_East_CUP_O_RU_Pilot, Zen_RTS_Asset_East_CUP_O_RU_Crew, Zen_RTS_Asset_East_CUP_O_RU_Spotter, Zen_RTS_Asset_East_CUP_O_RU_Sniper, Zen_RTS_Asset_East_CUP_O_RU_Sniper_KSVK, Zen_RTS_Asset_East_CUP_O_INS_Sniper]
UPGRADE(Zen_RTS_F_East_BarracksUpgrade03, ASSETS)

Zen_RTS_BuildingType_East_Barracks = ["Zen_RTS_F_East_BarracksConstructor", "Zen_RTS_F_East_BarracksDestructor", ["Zen_RTS_F_East_BarracksUpgrade01", "Zen_RTS_F_East_BarracksUpgrade02", "Zen_RTS_F_East_BarracksUpgrade03"], "Barracks", "Cost: 1000, Time: 10, Picture: pictures\barraks_ca.paa, Classname: LAND_CARGO_PATROL_V2_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack Zen_RTS_BuildingType_East_Barracks;

/////////////////////////////////
// Assets
/////////////////////////////////

//**// LEVEL 0
Zen_RTS_Asset_East_CUP_O_INS_Soldier_AK74 = ["CUP_O_INS_Soldier_AK74", "Rifleman AK74", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_INS_Soldier_GL = ["CUP_O_INS_Soldier_GL", "Rifleman GL", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Soldier_Marksman = ["CUP_O_RU_Soldier_Marksman", "Marksman", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
//**// LEVEL 1
Zen_RTS_Asset_East_CUP_O_RU_Soldier = ["CUP_O_RU_Soldier", "Rifleman", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_INS_Soldier_AR  = ["CUP_O_INS_Soldier_AR", "Rifleman AR", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_INS_Soldier_MG = ["CUP_O_INS_Soldier_MG", "Rifleman MG", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_INS_Soldier_AT = ["CUP_O_INS_Soldier_AT", "Rifleman AT", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_INS_Soldier_AA = ["CUP_O_INS_Soldier_AA", "Rifleman AA", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_INS_Soldier_Exp = ["CUP_O_INS_Soldier_Exp", "Rifleman Exp", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_INS_Saboteur = ["CUP_O_INS_Saboteur", "Saboteur", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
//**// LEVEL 2
Zen_RTS_Asset_East_CUP_O_RU_Soldier_Saiga = ["CUP_O_RU_Soldier_Saiga", "Soldier Saiga", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Soldier_GL = ["CUP_O_RU_Soldier_GL", "Soldier GL", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Soldier_Light = ["CUP_O_RU_Soldier_Light", "Soldier Light", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Officer = ["CUP_O_RU_Officer", "Officer", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Soldier_SL = ["CUP_O_RU_Soldier_SL", "Soldier SL", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Soldier_TL = ["CUP_O_RU_Soldier_TL", "Soldier TL", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Soldier_MG = ["CUP_O_RU_Soldier_MG", "Soldier MG", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Soldier_AR = ["CUP_O_RU_Soldier_AR", "Soldier AR", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Soldier_LAT = ["CUP_O_RU_Soldier_LAT", "Soldier LAT", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Soldier_HAT = ["CUP_O_RU_Soldier_HAT", "Soldier HAT", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
//**// LEVEL 3
Zen_RTS_Asset_East_CUP_O_RU_Soldier_AT = ["CUP_O_RU_Soldier_AT", "Soldier AT", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Soldier_AA = ["CUP_O_RU_Soldier_AA", "Soldier AA", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_TK_INS_Soldier_GL = ["CUP_O_TK_INS_Soldier_GL", "Soldier GL", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Medic = ["CUP_O_RU_Medic", "Medic", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Pilot = ["CUP_O_RU_Pilot", "Pilot", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Crew = ["CUP_O_RU_Crew", "Crew", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Spotter = ["CUP_O_RU_Spotter", "Spotter", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Sniper = ["CUP_O_RU_Sniper", "Sniper", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_RU_Sniper_KSVK = ["CUP_O_RU_Sniper_KSVK", "Sniper KSVK", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_CUP_O_INS_Sniper = ["CUP_O_INS_Sniper", "INS Sniper", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;

/**
    Level 1:
        
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_NavalConstructor = {
    diag_log "West Naval constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_Zodiac;

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
        0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_NavalFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("Land_Nav_Boathouse", -5)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_NavalFactory, West)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3'  
      image='pictures\build_ca.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_West_NavalDestructor = {
    diag_log "West Naval destructor";

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

#define ASSETS [Zen_RTS_Asset_West_GunBoat]
UPGRADE(Zen_RTS_F_West_NavalUpgrade01, ASSETS)

// #define ASSETS []
// UPGRADE(Zen_RTS_F_West_NavalUpgrade02, ASSETS)

Zen_RTS_BuildingType_West_NavalFactory = ["Zen_RTS_F_West_NavalConstructor", "Zen_RTS_F_West_NavalDestructor", ["Zen_RTS_F_West_NavalUpgrade01"], "Naval Factory", "Cost: 2000, Time: 10, Picture: pictures\naval_ca.paa, Classname: Land_Nav_Boathouse,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack  Zen_RTS_BuildingType_West_NavalFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_West_GunBoat = ["Zen_RTS_F_West_AssetGunBoat","Armed Patrol Boat", "Cost: 200, Time: 10, Crew: 4,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_Zodiac = ["Zen_RTS_F_West_AssetZodiac","Zodiac", "Cost: 100, Time: 10, Crew: 5,"] call Zen_RTS_StrategicAssetCreate;

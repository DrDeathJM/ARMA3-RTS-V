//

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_RecyclePlantConstructor = {
    diag_log "West barracks constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_Repairer;
    _assetsToAdd pushBack Zen_RTS_Asset_West_Recycler;

    // if (Zen_RTS_TechFlag_West_BuildEnemy) then {
    // };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    // ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_West_HQ, _ID)
    // if (_ID != "") then {
        // 0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_Barracks]] call Zen_RTS_F_StrategicAddAssetGlobal;
    // };

    BUILDING_VISUALS("LAND_SLUM_HOUSE01_F", -1)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_RecyclePlant, West)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3' image='pictures\build_CA.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_West_RecyclePlantDestructor = {
    diag_log "West Recycle Plant destructor";

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

// #define ASSETS []
// UPGRADE(, ASSETS)

Zen_RTS_BuildingType_West_RecyclePlant = ["Zen_RTS_F_West_RecyclePlantConstructor", "Zen_RTS_F_West_RecyclePlantDestructor", [], "Recycle Plant", "Cost: 1000, Time: 10, Picture: pictures\depot_ca.paa, Classname: LAND_SLUM_HOUSE01_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack Zen_RTS_BuildingType_West_RecyclePlant;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_West_Repairer = ["Zen_RTS_F_West_Repairer", "Repairer", "Cost: 50, Time: 10, Classname: CUP_B_BAF_Engineer_MTP,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_Recycler = ["Zen_RTS_F_West_Recycler", "Recycler", "Cost: 50, Time: 10, Classname: CUP_B_BAF_Engineer_MTP,"] call Zen_RTS_StrategicAssetCreate;

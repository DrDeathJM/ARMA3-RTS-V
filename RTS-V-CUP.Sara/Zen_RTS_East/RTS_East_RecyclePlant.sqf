//

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_East_RecyclePlantConstructor = {
    diag_log "East barracks constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_East_Repairer;
    _assetsToAdd pushBack Zen_RTS_Asset_East_Recycler;

    // if (Zen_RTS_TechFlag_East_BuildEnemy) then {
    // };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    // ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_East_HQ, _ID)
    // if (_ID != "") then {
        // 0 = [_ID, [Zen_RTS_Asset_Tech_East_Upgrade_Barracks]] call Zen_RTS_F_StrategicAddAssetGlobal;
    // };

    BUILDING_VISUALS("LAND_SLUM_HOUSE03_F", -1)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_RecyclePlant, east)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3'image='pictures\build_CA.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_East_RecyclePlantDestructor = {
    diag_log "East Recycle Plant destructor";

    _buildingObjData = _this select 0;
    _level = _buildingObjData select 3;
    diag_log _level;

    _index = [(_buildingObjData select 0), (RTS_Used_Building_Types select 0)] call Zen_ValueFindInArray;
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
        (RTS_Used_Asset_Types select 0) pushBack _x; \
    } forEach _assetsToAdd; \
    publicVariable "RTS_Used_Asset_Types"; \
    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal; \
    (true) \
};

// #define ASSETS []
// UPGRADE(, ASSETS)

Zen_RTS_BuildingType_East_RecyclePlant = ["Zen_RTS_F_East_RecyclePlantConstructor", "Zen_RTS_F_East_RecyclePlantDestructor", [], "Recycle Plant", "Cost: 1000, Time: 10, Picture: pictures\depot_ca.paa, Classname: LAND_SLUM_HOUSE03_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack Zen_RTS_BuildingType_East_RecyclePlant;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_East_Repairer = ["Zen_RTS_F_East_Repairer", "Repairer", "Cost: 50, Time: 10, Classname: C_man_polo_1_F_afro,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_Recycler = ["Zen_RTS_F_East_Recycler", "Recycler", "Cost: 50, Time: 10, Classname: C_man_shorts_4_F_afro,"] call Zen_RTS_StrategicAssetCreate;

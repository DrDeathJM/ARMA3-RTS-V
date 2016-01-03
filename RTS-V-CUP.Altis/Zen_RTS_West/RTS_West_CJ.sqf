/**
    Level 1:
        MG
//*/

#define SWAP_CJ_OWNER(F) \
    (_this select 3) setVariable ["Zen_RTS_StrategicIsAIOwned", F, true]; \
    (_this select 3) setVariable ["Zen_RTS_StrategicIsAIAssigned", false, true];

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_CJConstructor = {
    diag_log "West CJ constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_MG;
    _assetsToAdd pushBack Zen_RTS_Asset_LAND_RAZORWIRE_F;
    _assetsToAdd pushBack Zen_RTS_Asset_LAND_BAGBUNKER_TOWER_F;
    _assetsToAdd pushBack Zen_RTS_Asset_LAND_BAGFENCE_LONG_F;
    _assetsToAdd pushBack Zen_RTS_Asset_LAND_CARGO_PATROL_V1_F;
    _assetsToAdd pushBack Zen_RTS_Asset_B_SLINGLOAD_01_MEDEVAC_F;
    _assetsToAdd pushBack Zen_RTS_Asset_B_SLINGLOAD_01_FUEL_F;
    _assetsToAdd pushBack Zen_RTS_Asset_Box_NATO_WpsSpecial_F;
    _assetsToAdd pushBack Zen_RTS_Asset_Land_BagFence_Corner_F;
    _assetsToAdd pushBack Zen_RTS_Asset_Land_CncWall4_F;

    if (Zen_RTS_TechFlag_West_BuildEnemy) then {
        // ... to do
    };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    // ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_West_HQ, _ID)
    // if (_ID != "") then {
        // 0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_Barracks]] call Zen_RTS_F_StrategicAddAssetGlobal;
    // };

    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;
    _assetStrRaw = _buildingTypeData select 5;

    sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart));
    _vehicle = [_spawnPos, "B_MRAP_01_F"] call Zen_SpawnVehicle;
    _vehicle setVariable ["side", West, true];
    _assetData = _buildingObjData;
    ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH

    // Recycle AI set up
    (RTS_CJ_Repair_Queue select 0) pushBack _vehicle;
    _vehicle setVariable ["Zen_RTS_StrategicIsAIOwned", false, true];
    _vehicle setVariable ["Zen_RTS_StrategicIsAIAssigned", false, true];

    _args = ["addAction", [_vehicle, ["CJ Menu", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "(_this in _target) && !(_target getVariable 'Zen_RTS_StrategicIsAIOwned')"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)

    _args = ["addAction", [_vehicle, ["Give CJ to AI", {SWAP_CJ_OWNER(true)}, _vehicle, 1, false, true, "", "((_this distance2D _target) < 5) && !(_target getVariable 'Zen_RTS_StrategicIsAIOwned') && (alive _target)"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)

    _args = ["addAction", [_vehicle, ["Take CJ from AI", {SWAP_CJ_OWNER(false)}, _vehicle, 1, false, true, "", "((_this distance2D _target) < 5) && (_target getVariable 'Zen_RTS_StrategicIsAIOwned') && (alive _target)"]]];

    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)

    if (_level > 0) then {
        for "_i" from 0 to (_level - 1) do {
            [_buildingObjData] call (missionNamespace getVariable ((_buildingTypeData select 3) select _i));
        };
    };

    (_vehicle)
};

Zen_RTS_F_West_CJDestructor = {
    diag_log "West CJ destructor";

    _buildingObjData = _this select 0;
    // _level = _buildingObjData select 3;
    // diag_log _level;

    // _index = [(_buildingObjData select 0), (RTS_Used_Building_Types select 0)] call Zen_ValueFindInArray;
    // _array = RTS_Building_Type_Levels select 0;
    // _array set [_index, _level];

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
// UPGRADE(Zen_RTS_F_West_CJUpgrade01, ASSETS)

Zen_RTS_BuildingType_West_CJ = ["Zen_RTS_F_West_CJConstructor", "Zen_RTS_F_West_CJDestructor", [], "CJ", "Cost: 1000, Time: 10, picture: pictures\rts_lvs.paa, Classname: B_MRAP_01_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack Zen_RTS_BuildingType_West_CJ;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_West_MG = ["Zen_RTS_F_West_AssetMG", "MG", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_LAND_RAZORWIRE_F= ["Zen_RTS_F_West_AssetLAND_RAZORWIRE_F", "razor wire", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_LAND_BAGBUNKER_TOWER_F= ["Zen_RTS_F_West_AssetLAND_BAGBUNKER_TOWER_F", "bunker", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_LAND_BAGFENCE_LONG_F= ["Zen_RTS_F_West_AssetLAND_BAGFENCE_LONG_F", "fence shelter", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_LAND_CARGO_PATROL_V1_F= ["Zen_RTS_F_West_AssetLAND_CARGO_PATROL_V1_F", "patrol tower", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_B_SLINGLOAD_01_MEDEVAC_F= ["Zen_RTS_F_West_AssetB_SLINGLOAD_01_MEDEVAC_F", "med tent", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_B_SLINGLOAD_01_FUEL_F= ["Zen_RTS_F_West_AssetB_SLINGLOAD_01_FUEL_F", "fuel port", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_Box_NATO_WpsSpecial_F= ["Zen_RTS_F_West_AssetBox_NATO_WpsSpecial_F", "Supply Box [NATO]", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_Land_BagFence_Corner_F= ["Zen_RTS_F_West_Asset_Land_BagFence_Corner_F", "repair port", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_Land_CncWall4_F= ["Zen_RTS_F_West_Asset_Land_CncWall4_F", "repair port", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;

//

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
    _assetsToAdd pushBack Zen_RTS_Asset_West_rhsusf_army_ocp_rifleman;
    _assetsToAdd pushBack Zen_RTS_Asset_West_rhsusf_army_ocp_grenadier;
    _assetsToAdd pushBack Zen_RTS_Asset_West_rhsusf_army_ocp_autoriflemana;
    _assetsToAdd pushBack Zen_RTS_Asset_West_rhsusf_army_ocp_medic;

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

    BUILDING_VISUALS("Land_Cargo_House_V1_F", -1.3)
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

#define ASSETS [Zen_RTS_Asset_West_rhsusf_army_ocp_autorifleman, Zen_RTS_Asset_West_rhsusf_army_ocp_javelin]
UPGRADE(Zen_RTS_F_West_BarracksUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_rhsusf_army_ocp_aa, Zen_RTS_Asset_West_rhsusf_army_ocp_sniper, Zen_RTS_Asset_West_rhsusf_army_ocp_officer, Zen_RTS_Asset_West_rhsusf_army_ocp_riflemanat, Zen_RTS_Asset_West_rhsusf_army_ocp_riflemanl]
UPGRADE(Zen_RTS_F_West_BarracksUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_rhsusf_army_ocp_engineer, Zen_RTS_Asset_West_rhsusf_army_ocp_rifleman_m590,Zen_RTS_Asset_West_rhsusf_army_ocp_rifleman_m16,Zen_RTS_Asset_West_rhsusf_army_ocp_rifleman_m4,Zen_RTS_Asset_West_rhsusf_army_ocp_marksman,Zen_RTS_Asset_West_rhsusf_army_ocp_fso]
UPGRADE(Zen_RTS_F_West_BarracksUpgrade03, ASSETS)

Zen_RTS_BuildingType_West_Barracks = ["Zen_RTS_F_West_BarracksConstructor", "Zen_RTS_F_West_BarracksDestructor", ["Zen_RTS_F_West_BarracksUpgrade01", "Zen_RTS_F_West_BarracksUpgrade02","Zen_RTS_F_West_BarracksUpgrade03"], "Barracks", "Cost: 1000, Time: 10, Picture: pictures\barraks_ca.paa, Classname: Land_Cargo_House_V1_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack Zen_RTS_BuildingType_West_Barracks;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_West_rhsusf_army_ocp_rifleman = ["Zen_RTS_F_West_rhsusf_army_ocp_rifleman", "Rifleman", "Cost: 50, Time: 10, Classname: b_soldier_02_f,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_grenadier = ["Zen_RTS_F_West_Assetrhsusf_army_ocp_grenadier", "Grenadier", "Cost: 100, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_autoriflemana = ["Zen_RTS_F_West_Assetrhsusf_army_ocp_autoriflemana", "Assistant Autorifleman", "Cost: 100, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_medic = ["Zen_RTS_F_West_Assetrhsusf_army_ocp_medic", "medic", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_autorifleman = ["Zen_RTS_F_West_Assetrhsusf_army_ocp_autorifleman", "autorifleman", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_javelin = ["Zen_RTS_F_West_Assetrhsusf_army_ocp_javelin", "Javelin Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_aa = ["Zen_RTS_F_West_Assetrhsusf_army_ocp_aa", "AA Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_sniper= ["Zen_RTS_F_West_Assetrhsusf_army_ocp_sniper", "sniper", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_officer= ["Zen_RTS_F_West_Assetrhsusf_army_ocp_officer", "officer", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_riflemanat= ["Zen_RTS_F_West_Assetrhsusf_army_ocp_riflemanat", "AT Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_riflemanl= ["Zen_RTS_F_West_Assetrhsusf_army_ocp_riflemanl", "l Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_engineer= ["Zen_RTS_F_West_Assetrhsusf_army_ocp_engineer", "engineer", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_rifleman_m590= ["Zen_RTS_F_West_Assetrhsusf_army_ocp_rifleman_m590", "m590-Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_rifleman_m16= ["Zen_RTS_F_West_Assetrhsusf_army_ocp_rifleman_m16", "m16-Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_rifleman_m4= ["Zen_RTS_F_West_Assetrhsusf_army_ocp_rifleman_m4", "m4-Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_marksman= ["Zen_RTS_F_West_Assetrhsusf_army_ocp_marksman", "marksman", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_army_ocp_fso= ["Zen_RTS_F_West_Assetrhsusf_army_ocp_fso", "FSO-Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;

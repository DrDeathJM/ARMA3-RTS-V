//

Zen_RTS_F_East_RadarConstructor = {
    diag_log "East Radar constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;

    _assetsToAdd = [];

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_East_HQ, _ID)
    if (_ID != "") then {
        0 = [_ID, [Zen_RTS_Asset_Tech_East_Upgrade_Radar]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;
    BUILDING_VISUALS("Land_Radar_Small_F", -1)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_Radar, east)

    if (_level > 0) then {
        for "_i" from 0 to (_level - 1) do {
            [_buildingObjData] call (missionNamespace getVariable ((_buildingTypeData select 3) select _i));
        };
    };

    (_building)
};

Zen_RTS_F_East_RadarDestructor = {
    diag_log "East Radar destructor";

    _buildingObjData = _this select 0;
    _level = _buildingObjData select 3;
    diag_log _level;

    _index = [(_buildingObjData select 0), (RTS_Used_Building_Types select 1)] call Zen_ValueFindInArray;
    _array = RTS_Building_Type_Levels select 1;
    _array set [_index, _level];

    (_buildingObjData select 2) setDamage 1;
};

#define ASSETS []
UPGRADE(Zen_RTS_F_East_RadarUpgrade01, ASSETS)

// #define ASSETS []
// UPGRADE(Zen_RTS_F_East_RadarUpgrade02, ASSETS)

Zen_RTS_BuildingType_East_Radar = ["Zen_RTS_F_East_RadarConstructor", "Zen_RTS_F_East_RadarDestructor", ["Zen_RTS_F_East_RadarUpgrade01"], "Radar", "Cost: 2000, Time: 10, Picture: pictures\target1.paa, Classname: Land_Radar_Small_F"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack Zen_RTS_BuildingType_East_Radar;

/**
    Zen_RTS_StrategicCompile
    by Zenophon
    for RTS V

    This is the complete compiler for the Zen RTS Strategic system.
    Run on all machines.
    Usage:
        call compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicCompile.sqf";
//*/

#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

Zen_RTS_Strategic_Building_Types = [];
Zen_RTS_Strategic_Building_Objects_Server = [];
Zen_RTS_Strategic_Building_Objects_Global = [];
Zen_RTS_Strategic_Building_Objects_Local = [];
Zen_RTS_Strategic_Asset_Types = [];

Zen_RTS_StrategicBuildingCreate = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingCreate.sqf";
Zen_RTS_StrategicBuildingRemove = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingRemove.sqf";
Zen_RTS_StrategicBuildingTypeGetData = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingTypeGetData.sqf";
Zen_RTS_StrategicBuildingTypeUpdate = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingTypeUpdate.sqf";

Zen_RTS_StrategicBuildingDestroy = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingDestroy.sqf";
Zen_RTS_StrategicBuildingInvoke = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingInvoke.sqf";
Zen_RTS_StrategicBuildingObjectGetDataGlobal = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingObjectGetDataGlobal.sqf";
Zen_RTS_StrategicBuildingObjectGetDataLocal = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingObjectGetDataLocal.sqf";
// Zen_RTS_StrategicBuildingObjectGetDataServer = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingObjectGetDataServer.sqf";
// Zen_RTS_StrategicBuildingObjectUpdate = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingObjectUpdate.sqf";
Zen_RTS_StrategicBuildingUpgrade = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingUpgrade.sqf";

Zen_RTS_StrategicBuildingQueueAdd = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingQueueAdd.sqf";
Zen_RTS_StrategicBuildingQueueClear = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingQueueClear.sqf";
Zen_RTS_StrategicBuildingQueueManager = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingQueueManager.sqf";
Zen_RTS_StrategicBuildingQueueRemove = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicBuildingQueueRemove.sqf";

Zen_RTS_StrategicAssetCreate = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicAssetCreate.sqf";
Zen_RTS_StrategicAssetGetData = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicAssetGetData.sqf";
Zen_RTS_StrategicAssetInvoke = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicAssetInvoke.sqf";
Zen_RTS_StrategicAssetRemove = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicAssetRemove.sqf";
Zen_RTS_StrategicAssetUpdate = compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicAssetUpdate.sqf";

Zen_RTS_F_StrategicAddAssetGlobal = {
    private ["_buildingID", "_assetsToAdd", "_buildingData", "_assetsArray"];

    _buildingID = _this select 0;
    _assetsToAdd = _this select 1;

    _buildingData = [_buildingID] call Zen_RTS_StrategicBuildingObjectGetDataGlobal;
    _assetsArray = _buildingData select 4;

    {
        if !(_x in _assetsArray) then {
            _assetsArray pushBack _x;
        };
    } forEach _assetsToAdd;
    publicVariable "Zen_RTS_Strategic_Building_Objects_Global";
};

Zen_RTS_F_StrategicAddAssetLocal = {
    private ["_buildingID", "_assetsToAdd", "_buildingData", "_assetsArray"];

    _buildingID = _this select 0;
    _assetsToAdd = _this select 1;

    diag_log ("Zen_RTS_F_StrategicAddAssetLocal  " + str _this + "  " + str time);

    _buildingData = [_buildingID] call Zen_RTS_StrategicBuildingObjectGetDataLocal;
    _assetsArray = _buildingData select 1;

    {
        if !(_x in _assetsArray) then {
            _assetsArray pushBack _x;
        };
    } forEach _assetsToAdd;
};

// Zen_RTS_F_StrategicCreateBuildingDataServer = {
    // private ["_h_queue"];

    // _h_queue = [(_this select 0)] spawn Zen_RTS_StrategicBuildingQueueManager;
    // _this set [2, _h_queue];

    // Zen_RTS_Strategic_Building_Objects_Server pushBack _this;
// };

Zen_RTS_F_StrategicCreateBuildingDataClient = {
    private ["_h_queue"];

    _h_queue = [(_this select 0)] spawn Zen_RTS_StrategicBuildingQueueManager;
    _this set [4, _h_queue];
    _this set [5, scriptNull];

    Zen_RTS_Strategic_Building_Objects_Local pushBack _this;
};

Zen_RTS_F_StrategicRemoveBuildingDataLocal = {
    0 = [Zen_RTS_Strategic_Building_Objects_Local, _this] call Zen_ArrayRemoveIndex;
};

// Zen_RTS_F_StrategicRemoveBuildingQueueServer = {
    // private ["_identifier", "_objData"];

    // _identifier = _this select 0;
    // _objData = [_identifier] call Zen_RTS_StrategicBuildingObjectGetDataServer;

    // terminate (_objData select 2);
    // terminate (_objData select 3);
// };

Zen_RTS_F_StrategicRemoveBuildingQueueClient = {
    private ["_identifier", "_objData"];

    _identifier = _this select 0;
    _objData = [_identifier] call Zen_RTS_StrategicBuildingObjectGetDataLocal;

    terminate (_objData select 4);
    terminate (_objData select 5);
};

// Zen_RTS_F_StrategicRequestCurrentAssetServer = {
    // private ["_buildingObjID", "_objData"];

    // _buildingObjID = _this select 0;

    // _buildingObjDataServer = [_buildingObjID] call Zen_RTS_StrategicBuildingObjectGetDataServer;
    // _queue = _buildingObjDataServer select 1;
    // Zen_RTS_Strategic_Current_Asset_Data = [];
    // if (count _queue > 0) then {
        // Zen_RTS_Strategic_Current_Asset_Data = (_queue select 0);
    // };
    // publicVariable "Zen_RTS_Strategic_Current_Asset_Data";
// };

Zen_RTS_F_StrategicRequestCurrentAssetClient = {
    // Zen_RTS_Strategic_Current_Asset_Data = nil;
    // ZEN_FMW_MP_REServerOnly("Zen_RTS_F_StrategicRequestCurrentAssetServer", _this, call)
    // waitUntil {
        // !(isNil "Zen_RTS_Strategic_Current_Asset_Data")
    // };

    // (Zen_RTS_Strategic_Current_Asset_Data)

    _objData = [(_this select 0)] call Zen_RTS_StrategicBuildingObjectGetDataLocal;
    _queue = _objData select 3;

    (if (count _queue > 0) then {
        (_queue select 0)
    } else {
        ([])
    })
};

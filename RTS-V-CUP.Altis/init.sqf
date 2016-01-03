#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

// For debug purposes
if !(isDedicated) then {
    diag_log profileNameSteam;
};

enableSaving [false, false];
player enableFatigue false;
player addEventhandler ["Respawn", {player enableFatigue false}];
RTS_Intro_Titletext_Code = {titleText [format ["%1", "-= RTS V =-\nWarGame\nFor Arma 3"], "PLAIN DOWN" , .5]};
call RTS_Intro_Titletext_Code;
[] execVM "briefing.sqf";

#include "Zen_RTS_Functions\Zen_RTS_GlobalFunctions.sqf"
#include "Zen_RTS_Functions\Zen_RTS_GlobalVariables.sqf"
#include "Zen_RTS_Functions\Zen_RTS_ParseParams.sqf"
#include "functions\RTS_FNC_INIT_PLAYERACTIONS.sqf"
#include "functions\RTS_FNC_flipACTIONS.sqf"
#include "functions\RTS_FNC_PUSH.sqf"

#define __cppfln(xdfunc,xfile2) xdfunc = compile preprocessFileLineNumbers #xfile2
__cppfln(barrelfun,functions\barrelfun.sqf);

// Compile Zen Functions --------------
Zen_RTS_AlphaMenu = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_AlphaMenu.sqf";
Zen_RTS_BuildMenuStructures = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_BuildMenuStructures.sqf";
Zen_RTS_BuildStructure = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_BuildStructure.sqf";
Zen_RTS_BuildMenu = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_BuildMenu.sqf";
Zen_RTS_BuildUnit = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_BuildUnit.sqf";
Zen_RTS_CommanderManager = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_CommanderManager.sqf";
Zen_RTS_DeployPlayer = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_DeployPlayer.sqf";
Zen_RTS_DisbandUnit = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_DisbandUnit.sqf";
Zen_RTS_DestroyStructure = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_DestroyStructure.sqf";
Zen_RTS_EconomyManager = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_EconomyManager.sqf";
Zen_RTS_GiveMoney = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_GiveMoney.sqf";
Zen_RTS_HackBuilding = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_HackBuilding.sqf";
Zen_RTS_RandomStart = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_RandomStart.sqf";
Zen_RTS_RecycleRepair = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_RecycleRepair.sqf";
Zen_RTS_RecycleRepairAIManager = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_RecycleRepairAIManager.sqf";
Zen_RTS_SetViewDistance = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_SetViewDistance.sqf";

call compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicCompile.sqf";
call compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryCompile.sqf";
call compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritoryCompile.sqf";

//adding rotation menu
// call compile preProcessFile "ROTATION_MENU_SYSTEM\InitRotationMenuSystem.sqf";
// _null = [] spawn RTMS_InitRotationMenuSystem;
// _null = [] spawn {
    // waitUntil {player == player};
    // waitUntil {!(isNil "RTMS_INITIALIZED")};
    // _menu = (call compile preprocessFile "ROTATION_MENU_SYSTEM\DEFAULT_CLASSES\ManSlay_Class.sqf") call RTMS_CreateMenuObject;
    // [_menu, true] call RTMS_SendRequest;
    // waitUntil {[_menu] call RTMS_IsInstalled};
    // [_menu, false] call RTMS_SendRequest;
// };

// RTS Client ---------------------
// #include "Zen_RTS_Functions\Zen_RTS_ClientExec.sqf"
//[] exec "Karr-SquadMarkers.sqs";
// [] exec "rts-build-addAction.sqs";
// [] execVM "territory\rts-territoryInit.sqf";
// [] exec "economy\rts-moneyMonitor.sqs";
// [] exec "rts-vcl-special.sqs";

// [] exec "rts-build-unitarrays.sqs";
// [] exec "rts-client-updateArrays.sqs";
// [] exec "rts-build-structurePosExec.sqs";
// [] exec "rts-z-endmission.sqs";

// [] execVM "rts-z-intro.sqf";
// [] exec "rts-showMsg.sqs";
// [] exec "rts-init-SetRandomPos.sqs";
// 1 setRadioMsg "Null";
// if (param3 > 0) then {
    // [] exec "vicpoint\rts-vpInit.sqs";
// };

#define ZEN_RTS_STRATEGIC_ASSET_SPAWN_MESSAGE() \
    _buildingType = _buildingObjData select 0; \
    _buildingTypeData = [_buildingType] call Zen_RTS_StrategicBuildingTypeGetData; \
    _args = ["hintSilent", [("Your " + (_assetData select 2) + " has been created at " + (_buildingTypeData select 4) + ".")]]; \
    ZEN_FMW_MP_REClient("Zen_ExecuteCommand", _args, call, _referenceUnit)

#define ZEN_RTS_STRATEGIC_BUILDING_UPGRADE_MESSAGE() \
    _args = ["hintSilent", [((_typeDataOther select 4) + " has been upgraded.")]]; \
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)

#define ZEN_RTS_STRATEGIC_ASSET_PLACEMENT() \
    _marker = (_buildingObjData select 2 ) getVariable ["Zen_RTS_StrategicBuildingMarker", ""]; \
    _pos = ([_marker] call Zen_ConvertToPosition); \
    scopeName "main"; \
    for "_r" from 10 to 50 step 10 do { \
        for "_phi" from 0 to 315 step 45 do { \
            _spawnPos = _pos vectorAdd [_r * round cos _phi, _r * round sin _phi, 0]; \
            _objects = (nearestObjects [_spawnPos, ["LandVehicle"], 10]) + (nearestObjects [_spawnPos, ["Air"], 10]); \
            if (count _objects == 0) then { \
                _pos = _spawnPos; \
                breakTo "main"; \
            }; \
        }; \
    };

#define DETECT_BUILDING(B, U) \
    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(B, _ID) \
    if (_ID != "") then { \
        _assetsToAdd pushBack U; \
    };

#define ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(N, I) \
    _objIndexes = [Zen_RTS_Strategic_Building_Objects_Global, N, 0] call Zen_ArrayGetNestedIndex; \
    I = ""; \
    if (count _objIndexes > 0) then { \
        _objData = Zen_RTS_Strategic_Building_Objects_Global select (_objIndexes select 0); \
        I = _objData select 1; \
    };

#define ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
    _vehicle setVariable ["Zen_RTS_StrategicValue", (call compile ([_assetStrRaw, "Cost: ", ","] call Zen_StringGetDelimitedPart)), true]; \
    _vehicle setVariable ["Zen_RTS_IsStrategicRepairable", true, true]; \
    _vehicle setVariable ["Zen_RTS_StrategicType", "Asset", true]; \
    _vehicle setVariable ["Zen_RTS_StrategicAssetType", (_assetData select 0), true]; \
    _vehicle setVariable ["Zen_RTS_IsStrategicDebris", false, true]; \
    ZEN_FMW_MP_REServerOnly("Zen_RTS_F_AddRecycleQueue", [_vehicle], call) \
    _vehicle addEventHandler ["Dammaged", { \
        _vehicle = _this select 0; \
        if (!(canMove _vehicle) || (damage _vehicle > 0.9)) then { \
            (_this select 0) setVariable ["Zen_RTS_IsStrategicDebris", true, true]; \
            _vehicle removeAllEventHandlers "Dammaged"; \
        }; \
    }];
    // (RTS_Recycle_Queue select (([west, east] find ([_vehicle] call Zen_GetSide)) max 0)) pushBack _vehicle; \
    // _vehicle setVariable ["Zen_RTS_IsStrategicRepairable", false, true]; \

#define BUILDING_VISUALS(T, O) \
    _buildTime = call compile ([(_buildingTypeData select 5), "Time: ", ","] call Zen_StringGetDelimitedPart); \
    _building = [_spawnPos, T, 0, random 360, true] call Zen_SpawnVehicle; \
    _building setVectorUp (surfaceNormal _spawnPos); \
    _height = ZEN_STD_OBJ_BBZ(_building); \
    _heightStep = (_height + O) / _buildTime; \
    _building setPos ((getPos _building) vectorAdd [0, 0, -(_height)]); \
    for "_i" from 0 to _buildTime do { \
        sleep 1; \
        if !(alive _building) exitWith {}; \
        _building setPos ((getPos _building) vectorAdd [0, 0, _heightStep]); \
    };
    // ZEN_STD_OBJ_TransformATL(_building, 0, 0, -(_height)) \
        // _building setPosWorld ((setPosWorld _building) vectorAdd [0, 0, _heightStep]); \
        // _building setPosASL ((getPosASL _building) vectorAdd [0, 0, _heightStep]); \

#define ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(T, S) \
    if !(alive _building) exitWith { \
        0 = [(_buildingObjData select 1)] spawn { \
            sleep 5; \
            0 = _this call Zen_RTS_StrategicBuildingDestroy; \
        }; \
        (_building) \
    }; \
    _cost = call compile ([(_buildingTypeData select 5), "Cost: ", ","] call Zen_StringGetDelimitedPart); \
    (RTS_Repair_Queue select ([west, east] find S)) pushBack _building; \
    _buildingSpawnGrid = [_building, "", "colorBlack", [30, 30], "rectangle", getDir _building, 0] call Zen_SpawnMarker; \
    _args = [_buildingSpawnGrid, S]; \
    ZEN_FMW_MP_REAll("Zen_RTS_F_AddSpawnGridMarker", _args, call) \
    _building setVariable ["Zen_RTS_StrategicBuildingMarker", _buildingSpawnGrid, true]; \
    _building setVariable ["Zen_RTS_StrategicValue", _cost, true]; \
    _building setVariable ["Zen_RTS_IsStrategicRepairable", true, true]; \
    _building setVariable ["Zen_RTS_StrategicType", "Building", true]; \
    _building setVariable ["Zen_RTS_StrategicBuildingSide", S, true]; \
    _building addEventHandler ["Killed", { \
        0 = _this spawn { \
            _buildingTypeData = [T] call Zen_RTS_StrategicBuildingTypeGetData; \
            _buildingObjData = [T, true, false] call Zen_RTS_StrategicBuildingObjectGetDataGlobal; \
            diag_log ("ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH  " + T + "  " + str time); \
            diag_log _buildingObjData; \
            if (count _buildingObjData > 0) then { \
                diag_log (_buildingObjData select 1); \
                0 = [(_buildingObjData select 1)] call Zen_RTS_StrategicBuildingDestroy; \
            }; \
            _building = _this select 0; \
            _buildingSpawnGrid = _building getVariable "Zen_RTS_StrategicBuildingMarker"; \
            0 = [(RTS_Repair_Queue select ([west, east] find S)), _building] call Zen_ArrayRemoveValue; \
            _pos = getPosATL _building; \
            sleep 5; \
            _objects = nearestObjects [_pos, ["All"], 10]; \
            _deadBuilding = objNull; \
            { \
                if (alive _x) exitWith { \
                    _deadBuilding = _x; \
                }; \
            } forEach _objects; \
            if !(isNull _deadBuilding) then { \
                diag_log ("ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH found dead building" + str _deadBuilding); \
                (RTS_Repair_Queue select ([west, east] find S)) pushBack _deadBuilding; \
                _args = [_buildingSpawnGrid, S]; \
                ZEN_FMW_MP_REAll("Zen_RTS_F_RemoveSpawnGridMarker", _args, call) \
                _cost = call compile ([(_buildingTypeData select 5), "Cost: ", ","] call Zen_StringGetDelimitedPart); \
                _deadBuilding setVariable ["Zen_RTS_StrategicType", "BuildingRuins", true]; \
                _deadBuilding setVariable ["Zen_RTS_IsStrategicRepairable", true, true]; \
                _deadBuilding setVariable ["Zen_RTS_IsStrategicDebris", true, true]; \
                _deadBuilding setVariable ["Zen_RTS_StrategicValue", _cost, true]; \
                _deadBuilding setVariable ["Zen_RTS_StrategicRuinsType", T, true]; \
                _deadBuilding setVariable ["Zen_RTS_StrategicBuildingSide", S, true]; \
            } else { \
                diag_log (" ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH  Destroyed Building" + str _building + " has no dead object"); \
            }; \
        }; \
    }];

[false] execVM "digitalLoadout\client.sqf";
// Data structure for custom squads, this is local to each player and side specific
// indexes pair with names/colors, 0 - Alpha, etc.
RTS_Custom_Squads_Assets = [[], [], [], []];

rts_arrays_initialized = true;
#include "Zen_RTS_West\RTS_West_AssetConstructors.sqf"
#include "Zen_RTS_East\RTS_East_AssetConstructors.sqf"
#include "Zen_RTS_Functions\Zen_RTS_JIPSync.sqf"
if !(isServer) exitWith {};
// TitleRsc ["Title","BLACK FADED"];
// CutRsc ["Black","BLACK FADED"];
sleep 1;

// RTS Server -------------
//FNC_AUTOTANK = compileFinal preprocessFileLineNumbers "FNC_AUTOTANK.sqf";
#include "FNC_AUTOTANK.sqf";

0 = [] execVM "unflip_vehicle.sqf";
0 = [] execVM "R3F_LOG\init.sqf";

// [] exec "rts-init-commandermonitor.sqs";
// [] exec "economy\rts-supplyMonitor.sqs";
// [] exec "rts-build-serverside.sqs";
// took this out with what ever it was attached to.. like unit monitor ... getting errors from east.
// [] exec "test.sqs";
// [] exec "rts-build-serverSideMonitor.sqs";
// rts_hq sideChat "Global Scripts and Variables Initialized";
// --------------------------

// Zen Server ------------------
diag_log diag_tickTime;
// [west], [east] format, see global functions for modify
// This is for server only
Zen_RTS_CommanderQueue = [[], []];

// These arrays are for the server only
// Do not transfer AI repair/recycle threads or locality to clients
// Must follow [[<west objects>], [<east objects>]] format
RTS_Recycle_Queue = [[], []];
RTS_Repair_Queue = [[], []];
RTS_Worker_Recycle_Queue = [[], []];
RTS_Worker_Repair_Queue = [[], []];
RTS_CJ_Repair_Queue = [[], []];

#include "Zen_RTS_Functions\Zen_RTS_CustomLoadouts.sqf"
#include "Zen_RTS_Functions\Zen_RTS_InitGiveMoneyDialog.sqf"
0 = [] call Zen_RTS_RandomStart;
0 = [] spawn Zen_RTS_CommanderManager;
0 = [] spawn Zen_RTS_EconomyManager;
0 = [] spawn Zen_RTS_RecycleRepairAIManager;
Zen_JIP_Args_Server = [overcast, fog, 2000];
diag_log diag_tickTime;
{
    // call compile format ["xp%1 = 0", _x];
    if (isPlayer _x) then {
        0 = [_x, str side _x + "rifleman"] call Zen_GiveLoadoutCustom;
        ZEN_FMW_MP_REClient("Zen_RTS_F_RespawnActions", _x, spawn, _x)
    };
} forEach ([West, East] call Zen_ConvertToObjectArray);

// For debug purposes
diag_log diag_tickTime;
diag_log date;
// ====================================================================================
// Zen_RTS_SubTerritory
// ====================================================================================

WestFC = 0;
EastFC = 0;
civFC = 0;
// ResourceTotal = 20*32;

0 = [] spawn Zen_RTS_SubTerritoryManager;

_flagMarkers = [];
for "_i" from 1 to 32 do {
    _marker = [missionNamespace getVariable ("Flag" + str _i), "", "colorBlack", [100, 100], "ellipse"] call Zen_SpawnMarker;
    _flagMarkers pushBack _marker;
    0 = [_marker, "Flag " + str _i, [0, 5, 10, 20]] call Zen_RTS_SubTerritoryCreate;
};

diag_log diag_tickTime;
// ====================================================================================
// Zen_RTS_Territory
// ====================================================================================

#define MKR(I) (_flagMarkers select (I - 1))

0 = [] spawn Zen_RTS_TerritoryManager;

_Zen_TerritorySouth_East_TerritoryMarker = [ListFlag1, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["South_East", [MKR(1), MKR(2),MKR(3),MKR(4)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryEast_TerritoryMarker = [ListFlag5, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["East", [MKR(5),MKR(6),MKR(7),MKR(26)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryDesert_TerritoryMarker = [ListFlag8, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["Desert", [MKR(8),MKR(9)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritorySouthBay_TerritoryMarker = [ListFlag10, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["SouthBay", [MKR(10), MKR(11), MKR(12)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritorySouth_West_TerritoryMarker = [ListFlag13, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["South_West", [MKR(13), MKR(14),MKR(15)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryNorthWest_TerritoryMarker = [ListFlag16, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["North_West", [MKR(16),MKR(17), MKR(18)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryNorth_TerritoryMarker = [ListFlag19, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["North", [MKR(19),MKR(20),MKR(21)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritorynwAir_port_TerritoryMarker = [ListFlag22, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["N-W_Air_port", [MKR(22)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryAir_port_TerritoryMarker = [ListFlag23, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["Air_port", [MKR(23)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryswAir_port_TerritoryMarker = [ListFlag24, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["S-W_Air_port", [MKR(24)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryneAir_port_TerritoryMarker = [ListFlag25, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["N-E_Air_port", [MKR(25)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryNorth_East_TerritoryMarker = [ListFlag27, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["North_East", [MKR(27),MKR(28), MKR(29)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryWest_TerritoryMarker = [ListFlag30, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["West", [MKR(30),MKR(31), MKR(32)]] call Zen_RTS_TerritoryCreate;

//////////
// Zen RTS Strategic
/////////

diag_log diag_tickTime;
// #define ZEN_RTS_STRATEGIC_DEBRIS_THRESHOLD 1.1

// all building types must be added here, or they will not be considered
// must be [[west building types], [east '']]
RTS_Used_Building_Types = [[], []]; // global

// the level of each building type for when the object is destroyed
// must be [[west building levels], [east '']]
RTS_Building_Type_Levels = [[], []]; // global

{
    _array = _x;
    for "_i" from 1 to 9 do {
        _array pushBack 0;
    };
} forEach RTS_Building_Type_Levels;

// all asset types must be added here, or they will not be considered for custom squads
// must be [[West asset types, [East '']]
RTS_Used_Asset_Types = [[], []]; // global

// all created buildings have a safe zone for spawning
// must be [[West markers, [East '']]
// every building object has its marker recorded as the Zen_RTS_StrategicBuildingMarker variable
RTS_Building_Spawn_Grid_Markers = [[], []];
publicVariable "RTS_Building_Spawn_Grid_Markers";

#include "Zen_RTS_West\RTS_West_HQ.sqf"
#include "Zen_RTS_West\RTS_West_Barracks.sqf"
#include "Zen_RTS_West\RTS_West_Radar.sqf"
#include "Zen_RTS_West\RTS_West_TankFactory.sqf"
#include "Zen_RTS_West\RTS_West_AirFactory.sqf"
#include "Zen_RTS_West\RTS_West_NavalFactory.sqf"
#include "Zen_RTS_West\RTS_West_SupportFactory.sqf"
#include "Zen_RTS_West\RTS_West_RecyclePlant.sqf"
#include "Zen_RTS_West\RTS_West_CJ.sqf"

#include "Zen_RTS_East\RTS_East_HQ.sqf"
#include "Zen_RTS_East\RTS_East_Barracks.sqf"
#include "Zen_RTS_East\RTS_East_Radar.sqf"
#include "Zen_RTS_East\RTS_East_TankFactory.sqf"
#include "Zen_RTS_East\RTS_East_AirFactory.sqf"
#include "Zen_RTS_East\RTS_East_NavalFactory.sqf"
#include "Zen_RTS_East\RTS_East_SupportFactory.sqf"
#include "Zen_RTS_East\RTS_East_RecyclePlant.sqf"
#include "Zen_RTS_East\RTS_East_CJ.sqf"

westTruck setVariable ["Zen_RTS_IsStrategicRepairable", true, true];
westTruck setVariable ["Zen_RTS_StrategicValue", 1000, true];
westTruck setVariable ["Zen_RTS_StrategicType", "Asset", true];

eastTruck setVariable ["Zen_RTS_IsStrategicRepairable", true, true];
eastTruck setVariable ["Zen_RTS_StrategicValue", 1000, true];
eastTruck setVariable ["Zen_RTS_StrategicType", "Asset", true];

publicVariable "RTS_Used_Building_Types";
publicVariable "RTS_Building_Type_Levels";
// publicVariable "RTS_Used_Asset_Types";

publicVariable "Zen_RTS_BuildingType_West_HQ";
publicVariable "Zen_RTS_BuildingType_West_CJ";

publicVariable "Zen_RTS_BuildingType_East_HQ";
publicVariable "Zen_RTS_BuildingType_East_CJ";

rts_Initialized = true;
publicVariable "rts_Initialized";
diag_log diag_tickTime;

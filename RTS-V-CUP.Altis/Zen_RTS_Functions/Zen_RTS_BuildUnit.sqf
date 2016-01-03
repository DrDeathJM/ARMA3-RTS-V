//

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

#define PROCESS_PURCHASE \
    _cost = call compile ([(_assetData select 3), "Cost: ", ","] call Zen_StringGetDelimitedPart); \
    if (playerMoney < _cost) exitWith { \
        player sideChat "Insufficient funds."; \
    }; \
    playerMoney = playerMoney - _cost; \
    _actualCrewCount = 0; \
    if (ctrlVisible _idCrewCountList) then { \
        _maxCrew = ([(_assetData select 3), "Crew: ", ","] call Zen_StringGetDelimitedPart); \
        if (_maxCrew == "") then {_maxCrew = 9} else {_maxCrew = call compile _maxCrew}; \
        _crewCount = (lbValue [_idCrewCountList, lbCurSel _idCrewCountList]) min _maxCrew; \
        _actualCrewCount = _crewCount; \
        if ((typeName _crewCount == "SCALAR") && {_crewCount > 0}) then { \
            _actualCrewCount = 0; \
            while {(playerMoney > 25) && {_actualCrewCount < _crewCount}} do { \
                _actualCrewCount = _actualCrewCount + 1; \
                playerMoney = playerMoney - 25; \
            }; \
        }; \
    };

0 = _this spawn {
    _Zen_stack_Trace = ["Zen_RTS_BuildUnit", _this] call Zen_StackAdd;
    _forSquad = _this select 0;

    _idAssetList = 2000;
    _idCrewCountList = 2045;
    _idSquadList = 2025;

    if (rating player < 0) then {
        player addRating ((rating player * -1));
    };

    _side = side player;
    _buildingObjId = player getVariable "Zen_RTS_Current_Building";
    _buildingObjData = [_buildingObjId] call Zen_RTS_StrategicBuildingObjectGetDataGlobal;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;
    _buildingObjDataLocal = [_buildingObjId] call Zen_RTS_StrategicBuildingObjectGetDataLocal;

    _index = lbCurSel _idAssetList;
    // _text = lbText [_idAssetList, _index];
    // _available = lbValue [_idAssetList, _index];

    /**
    if (_idCustomList == 2030) then { // custom squad
        _index = lbCurSel _idCustomList;
        _customSquadIndex = lbValue [_idCustomList, _index];
        // _squadName = lbText [_idCustomList, _index];
        // _customArray = lbData [_idc2, _index];

        _customAssets = RTS_Custom_Squads_Assets select _customSquadIndex;
        {
            _assetData = [_x] call Zen_RTS_StrategicAssetGetData;

            PROCESS_PURCHASE
            0 = [_buildingObjId, _x, player, _manned] call Zen_RTS_StrategicAssetInvoke;
        } forEach _customAssets;
    } else {
    //*/
        _assetType = lbData [_idAssetList, _index];
        _assetData = [_assetType] call Zen_RTS_StrategicAssetGetData;

        PROCESS_PURCHASE
        // closeDialog 0;
        _buildingObjDataLocal set [2, (_buildingObjDataLocal select 2) + 1];

        if (_forSquad) then {
            _playerArray = [_side] call Zen_ConvertToObjectArray;
            _playerArray = [_playerArray, compile format [" (switch (side _this) do { case West: {0}; case East: {1};}) != %1", (switch (_side) do { case West: {0}; case East: {1};})]] call Zen_ArrayFilterCondition;
            _playerArray = [_playerArray, {leader group _this != _this}] call Zen_ArrayFilterCondition;
            0 = [_playerArray, WestCommander] call Zen_ArrayRemoveValue;
            0 = [_playerArray, EastCommander] call Zen_ArrayRemoveValue;

            _index = lbCurSel _idSquadList;
            _unit = _playerArray select _index;

            _args = [_buildingObjId, _assetType, _unit, _actualCrewCount];
            // ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicAssetInvoke", _args, call)
            _args call Zen_RTS_StrategicAssetInvoke;
        } else {
            if ((_buildingTypeData select 4) isEqualTo "CJ") then {
                closeDialog 0;
                _building = _buildingObjData select 2;
                Zen_RTS_CJ_DoPlace = false;
                _redArrow = "Sign_Arrow_Large_F" createVehicleLocal [0,0,0]; \
                _building addAction ["<t color='#D80000'>Place</t>", {Zen_RTS_CJ_DoPlace = true; (_this select 0) removeAction (_this select 2);}, [], 2.5, false, true, "", "(_this in _target)"];
                waitUntil {
                    sleep 0.5;
                    _redArrow setPosATL ([_building, 10, getDir _building, "compass", 1] call Zen_ExtendPosition);
                    (Zen_RTS_CJ_DoPlace)
                };

                deleteVehicle _redArrow;
                _args = [_buildingObjId, _assetType, player, getPosATL _redArrow];
                // ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicAssetInvoke", _args, call)
                _args call Zen_RTS_StrategicAssetInvoke;
            } else {
                _args = [_buildingObjId, _assetType, player, _actualCrewCount];
                // ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicAssetInvoke", _args, call)
                _args call Zen_RTS_StrategicAssetInvoke;
            };
        };
    // };

    call Zen_StackRemove;
    if (true) exitWith {};
};

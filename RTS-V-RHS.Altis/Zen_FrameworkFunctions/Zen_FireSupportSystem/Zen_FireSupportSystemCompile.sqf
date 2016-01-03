// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_FrameworkLibrary.sqf"

Zen_Fire_Support_Round_Local = objNull;
Zen_Fire_Support_Target_Pos_Local = [];
Zen_Fire_Support_Array_Global = [];
Zen_Fire_Support_Action_Array_Global = [];
Zen_Fire_Support_Action_Array_Local = [];

Zen_AddFireSupportAction = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_AddFireSupportAction.sqf";
Zen_CreateFireSupport = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_CreateFireSupport.sqf";
Zen_GetFireSupportActionData = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_GetFireSupportActionData.sqf";
Zen_GetFireSupportData = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_GetFireSupportData.sqf";
Zen_GetUnitFireSupportActions = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_GetUnitFireSupportActions.sqf";
Zen_GuideRound = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_GuideRound.sqf";
Zen_InvokeFireSupport = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_InvokeFireSupport.sqf";
Zen_InvokeFireSupportAction = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_InvokeFireSupportAction.sqf";
Zen_RemoveFireSupport = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_RemoveFireSupport.sqf";
Zen_RemoveFireSupportAction = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_RemoveFireSupportAction.sqf";
Zen_UpdateFireSupport = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_UpdateFireSupport.sqf";
Zen_UpdateFireSupportAction = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_FireSupportSystem\Zen_UpdateFireSupportAction.sqf";

Zen_AddFireSupportAction_AddAction_MP = {
    if (isDedicated || !hasInterface) exitWith {};
    private ["_nameString", "_units", "_titleString", "_supportString", "_guideObj", "_guideType", "_maxCalls", "_IDs", "_actionID", "_indexes", "_oldData", "_oldUnits", "_oldIDs"];

    _nameString = _this select 0;
    _units = _this select 1;
    _titleString = _this select 2;
    _supportString = _this select 3;
    _guideObj = _this select 4;
    _guideType = _this select 5;
    _maxCalls = _this select 6;

    _IDs = [];
    {
        _actionID = _x addAction ["<t color='#990000'>" + _titleString + "</t>", {(_this select 3) spawn Zen_InvokeFireSupportAction}, [_nameString], 1, false, true, "", "(_target == _this)"];
        _IDs pushBack _actionID;
    } forEach _units;

    _indexes = [Zen_Fire_Support_Action_Array_Local, _nameString, 0] call Zen_ArrayGetNestedIndex;
    if (count _indexes == 0) then {
        Zen_Fire_Support_Action_Array_Local pushBack [_nameString, _units, _IDs];
    } else {
        _oldData = Zen_Fire_Support_Action_Array_Local select (_indexes select 0);
        _oldUnits = _oldData select 1;
        _oldIDs = _oldData select 2;

        0 = [_oldUnits, _units] call Zen_ArrayAppendNested;
        0 = [_oldIDs, _IDs] call Zen_ArrayAppendNested;
    };

    if (true) exitWith {};
};

Zen_InvokeFireSupportAction_CheckCount_Server_MP = {
    if !(isServer) exitWith {};
    private ["_nameString", "_indexes", "_data", "_maxCount", "_count"];
    _nameString = _this select 0;

    _indexes = [Zen_Fire_Support_Action_Array_Global, (_this select 0), 0] call Zen_ArrayGetNestedIndex;
    _data = Zen_Fire_Support_Action_Array_Global select (_indexes select 0);
    _maxCount = _data select 6;
    _count = (_data select 7) + 1;

    _data set [7, _count];
    if ((_count >= _maxCount) && {_maxCount != -1}) then {
        0 = [_nameString] call Zen_RemoveFireSupportAction;
    } else {
        publicVariable "Zen_Fire_Support_Action_Array_Global";
    };

    if (true) exitWith {};
};

Zen_InvokeFireSupportAction_Fire_MP = {
    _supportTemplate = (_this select 0) select 1;
    _guideObj = (_this select 0) select 2;
    _h_support = (_this select 0) spawn Zen_InvokeFireSupport;

    _threadID = "Zen_FireSupportAction_ID_" + ([5] call Zen_StringGenerateRandom);
    missionNamespace setVariable [_threadID, _h_support];

    _callingUnit = _this select 1;
    _args = [_threadID, _guideObj, _supportTemplate];
    ZEN_FMW_MP_REClient("Zen_InvokeFireSupportAction_AddCancelAction_MP", _args, spawn, _callingUnit)
};

Zen_InvokeFireSupportAction_AddCancelAction_MP = {
    // _threadID = _this select 0;
    // _guideObj = _this select 1;
    _supportTemplate = _this select 2;
    _actionID = player addAction ["<t color='#990000'>Cancel Fire Support</t>", {
        player removeAction (_this select 2);
        _guideObj = (_this select 3) select 1;
        if (isNull _guideObj) then {
            ZEN_FMW_MP_REServerOnly("Zen_InvokeFireSupportAction_CancelAction_MP", (_this select 3), spawn)
        } else {
            ZEN_FMW_MP_REClient("Zen_InvokeFireSupportAction_CancelAction_MP", (_this select 3), spawn, _guideObj)
        };
    }, _this, 1, false, true, "", "(_target == _this)"];

    _templateArray = [_supportTemplate] call Zen_GetFireSupportData;
    _roundsPerSalvo = (_templateArray select 2) select 1;
    _salvos = (_templateArray select 3) select 1;
    _timePerRound = (_templateArray select 4) select 1;
    _timePerSalvo = (_templateArray select 5) select 1;

    _fireSupportTime = _timePerSalvo * (_salvos + 1) + _timePerRound * _roundsPerSalvo * _salvos;
    sleep _fireSupportTime;
    player removeAction _actionID;
};

Zen_InvokeFireSupportAction_CancelAction_MP = {
    _threadID = _this select 0;
    // _guideObj = _this select 1;

    terminate (missionNamespace getVariable _threadID);
    missionNamespace setVariable [_threadID, nil];
};

Zen_RemoveFireSupportAction_RemoveAction_MP = {
    if (isDedicated || !hasInterface) exitWith {};
    private ["_nameString", "_unitsToRemove", "_unitsRemaining", "_indexes", "_commArray", "_IDs"];

    _nameString = _this select 0;
    _unitsToRemove = _this select 1;
    _unitsRemaining = _this select 2;

    _indexes = [Zen_Fire_Support_Action_Array_Local, _nameString, 0] call Zen_ArrayGetNestedIndex;
    _commArray = Zen_Fire_Support_Action_Array_Local select (_indexes select 0);

    if (count _unitsRemaining > 0) then {
        {
            0 = [_unitsRemaining, _x] call Zen_ArrayRemoveValue;
        } forEach _unitsToRemove;
    };

    {
        _IDs = _commArray select 2;
        if (_x in _unitsToRemove) then {
            _x removeAction (_IDs select _forEachIndex);
            _IDs set [_forEachIndex, -1];
        };
    } forEach (_commArray select 1);

    0 = [_IDs, -1] call Zen_ArrayRemoveValue;
    if (count _unitsRemaining == 0) then {
        0 = [Zen_Fire_Support_Action_Array_Local, (_indexes select 0)] call Zen_ArrayRemoveIndex;
    } else {
        _commArray set [1, _unitsRemaining];
    };
};

Zen_InvokeFireSupportAction_SideChat_MP = {
    if (isDedicated || !hasInterface) exitWith {};
    private ["_unit", "_side", "_group", "_pos", "_sentTime"];

    _unit = _this select 0;
    _pos = _this select 1;
    _sentTime = _this select 2;

    _side = side _unit;

    if (side player != _side) exitWith {};

    _group = toArray str group _unit;
    _group = toString ([_group, 2] call Zen_ArrayGetIndexedSlice);

    _unit sideChat format ["HQ, %1, Request fire support at grid %2, over.", _group, (mapGridPosition _pos)];
    sleep 7;
    [_side, "base"] sideChat format ["%1, HQ, Fire support inbound in %2 seconds, out.", _group, _sentTime];

    if (true) exitWith {};
};

if (true) exitWith {};

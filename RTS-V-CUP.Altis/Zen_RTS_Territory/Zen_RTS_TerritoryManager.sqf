/**
    Zen_RTS_TerritoryManager
    by Zenophon
    for RTS V

    The main territory management thread.  Controls changing the side of territories.
    Dynamically reads current data for added and removed territories.
    Updates the visual representation of territories.
    Calls Zen_RTS_TerritoryEventCaptured when the side of a territory changes.
    Usage : Spawn
    Params: None
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_TerritoryManager", _this] call Zen_StackAdd;
private ["_markers", "_oldData", "_indexSide", "_subMarkers", "_sidePoints", "_winningPoints", "_winningIndex", "_winningSide", "_winningAdvantage", "_sideIndex", "_subData", "_index"];

_indexSide = {
    (switch (_this) do {
        case 0: {(West)};
        case 1: {(East)};
        case 2: {(resistance)};
        case 3: {(civilian)};
        default {(sideLogic)};
    })
};

_sideIndex = {
    (switch (_this) do {
        case West: {0};
        case East: {1};
        case resistance: {2};
        case civilian: {3};
        default {4};
    })
};

while {true} do {
    _markers = [[1], [[0, 2]], [{1}]] call Zen_RTS_TerritorySearch;
    {
        0 = [_x] call Zen_RTS_TerritoryUpdate;
        _oldData = [_x] call Zen_RTS_TerritoryGetData;
        _subMarkers = _oldData select 2;

        _sidePoints = [0, 0, 0, 0];
        {
            _subData = [_x] call Zen_RTS_SubTerritoryGetData;
            _index = (_subData select 1) call _sideIndex;

            if (_index < 3) then {
                _sidePoints set [_index, (_sidePoints select _index) + 1];
            };
        } forEach _subMarkers;

        _winningPoints = [_sidePoints, {_this}] call Zen_ArrayFindExtremum;
        _winningIndex = _sidePoints find _winningPoints;
        _winningSide = _winningIndex call _indexSide;

        if (_winningSide != (_oldData select 1)) then {
            _sidePoints set [_winningIndex, 0];
            _winningAdvantage = _winningPoints - ([_sidePoints] call Zen_ArrayFindSum);

            if (_winningAdvantage > 0) then {
                0 = [_x, _winningSide] call Zen_RTS_TerritoryUpdate;
                0 = [_x, _oldData] spawn Zen_RTS_TerritoryEventCaptured;
            };
        };

        0 = [_x] call Zen_RTS_TerritoryUpdateVisual;
    } forEach _markers;
    sleep 5;
};

call Zen_StackRemove;
if (true) exitWith {};

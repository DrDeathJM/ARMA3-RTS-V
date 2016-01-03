/**
    Zen_RTS_SubTerritoryManager
    by Zenophon
    for RTS V

    The sub-territory management thread.  Controls changing the side of sub-territories.
    Dynamically reads current data for added and removed sub-territories.
    Updates the visual representation of sub-territories.
    Calls Zen_RTS_SubTerritoryEventCaptured when the side of a sub-territory changes.
    Usage : Spawn
    Params: None
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

#define UPGRADE_TIME 60

_Zen_stack_Trace = ["Zen_RTS_SubTerritoryManager", _this] call Zen_StackAdd;
private ["_indexSide", "_markers", "_oldData", "_units", "_sideCounts", "_winningPoints", "_winningIndex", "_winningSide", "_markerListLocal", "_markerTimeLocal", "_lastTime", "_name", "_localIndex", "_oldSide", "_oldLevel", "_oldResources", "_maxLevel"];

_indexSide = {
    (switch (_this) do {
        case 0: {(West)};
        case 1: {(East)};
        case 2: {(resistance)};
        case 3: {(civilian)};
        default {(sideLogic)};
    })
};

_markerListLocal = [];
_markerTimeLocal = [];

while {true} do {
    _markers = [[1], [[0, 2]], [{1}]] call Zen_RTS_SubTerritorySearch;
    {
        if !(_x in _markerListLocal) then {
            _localIndex = count _markerListLocal;
            _markerListLocal pushBack _x;
            _markerTimeLocal pushBack time;
            _lastTime = time;
        } else {
            _localIndex = _markerListLocal find _x;
            _lastTime = _markerTimeLocal select _localIndex;
        };

        0 = [_x] call Zen_RTS_SubTerritoryUpdate;
        _oldData = [_x] call Zen_RTS_SubTerritoryGetData;
        _oldSide = _oldData select 1;
        _name = _oldData select 2;
        _oldLevel = _oldData select 3;
        _maxLevel = (count (_oldData select 4)) - 1;
        _oldResources = (_oldData select 4) select _oldLevel;

        _units = [_x, [], [West, East, resistance]] call Zen_GetAllInArea;
        _sideCounts = [];
        for "_i" from 0 to 2 do {
            _sideCounts pushBack ({(side _x) == (_i call _indexSide)} count _units);
        };

        #define LEVEL_UP \
            if ((_oldLevel < _maxLevel) && {(_oldSide in [West, East]) && {(time > (_lastTime + UPGRADE_TIME))}}) then { \
                _markerTimeLocal set [_localIndex, time]; \
                0 = [_x, -1, -1, _oldLevel + 1] call Zen_RTS_SubTerritoryUpdate; \
                _newResources = (_oldData select 4) select (_oldLevel + 1); \
                _winningSideEcoData = Zen_RTS_Economy_Data select ([West, East] find _oldSide); \
                _winningSideEcoData set [2, (_winningSideEcoData select 2) + _newResources * (_oldLevel + 1) - _oldResources * _oldLevel]; \
                _args = ["sideChat", [[_oldSide,"HQ"], format ["Flag %1 (%2) has upgraded to level %3", _name, _oldSide, _oldLevel + 1]]]; \
                ZEN_FMW_MP_RENonDedicated("Zen_ExecuteCommand", _args, call) \
            };

        _winningPoints = [_sideCounts, {_this}] call Zen_ArrayFindExtremum;
        if ((_winningPoints > 0) && {_winningPoints == (count _units)}) then {
            _winningIndex = _sideCounts find _winningPoints;
            _winningSide = _winningIndex call _indexSide;

            if (_winningSide != _oldSide) then {
                _markerTimeLocal set [_localIndex, time];
                0 = [_x, _winningSide, -1, 0] call Zen_RTS_SubTerritoryUpdate;

                if (_oldSide in [West, East]) then {
                    _losingSideEcoData = Zen_RTS_Economy_Data select ([West, East] find _oldSide);
                    _losingSideEcoData set [2, (_losingSideEcoData select 2) - _oldResources * _oldLevel];
                };

                // _newResources = (_oldData select 4) select 0;
                _winningSideEcoData = Zen_RTS_Economy_Data select ([West, East] find _winningSide);
                // _winningSideEcoData set [2, (_winningSideEcoData select 2) + _newResources * 0];

                _args = ["sideChat", [[_winningSide,"HQ"], format ["%1 has captured flag %2", _winningSide, _name]]];
                ZEN_FMW_MP_RENonDedicated("Zen_ExecuteCommand", _args, call)

                0 = [_x, _oldData] spawn Zen_RTS_SubTerritoryEventCaptured;
            } else {
                LEVEL_UP
            };
        } else {
            LEVEL_UP
        };
    } forEach _markers;
    sleep 5;
};

call Zen_StackRemove;
if (true) exitWith {};

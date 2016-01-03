//

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {};
sleep 2;

_westQueue = ([west] call Zen_ConvertToObjectArray);
_eastQueue = ([east] call Zen_ConvertToObjectArray);

if (isMultiplayer) then {
    _westQueuePlayers = [_westQueue, {!(isPlayer _this)}] call Zen_ArrayFilterCondition;
    _eastQueuePlayers = [_eastQueue, {!(isPlayer _this)}] call Zen_ArrayFilterCondition;

    if (count _westQueuePlayers > 0) then {
        _westQueue = _westQueuePlayers;
    };

    if (count _eastQueuePlayers > 0) then {
        _eastQueue = _eastQueuePlayers;
    };
};

Zen_RTS_CommanderQueue set [0, +_westQueue];
Zen_RTS_CommanderQueue set [1, +_eastQueue];

WestCommander = _westQueue select 0;
EastCommander = _eastQueue select 0;

while {true} do {
    publicVariable "WestCommander"; publicVariable "EastCommander";
    sleep 5;

    #define PROCESS_COMMANDER_QUEUE(S, V, A) \
        _array = (Zen_RTS_CommanderQueue select A); \
        _array = [_array] call Zen_ArrayRemoveDead; \
        _array = [_array] call Zen_ArrayRemoveDuplicates; \
        Zen_RTS_CommanderQueue set [A, _array]; \
        if (V != (_array select 0)) then { \
            V = _array select 0; \
            _args = ["sideChat", [[S,"HQ"], (format ["Reassigning %1 as %2 Commander", Name V, S])]]; \
            ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call) \
        };

    PROCESS_COMMANDER_QUEUE(west, WestCommander, 0)
    PROCESS_COMMANDER_QUEUE(east, EastCommander, 1)
};

//

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"

if !(isServer) exitWith {};
private ["_westMk", "_eastMk", "_posMkArray", "_index"];

_posMkArray = [[], []];
{
    for "_i" from 1 to 6 do {
        (_posMkArray select _forEachIndex) pushBack ("pos" + str _i + _x);
    };
} forEach ["a", "b"];

_index = ZEN_STD_Array_RandIndex(_posMkArray);
if (random 1 > 0.5) then {
    _westMk = (_posMkArray select 0) select _index;
    _eastMk = (_posMkArray select 1) select _index;
} else {
    _westMk = (_posMkArray select 1) select _index;
    _eastMk = (_posMkArray select 0) select _index;
};

WestTruck setPosATL getMarkerPos _westMk;
EastTruck setPosATL getMarkerPos _eastMk;

// PlayerCount = {isPlayer _x} count ([east, west] call Zen_ConvertToObjectArray);
// PublicVariable "PlayerCount";

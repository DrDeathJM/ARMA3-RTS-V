_player = _this select 0;
_player setVariable ["side", side _player, false];

player addAction ["Get a Ride" , "ZKS\Vehicles\pickup.sqf",[0],10,false,false,"","((((cursorTarget emptyPositions 'cargo') > 0) or ((cursorTarget emptyPositions 'gunner') > 0)) and (side cursorTarget == side player) and ((cursorTarget emptyPositions 'driver') == 0))"];
// [player,"Death"] call BIS_fnc_setUnitInsignia;
if !(FatigueTrue) then {
player enableFatigue false;
};


if !(isDedicated) then 
{
KOTIME = 10;
_this addEventHandler ["killed", {_this execFSM "ZKS\Revive\Zks_Revive_Start.fsm";}];
_this setVariable ["side", side _this, false];

reviveMouseEvents = compile preprocessFile "ZKS\Revive\RESPAWN_Mouse.sqf";

sleep 20;

PLAYER_RESPAWN = 0;
};
/*if !(isDedicated) then 
{
KOTIME = 10;
_this addEventHandler ["killed", {(_this select 0) setVariable ["myweapons", [weaponsItems (_this select 0),backpackItems (_this select 0),vestItems (_this select 0),uniformItems (_this select 0)], false];_this execFSM "ZKS\Revive\Zks_Revive_Start.fsm";}];
_this setVariable ["side", side _this, false];

reviveMouseEvents = compile preprocessFile "ZKS\Revive\RESPAWN_Mouse.sqf";

sleep 20;

PLAYER_RESPAWN = 0;
};
*/
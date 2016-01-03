
if !(isserver) exitwith {};

capture_units = 1;
triggersize = 50;


if (isDedicated) then 
{
_id = addMissionEventHandler ["HandleDisconnect",{ [(_this select 0),(_this select 2)] execVM "ZKS\ZKS_Start\Player\Force_Update_left.sqf";}];
};


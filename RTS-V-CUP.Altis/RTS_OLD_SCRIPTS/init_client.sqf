
TitleRsc  ["Zen_pic","PLAIN"];

KOTIME = 10;
FatigueTrue = false;

if (isserver) then 
{
[] execVM "ZKS\ZKS_Start\Server\Start.sqf";
};

if !(isDedicated) then 
{
[] execVM "ZKS\ZKS_Start\Player\Start.sqf";
};
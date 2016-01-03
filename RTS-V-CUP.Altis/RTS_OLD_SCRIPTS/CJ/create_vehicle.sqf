_menu= objNull;
_menu= player addAction ["<t color='#4e3366'>" + "CreateHGM" + "</t>", "CJ\formee.sqf", [], 100, false, true,"teamSwitchPrev", "vehicle player isKindOf 'B_MRAP_01_F'"];
_menu = player addAction ["<t color='#4e3366'>" + "CreateHGM" + "</t>", "CJ\forhgm.sqf", [], 100, false, true, "teamSwitchPrev", "vehicle player isKindOf 'O_MRAP_02_F'"];

sleep 5;
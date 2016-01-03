//exec'd from init.sqs

waitUntil {rts_arrays_initialized};

if (Local Server) then {flagNumber = 0};

rts_refreshTerritoryArrays = FALSE;

WestFC = 0;
EastFC = 0;
GuerFC = 0;
CivFC = 0;

colorWest = "ColorBlue";
colorEast = "ColorRed";
ColorIndependent = "ColorGreen";
colorCiv = "ColorBlack";

TextureWest = "pictures\flags\flag_blufor.paa";
TextureEast = "pictures\flags\flag_opfor.paa";
TextureGuer = "pictures\flag.paa";
TextureCiv = "pictures\flag.paa";

rts_flagTaken = objNull;

[] exec "territory\rts-territorySounds.sqs";

Flag1Name = "S-E 1";
Flag2Name = "S-E 2";
Flag3Name = "S-E 3";
Flag4Name = "S-E 4";
Flag5Name = "E- 1";
Flag6Name = "E- 2";
Flag7Name = "E- 3";
Flag8Name = "Desert N";
Flag9Name = "Desert S";
Flag10Name = "j";
Flag11Name = "central A";
Flag12Name = "l";
Flag13Name = "m";
Flag14Name = "n";
Flag15Name = "o";
Flag16Name = "p";
Flag17Name = "q";
Flag18Name = "r";
Flag19Name = "s";
Flag20Name = "t";
Flag21Name = "u";
Flag22Name = "v";
Flag23Name = "w";
Flag24Name = "x";
Flag25Name = "central B";
Flag26Name = "central C";
Flag27Name = "MWest A";
Flag28Name = "MWest B";
Flag29Name = "MWest C";
Flag30Name = "MEast A";
Flag31Name = "MEast B";
Flag32Name = "MEast C";
["1","5"] exec "territory\rts-territoryMonitor.sqs";

["2","10"] exec "territory\rts-territoryMonitor.sqs";

["3","20"] exec "territory\rts-territoryMonitor.sqs";

["4","5"] exec "territory\rts-territoryMonitor.sqs";

["5","10"] exec "territory\rts-territoryMonitor.sqs";

["6","20"] exec "territory\rts-territoryMonitor.sqs";

["7","5"] exec "territory\rts-territoryMonitor.sqs";

["8","10"] exec "territory\rts-territoryMonitor.sqs";

["9","20"] exec "territory\rts-territoryMonitor.sqs";

["10","5"] exec "territory\rts-territoryMonitor.sqs";

["11","10"] exec "territory\rts-territoryMonitor.sqs";

["12","20"] exec "territory\rts-territoryMonitor.sqs";

["13","5"] exec "territory\rts-territoryMonitor.sqs";

["14","10"] exec "territory\rts-territoryMonitor.sqs";

["15","20"] exec "territory\rts-territoryMonitor.sqs";

["16","5"] exec "territory\rts-territoryMonitor.sqs";

["17","10"] exec "territory\rts-territoryMonitor.sqs";

["18","20"] exec "territory\rts-territoryMonitor.sqs";

["19","5"] exec "territory\rts-territoryMonitor.sqs";

["20","10"] exec "territory\rts-territoryMonitor.sqs";

["21","15"] exec "territory\rts-territoryMonitor.sqs";

["22","20"] exec "territory\rts-territoryMonitor.sqs";

["23","5"] exec "territory\rts-territoryMonitor.sqs";

["24","10"] exec "territory\rts-territoryMonitor.sqs";

["25","15"] exec "territory\rts-territoryMonitor.sqs";

["26","5"] exec "territory\rts-territoryMonitor.sqs";

["27","10"] exec "territory\rts-territoryMonitor.sqs";

["28","15"] exec "territory\rts-territoryMonitor.sqs";

["29","5"] exec "territory\rts-territoryMonitor.sqs";

["30","10"] exec "territory\rts-territoryMonitor.sqs";

["31","10"] exec "territory\rts-territoryMonitor.sqs";

["32","10"] exec "territory\rts-territoryMonitor.sqs";
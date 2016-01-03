private ["_side","_side2","_teamName","_teamLabel1","_stat0","_stat1","_stat2","_stat3","_stat4","_stat5","_title5","_divider","_stats1","_stats2"];

_side = _this select 0;
_side2 = _this select 1;



_teamName = call compile format ["%1TeamName",_side];
_teamLabel1 = format ["%1",_teamName];

_stat0 = call compile format ["Name %1Commander",_side];
_stat1 = call compile format ["Oil%1",_side];
_stat2 = call compile format ["Ore%1",_side];
_stat3 = call compile format ["Energy%1",_side];
_stat4 = call compile format ["%1FC",_side];
_stat5 = call compile format ["Count list %1List",_side];

_title5 = format ["%1 Units",_teamName];

_divider = "--------------------";

_stats1 = [["Commander",_stat0],["Oil",_stat1],["Ore",_stat2],["Energy",_stat3],["Territories",_stat4],[_title5,_stat5]];
_stats1 = [["Commander",_stat0],["Territories",_stat4],[_title5,_stat5]];

_teamName = call compile format ["%1TeamName",_side2];
_teamLabel1 = format ["%1",_teamName];

_stat0 = call compile format ["Name %1Commander",_side2];
_stat1 = call compile format ["Oil%1",_side2];
_stat2 = call compile format ["Ore%1",_side2];
_stat3 = call compile format ["Energy%1",_side2];
_stat4 = call compile format ["%1FC",_side2];
_stat5 = call compile format ["Count list %1List",_side2];

_stat6 = call compile format ["xp%1",Player];

_title5 = format ["%1 Units",_teamName];
_title6 = format ["%1's Rank Points", name Player];

_stats2 = [[_teamLabel1,"Stats"],["Commander",_stat0],["Oil",_stat1],["Ore",_stat2],["Energy",_stat3],["Territories",_stat4],[_title5,_stat5],["",""],[_title6,_stat6]];

_stats = _stats1 + _stats2;

_stats = _stats1;

_stats
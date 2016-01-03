waitUntil { !isNil {player} };
waitUntil { player == player };



if !(FatigueTrue) then {
player enableFatigue false;
};

player addAction ["Get a Ride" , "ZKS\Vehicles\pickup.sqf",[0],10,false,false,"","((((cursorTarget emptyPositions 'cargo') > 0) or ((cursorTarget emptyPositions 'gunner') > 0)) and (side cursorTarget == side player) and ((cursorTarget emptyPositions 'driver') == 0))"];




//[player] execFSM "ZKS\Counter\Player_Hud.fsm";
//sleep 1;
[] execVM "ZKS\Code\Player\CodeStarter.sqf";
sleep 1;
player addEventHandler["Dammaged",{[(_this select 0),(side (_this select 0))] execFSM "ZKS\Sound\Sounds_Say.fsm";}];

[] execVM "ZKS\ZKS_Start\Player\friend_map.sqf";


_colour = "";
_side = side player;

  	switch (_side) do 
	{
	case West : {_colour = "colorblue"};

	case East : {_colour = "colorred"};

	case RESISTANCE : {_colour = "colorgreen"};

	};



_markers = ["base1","base2","base3","base4","base5","base6","base7","base8","base9","base10","base11","base12"];
_i = 0;


while {(getmarkercolor (_markers select _i) != _colour)} do
{
_i = _i + 1;
sleep .1;
if (_i == 12) then {_i = 0};
};

player setpos getmarkerpos (_markers select _i);
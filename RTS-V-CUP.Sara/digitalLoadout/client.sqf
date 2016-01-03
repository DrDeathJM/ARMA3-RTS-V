//

_doPresent = _this select 0;

if (isDedicated) exitWith {};

waitUntil {!(isNull Player)};
waitUntil {(local player)};

loadChange = compileFinal preprocessFile "digitalLoadout\loadChange.sqf";
TAG_loadoutRespawnDialog = compileFinal preprocessFile "digitalLoadout\respawnUI.sqf";
TAG_missionStart_UI = compileFinal preprocessFile "digitalLoadout\missionStartUI.sqf";

if (_doPresent) then {
    waitUntil { time > 1 };

    switch (side player) do {
        case west: {
            if (faction player == "BLU_G_F") then {
                [] call compile preprocessFile "digitalLoadout\LoadoutsFia.sqf";
            } else {
                [] call compile preprocessFile "digitalLoadout\LoadoutsBlu.sqf";
            };
        };
        case resistance : {[] call compile preprocessFile "digitalLoadout\LoadoutsInd.sqf";};
        case east : {[] call compile preprocessFile "digitalLoadout\LoadoutsOpf.sqf";};
    };

      waitUntil {!isnil "BIS_fnc_establishingShot_playing" && {!BIS_fnc_establishingShot_playing}};
      call TAG_MissionStart_UI;
      [player] call TAG_FNC_Rifleman;
};

//

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

GetSideID = {
    (0)
};

GetClientID = {
    (0)
};

GetNamespace = {
    (0)
};

Zen_RTS_F_RequestEconomyData = {
    (owner _this) publicVariableClient "Zen_RTS_Economy_Data";
};

Zen_RTS_F_RespawnActions = {
    // player sideChat "Respawn Actions Running";
    while {true} do {
        0 = [player] spawn Zen_RTS_DeployPlayer;

        waitUntil {
            sleep 2;
            (alive player)
        };

        0 = [player, player, 0] spawn RTS_FNC_INIT_PLAYERACTIONS;

        waitUntil {
            sleep 2;
            !(alive player)
        };
    };
};

Zen_RTS_F_ModifyMoney = {
    playerMoney = playerMoney + _this;
};

Zen_RTS_F_SetMoney = {
    playerMoney = _this;
};

Zen_RTS_F_PrintMoney = {
    _moneyPerMinute = _this select 0;
    _supply = _this select 1;
    _supplyPerMinute = _this select 2;
    _side = _this select 3;

    if ((side player) == _side) then {
        ctrlSetText [idMoney, format ["Funds : %1 +%2/min", floor playerMoney, _moneyPerMinute]];
        ctrlSetText [idSupply, format ["Supply: %1 +%2/min", floor _supply, _supplyPerMinute]];
        ctrlSetText [idFPS, format ["FPS: %1", round diag_fps]];
    };
};

Zen_RTS_F_CommanderQueueAdd = {
    _unit = _this select 0;
    _side = _this select 1;

    _subArray = Zen_RTS_CommanderQueue select ([west, east] find _side);
    _subArray pushBack _unit;
};

Zen_RTS_F_GiveMoneyDialogOK = {
    _moneyString = _this select 0;
    _receivingPlayer = _this select 1;

    _invalidEntry = false;
    if (count toArray _moneyString == 0) then {
        _invalidEntry = true;
    } else {
        {
            if (_x < 48 || _x > 57) exitWith {
                _invalidEntry = true;
            };
        } forEach (toArray _moneyString);
    };

    if (_invalidEntry) exitWith {
        player groupChat "Invalid characters entered.";
        // 0 = [] call Zen_RefreshDialog;
    };

    _money = call compile _moneyString;

    if (_money > playerMoney) exitWith {
        player groupChat "You don't have that much money.";
        // 0 = [] call Zen_RefreshDialog;
    };

    (-_money) call Zen_RTS_F_ModifyMoney;
    ZEN_FMW_MP_REClient("Zen_RTS_F_ModifyMoney", _money, call, _receivingPlayer)

    player groupChat ("You donated $" + str _money + " to " + name _receivingPlayer);
    0 = [] call Zen_CloseDialog;
    0 = [] spawn Zen_RTS_AlphaMenu;
};

Zen_RTS_F_GiveMoneyDialogCancel = {
    0 = [] call Zen_CloseDialog;
    0 = [] spawn Zen_RTS_AlphaMenu;
};

Zen_RTS_F_GiveMoneyDialogRefresh = {
    0 = [] call Zen_CloseDialog;
    0 = [] spawn Zen_RTS_GiveMoney;
};

Zen_RTS_F_AddSpawnGridMarker = {
    _marker = _this select 0;
    _side = _this select 1;

    if (isNil "RTS_Building_Spawn_Grid_Markers") then {
        RTS_Building_Spawn_Grid_Markers = [[], []];
    };

    (RTS_Building_Spawn_Grid_Markers select ([west, east] find _side)) pushBack _marker;
};

Zen_RTS_F_RemoveSpawnGridMarker = {
    _marker = _this select 0;
    _side = _this select 1;

    0 = [(RTS_Building_Spawn_Grid_Markers select ([west, east] find _side)), _marker] call Zen_ArrayRemoveValue;
};

Zen_RTS_F_AddRecycleQueue = {
    _vehicle = _this select 0;
    (RTS_Recycle_Queue select (([west, east] find ([_vehicle] call Zen_GetSide)) max 0)) pushBack _vehicle;
};

Zen_RTS_F_RemoveRepairQueue = {
    _building = _this select 0;
    _side = _this select 1;

    0 = [(RTS_Repair_Queue select ([west, east] find _side)), _building] call Zen_ArrayRemoveValue;
};

// Zen_RTS_F_RemoveRecycleQueue = {
    // _vehicle = _this select 0;
    // _side = _this select 1;

    // 0 = [(RTS_Recycle_Queue select ([west, east] find _side)), _vehicle] call Zen_ArrayRemoveValue;
// };

// run only on the server

_cancelButton = ["Button",
    ["Size", [5,2]],
    ["Position", [35, 4]],
    ["Text", "Cancel"],
    ["ActivationFunction", "Zen_RTS_F_GiveMoneyDialogCancel"]
] call Zen_CreateControl;

_refreshButton = ["Button",
    ["Size", [5,2]],
    ["Position", [35, 6]],
    ["Text", "Refresh"],
    ["ActivationFunction", "Zen_RTS_F_GiveMoneyDialogRefresh"]
] call Zen_CreateControl;

_currentMoney = ["Text",
    ["Size", [5,2]],
    ["Position", [0, 0]],
    ["Text", "$0"]
] call Zen_CreateControl;

_enterMoneyField = ["TextField",
    ["Size", [5,2]],
    ["Position", [35, 0]],
    ["Text", ""]
] call Zen_CreateControl;

_dollarSign = ["Text",
    ["Size", [1,2]],
    ["Position", [34, 0]],
    ["Text", "$"]
] call Zen_CreateControl;

_playerList = ["List",
    ["Size", [29, 11.5]],
    ["Position", [5, 0]],
    ["List", []],
    ["ListData", []]
] call Zen_CreateControl;

_giveButton = ["Button",
    ["Size", [5,2]],
    ["Position", [35, 2]],
    ["Text", "Give"],
    ["LinksTo", [_enterMoneyField, _playerList]],
    ["ActivationFunction", "Zen_RTS_F_GiveMoneyDialogOK"]
] call Zen_CreateControl;

_giveMoneyDialog = [] call Zen_CreateDialog;
{
    0 = [_giveMoneyDialog, _x] call Zen_LinkControl;
} forEach [_cancelButton, _refreshButton, _currentMoney, _enterMoneyField, _dollarSign, _playerList, _giveButton];

Zen_RTS_GiveMoneyDialog_Current_Money_Control = _currentMoney;
Zen_RTS_GiveMoneyDialog_Player_List = _playerList;
Zen_RTS_GiveMoneyDialog_Dialog = _giveMoneyDialog;

publicVariable "Zen_RTS_GiveMoneyDialog_Current_Money_Control";
publicVariable "Zen_RTS_GiveMoneyDialog_Player_List";
publicVariable "Zen_RTS_GiveMoneyDialog_Dialog";

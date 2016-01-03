//

if (_Zen_Is_JIP) then {
    Zen_Task_Array_Global = 1;
    Zen_MP_Closure_Packet = ["Zen_SyncJIPServer", player];
    publicVariableServer "Zen_MP_Closure_Packet";

    waitUntil {
        (!(isNil "Zen_JIP_Args_Server") && (typeName Zen_Task_Array_Global == "ARRAY"))
    };

    _overcast = Zen_JIP_Args_Server select 0;
    _fog = Zen_JIP_Args_Server select 1;
    _viewDist = Zen_JIP_Args_Server select 2;

    0 = [["overcast", _overcast], ["fog", _fog], ["packet", false]] spawn Zen_SetWeather;
    0 = [_viewDist, -1, -1, false] call Zen_SetViewDistance;

    if (((missionConfigFile >> "disabledAI") isEqualTo 1) || ((count ([player] call Zen_GetUnitTasks)) == 0)) then {
        private ["_refUnit"];
        _refUnitArray = (units group player) - [player];
        if (count _refUnitArray == 0) then {
            _refUnit = (([side player] call Zen_ConvertToObjectArray) - [player]) select 0;
        } else {
            _refUnit = _refUnitArray select 0;
        };

        // Due to the nature of actions in MP, the framework's actions must be added this way
        0 = [([side player] call Zen_ConvertToObjectArray) - [player], false] call Zen_AddGiveMagazine;
        0 = [player] call Zen_AddGiveMagazine;

        0 = [([side player] call Zen_ConvertToObjectArray) - [player], false] call Zen_AddRepackMagazines;
        0 = [player] call Zen_AddRepackMagazines;

        if (vehicle _refUnit != _refUnit) then {
            player moveInAny (vehicle _refUnit);
            if (vehicle player == player) then {
                player setPosATL ([_refUnit, 2 + random 3, random 360] call Zen_ExtendPosition);
            };
        } else {
            player setPosATL ([_refUnit, 2 + random 3, random 360] call Zen_ExtendPosition);
        };

        {
            0 = [_x, player] call Zen_ReassignTask;
        } forEach ([_refUnit] call Zen_GetUnitTasks);
    } else {
        0 = [_playerGroup, false] call Zen_AddGiveMagazine;
        0 = [_playerGroup, false] call Zen_AddRepackMagazines;

        {
            0 = [(_x select 1), (_x select 4), (_x select 5), (_x select 3), false, (_x select 0), (_x select 6)] call Zen_InvokeTaskClient;
            0 = [(_x select 0)] call Zen_UpdateTask;
            sleep 0.1;
        } forEach Zen_Task_Array_Global;
    };
};

if (isServer) then {
    Zen_SyncJIPServer = {
        Zen_JIP_Args_Server set [0, overcast];
        Zen_JIP_Args_Server set [1, fog];

        (owner _this) publicVariableClient "Zen_Task_Array_Global";
        (owner _this) publicVariableClient "Zen_Fire_Support_Array_Global";
        (owner _this) publicVariableClient "Zen_Loadout_Array_Global";
        (owner _this) publicVariableClient "Zen_Damage_Increase";
        (owner _this) publicVariableClient "Zen_JIP_Args_Server";

        // Territory Information for JIP Clients
        (owner _this) publicVariableClient "WestFC";
        (owner _this) publicVariableClient "EastFC";
        (owner _this) publicVariableClient "GuerFC";
        (owner _this) publicVariableClient "CivFC";
        (owner _this) publicVariableClient "FlagNumber";

        // Victory Point Information for JIP Clients
        (owner _this) publicVariableClient "rts_vpTickerWest";
        (owner _this) publicVariableClient "rts_vpTickerEast";

        // Resource variables for JIP clients
        // (owner _this) publicVariableClient "WestSupplyFactor";
        (owner _this) publicVariableClient "WestSupply";

        // (owner _this) publicVariableClient "EastSupplyFactor";
        (owner _this) publicVariableClient "EastSupply";

        // Building Placeholder Vars so JIP clients will have base buildings
        // (owner _this) publicVariableClient "WestBarracksTmp";
        // (owner _this) publicVariableClient "WestLightFacTmp";
        // (owner _this) publicVariableClient "WestHeavyFacTmp";
        // (owner _this) publicVariableClient "WestAirFacTmp";
        // (owner _this) publicVariableClient "WestNavalFacTmp";

        // (owner _this) publicVariableClient"EastBarracksTmp";
        // (owner _this) publicVariableClient"EastHeavyFacTmp";
        // (owner _this) publicVariableClient"EastLightFacTmp";
        // (owner _this) publicVariableClient"EastAirFacTmp";
        // (owner _this) publicVariableClient"EastNavalFacTmp";
        // ;
        // (owner _this) publicVariableClient"WestBarracksLevel";
        // (owner _this) publicVariableClient"WestLightFacLevel";
        // (owner _this) publicVariableClient"WestHeavyFacLevel";
        // (owner _this) publicVariableClient"WestAirFacLevel";
        // ;
        // (owner _this) publicVariableClient"EastBarracksLevel";
        // (owner _this) publicVariableClient"EastLightFacLevel";
        // (owner _this) publicVariableClient"EastHeavyFacLevel";
        // (owner _this) publicVariableClient"EastAirFacLevel";

        // Update West Assets with public array
        // rts_updateArray = str [West,WestAssets];
        // (owner _this) publicVariableClient "rts_updateArray";

        // Update East Assets with public array
        // rts_updateArray = str [East,EastAssets];
        // (owner _this) publicVariableClient "rts_updateArray";
    };
};

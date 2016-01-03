//

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

0 = _this spawn {
    _Zen_stack_Trace = ["Zen_RTS_BuildMenuStructures", _this] call Zen_StackAdd;
    // _mcu = _this select 0;
    _player = _this select 1;

    _mcu = vehicle _player;

    // ActionUnit = _mcu;
    // Activator = _player;

    _side = side _player;
    _side2 = [East, West] select ([West, East] find _side);

    // sleep 0.2;
    CloseDialog 0;

    _mcuSide = if (_mcu isEqualTo WestTruck) then {(West)} else {(East)};
    _mcuCommander = call compile format ["%1Commander", _mcuSide];

    if (_player != _mcuCommander) exitWith {
        // _found = false;
        player groupChat format ["Only the %1 commander is authorized for this interface.", _mcuSide];
    };

    if (_side != _mcuSide) exitWith {
        // _found = false;
        player groupChat format ["Side %1 is not authorized for this interface.", _side];
    };

    /**
    _MCUVehs = [WestTruck, EastTruck];
    _type = typeOf _mcu;
    _found = true;
    {
        // _unitType = _x select 0;
        // _mcuName = _x;
        // bName = _mcuName;

        _mcuSide = if (_x isEqualTo WestTruck) then {(West)} else {(East)};
        _mcuCommander = call compile format ["%1Commander", _mcuSide];

        if (_player != _mcuCommander) exitWith {
            _found = false;
            player groupChat format ["Only the %1 commander is authorized for this interface.", _mcuSide];
        };

        if (_side != _mcuSide) exitWith {
            _found = false;
            player groupChat format ["Side %1 is not authorized for this interface.", _side];
        };

        if !(alive _mcu) exitWith {
            _found = false;
            player groupChat "MCU not available.";
        };
    // } forEach ([_MCUVehs, compile format ["!( (toLower (_this select 0) isEqualTo toLower '%1'))", _type]] call Zen_ArrayFilterCondition);
    } forEach _MCUVehs;

    if !(_found) exitWith {
        hintSilent "Not Found";
        player groupChat format ["Build Type:  %1, CheckType:  %2", _type, ""];
    };
    //*/

    sleep 0.1;
    _idDlgBuild = 2002;
    _idlist = 2000;
    _idgoback = 2001;
    _idbuild = 2005;
    _idbuildyou = 2015;
    _idRepair = 2020;
    _idsquadlist = 2025;
    _idsquadlistbk = 2026;
    _idtitle = 1050;

    _idRecycle = 2016;
    _idListCustom = 2030;
    _idBgdCustom = 2031;

    _idDroplist = 2045;
    _idstats = 500;
    _indnum1 = 0;
    _indnum2 = 0;

    _idSldQ = 1030;
    _idLightQ = 1032;
    _idHeavyQ = 1034;
    _idAirQ = 1036;
    // // _idNavalQ = 1041;

    _idInfQButton = 1031;
    _idLightQButton = 1033;
    _idHeavyQButton = 1035;
    _idAirQButton = 1039;
    // _idNavalQButton = 1042;

    createDialog "DlgBuild";
    {
        ctrlShow [_x, false];
    } forEach [_idgoback, _idSquadList, _idSquadListbk, _idListCustom, _idBgdCustom, _idstats, _idLightQButton, _idHeavyQButton, _idAirQButton, _idLightQ, _idHeavyQ, _idAirQ, _idSldQ, _idInfQButton, _idDroplist];

    _idSel = 0;
    // while {((ctrlVisible _idlist) && {(alive _player)})} do {
        // Clear the Stats list to repopulate
        // _stats = [_side, _side2] call compile preprocessFileLineNumbers "functions\rts-statistics-array.sqf";
        // lbClear _idStats;

        // {
            // _info = format ["%1 - %2", (_x select 0), (_x select 1)];
            // _index = lbAdd [_idStats, _info];
        // } forEach _stats;

        // Set Button names
        ctrlSetText [_idbuild, "Deploy"];
        ctrlSetText [_idtitle, "Base Construction Menu"];
        ctrlSetText [_idbuildYou, "Destroy"];
        ctrlSetText [_idRepair, "Repair Building"];
        ctrlSetText [_idRecycle, "Recycle Building"];

        buttonSetAction [_idBuild, "2000 call Zen_RTS_BuildStructure"];
        buttonSetAction [_idbuildYou, "2000 call Zen_RTS_DestroyStructure"];
        buttonSetAction [_idRepair, "['Repair', ['Building', 'BuildingRuins']] spawn Zen_RTS_RecycleRepair"];
        buttonSetAction [_idRecycle, "['Recycle', ['Building', 'BuildingRuins']] spawn Zen_RTS_RecycleRepair"];

        // Clear the Vehicle build list to repopulate
        lbClear _idlist;
        {
            _bldData = [_x] call Zen_RTS_StrategicBuildingTypeGetData;
            _descrRaw = _bldData select 5;

            _descrText = ("Cost: " + ([_descrRaw, "Cost: ", ","] call Zen_StringGetDelimitedPart)) + (", Time: " + ([_descrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart));
            _info = (_bldData select 4) + ", " + _descrText;

            _index = lbAdd [_idlist, _info];
            lbSetData [_idlist, _index, _x];
            // lbSetValue [_idlist, _index, _bldTime]

            _pic = [_descrRaw, "Picture: ", ","] call Zen_StringGetDelimitedPart;
            if (_pic == "") then {
                _type = [_descrRaw, "Classname", ","] call Zen_StringGetDelimitedPart;
                if (_type != "") then {
                    _pic = getText (configFile >> "CfgVehicles" >> _type >> "picture");
                    // player sidechat str _pic; // debug
                    lbSetPicture [_idlist, _index, _pic];
                };
            } else {
                // player sidechat str _pic; // debug
                lbSetPicture [_idlist, _index, _pic];
            };
        } forEach (RTS_Used_Building_Types select ([West, East] find _side));

        lbSetCurSel [_idlist, _idSel];
        // sleep 30;
        _idSel = lbCurSel _idList;
    // };

    call Zen_StackRemove;
    if (true) exitWith {};
};

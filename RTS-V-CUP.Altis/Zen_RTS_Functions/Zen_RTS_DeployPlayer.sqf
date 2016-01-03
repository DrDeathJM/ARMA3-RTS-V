// ;;Exec'd by !Alive Player trigger in the mission
// ;;RTS_PlayerRespawnDelay is set in init.sqs
// ;;rts_respawn is set true by a button in the DLGRespawn Menu (description.ext)

// if (StopMsg) then {Exit};

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf";
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf";

_unit = _this select 0;

if ((isServer) && {(_unit != player)} && {(local _unit)}) then {
    // sleep 5;
    // _unit = call compile _unitstring
} else {
    // if (!isNil {PLAYER_RESPAWN}) exitWith {};
    if (_unit != player) exitWith {};

    CloseDialog 0;
    rts_respawn = false;

    _idclabel = 1310;
    _idcTimerNumber = 1311;
    _idcList = 1312;
    _idcbutton = 1313;
    _idcTimerText = 1308;

    /** Music
    _num = random 10;
    _num=(_num+.05)-((_num+.05) mod 1);
    ?_num == 0 : _num = 24;
    _music = format ["atrack%1",_num];

    ?_num == 0 : _music = "rtsTheme";

    0 fadeMusic .6;
    playMusic _music;
    //*/

    /** Camera
        sleep 1;
    _cam = "camera" camCreate [0,0,0];
    _cam cameraEffect ["internal","back"];

    _cam camSetTarget vehicle _unit;
    _cam camSetRelPos [0,.5,1.5];
    _cam camSetFOV 1.4;
    _cam camCommit 0;

    sleep 1;
    _cam camSetRelPos [0,1.5,10];
    _cam camCommit 5;

    waitUntil {
        sleep 1;
        (camCommitted _cam)
    };
    //*/

    waitUntil {
        sleep 1;
        (alive player)
    };

    _side = side player;
    player addEventHandler rts_killedSld;
    (group Player) selectLeader player;
    0 = [player] call Zen_AddRepackMagazines;
    // [player,"Death"] call BIS_fnc_setUnitInsignia;
    execVM "RTS_JUMPACTIONS.sqf";

    player addEventHandler ["fired","_count = player ammo (currentWeapon player); if(_count != 0) then {magazineClass = currentMagazine player;};  if(_count == 0) then {player addMagazine magazineClass; reload player;};"];
    player enableFatigue false;
    player addEventHandler ["Respawn", {player enableFatigue false}];

    onMapSingleClick "[_pos, _units, _shift, _alt] exec ""onMapSingleClick.sqs""";

    _args = [player, side player];
    ZEN_FMW_MP_REServerOnly("Zen_RTS_F_CommanderQueueAdd", _args, call)
    // waitUntil {
        // sleep 1;
        // (rts_arrays_initialized)
    // };

    _mcu = call compile format ["%1Truck",_side];
    // _mcuName = call compile format ["%1MCUName",_side];

    // _assets = call compile format ["%1Assets",_side];
    // _n = count _assets
    // _x = 0
    // _baseList = []

    // #CreateList
    // ~.1
    // _bldName = _assets select _x select 0
    // _varName = _assets select _x select 3

    // _var = call compile _varName

    // ?format ["%1",_var] != undefined_var && !isNull _var : _baseList = _baseList + [[_bldName,_varName]];

    // ?Alive call compile _varName : _baseList = _baseList + [[_bldName,_varName]];

    // ;;player groupChat format ["%1  |  %2",_bldName,_varName];

    // _x = _x + 1

    // ?_x < _n : goto "CreateList"

    // ?count _baseList < 1 : _baseList = [[_mcuName,STR _mcu]];

    // ;;player groupChat format ["%1",_baseList];

    _timer = rts_playerRespawnDelay;
    sleep _timer;

    // _rn = random 1
    // _n1 = +10
    // ?_rn <= .5 : _n1 = -10

    // _rn = random 1
    // _n2 = -10
    // ?_rn <= .5 : _n2 = +10

    // execVM "starter.sqf";

    // #Loadout
    // ;;execVM "RTS-Player_actions.sqf";
    // #LoadoutLoop
    // ~1
    // ?StopMsg : CloseDialog 0; Exit
    // ?_timer > 0 : _timer = _timer - 1
    // ?!Alive Player : Goto "EndLoop"
    // ?CtrlVisible 1051 : Goto "LoadoutLoop"

    // #Dialog
    // _x = 0

    // sleep 5;
    _cam = "camera" camCreate [0,0,0];
    _cam cameraEffect ["internal","back"];

    _respawnloc = getPosATL _mcu;
    _camTarget = _mcu;
    while {true} do {
        createDialog "DLGRespawn";
        lbClear _idcList;
        ctrlShow [_idcbutton, true];
        // ctrlShow [_idclabel, false];

        // #ListLoop

        // _bldName = _baseList Select _x Select 0;
        // _varName = _baseList Select _x Select 1;


        // ;;titletext [format ["%1\n%2",_bUnit,_bName],"PLAIN"];

        // ;;?format ["%1",call compile format["%1", _bUnit]] == undefined_var : Goto "Skip"
        // ;;?IsNull call compile format ["%1",_bUnit] : Goto "Skip"

        // #AddList
        // _info = _bldName

        _index = lbAdd [_idcList, "MCU"];
        lbSetData [_idcList, _index, str _mcu];
        lbSetValue [_idcList, _index, 0];

        _sideFlags = [[1], [[1, 1]], [compile format ["(if (str _this isEqualTo '%1') then {1} else {0})", str side player]]] call Zen_RTS_SubTerritorySearch;
        {
            _flagData = [_x] call Zen_RTS_SubTerritoryGetData;
            _index = lbAdd [_idcList, _flagData select 2];
            lbSetData [_idcList, _index, _x];
            lbSetValue [_idcList, _index, 1];
        } forEach _sideFlags;
        
        // #LBAdd

        // _x = _x + 1
        // ?_x < Count _baseList : Goto "ListLoop"

        // ?lbSize _idcList <= 0 : _info = _mcuName; _unitInfo = Format["%1",_mcu]; Goto "LBAdd"

        lbSetCurSel [_idcList, 0];
        ctrlSetText [_idcTimerNumber, "60"];
        // _index = lbCurSel _idcList;
        // _data = lbData [_idcList, _index];

        // _camTarget = call compile format ["%1",_data];
        // _cam camSetTarget (getPosATL _camTarget);
        // _cam camSetRelPos [0,-20,10];
        // _cam camCommit 0;

        _maxTime = 60;
        for "_i" from 1 to _maxTime step 1 do {
            // if (StopMsg) exitWith {closeDialog 0;};
            if !(ctrlVisible _idcList) exitWith {};
            if (_i == _maxTime) then {rts_respawn = true};
            if (rts_respawn) exitWith {};

            _index = lbCurSel _idcList;
            _data = lbData [_idcList, _index];
            _dataType = lbVAlue [_idcList, _index];

            _camTarget = [0,0,0];
            switch (_dataType) do {
                case 0: {
                    _camTarget = getposATL (call compile format ["%1",_data]);
                };
                case 1: {
                    _camTarget = markerPos _data;
                };
            };

            // _timertext = Format["%1",_timer];
            // CtrlSetText [_idctimer,_timertext];
            // ?_timer <= 0 : ctrlshow [_idcbutton,TRUE];
            // ?_timer > 0 : _timer = _timer - 1;

            _respawnLoc = _camTarget;
            _cam camSetTarget _camTarget;

            _camY = -20;
            // _text = lbText [_idcList, _index];
            // ?_text in ["Forward Base Perimeter"] : _camY = -400;
            // ?_text in ["Back Base Perimeter"] : _camY = +400;
            _cam camSetRelPos [0, _camY, 10];
            _cam camCommit 0;
            ctrlSetText [_idcTimerNumber, str (_maxTime - _i)];
            sleep 1;
        };

        // CtrlSetText [_idclabel,_text];
        if (!(rts_respawn) && {!(ctrlVisible _idcList)}) then {
            cutText ["DON'T EXIT THE MENU USING ESC!","PLAIN"];
        };
        if (rts_respawn) exitWith {};
    };

    closeDialog 0;
    // 2 fadeMusic 0;
    // ?_text in ["Forward Base Perimeter"] : _dist = -400
    // ?_text in ["Back Base Perimeter"] : _dist = +400

    player setposATL ([_respawnloc, 12, random 360] call Zen_ExtendPosition);

    player switchCamera "INTERNAL";
    player cameraEffect ["terminate","back"];
    camDestroy _cam;

    // /**
    sleep 2;
    [player] call TAG_loadoutRespawnDialog;
    //*/

    /** Music
    5 fadeMusic 0;
    sleep 1
    player reveal _camTarget;
    sleep 5;
    playMusic "";
    //*/

    // ?rts_PlayerInit : goto "End"

    // rts_hq sideChat "Initializing group Markers for JIP"
    // _g = units group Player - [player]
    // _c = count _g
    // ?_c < 1 : goto "End"
    // _x = 0
    // #group
    // ~1
    // _unit = _g select _x
    // _unit exec "rts-unit-markers.sqs"
    // _x = _x + 1

    // ?_x < _c : goto "Group"

    // #End
    // rts_PlayerInit = TRUE

    // Exit
};

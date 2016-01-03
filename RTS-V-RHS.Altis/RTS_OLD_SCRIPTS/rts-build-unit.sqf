// http://pastebin.com/jVnWqHpE

#define DEBUG false

private ["_f_Denied", "_idc", "_idc2", "_manned", "_forSquad", "_msg", "_buildFor", "_squadName", "_ind", "_customArray", "_num", "_side", "_bld", "_bldString", "_index", "_text", "_type", "_available", "_qnum", "_qName", "_active", "_var1", "_var2", "_player", "_playerName", "_actionunit", "_index2", "_text2", "_unitNum", "_vArray", "_bldName", "_qTextID", "_qButtonID", "_cString", "_foundType", "_unitType", "_mA", "_name", "_class", "_bTime", "_oil", "_ore", "_energy", "_credits", "_dist", "_pos", "_posX", "_posY", "_qTime", "_wait", "_info", "_doRefund", "_timeLeft", "_spawnedUnit", "_vehicle"];

_f_Denied = {
    player groupChat _this;
    call compile format ["%1QActive = FALSE", _bldString];
    call compile format ["%1QNum = %1QNum - 1", _bldString];
    ctrlSetText [_qTextID, _info];
    if (true) exitWith {};
};

if (isNil (missionNamespace getVariable "RTS_Build_Unit_MP_Manned_Veh")) then {
    RTS_Build_Unit_MP_Manned_Veh = {
        _this lock true;
        _this addAction ["[UNLOCK]", "rts-vcl-LockFalse.sqs"];
    };
    publicVariable "RTS_Build_Unit_MP_Manned_Veh";
};

// Check integrity of all global variables
if (DEBUG) then {
    player sideChat "rts-build-unit.sqf global variables logged";
    diag_log ("rts-build-unit.sqf at " + str time + " with " + str _this + ", Global variable check");
    diag_log ("ActionUnit: " + str ActionUnit);
    diag_log ("Activator: " + str Activator);
    diag_log ("rts_tmpstring: " + str rts_tmpstring);
    diag_log ("vArray: " + str vArray);
    diag_log ("BName: " + str BName);
    diag_log ("EastBarracksName: " + str EastBarracksName);
    diag_log ("WestBarracksName: " + str WestBarracksName);
    diag_log ("EastLightFacName: " + str EastLightFacName);
    diag_log ("WestLightFacName: " + str WestLightFacName);
    diag_log ("EastHeavyFacName: " + str EastHeavyFacName);
    diag_log ("WestHeavyFacName: " + str WestHeavyFacName);
    diag_log ("EastAirFacName: " + str EastAirFacName);
    diag_log ("WestAirFacName: " + str WestAirFacName);
    //diag_log ("EastHQFacName: " + str EastHQFacName);
    //diag_log ("WestHQFacName: " + str WestHQFacName);
    diag_log ("param1: " + str param1);
    diag_log ("rts_debug: " + str rts_debug);
    diag_log ("AICount: " + str AICount);
    diag_log ("AILimit: " + str AILimit);
    diag_log ("playerMoney: " + str playerMoney);
    diag_log ("rts_name: " + str rts_name);
    diag_log ("rts_hq: " + str rts_hq);
    diag_log ("rts_killedSld: " + str rts_killedSld);
};

// This is for double click on MCU build menu to re-route it
if (typeOf ActionUnit in ["B_MRAP_01_F","O_MRAP_02_F"]) exitWith {
    2000 exec "rts-build-structures.sqs";
};

_idc = _this select 0;
_idc2 = _this select 1;
_manned = _this select 2;
_forSquad = _this select 3;

_msg = "";
_buildFor = player;
if !(_forSquad) then {
    _buildFor = Activator;
};

if (_idc2 == 2030) then {
    _ind = lbCurSel _idc2;
    _squadName = lbText [_idc2, _ind];
    _customArray = lbData [_idc2, _ind];
    _num = lbValue [_idc2, _ind];
};

if (rating Activator < 0) then {
    Activator addRating ((rating player * -1));
};

_side = Side Activator;
_bld = call compile rts_tmpstring;
_bldString = rts_tmpString;

if (call compile format ["%1QNum >= rts_maxQueueSize", _bldString]) exitWith {
    player groupChat "Deployment queue is full, try again after current order is complete.";
};

call compile format ["%1QNum = %1QNum max 0;", _bldString];

if (DEBUG) then {
    player groupChat _bldString;
};

_index = lbCurSel _idc;
_text = lbText [_idc, _index];
_type = lbData [_idc, _index];
_available = lbValue [_idc, _index];

if (toLower _type isEqualTo "none") exitWith {
    0 = "This asset automatically activates certain abilities.  Nothing is built here." call _f_Denied;
};

call compile format ["%1QNum = %1QNum + 1", _bldString];
_qnum = call compile format ["%1QNum", _bldString];
_qName = call compile format ["%1Name", _bldString];

player groupChat format ["Queueing %1 %2 unit(s) queued at %3", _text, _qnum, _qName];

waitUntil {
    sleep 1;

    if !(alive _bld) exitWith {
        0 = (format ["%1 is Offline.  Unit build Aborted.", _qName]) call _f_Denied;
    };

    _active = call compile format ["%1QActive", _bldString];
    if (!_active) then {
        _var1 = call compile format ["%1QNum", _bldString];
        _var2 = call compile format ["%1QActive", _bldString];

        if (DEBUG) then {
            player groupChat format ["ReduceA: _qnum: %1, QNum: %2, QActive?: %3, bldstring: %4", _qnum, _var1, _var2, _bldString];
        };

        _qnum = _qnum - 1;
    };
    (_qnum <= 1 && {!_active})
};

call compile format ["%1QActive = TRUE", _bldString];
call compile format ["%1QNum = %1QNum - 1", _bldString];

_var1 = call compile format ["%1QNum", _bldString];
_var2 = call compile format ["%1QActive", _bldString];
if (DEBUG) then {
    player groupChat format ["ReduceB: _qnum: %1, QNum: %2, QActive?: %3, _text: %4", _qnum, _var1, _var2, _text];
};

_player = Activator;
_playerName = Name _player;
_actionunit = ActionUnit;

_index2 = lbCurSel _idc2;
_text2 = lbText [_idc2, _index2];
_unitNum = lbValue [_idc2, _index2];

_vArray = vArray;
_bldName = BName;

// This will show queue status when enabled
switch (true) do {
    case (_bldName in [EastBarracksName,WestBarracksName]): {
        _qTextID   = 1030;
        _qButtonID = 1031;
        _cString   = "Sld";
    };
    case (_bldName in [EastLightFacName,WestLightFacName]): {
        _qTextID   = 1032;
        _qButtonID = 1033;
        _cString   = "Vcl";
    };
    case (_bldName in [EastHeavyFacName,WestHeavyFacName]): {
        _qTextID   = 1034;
        _qButtonID = 1035;
        _cString   = "Vcl";
    };
    case (_bldName in [EastAirFacName,WestAirFacName]): {
        _qTextID   = 1036;
        _qButtonID = 1039;
        _cString   = "Air";
    };
   // case (_bldName in [EastHQFacName,WestHQFacName]): {
    //    _qTextID   = 2036;
   //     _qButtonID = 2037;
   //     _cString   = "Air";
    //};
    default {
        _qTextID   = 0;
        _qButtonID = 0;
        _cString   = "None";
    };
};

call compile format ["Cancel%1 = FALSE",_cString];
ctrlSetText [_qTextID, "Empty"];
_name = ""; 
_foundType = false;
{
    _unitType = _x Select 0;
    if (_unitType == _type) exitWith {
        _foundType = true;
        _mA = _x;
    };
} forEach _vArray;

if !(_foundType) exitWith {
    hintSilent "Not Found";
    player groupChat format ["Build Type:  %1, CheckType:  %2", _type, _unitType];
    call compile format ["%1QActive = FALSE",_bldString];
};

_type = _mA Select 0;
_name = _mA select 1;
_class = _mA Select 2;
_bTime = _mA select 3;
_oil = _mA select 4;
_ore = _mA select 5;
_energy = _mA select 6;
_credits = _mA select 7;

if (rts_debug) then {
    _oil = 0;
    _ore = 0;
    _energy = 0;
    _credits = 0;
};

if (_idc2 == 2030) then {
    _oil = 0;
    _ore = 0;
    _energy = 2;
    _credits = 10;
};

AICount = {!(isPlayer _x)} count units _player;

if (((_class == "troop") && (AICount >= AILimit)) || {((_idc2 == 2030) && (AICount >= AILimit))}) exitWith {
    0 = (format ["Limit of %1 Soldiers is already reached.  You can train more if one dies.", AILimit]) call _f_Denied;
};

if (_manned && {AICount >= AILimit}) exitWith {
    0 = (format ["Limit of %1 Soldiers is already reached.  You can train more if one perishes horribly.", AILimit]) call _f_Denied;
};

if (playerMoney < _credits) exitWith {
    0 = (format ["Insufficient funds.  %1 Cancelled.",_name]) call _f_Denied;
};

_dist = -30;
if (rts_name in [EastAirFacName, WestAirFacName]) then {
    _dist = -50 - random 30;
};

_pos = [_bld, _dist, getDir _bld] call Zen_ExtendPosition;
_posX = _pos select 0;
_posY = _pos select 1;
posX = _posX;
posY = _posY;

if (rts_debug) then {
    _btime = 3;
};

if (_idc2 == 2030) exitWith {
    [_posX, _posY, (getDir _bld) - 180, _squadName, _customArray, _num] exec "rts-build-squad.sqs";
};

_qTime = time;
_wait = time + _bTime;
rts_hq sideChat format ["Building %1, %2 Seconds remaining.  $%3 deducted.", _name, _bTime, _credits];

playerMoney = playerMoney - _credits;
_info = format ["%1 ready in %2 seconds.", _name, _bTime];

_doRefund = false;
waitUntil {
    sleep 1;
    _timeLeft = _wait - time;
    _timeLeft = (_timeLeft + 0.01) - ((_timeLeft + 0.01) mod 1);

    if (_qTime < time) then {
        _info = format ["%1 - %2 seconds.", _name, _timeLeft];
        _qTime = time + 1;
    };

    ctrlSetText [_qTextID, _info];

    if (!alive _bld) exitWith {
        _msg = format ["%1 is Offline.  %2 Aborted.", _bldName, _name];
        _doRefund = true;
    };

    if (call compile format ["Cancel%1", _cString]) exitWith {
        _msg = format ["%1 Aborted.", _bldName, _name];
        _doRefund = true;
    };

    (time >= _wait)
};

if (_doRefund) exitWith {
    playerMoney = playerMoney + _credits;
    0 = _msg call _f_Denied;
};

ctrlSetText [_qTextID, _info];

if (_manned && _forSquad) then {
    _buildFor =  (_unitsArray select _unitNum);
    [side _buildfor, "HQ"] sideChat format["Activating unit for %1's group", name _buildfor];

    if (DEBUG) then {
        player sideChat format ["DEBUG :  unit num: %1 - idc : %2", _unitNum, _idc2];
    };
};

if (toLower _class isEqualTo "troop") then {
    _spawnedUnit = (units ([_pos, _type] call Zen_SpawnGroup)) select 0;
    _spawnedUnit setUnitRank "CORPORAL";
    0 = [_spawnedUnit, "infantry"] call Zen_SetAISkill;

    _spawnedUnit exec "rts-unit-markers.sqs";
    player reveal _spawnedUnit;
    _spawnedUnit addEventHandler rts_killedSld;

    [_spawnedUnit] join group _buildFor;
    doStop _spawnedUnit;

    if (_buildFor isEqualTo _player) then {
        _msg = format ["%2 moved to active duty.  You Command %1 Soldiers", (count units _player) - 1, _name];
        hintSilent _msg;
        [side _buildFor, "HQ"] sideChat _msg;
    };
} else {
    _vehicle = [_pos, _type, 0, (getDir _bld) - 180] call Zen_SpawnVehicle;
    player reveal _vehicle;
    _vehicle exec "rts-vcl-timedDelete.sqs";
    _vehicle addEventHandler rts_killedSld;

    rts_newvehicle = _vehicle;
    rts_newVehicleName = _name;
    publicVariable "rts_newvehicleName";
    publicVariable "rts_newvehicle";

    if (_manned) then {
        _crew = [_vehicle, side _buildFor] call Zen_SpawnVehicleCrew;
        (units _crew) join group _buildFor;
        doStop driver _vehicle;
        if !(_buildFor isEqualTo _player) then {
             call compile format ["BuildFor%1 = _buildfor; Vcl%1 = _vehicle; publicVariable ""BuildFor%1""; publicVariable ""Vcl%1""", _side];  
        };
    } else {
        _vehicle call (missionNamespace getVariable "RTS_Build_Unit_MP_Manned_Veh");
        if (isMultiplayer) then {
            Zen_MP_Closure_Packet = ["RTS_Build_Unit_MP_Manned_Veh", _vehicle];
            publicVariable "Zen_MP_Closure_Packet";
        };
    };

    [_side, "HQ"] sideChat format ["%1 moved to active duty.", _name];
};

if (DEBUG) then {
    player sideChat ("rts-build-unit.sqf complete at " + str time);
};

hintSilent "Deployment queue ready.";
call compile format ["%1QActive = FALSE",_bldString];
if (true) exitWith {};
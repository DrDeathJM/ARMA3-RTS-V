_bld = _this select 0;
_kill = _this select 1;
_p1 = getPos _bld;

_bldType = typeOf _bld;
_bldArray = AllBuildings;

_bldName = "";
{
    if (_bldType isEqualTo (_x select 0)) exitWith {
        _bldName = _x select 1;
    };
} forEach _bldArray;


if (_bldName isEqualTo "") exitWith {
    player groupChat format ["Destroyed building type %1 not found.",_bldType];
};
 
[SIDE Player,"HQ"] sideChat format ["%1 was destroyed.",_bldName];
 
_side = if (_bldName in WestBldNames) then {West} else {East};
_teamEnergy = missionNamespace getvariable [format ["energy%1",_side], 0];
 
_repairWait = 10;
_dmg = 100;
 
uiSleep 10;

_z = 0;
if(_bldName in [EastBarracksName,WestBarracksName])then{
	_z = -5.7;
};
if(_bldName in [EastAirFacName,WestAirFacName])then{
	_z = -14;
};
if(_bldName in [EastLightFacName,WestLightFacName])then{
	_z = -10;
};
if(_bldName in [EastHeavyFacName,WestHeavyFacName])then{
	_z = -10;
};


[_side,"HQ"] sideChat format ["Initiating repairs on %1.  Upgrade Fast Repairs in the HQ Factory for faster repair.",_bldName];
 
_inc = _z / _dmg;
_bld setPos [(_p1 select 0),(_p1 select 1), _z];
 
while {(_dmg > 0)} do {
    uisleep 0.01;
    _teamEnergy = missionNamespace getvariable [format ["energy%1",_side], 0];
 
    if (_teamEnergy >= 1) then {
        uisleep (_repairWait / _teamEnergy);
 
        _dmg = _dmg - 1;
        if (_dmg in [25, 50, 75]) then {
            [_side,"HQ"] sideChat format ["%1 repairs %2% complete",_bldName, 100 - _dmg];
        };
 
        _z = _z - _inc;
        if (_z > 0) then {_z = 0};
        if (local _bld) then {_bld setPos [(_p1 select 0), (_p1 select 1), _z]};
    };
};
[_side,"HQ"] sideChat format ["%1 Repairs complete.",_bldName];
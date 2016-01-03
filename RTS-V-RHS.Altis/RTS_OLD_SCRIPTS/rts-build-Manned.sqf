_type = _this select 0;
_pos = _this select 1;
_dir = _this select 2;
_name = _this select 3;
_teamColor = _this select 4;

_posX = _pos select 0;
_posY = _pos select 1;

_bld = call compile rts_tmpstring;
_bldString = rts_tmpString;

_side = Side Player;

_ctype = call compile format ["%1ArmorCrewType", _side];


_vcl = _type createVehicle _pos;
_vcl setDir _dir - 180;
player reveal _vcl;

_vcl addEventHandler rts_killedSld;

rts_newvehicle = _vcl;
publicVariable "rts_newvehicle";

_hasDriver = getNumber (configFile >> "CfgVehicles" >> _type >> "hasDriver");
_hasGunner = getNumber (configFile >> "CfgVehicles" >> _type >> "hasGunner");
_hasCommdr = getNumber (configFile >> "CfgVehicles" >> _type >> "hasCommander");

_init = "newSoldier = this";
_skill = 1;
_rank = "PRIVATE";
_group = Group Player;

if (rts_driver) then
	{
		_ctype CreateUnit [_pos, _group, _init, _skill, _rank];
		_newSoldier = newSoldier;
		_newSoldier exec "rts-unit-markers.sqs";
		Player reveal _newsoldier;
		_newSoldier assignTeam _teamColor;
		_newSoldier addEventHandler rts_killedSld;
		_newSoldier moveInDriver _vcl;
	};

if (_hasGunner == 1  && rts_gunner) then
	{
		_ctype CreateUnit [_pos, _group, _init, _skill, _rank];
		_newSoldier = newSoldier;
		_newSoldier exec "rts-unit-markers.sqs";
		Player reveal _newsoldier;
		_newSoldier assignTeam _teamColor;
		_newSoldier addEventHandler rts_killedSld;
		_newSoldier moveInGunner _vcl;
	};

if (_hasCommdr == 1 && rts_commander) then
	{
		_ctype CreateUnit [_pos, _group, _init, _skill, _rank];
		_newSoldier = newSoldier;
		_newSoldier exec "rts-unit-markers.sqs";
		Player reveal _newsoldier;
		_newSoldier assignTeam _teamColor;
		_newSoldier addEventHandler rts_killedSld;
		_newSoldier moveInCommander _vcl;
	};

_vcl assignTeam _teamColor;

_msg = Format ["%2 moved to active duty.  You Command %1 Soldiers", (Count Units Group Player) -1, _name];
rts_hq sideChat _msg;

_num = random 1;
if (_num >= .5) then { _vcl setPos [ _posX + 10 + Random 20, _posY - 10 - Random 20]};
if (_num < .5) then { _vcl setPos [ _posX - 10 - Random 20, _posY - 10 - Random 20]};
doStop _vcl;
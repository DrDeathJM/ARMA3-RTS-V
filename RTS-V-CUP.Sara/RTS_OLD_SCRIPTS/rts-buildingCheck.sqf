private ["_side", "_level", "_spot","_duty", "_bldType1", "_bldType2", "_result","_bld", "_bld1", "_bld2"];

_side = _this select 0;
_level = _this select 1;
_spot = _this select 2;
_duty = _this select 3;
_result = [];
_bld = objNull;

if (_duty == "") then

{

	_bldType1 = call compile format ["%1RefineryLevel%2",_side ,_level];
	_bldType2 = call compile format ["%1BaseLevel%2",_side ,_level];

	_bld1 = nearestObject [_spot, _bldType1];
	_bld2 = nearestObject [_spot, _bldType2];


	if (!isNull _bld1) then {_bld = _bld1; _duty = "Refinery"};
	if (!isNull _bld2) then {_bld = _bld2; _duty = "Base"};
};

if (_duty != "") then

{
	_bldType = call compile format ["%1%2Level%3", _side, _duty, _level];
	_bld = nearestObject [_spot, _bldType];
	_result = _bld
};


_result = [_bld, _duty];

_result
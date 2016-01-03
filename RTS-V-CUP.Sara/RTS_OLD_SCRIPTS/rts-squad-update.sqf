_idListUnits = 4005;
_idListSquad = 4010;
_idListCustoms = 4015;

_action = _this select 0;


_indexListUnits = lbCurSel _idListUnits;
_indexListSquad = lbCurSel _idListSquad;
_indexListCustoms = lbCursel _idListCustoms;


if (_action == 1) then
	{
		//INSERT LIMIT
		_stringAddArray = lbData [_idListUnits, _indexListUnits];
		_addArray = call compile _stringAddArray;
		_customArray = lbData [_idListCustoms,_indexListCustoms];
		if (count call compile _customArray >= customSquadSizeLimit) exitWith {rts_hq sideChat format ["Custom Squad size limit of %1 reached.",customSquadSizeLimit]};
		call compile format ["%1 = %1 + [_addArray]",_customArray];
	
	};

if (_action == 0) then
	{
		_customArray = lbData [_idListCustoms,_indexListCustoms];
		call compile format ["%1 set [_indexListSquad,""DELETE""]; %1 = %1 - [""DELETE""]",_customArray];

	};

if (_action == -1) then 
	{
		_customArray = lbData [_idListCustoms,_indexListCustoms];
		call compile format ["%1 = []",_customArray];

	};







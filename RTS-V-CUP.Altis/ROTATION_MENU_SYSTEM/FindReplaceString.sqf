private ["_find", "_replace", "_string", "_buf", "_size", "_start", "_new", "_diff"];

_find = toArray (_this select 0);
_replace = toArray (_this select 1);
_string = toArray (_this select 2);
_buf = [];
_new = [];
_size = count _find;
_start = 0;
_diff = (count _replace) - _size;

{
	_new pushBack _x;
	_buf pushBack _x;
	if (_forEachIndex >= _size) then
	{
		_start = _start + 1;
		_buf deleteAt 0;
	};
	
	if (_buf isEqualTo _find) then
	{
		_new deleteRange [_start, _size];
		_new append _replace;
		_start = _start + _diff;
	};
} foreach _string;

_new = toString _new;
_new;
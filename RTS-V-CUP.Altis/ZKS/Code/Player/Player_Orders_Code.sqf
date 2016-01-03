if (isDedicated) exitwith {};

private ["_array","_orders"];


_array = _this select 0;
_orders = _array select (count _array - 1);
_array set [(count _array - 1),-1];
_orders = if (typename _orders != "STRING") then {_orders}else{call compile _orders};
_array call _orders;












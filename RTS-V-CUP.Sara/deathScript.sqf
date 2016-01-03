//deathScript.sqf
_unit = _this select 0;

_obj= "Land_HelipadEmpty_F" createVehicleLocal [0,0,0]; 
_obj attachTo [_unit,[0,0,1.5]];
_obj say3D "death";
sleep 10;
deleteVehicle _obj;
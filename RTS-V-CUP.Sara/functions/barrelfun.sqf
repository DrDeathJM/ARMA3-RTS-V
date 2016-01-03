if (!isServer) exitWith {};
_obj = _this select 0;

_speed = random 9;
_dir = random 359;
_zvel = 15 + (random 15);


sleep (random 1);
_boom = "HelicopterExplobig", "Bo_GBU12_LGB" createVehicle (getPos _obj);
sleep 0.1;
sleep (random 1);
_boom = "HelicopterExploSmall" createVehicle (getPos _obj);
_obj setVelocity [_speed * sin(_dir), _speed * cos(_dir), _zvel];
{_x setdamage 2} foreach (nearestobjects [getpos _boom,[],1]);// damage area


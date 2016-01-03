if (!alive player) exitWith {};

private ["_veh", "_push", "_vecDir"];

_veh = vehicle player;
if (_veh == player) exitWith {};

moveOut player;
playSound ["jump8", true];

if (_veh isKindOf "Plane"||_veh isKindOf "Helicopter"||_veh isKindOf "car"||_veh isKindOf "ship") then
{
	player setDir getDir _veh;
	_push = (vectorUp _veh) vectorMultiply 40; 
}
else
{
	if ((getPos _veh) select 2 > 4) then
	{
		_vecDir = (getPosASL player) vectorDiff (getPosASL _veh);
		_push = _vecDir vectorMultiply (5 / vectorMagnitude _vecDir);
	};
};

if (!isNil "_push") then
{
	player setVelocity ((velocity player) vectorAdd _push);
};
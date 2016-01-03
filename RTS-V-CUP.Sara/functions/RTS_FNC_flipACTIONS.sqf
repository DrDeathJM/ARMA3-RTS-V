RTS_FNC_flipACTIONS = {
if (!alive player) exitWith {};

private ["_vehicle"];
_vehicle = vehicle player;
		if (player != _vehicle) then {
			if (speed _vehicle < 5 && getPos _vehicle select 2 < 5) then {
				_vehicle setPos [getPos _vehicle select 0, getPos _vehicle select 1, 1];
				_vehicle setVelocity [0,0,1];
			};
		} else {
			{
				if (speed _x < 5 && getPos _x select 2 < 5) then {
					_x setPos [getPos _x select 0, getPos _x select 1, 1];
					_x setVelocity [0,0,1];
				};
			} forEach (player nearEntities[["Car","Ship","Tank","air"],10]);
		};
		};
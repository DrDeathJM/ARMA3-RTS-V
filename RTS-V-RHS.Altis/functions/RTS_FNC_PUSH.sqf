RTS_FNC_PUSH ={
    if (!alive player) exitWith {};
    private ["_vehicle"];
    _vehicle = vehicle player;
    if (player != _vehicle) then {
        if (speed _vehicle < 10 && getPos _vehicle select 2 < 10) then {
            _vehicle setPos [getPos _vehicle select 0, getPos _vehicle select 1, 1];
            _vehicle setVelocity [(sin(direction player))*3, (cos(direction player))*3, 0];
        };
    } else {
        {
            if (speed _x < 10 && getPos _x select 2 < 10) then {
                _x setPos [getPos _x select 0, getPos _x select 1, 1];
                _x setVelocity [(sin(direction player))*3, (cos(direction player))*3, 0];
            };
        } forEach (player nearEntities[["Car","Ship","Tank","air","object"],10]);
    };
};

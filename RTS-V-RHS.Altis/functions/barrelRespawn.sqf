/* ---------------------------------------------------------------------------------------------------


_nul = [this, 2, 1] execVM "barrelRespawn.sqf";fixed by Dr.Deathjm
this goes in the init of barrel you place on map in editor.. fully mp.

---------------------------------------------------------------------------------------------------- */

private "_barrel";
_barrel = _this select 0;
_deadDelay = (_this select 2) * 60;
_dir = getDir _barrel;
_pos = getPos _barrel;
_barreltype = typeOf _barrel;

if (isServer) then {
     While {True} Do {
       sleep 1;


        if ((!alive _barrel) || (!canMove _barrel)) then {
            _dead = true;

            for "_i" from 1 to _deadDelay do {
                 if ({alive _x} count (crew _barrel) > 0) exitWith {_dead = false;};
                 sleep 1;
                };

        if (_dead) then {
            deleteVehicle _barrel;
            sleep 1;
            _barrel = createVehicle [_barreltype, _pos, [], 0, "CAN_COLLIDE"];
            _barrel setDir _dir;
            _barrel setPos [_pos select 0, _pos select 1,0];
            _barrel addEventHandler ["killed",{_this spawn barrelfun; (_this select 1) addRating 2000;}];
         };

      };

   };

};
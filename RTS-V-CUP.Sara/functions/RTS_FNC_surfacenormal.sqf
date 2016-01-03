RTS_FNC_surfacenormal = {
_obj = _this select 0; // the object that gets aligned
_offset = _this select 1; // how many metres the object gets raised/lowered.
_obj setVectorUp (surfacenormal (getPosATL _obj)); // align the Object with its surface.


_posASL = getPosASL _obj; // get its position ASL
_obj setPosASL [posASL  select 0,posASL select 1, ((posASL select 2) + _offset)]; // lower it with the given offset (_this select 1)

};
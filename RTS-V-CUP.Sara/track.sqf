0 = [] spawn { 
    while {true} do { 
        _allVehicles = []; 
        { 
            if ((vehicle _x != _x) && {!(vehicle _x in _allVehicles)}) then { 
                _allVehicles set [(count _allVehicles), vehicle _x]; 
            }; 
        } forEach allUnits; 

        _allInfantry = [allUnits, {!(vehicle _this == _this)}] call Zen_ArrayFilterCondition; 

        _groupTrack = [_allInfantry] call Zen_TrackGroups; 
        _vehTrack = [_allVehicles, "object"] call Zen_TrackVehicles; 

        sleep 60; 

        terminate (_groupTrack select 1); 
        terminate (_vehTrack select 1); 

        { 
            deleteMarker _x; 
        } forEach ((_groupTrack select 0) + (_vehTrack select 0)) 
    }; 
}; 
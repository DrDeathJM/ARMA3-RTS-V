//

waitUntil {
    (rts_arrays_initialized)
};

sleep 1;

MCUWest = WestTruck;
MCUEast = EastTruck;

MCUWest addAction ["<t color='#D80000'>" + (format ["Base Construction Menu", WestMCUName]) + "</t>", Zen_RTS_BuildMenuStructures, [], 100, false, true, "teamSwitchPrev", "vehicle player isKindOf 'B_Truck_01_medical_F'"];
MCUWest addAction ["<t color='#D80000'>Recycle</t>", Zen_RTS_Recycle, [], 100, false, true, "teamSwitchPrev", "vehicle player isKindOf 'B_Truck_01_medical_F'"];

MCUEast addAction ["<t color='#D80000'>" + (format ["Base Construction Menu", EastMCUName]) + "</t>", Zen_RTS_BuildMenuStructures, [], 100, false, true, "teamSwitchPrev", "vehicle player isKindOf 'O_Truck_02_medical_F'"];
MCUEast addAction ["<t color='#D80000'>Recycle</t>", Zen_RTS_Recycle, [], 100, false, true, "teamSwitchPrev", "vehicle player isKindOf 'B_Truck_01_medical_F'"];

// This appears to be deprecated with the old territory system
/**
newBuilding = objNull;
while {true} do {
    waitUntil {
        sleep 2;
        !(isNull newBuilding)
    };

    _bld = newBuilding;
    _bldType = typeOf _bld;
    newBuilding = objNull;

    if (_bldType in rscBldTypesAll) then {
        _bld addEventHandler rts_killedRsc
    } else {
        _bld addEventHandler rts_killedBase
    };
};
//*/

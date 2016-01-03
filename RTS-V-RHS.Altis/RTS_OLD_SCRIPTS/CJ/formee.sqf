	_new_veh = createVehicle ["B_HMG_01_high_F", [(getPos player select 0) + 2, (getPos player select 1) + 2, 0.1], [], 0, "NONE"];
	waitUntil {alive _new_veh};
	_new_veh setDir getDir player;

   //_new_veh addEventHandler ["Fired", {[_this select 6]execVM "scripts\scriptest.sqf"} ];

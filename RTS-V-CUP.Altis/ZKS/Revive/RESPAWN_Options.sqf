_side = _this select 0;
RespawnArea = 15000;

No_Camera = 0;

Group_Revive_Only = 0;
Civ_Revive = 1;

MY_SPAWN = objnull;



	switch (_side) do 
	{
	case West : {MY_SPAWN = WestTruck};
	case East : {MY_SPAWN = EastTruck};
	case RESISTANCE : {MY_SPAWN = objnull};
	case CIVILIAN : {MY_SPAWN = objnull};
	};



if (MY_SPAWN iskindof "HOUSE") then
{
MY_SPAWN_room = [[3]];
}else{
MY_SPAWN_room = [];
};




player setVariable ["My_Spawn",MY_SPAWN, false];

Spawn_Houses = [];
Spawn_Rooms = [];
Spawn_Objects = [];
Spawn_Places = [];




	switch (_side) do 
	{
		case West : {
				//-----------------------
				//Houses
				Spawn_Houses = ["Land_Cargo_Patrol_V1_F","Land_i_Garage_V1_F","Land_Cargo_House_V1_F","rhs_2P3_1","Land_Airport_Tower_F","Land_Research_HQ_F"];

				//Rooms
				Spawn_Rooms = [[0],[-1],[5],[3]];
				//-------------------------

				//Objects
				Spawn_Objects = ["B_Truck_01_medical_F"];
   			};

		case East : {
				//-----------------------
				//Houses
				Spawn_Houses = ["Land_Cargo_Patrol_V1_F","Land_i_Garage_V1_F","Land_Cargo_House_V1_F","rhs_2P3_1","Land_Airport_Tower_F","Land_Research_HQ_F"];

				//Rooms
				Spawn_Rooms = [[0],[-1],[5],[4]];
				//-------------------------

				//Objects
				Spawn_Objects = ["O_Truck_03_medical_F"];
   			};

		case RESISTANCE : {
				//-----------------------
				//Houses
				Spawn_Houses = [];

				//Rooms
				Spawn_Rooms = [];
				//-------------------------

				//Objects
				Spawn_Objects = [];
   			};

		case CIVILIAN : {
				//-----------------------
				//Houses
				Spawn_Houses = [];

				//Rooms
				Spawn_Rooms = [];
				//-------------------------

				//Objects
				Spawn_Objects = [];
   			};

	};










Spawn_Places = Spawn_Houses + Spawn_Objects;









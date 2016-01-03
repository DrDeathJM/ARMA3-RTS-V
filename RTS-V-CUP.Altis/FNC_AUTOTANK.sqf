comment "1st step exec global";

FNC_AUTOTANK =
{
	params
	[
		"_vehicle"
	];
	
	[_vehicle, [[0], true]] remoteExec ["lockTurret", _vehicle];
	[_vehicle, [[0, 0], true]] remoteExec ["lockTurret", _vehicle];
	[_vehicle, true] remoteExec ["lockCargo", _vehicle];
	
	[
		_vehicle,
		[
			"MPKilled",
			{
				if (isServer) then
				{
					_d = driver (_this select 0);
					_g = gunner (_this select 0);
					if (!isNull _d) then {deleteVehicle _d};
					if (!isNull _g) then {_g setDamage 1};
				};
			}
		]
	]
	remoteExec ["addMPEventHandler", 2];
	

	[
		_vehicle,
		[
			"GetIn",
			{
				enableSentences false;
				_tank = _this select 0;
				_unit = _this select 2;
				_unit allowDamage false;
				_unit action ["EngineOn", _tank];
				_unit action ["MoveToGunner", _tank];
				_tank lock true;
				_tank switchCamera "EXTERNAL";
				
				_tank addAction
				[
					localize "str_action_getout",
					{
						_this select 0 removeAction (_this select 2);
						_this select 1 action ["GetOut", _this select 0];
					},
					"",
					3,
					false,
					true,
					"GetOver"
				];
				
				_tank spawn
				{
					waitUntil {!isNull gunner _this};
					_ai = createAgent [typeOf gunner _this, [0,0,0], [], 0, "NONE"];
					_ai allowDamage false;
					_ai moveInDriver _this;
				};
			}
		]
	]
	remoteExec ["addEventHandler", -2];
	

	[
		_vehicle,
		[
			"GetOut",
			{
				_tank = _this select 0;
				_unit = _this select 2;
				deleteVehicle driver _tank;
				_unit allowDamage true;
				_unit action ["EngineOff", _tank];
				_tank lock false;
				enableSentences true;
			}
		]
	]
	remoteExec ["addEventHandler", -2];
	
	
	
};


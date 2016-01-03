//flag JIP players
isJIPplayer = false;
if ( (not (isServer)) and (isNull player) ) then
{
	isJIPplayer = true;
};
a_vehs = [];
a_tanks = [];
a_APCs = [];
a_gunships = [];

for "_i" from 0 to (count (configFile >> "CfgVehicles") - 1)  do
{
	_entry = (configFile >> "CfgVehicles") select _i;
	if (isClass _entry) then
	{
		_entryName = configName _entry;
		_scope = getNumber (configfile >> "CfgVehicles" >> _entryName >> "scope");
		_weapons = getArray (configfile >> "CfgVehicles" >> _entryName >> "weapons");

		if (_scope > 0) then
		{
			if (_entryName isKindOf "Tank") then
			{
				a_tanks = a_tanks + [_entryName];
			};

			if (_entryName isKindOf "Wheeled_APC_F") then
			{
				a_APCs = a_APCs + [_entryName];
			};
		};
	};
};
a_vehs = a_tanks + a_APCs;
if (!isServer) exitWith{};
//if not server or if host/player
if ( (not (isServer)) or (not (isNull player)) ) then
{
	execVM "init_client.sqf";
};
#include "CJ\create_vehicle.sqf"
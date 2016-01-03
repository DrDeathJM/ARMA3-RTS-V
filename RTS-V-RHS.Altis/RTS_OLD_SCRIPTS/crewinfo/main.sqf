/*
 * Filename:
 * crewInfo (main.sqf)
 *
 * Description:
 * Runs on client
 *
 * Created by [KH]Jman
 * Creation date: 31/03/2011
 * Email: jman@kellys-heroes.eu
 * Web: http://www.kellys-heroes.eu
 *
 *
 * Original script by =[A*C]= code34
 * Modified by [KH]Jman
 * Part is modified code from WINSE - Valhalla mission

 * modified for MSO: 16/08/2012

 * */
// ====================================================================================
	if (!local player) exitWith { };
	private ["_crew", "_text", "_vehicle", "_role", "_name"];
	_text = "";
	disableSerialization;
	#define WCTEXTW		0.80
	#define WCTEXTY		0.06
	#define WCTEXTHEIGHT	0.50
	#define WCTEXTWIDTH	0.30
	// controlName ctrlSetPosition [x, y, w, h]
	// SafeZoneX returns the value for the left side of screen.
	// SafeZoneY returns the value for the top of the screen.
	// SafeZoneW returns the whole width of the screen.
	// SafeZoneH returns the whole height of the screen.
	private ["_ctrl"];
	uiNamespace setVariable ['crewinfodisplay', objnull];
	while { true } do {
		if (isnull (uiNamespace getVariable "crewinfodisplay")) then { cutrsc ["crewinfomessage", "PLAIN"]; };
		if (vehicle player != player) then {
			_text = "";
			_crew = crew (vehicle player);
			_vehicle = vehicle player;
			_name= getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "DisplayName");
			_text= _text + format ["<t size='1.35' shadow='true' color='#AAAAFF'>%1</t><br/>", _name];
			{
				if(!(format["%1", name _x] == "") and !(format["%1", name _x] == "Error: No unit")) then {
					_role = assignedVehicleRole _x;
					switch(_x)do {
						case commander _vehicle: {
							_text=_text+format ["<t size='1.5'><img image='crewinfo\img\i_commander_ca.paa'></t> <t size='1.35' shadow='true' color='#AAAAFF'>%1</t><br/>", name _x];
						};

						case gunner _vehicle: {
							_text=_text+format ["<t size='1.5'><img image='crewinfo\img\i_gunner_ca.paa'></t> <t size='1.35' shadow='true' color='#FF8888'>%1</t><br/>", name _x];
						};

						case driver _vehicle: {
							_text=_text+format ["<t size='1.5'><img image='crewinfo\img\i_driver_ca.paa'></t> <t size='1.35' shadow='true' color='#88FF88'>%1</t><br/>", name _x];
						};

						default	{
							if(format["%1", (_role select 0)] != "Turret") then {
								_text=_text+format ["<t size='1.5'><img image='crewinfo\img\i_cargo_ca.paa'></t> <t size='1.35' shadow='true' color='#EEEEEE'>%1</t><br/>", name _x];
							} else {
								_text=_text+format ["<t size='1.5'><img image='crewinfo\img\i_gunner_ca.paa'></t> <t size='1.35' shadow='true' color='#FF8888'>%1</t><br/>", name _x];
							};
						};
					};
				};
			}forEach _crew;
		};



		_ctrl = (uiNamespace getVariable 'crewinfodisplay') displayCtrl 10101;
		_ctrl ctrlSetStructuredText parseText _text;
		_text = "";
		_ctrl ctrlCommit 0;
		uiNamespace setVariable ['crewinfodisplay', objnull];
		 sleep 1;

	};
// ====================================================================================


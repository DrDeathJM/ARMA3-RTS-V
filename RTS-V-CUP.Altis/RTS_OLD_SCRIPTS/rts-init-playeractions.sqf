//refixed by ZDROB
//rts-init-playeractions
_playerunit = _this select 0;
_unit = _this select 1;
_unitname = Name _unit;
_oldactionid = _this select 2;
waitUntil {not (isNil "rts_Initialized")};
waitUntil {rts_Initialized AND rts_arrays_initialized};

_msg = Format["COMMUNICATIONS ESTABLISHED"];

rts_hq sideChat _msg;
Hint _msg;

// actionid = _playerunit AddAction["<t color='#2D8CE0'>RTS Player Menu</t>","rts-alpha-menu.sqs"];
actionid = _playerunit AddAction["<t color='#2D8CE0'>RTS Player Menu</t>", Zen_RTS_AlphaMenu];

if (Side _unit == West) then
{
	_msg = "Checking command status";
	rts_hq sideChat _msg;

	sleep 2;
	waitUntil {not (IsNull WestCommander) AND (Alive WestCommander)};
	_name = Name WestCommander

}

else
{
	_msg = "Checking command status";
	rts_hq sideChat _msg;

	sleep 2;
	waitUntil {not (IsNull EastCommander) AND (Alive EastCommander)};

	_name = Name EastCommander;

};
	

_msg = Format["%1 is your commander.",_name];
rts_hq sideChat _msg;

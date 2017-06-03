
FNC_AUTOTANK = {
    params ["_vehicle"];

    _vehicle addMPEventHandler ["MPKilled", {
        if (isServer) then {
            _d = driver (_this select 0);
            _g = gunner (_this select 0);
            if (!isNull _d) then {deleteVehicle _d};
            if (!isNull _g) then {_g setDamage 1};
        };
    }];
       
    _args = {
      _aItyPe = createAgent ["rhsusf_army_ocp_driver",[0, 0, 0], [],0, "joinSilent"]; 
        enableSentences false;
		_vehicle = _this select 0;
        player moveInGunner _vehicle;
        _aItyPe moveInDriver _vehicle;
      _vehicle lockdriver true;
};
    ZEN_FMW_MP_RENonDedicated("Zen_ExecuteCommand", _args,[_vehicle] call);

    _args = ["addEventHandler", [_vehicle, ["GetOut", {
       _vehicle = _this select 0;
        enableSentences true;
        _vehicle action ["EngineOff", _vehicle];
		_vehicle lockdriver true;
    }]]];
    ZEN_FMW_MP_RENonDedicated("Zen_ExecuteCommand", _args, call);

};

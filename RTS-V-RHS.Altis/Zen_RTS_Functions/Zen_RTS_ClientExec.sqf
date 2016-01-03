[] execVM "rts-z-intro.sqf";
//[] exec "Karr-SquadMarkers.sqs";
[] exec "rts-build-unitarrays.sqs";
// [] exec "rts-init-SetRandomPos.sqs";

// [] exec "rts-build-addAction.sqs";
0 = [] execVM "RTS_Build_AddAction.sqf";

[] exec "rts-build-structurePosExec.sqs";
// [] execVM "territory\rts-territoryInit.sqf";
// [] exec "economy\rts-moneyMonitor.sqs";
// [] exec "rts-showMsg.sqs";
[] exec "rts-client-updateArrays.sqs";
// [] exec "rts-vcl-special.sqs";
[] exec "rts-z-endmission.sqs";
onMapSingleClick "[_pos, _units, _shift, _alt] exec ""onMapSingleClick.sqs""";

1 setRadioMsg "Null";
if (param3 > 0) then {
    [] exec "vicpoint\rts-vpInit.sqs";
};

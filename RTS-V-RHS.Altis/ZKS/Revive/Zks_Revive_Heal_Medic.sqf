_imhurt = _this select 0;
_healer = _this select 1;
_id = _this select 2;

_imhurt removeAction _id;

_healer playMoveNow "AmovPercMstpSrasWpstDnon_AinvPknlMstpSnonWnonDnon_end";
_imhurt setVariable ["HURT", nil, true];
sleep 4;
_healer playMoveNow "AinvPknlMstpSnonWrflDnon_medicEnd";
//

0 = [] spawn {
    _Zen_stack_Trace = ["Zen_RTS_SquadsMenu", _this] call Zen_StackAdd;
    closeDialog 0;
    sleep 0.01;

    createDialog "dlgSquads";

    _idListUnits = 4005; // available assets list
    _idListSquad = 4010; // assets in squad list
    _idListCustom = 4015; // squads list

    _idButtonBack = 4004;
    _idButtonAdd = 4002;
    _idButtonRemove = 4003;
    _idButtonClear = 4006;
    _idButtonExit = 4007;

    _indexUnits = 0;
    _indexCustoms = 0;
    _indexSquad = 0;

    _side = side player;
    _squadNames = ["Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot"];

    // Set Button names
    // ctrlSetText [_idbuild, "Deploy"]
    // ctrlSetText [_idbuildyou, "Deploy Manned"]
    // ctrlSetText [_idbuildsquad, "Deploy for Squad"]
    // ctrlSetText [_idtitle, _bldName]

    buttonSetAction [_idButtonBack, "[player, player, 0] call Zen_RTS_AlphaMenu"];
    buttonSetAction [_idButtonAdd, "
        _squadIndex = lbCurSel 4015;
        _asset = lbData [4005, lbCurSel 4005];
        (RTS_Custom_Squads_Assets select _squadIndex) pushBack _asset;
    "];

    buttonSetAction [_idButtonRemove, "
        _squadIndex = lbCurSel 4015;
        _assetIndex = lbCurSel 4010;
        [(RTS_Custom_Squads_Assets select _squadIndex), _assetIndex] call Zen_ArrayRemoveIndex;
    "];

    buttonSetAction [_idButtonClear, "
        _squadIndex = lbCurSel 4015;
        RTS_Custom_Squads_Assets set [_squadIndex, []];
    "];

    buttonSetAction [_idButtonExit, "closeDialog 0"];

    while {(ctrlVisible _idListSquad) && (alive player)} do {
        // Asset List
        lbClear _idListUnits;
        lbClear _idListCustom;
        lbClear _idListSquad;

        {
            _data = [_x] call Zen_RTS_StrategicAssetGetData;

            _index = lbAdd [_idListUnits, (_data select 2)];
            lbSetData [_idListUnits, _index, _x];
            // lbSetValue [_idListUnits, _index, _forEachIndex];
            // lbSetPicture [_idListUnits, _index, ""];
        } forEach (RTS_Used_Asset_Types select ([West, East] find _side));

        for "_i" from 0 to (count RTS_Custom_Squads_Assets - 1) do {
            _index = lbAdd [_idListCustom, _squadNames select _i];
            lbSetValue [_idListCustom, _index, _i];
            // lbSetData [_idListCustom, _index, ""];
            // lbSetColor [_idListCustom, _index, _color];
        };

        {
            if ((lbCurSel _idListCustom) == _forEachIndex) then {
                {
                    _data = [_x] call Zen_RTS_StrategicAssetGetData;

                    _index = lbAdd [_idListSquad, (_data select 2)];
                    // lbSetData [_idListSquad, _index, _x];
                } forEach _x;
            };
        } forEach RTS_Custom_Squads_Assets;

        lbSetCurSel [_idListUnits, _indexUnits];
        lbSetCurSel [_idListCustom, _indexCustoms];
        lbSetCurSel [_idListSquad, _indexSquad];

        sleep 0.1;
        _indexUnits = lbCurSel _idListUnits;
        _indexCustoms = lbCurSel _idListCustom;
        _indexSquad = lbCurSel _idListSquad;
    };

    call Zen_StackRemove;
    if (true) exitWith {};
};

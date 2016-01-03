//

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

0 = _this spawn {
    _idc = _this;

    _index = lbCurSel _idc;
    _text = lbText [_idc, _index];
    _type = lbData [_idc, _index];

    _buildingObjs = [Zen_RTS_Strategic_Building_Objects_Global, _type, 0] call Zen_ArrayGetNestedIndex;
    if (count _buildingObjs == 0) exitWith {
        player sideChat "This building type has not been constructed.";
    };

    if (isNull ((Zen_RTS_Strategic_Building_Objects_Global select (_buildingObjs select 0)) select 2)) exitWith {
        player sideChat "This building is not fully constructed.";
    };

    _buildingObjData = Zen_RTS_Strategic_Building_Objects_Global select (_buildingObjs select 0);

    // if ((player distance (_buildingObjData select 2)) > 50) exitWith {
        // player sideChat "You must be closer to this building to recycle it.";
    // };
    0 = [(_buildingObjData select 1)] call Zen_RTS_StrategicBuildingDestroy;
    cLoseDialog 0;
};

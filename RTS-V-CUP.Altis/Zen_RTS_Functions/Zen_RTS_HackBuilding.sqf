// Zen_RTS_HackBuilding
// from addAction

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"


0 = _this spawn {
    _buildingObjData = _this select 3;
    (_this select 0) removeAction (_this select 2);

    sleep 5;
    _building = _buildingObjData select 2;
    _building setVariable ["Zen_RTS_IsHacked", true, true];
};

// spawn this

#include "Zen_StandardLibrary.sqf"
#include "Zen_FrameworkLibrary.sqf"

while {true} do {
    _Zen_stack_Trace = ["Zen_RTS_BuildMenuQueue", _this] call Zen_StackAdd;
    sleep 2;
    // infantry, light, heavy, air
    _idQTexts = [1030, 1032, 1034, 1036];
    _idQButtons = [1031, 1033, 1035, 1039];

    _index = if (side player == West) then {0} else {1};
    _buildingTypes = (RTS_Used_Building_Types select _index);
    _buildingObjs = [[], [], [], []];

    _queue = [];
    if (ctrlVisible 1000 || ctrlVisible 2000) then {
        {
            _buildingObjData = _buildingObjs select _forEachIndex;
            if (count _buildingObjData > 0) then {
                _queue = (_buildingObjs select _forEachIndex) select 5;
            } else {
                _buildingObjData = [_x] call Zen_RTS_StrategicBuildingObjectGetDataGlobal;
                if (count _buildingObjData > 0) then {
                    _buildingObjs set [_forEachIndex, _buildingObjData];
                    _queue = _buildingObjData select 5;
                };
            };

            _text = "Queue Empty";
            if (count _queue > 0) then {
                _text = ((_queue select 0) select 0) select 2;
            };

            _buttonCode = "";
            if (count _buildingObjData > 0) then {
                _buttonCode = "[ " + str (_buildingObjData select 1) + ", 0] spawn Zen_RTS_StrategicBuildingQueueRemove";
            };

            ctrlSetText [(_idQTexts select _forEachIndex), _text];
            buttonSetAction [(_idQButtons select _forEachIndex), _buttonCode];
        } forEach _buildingTypes;
    };
};

call Zen_StackRemove;
if (true) exitWith {};

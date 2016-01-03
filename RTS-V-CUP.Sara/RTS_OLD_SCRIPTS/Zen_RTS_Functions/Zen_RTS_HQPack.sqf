/**
    Zen_RTS_HQPack by Zenophon for RTS V Warfare Unleashed

    Places the given HQ container one its nearby transport vehicle
    Usage : Spawn
    Params: 1. Object, the container to pack
            2. Side, the side of the HQ
    Return: Void
//*/

#include "Zen_StandardLibrary.sqf"
#include "Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_HQPack", _this] call Zen_StackAdd;
private ["_HQContainer", "_side", "_truckTypes", "_attachProxy", "_truckType", "_attachOffset", "_truckArray", "_truck"];

if !([_this, [["OBJECT"], ["SIDE"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_HQContainer = _this select 0;
_side = _this select 1;

// IMPORTANT: Addon vehicles must be appended to work
_truckTypes = ["B_Truck_01_medical_F","O_Truck_03_medical_F","I_Truck_02_transport_F"];
_attachProxy = [_HQContainer, "Land_CanisterPlastic_F", -5, 0, true] call Zen_SpawnVehicle;

switch (_side) do {
    case West: {
        _truckType = _truckTypes select 0;
        _attachOffset = [0,-2,.845];
    };
    case East: {
        _truckType = _truckTypes select 1;
        _attachOffset = [-0.04,-1.65,.66];
    };
    case Independent: {
        _truckType = _truckTypes select 2;
        _attachOffset = [-0.04,-1.65,.66];
    };
    default {
        _truckType = "";
    };
};

if (_truckType isEqualTo "") exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_HQPack", "Invalid side given")
};

ZEN_STD_Parse_ToArray(_truckType)

if (count _truckType == 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_HQPack", "Invalid truck data for given side")
};

_truckArray = nearestObjects [_HQContainer, _truckType, 15];

player commandChat str _truckArray;

_truck = objNull;

{
    if (alive _x) exitWith {
        _truck = _x;
    };
} forEach _truckArray;

if (isNull _truck) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_HQPack", "No transport truck found near container")
};

_attachProxy attachTo [_truck, [0, 0, -6]];
_HQContainer attachTo [_attachProxy, _attachOffset vectorAdd [0, 0, 6.4]];

sleep 0.05;
detach _HQContainer;

_HQContainer attachTo [_truck,_attachOffset];
_HQContainer setDir 270;

detach _attachProxy;
deleteVehicle _attachProxy;

sleep 1;
waitUntil {
    (!(alive _truck) || {ZEN_STD_OBJ_ATLPositionZ(_HQContainer) < 1})
};

sleep 0.25;

// TODO: Test this, why are commands commented out??
if !(alive _truck) then {
    //detach _HQContainer;
    _HQContainer attachTo [_truck, [0,-9,-.8]];
    //_HQContainer setDir ((getDir _truck) - 90);
    sleep 1;
    detach _HQContainer;
};

_HQContainer setPos [(getPos _HQContainer select 0),(getPos _HQContainer select 1), 0];

call Zen_StackRemove;
if (true) exitWith {};
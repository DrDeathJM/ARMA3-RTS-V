/**
    Zen_RTS_HQUnPack by Zenophon for RTS V Warfare Unleashed

    Removes the given HQ container from its transport vehicle
    Usage : Spawn
    Params: 1. Object, the container being carried
    Return: Void
//*/

#include "Zen_StandardLibrary.sqf"
#include "Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_HQUnPack", _this] call Zen_StackAdd;
private ["_HQContainer", "_truckTypes", "_attachOffset", "_nearVehicles", "_truckTransport"];

if !([_this, [["OBJECT"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_HQContainer = _this select 0;

// IMPORTANT: Addon vehicles must be appended to work
_truckTypes = ["B_Truck_01_medical_F","O_Truck_03_medical_F","I_Truck_02_transport_F"];
_attachOffset = [0, -9, -0.8];

_nearVehicles = (nearestObjects [_HQContainer, _truckTypes, 5]);

if (count _nearVehicles == 0) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RTS_HQUnPack", "Given container is not being carried by a transport vehicle")
};

_truckTransport = (_nearVehicles select 0);

_HQContainer attachTo [_truckTransport, _attachOffset];
_HQContainer setDir ((getDir _truckTransport) - 90);
sleep 0.1;

detach _HQContainer;
ZEN_STD_OBJ_TransformATL(_HQContainer, 0, 0, (getPosATL _HQContainer select 1))

call Zen_StackRemove;
if (true) exitWith {};
//edited and fixed by Dr Death jm and eRazer
if (!alive player) exitWith {};
if (vehicle player != player) exitWith {};

private ["_wait", "_pos", "_para"];

// some aircrafts blow up on contact with parachutes, so we have to make sure none's close
waitUntil {sleep 0.1; {player distance _x < 10 max (sizeOf typeOf _x)} count (player nearEntities ["Helicopter_Base_F", 20]) == 0};

if (!alive player) exitWith {};

_wait = false;
_pos = getPosATL player;

if (_pos select 2 < 20) then
{
	_para = createVehicle ["NonSteerable_Parachute_F", _pos, [], 0, "FLY"];
	_para setPosATL _pos;
	_para setDir 0;

}
else
{
	_wait = true;
	_para = createVehicle ["Steerable_Parachute_F", _pos, [], 0, "CAN_COLLIDE"];
	_para setDir getDir player;
};

_para disableCollisionWith player;
player moveInDriver _para;
_para setVelocity [0,0,0];

[] spawn
{
 disableSerialization;
   
    hint "PRESS SPACE BAR TO JUMP OUT OF PARACHUTE";
   
    ZSP_EH_SPACE_TO_EJECT_PARACHUTE = [] call BIS_FNC_DISPLAYMISSION displayAddEventHandler
    [
        "KeyDown",
        {
            if (_this select 1 == 0x39) then
            {
                deleteVehicle vehicle player;
                [] call BIS_FNC_DISPLAYMISSION displayRemoveEventHandler ["KeyDown", ZSP_EH_SPACE_TO_EJECT_PARACHUTE];

                true
            }
            else
            {
                false
            }
        }
    ]; waitUntil {vehicle player == player or {not alive player}};
    player switchMove "AcrgPknlMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon_getOutLow";
    [] call BIS_FNC_DISPLAYMISSION displayRemoveEventHandler ["KeyDown", ZSP_EH_SPACE_TO_EJECT_PARACHUTE];};

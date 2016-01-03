if (isDedicated) exitwith {};


Player_Orders_Code = compile preprocessFileLineNumbers "ZKS\Code\Player\Player_Orders_Code.sqf";


if (isNil "playerorders") then {playerorders = [objNull,""];};

"playerorders" addPublicVariableEventHandler {
private["_array"];
_array = _this select 1;
[_array] spawn Player_Orders_Code; 
};

















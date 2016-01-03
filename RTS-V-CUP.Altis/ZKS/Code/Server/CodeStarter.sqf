if !(isserver) exitwith {};


Server_Orders_Code = compile preprocessFileLineNumbers "ZKS\Code\Server\Server_Orders_Code.sqf";





if (isNil "serverorders") then {serverorders = [objNull,""];};

"serverorders" addPublicVariableEventHandler {
private["_array"];
_array = _this select 1;
[_array] spawn Server_Orders_Code; 
};

















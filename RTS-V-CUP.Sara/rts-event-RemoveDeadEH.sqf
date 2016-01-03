_unit = _this select 0; 
_killer = _this select 1; 
_leader = leader _killer; 

// Check that XP is given to one of the starting units 
if !(isNull _leader) then { 
    _unitStr = str _leader; 
    if ((["West", _unitStr] call Zen_StringIsInString) || {(["East", _unitStr] call Zen_StringIsInString)}) then { 
        call compile format ["XP%1 = XP%1 + 1; publicVariable ""XP%1""", _leader]; 
    }; 
}; 

_unit setPosATL getPosATL _unit; 
sleep 15; 
deleteVehicle _unit; 

if (true) exitWith {};  
  
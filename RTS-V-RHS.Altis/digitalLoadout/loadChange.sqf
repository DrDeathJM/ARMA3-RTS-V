/* ---------------------------------------------------------------------------------------------



THIS FUNCTION (loadChange) ASSIGNS PICTURES AND ITEM COUNT TO THE DIALOG



---------------------------------------------------------------------------------------------- */

/*------------------------------------------------------------
SET SOME LOCAL VARIABLES PRIVATE OVER THE ENTIRE SCRIPTS SCOPE
------------------------------------------------------------*/
 private ["_itemPic", "_count", "_unit"];

/*-----------------------------
 PASS THE PLAYER TO THE SCRIPT
-----------------------------*/
 _unit = _this select 0;

/*-------------------
 DEFINE SOME CONTROLS
-------------------*/
 disableSerialization; 

 _display = uiNamespace getVariable "Dload"; 

  waitUntil {!isNull _display};
 _nameCtrl = _display displayCtrl 61500;
 _PWeaponCtrl = _display displayCtrl 71500;
 _SWeaponCtrl = _display displayCtrl 71501;
 _BPackCtrl = _display displayCtrl 71502;
 _PisCtrl = _display displayCtrl 71503;
 _PWAmmoCtrl = _display displayCtrl 71504;
 _SWAmmoCtrl = _display displayCtrl 71505;
 _PisAmmoCtrl = _display displayCtrl 71506;
 _HEGreAmmoCtrl = _display displayCtrl 71522;
 _PWAmmoTextCtrl = _display displayCtrl 71507;
 _SWAmmoTextCtrl = _display displayCtrl 71508;
 _PisAmmoTextCtrl = _display displayCtrl 71509;
 _HEGreAmmoTextCtrl = _display displayCtrl 71523;
 _rankHeader = _display displayCtrl 100001; 

if (paramsArray select 4 == 1) then {
   ((uiNamespace getVariable "Dload") displayCtrl 100002) ctrlSetText "\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
   ((uiNamespace getVariable "Dload") displayCtrl 100003) ctrlSetText "\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
   ((uiNamespace getVariable "Dload") displayCtrl 100004) ctrlSetText "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
   ((uiNamespace getVariable "Dload") displayCtrl 100005) ctrlSetText "\A3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa";
   ((uiNamespace getVariable "Dload") displayCtrl 100006) ctrlSetText "\A3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa";
   ((uiNamespace getVariable "Dload") displayCtrl 100007) ctrlSetText "\A3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa";
   ((uiNamespace getVariable "Dload") displayCtrl 100008) ctrlSetText "\A3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa";
   ((uiNamespace getVariable "Dload") displayCtrl 100009) ctrlSetText "\A3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa";
   ((uiNamespace getVariable "Dload") displayCtrl 100010) ctrlSetText "\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa";
   ((uiNamespace getVariable "Dload") displayCtrl 100011) ctrlSetText "\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa";


   switch (rank _unit) do {

    case "PRIVATE":{{ctrlEnable [_x, false]} forEach [15001,15002,15003,15004,15005,15006,15007,15008,15009];_rankHeader ctrlSetText format ["\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa"];};
    case "CORPORAL":{{ctrlEnable [_x, false]} forEach [15002,15003,15004,15005,15006,15007,15008,15009];_rankHeader ctrlSetText format ["\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa"];};
    case "SERGEANT":{{ctrlEnable [_x, false]} forEach [15003,15004,15005,15006,15007,15008,15009];_rankHeader ctrlSetText format ["\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa"];};
    case "LIEUTENANT":{{ctrlEnable [_x, false]} forEach [15005,15006,15007,15008,15009];_rankHeader ctrlSetText format ["\A3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa"];};
    case "CAPTAIN":{{ctrlEnable [_x, false]} forEach [15007,15008,15009];_rankHeader ctrlSetText format ["\A3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa"];};
    case "MAJOR":{{ctrlEnable [_x, false]} forEach [15008,15009,15010];_rankHeader ctrlSetText format ["\A3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa"];};
    case "COLONEL":{{ctrlEnable [_x, false]} forEach [];_rankHeader ctrlSetText format ["\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa"];}; 
   }; 

};

/*---------------------------------------------
  DEFINE MAGAZINE TYPES & COUNT THE UNITS AMMO 
---------------------------------------------*/
 _PWAmmoType = primaryWeaponMagazine _unit;
 _SWAmmoType = secondaryWeaponMagazine _unit;
 _PisAmmoType = handgunMagazine _unit;
 _HEGreCountType = ({_x == "1Rnd_HE_Grenade_shell"} count magazines _unit);
 _SWCountType = ({_x == _SWAmmoType select 0} count magazines _unit) + (count secondaryWeaponMagazine _unit);
 _PisCountType = ({_x == _PisAmmoType select 0} count magazines _unit) + (count handgunMagazine _unit);
 _PWCountType = ({_x == _PWAmmoType select 0} count magazines _unit);
 _nameCtrl ctrlSetText format["Digital Weapons System | %1: %2",rank _unit,name _unit];

/*--------------------------------------------------
       WIPE THE BACK PACK ITEM CONTROLS CLEAN
--------------------------------------------------*/
 for [{_i=0},{_i < 13},{_i=_i+1}] do {
     _BPitemCtrl = _display displayCtrl 71510 + _i;
     _BPItemCtrl ctrlSetText format [""];
     _BPTextCtrl = _display displayCtrl 26500 + _i;
     _BPTextCtrl ctrlSetText format [""];
   };

 for [{_i=0},{_i < 3},{_i=_i+1}] do {
    _attachCtrl = _display displayCtrl 80500 + _i;
    _attachCtrl ctrlSetText format [""];
   };


/*----------------------------------------------------------------
 IF THE UNIT HAS A PRIMARY WEAPON THEN DISPLAY THE WEAPONS PICTURE
----------------------------------------------------------------*/
 if (primaryWeapon _unit !="") then {
    _PWPicture = getText (configfile >> "CfgWeapons" >> primaryWeapon _unit >> "picture");
    _PWeaponCtrl ctrlSetText format ["%1", _PWPicture];
    ((uiNamespace getVariable "DLoad") displayCtrl 40500) ctrlSetTextColor [1,1,1,0];
     
 } else {
    _PWeaponCtrl ctrlSetText format [""];
    ((uiNamespace getVariable "DLoad") displayCtrl 40500) ctrlSetTextColor [1,1,1,1];
 };

/*------------------------------------------------------------------
 IF THE UNIT HAS A SECONDARY WEAPON THEN DISPLAY THE WEAPONS PICTURE
-------------------------------------------------------------------*/
 if (secondaryWeapon _unit !="") then {
    _SWPicture = getText (configfile >> "CfgWeapons" >> SecondaryWeapon _unit >> "picture");
    _SWeaponCtrl ctrlSetText format ["%1", _SWPicture];
    ((uiNamespace getVariable "DLoad") displayCtrl 40501) ctrlSetTextColor [1,1,1,0];
 } else {
    _SWeaponCtrl ctrlSetText format [""];
    ((uiNamespace getVariable "DLoad") displayCtrl 40501) ctrlSetTextColor [1,1,1,1];
 };

/*-------------------------------------------------------------------------------------------------------
 IF THE UNIT HAS A BACKPACK THEN DISPLAY THE BACKPACKS PICTURE ALONG WITH ITS CONTENTS PICTURES AND COUNT
--------------------------------------------------------------------------------------------------------*/
 if (backPack _unit != "") then {
    _BPPicture = getText (configfile >> "CfgVehicles" >> backPack _unit >> "picture");
    _BPackCtrl ctrlSetText format ["%1", _BPPicture];
    _items = [];
   {
    if (!(_x in _items)) then {
     _items set [count _items, _x];
    };
   } forEach backpackItems _unit; 

 for [{_i=0},{_i < count _items },{_i=_i+1}] do {
     _BPPicCtrl = _display displayCtrl 71510 + _i;
     _BPTextCtrl = _display displayCtrl 26500 + _i;
     if (isClass (configFile >> "cfgWeapons" >> _items select _i)) then {
     _itemPic = getText (configfile >> "CfgWeapons" >> _items select _i >> "picture");
     _Count = ({_x == _items select _i} count items _unit);
    };
     if (isClass (configFile >> "cfgMagazines" >> _items select _i)) then {
     _itemPic = getText (configfile >> "CfgMagazines" >> _items select _i >> "picture");
     _Count = ({_x == _items select _i} count magazines _unit);
    };
     _BPPicCtrl ctrlSetText format ["%1", _itemPic]; 
     _BPTextCtrl ctrlSetText format ["%1", _count];
    };
      ((uiNamespace getVariable "DLoad") displayCtrl 40503) ctrlSetTextColor [1,1,1,0];
 } else {
     _BPackCtrl ctrlSetText format [""];
     ((uiNamespace getVariable "DLoad") displayCtrl 40503) ctrlSetTextColor [1,1,1,1];
 };

/*-------------------------------------------------------------------------------------------------------
 IF THE UNIT HAS A HANDGUN THEN DISPLAY THE HANDGUN'S PICTURE 
--------------------------------------------------------------------------------------------------------*/
 if (handGunWeapon _unit != "") then {
     _PisPicture = getText (configfile >> "CfgWeapons" >> handgunWeapon _unit >> "picture");
     _PisCtrl ctrlSetText format ["%1", _PisPicture];
     ((uiNamespace getVariable "DLoad") displayCtrl 40502) ctrlSetTextColor [1,1,1,0];
 } else {
     _PisCtrl ctrlSetText format [""];
    ((uiNamespace getVariable "DLoad") displayCtrl 40502) ctrlSetTextColor [1,1,1,1];
 };

/*-------------------------------------------------------------------------------
 IF THE UNIT HAS ATLEast 1 PRIMARY MAGAZINE THEN DISPLAY IT'S PICTURE AND COUNT
-------------------------------------------------------------------------------*/
 if (count primaryWeaponMagazine _unit > 0) then {
     _PWAmmoPicture = getText (configfile >> "CfgMagazines" >> primaryWeaponMagazine _unit select 0 >> "picture");
     _PWAmmoCtrl ctrlSetText format ["%1", _PWAmmoPicture];
     _PWAmmoTextCtrl ctrlSetText format ["%1", _PWCountType];
 } else {
     _PWAmmoCtrl ctrlSetText format [""];
     _PWAmmoTextCtrl ctrlSetText format [""];
 };

/*-------------------------------------------------------------------------------------------------------
 IF THE UNIT HAS ATLEast 1 SECONDARY MAGAZINE THEN DISPLAY IT'S PICTURE AND COUNT
--------------------------------------------------------------------------------------------------------*/
 if (count secondaryWeaponMagazine _unit > 0) then {
     _SWAmmoPicture = getText (configfile >> "CfgMagazines" >> secondaryWeaponMagazine _unit select 0 >> "picture");
     _SWAmmoCtrl ctrlSetText format ["%1", _SWAmmoPicture];
     _SWAmmoTextCtrl ctrlSetText format ["%1", _SWCountType];
 } else {
     _SWAmmoCtrl ctrlSetText format [""];
     _SWAmmoTextCtrl ctrlSetText format [""];
 };

/*-------------------------------------------------------------------------------------------------------
 IF THE UNIT HAS ATLEast 1 HAND GUN MAGAZINE THEN DISPLAY IT'S PICTURE AND COUNT
--------------------------------------------------------------------------------------------------------*/
 if (count handGunMagazine _unit > 0) then {
    _PisAmmoPicture = getText (configfile >> "CfgMagazines" >> handgunMagazine _unit select 0 >> "picture");
    _PisAmmoCtrl ctrlSetText format ["%1", _PisAmmoPicture];
    _PisAmmoTextCtrl ctrlSetText format ["%1", _PisCountType];
 } else {
    _PisAmmoCtrl ctrlSetText format [""];
    _PisAmmoTextCtrl ctrlSetText format [""];
 };

/*-------------------------------------------------------------------------------------------------------
 IF THE UNIT HAS ATLEast 1 HE GRENADE THEN DISPLAY IT'S PICTURE AND COUNT
--------------------------------------------------------------------------------------------------------*/
 if (_HEGreCountType > 0) then {
    _PWHEAmmoPicture = getText (configfile >> "CfgMagazines" >> primaryWeaponMagazine _unit select 1 >> "picture");
    _HEGreAmmoCtrl ctrlSetText format ["%1", _PWHEAmmoPicture];
    _HEGreAmmoTextCtrl ctrlSetText format ["%1", _HEGreCountType];
 } else {
    _HEGreAmmoCtrl ctrlSetText format [""];
    _HEGreAmmoTextCtrl ctrlSetText format [""];
 };

/*-------------------------------------------------------------------------------------------------------
 IF THE UNIT HAS ATLEast 1 WEAPON ATTATCHEMENT THEN DISPLAY THEIR PICTURES AND COUNT
--------------------------------------------------------------------------------------------------------*/
 if (count primaryWeaponItems _unit > 0) then {
    for [{_i=0},{_i < count primaryWeaponItems _unit},{_i=_i+1}] do {
    _attachCtrl = _display displayCtrl 80500 + _i;
    _attachPicture = getText (configfile >> "CfgWeapons" >> primaryWeaponItems _unit select _i >> "picture");
    _attachCtrl ctrlSetText format ["%1", _attachPicture];
   };
  };

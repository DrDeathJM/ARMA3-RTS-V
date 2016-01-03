TAG_FNC_Rifleman = 
{
  _unit = _this select 0;

   removeAllWeapons _unit;
   removeHeadgear _unit;
   removeVest _unit;
   removeUniform _unit;
   removeBackPack _unit;

  _unit addHeadgear "H_HelmetB";
  _unit addUniform "U_B_CombatUniform_mcam";
  _unit addVest "V_PlateCarrier1_rgr";
  _Unit addBackPack "B_AssaultPack_blk";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["HandGrenade",3]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_MX_F" ,10 ,"30Rnd_65x39_caseless_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};

TAG_FNC_Grenadier = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_HelmetB";
  _unit addUniform "U_B_CombatUniform_mcam";
  _unit addVest "V_PlateCarrier1_rgr";
  _Unit addBackPack "B_AssaultPack_blk";

  _unit addWeapon "rangefinder";
  _unit addItem "optic_holosight";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["1Rnd_HE_Grenade_shell",3];
  (unitBackpack _unit) addMagazineCargo ["MiniGrenade",5];
  (unitBackpack _unit) addMagazineCargo ["HandGrenade",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_MX_GL_F" ,10 ,"30Rnd_65x39_caseless_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};

TAG_FNC_Engineer = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_HelmetB_paint";
  _unit addUniform "U_B_CombatUniform_mcam_vest";
  _unit addVest "V_Chestrig_rgr";
  _Unit addBackPack "B_Carryall_ocamo_Eng";
  clearAllItemsFromBackpack _unit;

  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["ATMine_Range_Mag",1]; 
  (unitBackpack _unit) addMagazineCargo ["SLAMDirectionalMine_Wire_Mag",3];
  (unitBackpack _unit) addMagazineCargo ["APERSMine_Range_Mag",1];
  (unitBackpack _unit) addMagazineCargo ["APERSBoundingMine_Range_Mag",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  _unit addWeapon "rangefinder";
  _unit addMagazine "smokeshell";
  [_unit, "arifle_MXC_F" ,7 ,"30Rnd_65x39_caseless_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};

TAG_FNC_AutoRifleman = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_HelmetB_paint";
  _unit addUniform "U_B_CombatUniform_mcam";
  _unit addVest "V_PlateCarrier1_rgr";

  _Unit addbackpack "B_AssaultPack_mcamo_Ammo";
  clearAllItemsFromBackpack _unit; 

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_MX_SW_Pointer_F" ,8 ,"100Rnd_65x39_caseless_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_holosight";
  [_unit] call loadChange;
};

TAG_FNC_AT_Light = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_HelmetB_light";
  _unit addUniform "U_B_CombatUniform_mcam";
  _unit addVest "V_PlateCarrier2_rgr";
  _Unit addBackPack "B_AssaultPack_rgr_LAT";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_MX_F" ,9 ,"30Rnd_65x39_caseless_mag"] call BIS_fnc_addWeapon;
  [_unit, "launch_NLAW_F" ,2 ,"NLAW_F"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};

TAG_FNC_sapper = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_HelmetB_light_snakeskin";
  _unit addUniform "U_B_CTRG_1";
   _unit addVest "V_PlateCarrier2_rgr";
  _Unit addBackPack "B_TacticalPack_mcamo";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["B_IR_Grenade",1];
  (unitBackpack _unit) addMagazineCargo ["HandGrenade",5];
  (unitBackpack _unit) addMagazineCargo ["SLAMDirectionalMine_Wire_Mag",3]; 
  (unitBackpack _unit) addMagazineCargo ["SatchelCharge_Remote_Mag",2]; 
  [_unit, "arifle_MX_F" ,7 ,"30Rnd_65x39_caseless_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
   _unit addPrimaryWeaponItem "optic_Aco";
   _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};


TAG_FNC_AA = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_HelmetB";
  _unit addUniform "U_B_CombatUniform_mcam";
  _unit addVest "V_PlateCarrierSpec_rgr";
  _Unit addBackPack "B_AssaultPack_mcamo_AA";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";

  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 

  [_unit, "arifle_MX_F" ,9 ,"30Rnd_65x39_caseless_mag"] call BIS_fnc_addWeapon;
  [_unit, "launch_B_Titan_F" ,1 ,"Titan_AA"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco";

  _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};



TAG_FNC_SpecialF = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_HelmetB";
  _unit addUniform "U_B_CombatUniform_mcam";
  _unit addVest "V_PlateCarrier1_rgr";
  _Unit addBackPack "B_AssaultPack_blk";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["handGrenade",5];
  (unitBackpack _unit) addMagazineCargo ["smokeshell",2];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 

  [_unit, "srifle_EBR_F" ,8 ,"20Rnd_762x51_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Hamr";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  _unit addPrimaryWeaponItem "muzzle_snds_B";
  [_unit] call loadChange;
};

TAG_FNC_AT_Heavy = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_HelmetB";
  _unit addUniform "U_B_CombatUniform_mcam";
  _unit addVest "V_PlateCarrierSpec_rgr";
  _Unit addBackPack "B_AssaultPack_mcamo_AT";
  
  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_MX_F" ,9 ,"30Rnd_65x39_caseless_mag"] call BIS_fnc_addWeapon;
  [_unit, "launch_B_Titan_short_F" ,1 ,"Titan_AT"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};

TAG_FNC_Marksman = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_HelmetB";
  _unit addUniform "U_B_CombatUniform_mcam";
  _unit addVest "V_PlateCarrier1_rgr";
  _Unit addBackPack "B_AssaultPack_blk";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 

  [_unit, "srifle_EBR_F" ,10 ,"20Rnd_762x51_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_DMS";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};
TAG_FNC_Sniper = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_HelmetB";
  _unit addUniform "U_B_GhillieSuit";
  _unit addVest "V_PlateCarrier1_rgr";
  _Unit addBackPack "B_AssaultPack_blk";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["APERSTripMine_Wire_Mag",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 

  [_unit, "srifle_LRR_camo_LRPS_F" ,10 ,"7Rnd_408_Mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_01_F" ,6 ,"11Rnd_45ACP_Mag"] call BIS_fnc_addWeapon;

  [_unit] call loadChange;
};

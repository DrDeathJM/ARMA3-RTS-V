TAG_FNC_Rifleman = 
{
  _unit = _this select 0;

   removeAllWeapons _unit;
   removeHeadgear _unit;
   removeVest _unit;
   removeUniform _unit;
   removeBackPack _unit;

  _unit addHeadgear "H_shemag_olive";
  _unit addUniform "U_BG_Guerilla1_1";
  _unit addVest "V_TacVest_blk";
  _Unit addBackPack "B_AssaultPack_blk";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["HandGrenade",3]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_TRG20_F" ,10 ,"30Rnd_556x45_Stanag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_P07_F" ,6 ,"16Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco_grn";
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

  _unit addHeadgear "H_shemag_olive";
  _unit addUniform "U_I_CombatUniform";
  _unit addVest "V_PlateCarrierIA1_dgtl";
  _Unit addBackPack "B_AssaultPack_blk";

  _unit addWeapon "rangefinder";
  _unit addItem "optic_holosight";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["1Rnd_HE_Grenade_shell",10];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_TRG21_GL_F" ,8 ,"30Rnd_556x45_Stanag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_P07_F" ,6 ,"16Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco_grn";
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

  _unit addHeadgear "H_Watchcap_camo";
  _unit addUniform "U_BG_Guerilla2_2";
  _unit addVest "V_Chestrig_blk";
  _Unit addBackPack "G_TacticalPack_Eng";
  clearAllItemsFromBackpack _unit; 

  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["ATMine_Range_Mag",1]; 
  (unitBackpack _unit) addMagazineCargo ["SLAMDirectionalMine_Wire_Mag",1];
  (unitBackpack _unit) addMagazineCargo ["APERSMine_Range_Mag",1];
  (unitBackpack _unit) addMagazineCargo ["APERSBoundingMine_Range_Mag",1];

  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  _unit addWeapon "rangefinder";
  _unit addMagazine "smokeshell";
  [_unit, "arifle_TRG20_F" ,10 ,"30Rnd_556x45_Stanag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_P07_F" ,4 ,"16Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco_grn";
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

  _unit addHeadgear "H_shemag_olive";
  _unit addUniform "U_BG_Guerilla2_1";
  _unit addVest "V_TacVest_khk";
  _Unit addBackPack "I_Fieldpack_oli_Ammo";
  clearAllItemsFromBackpack _unit;

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "LMG_Mk200_F" ,8 ,"200Rnd_65x39_cased_Box"] call BIS_fnc_addWeapon;
  [_unit, "hgun_P07_F" ,4 ,"16Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
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

  _unit addHeadgear "H_shemag_olive";
  _unit addUniform "U_BG_Guerilla3_2";
  _unit addVest "V_TacVest_blk";
  _Unit addBackPack "G_FieldPack_LAT";
  clearAllItemsFromBackpack _unit; 

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_TRG20_F" ,8 ,"30Rnd_556x45_Stanag"] call BIS_fnc_addWeapon;
  [_unit, "launch_NLAW_F" ,2 ,"NLAW_F"] call BIS_fnc_addWeapon;
  [_unit, "hgun_P07_F" ,4 ,"16Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco_grn";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};

TAG_FNC_Pilot = 
{
  _unit = _this select 0;

  removeAllWeapons _unit;
  removeHeadgear _unit;
  removeVest _unit;
  removeUniform _unit;
  removeBackPack _unit;

  _unit addHeadgear "H_pilothelmetfighter_B";
  _unit addUniform "U_B_pilotcoveralls";
  _Unit addBackPack "B_parachute";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",3];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_TRG20_F" ,10 ,"30Rnd_556x45_Stanag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_P07_F" ,4 ,"16Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco_grn";
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

  _unit addHeadgear "H_shemag_olive";
  _unit addUniform "U_BG_Guerilla3_2";
  _unit addVest "V_TacVest_blk";
  _Unit addBackPack "I_Fieldpack_oli_AA";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_TRG20_F" ,8 ,"30Rnd_556x45_Stanag"] call BIS_fnc_addWeapon;
  [_unit, "launch_B_Titan_F" ,1 ,"Titan_AA"] call BIS_fnc_addWeapon;
  [_unit, "hgun_P07_F" ,4 ,"16Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco_grn";
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

  _unit addHeadgear "H_shemag_olive";
  _unit addUniform "U_BG_Guerilla3_2";
  _unit addVest "V_TacVest_blk";
  _Unit addBackPack "B_AssaultPack_blk";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",2];
  (unitBackpack _unit) addMagazineCargo ["handGrenade",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "srifle_EBR_F" ,10 ,"20Rnd_762x51_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_P07_F" ,4 ,"16Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_MRCO";
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

  _unit addHeadgear "H_shemag_olive";
  _unit addUniform "U_BG_Guerilla3_2";
  _unit addVest "V_TacVest_blk";
  _Unit addBackPack "I_Fieldpack_oli_AT";
  
  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_TRG20_F" ,8 ,"30Rnd_556x45_Stanag"] call BIS_fnc_addWeapon;
  [_unit, "launch_B_Titan_short_F" ,1 ,"Titan_AT"] call BIS_fnc_addWeapon;
  [_unit, "hgun_P07_F" ,4 ,"16Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_Aco_grn";
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

  _unit addHeadgear "H_shemag_olive";
  _unit addUniform "U_BG_Guerilla3_1";
  _unit addVest "V_BandollierB_khk";
  _Unit addBackPack "B_AssaultPack_blk";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_blue",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "srifle_EBR_F" ,10 ,"20Rnd_762x51_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_P07_F" ,4 ,"16Rnd_9x21_Mag"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_DMS";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};

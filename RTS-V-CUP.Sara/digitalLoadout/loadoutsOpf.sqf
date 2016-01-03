TAG_FNC_Rifleman = 
{
  _unit = _this select 0;

   removeAllWeapons _unit;
   removeHeadgear _unit;
   removeVest _unit;
   removeUniform _unit;
   removeBackPack _unit;
	
  _unit addHeadgear "H_HelmetO_ocamo";
  _unit addUniform "U_O_CombatUniform_ocamo";
  _unit addVest "V_harnessO_brn";
  _Unit addBackPack "B_Fieldpack_cbr";

  _unit addWeapon "binocular";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["HandGrenade",3]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_red",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_Katiba_F" ,10 ,"30Rnd_65x39_caseless_Green"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_ACO_grn";
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

  _unit addHeadgear "H_HelmetO_ocamo";
  _unit addUniform "U_O_CombatUniform_ocamo";
  _unit addVest "V_harnessO_brn";
  _Unit addBackPack "B_Fieldpack_cbr";

  _unit addWeapon "binocular";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["1Rnd_HE_Grenade_shell",3];
  (unitBackpack _unit) addMagazineCargo ["MiniGrenade",5];
  (unitBackpack _unit) addMagazineCargo ["HandGrenade",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_TRG21_GL_F" ,10 ,"30Rnd_65x39_caseless_Green"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_ACO_grn";
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

  _unit addHeadgear "H_HelmetO_ocamo";
  _unit addUniform "U_O_CombatUniform_ocamo";
  _unit addVest "V_harnessO_brn";
  _Unit addBackPack "B_Carryall_mcamo";
  clearAllItemsFromBackpack _unit; 

  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["ATMine_Range_Mag",1]; 
  (unitBackpack _unit) addMagazineCargo ["SLAMDirectionalMine_Wire_Mag",3];
  (unitBackpack _unit) addMagazineCargo ["APERSMine_Range_Mag",1];
  (unitBackpack _unit) addMagazineCargo ["APERSBoundingMine_Range_Mag",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_red",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  _unit addWeapon "binocular";
  _unit addMagazine "smokeshell";
  [_unit, "arifle_katiba_F" ,7 ,"30Rnd_65x39_caseless_green"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_ACO_grn";
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

  _unit addHeadgear "H_HelmetO_ocamo";
  _unit addUniform "U_O_CombatUniform_ocamo";
  _unit addVest "V_harnessO_brn";
  _Unit addBackPack "B_Fieldpack_cbr";

  _unit addWeapon "binocular";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_red",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "LMG_Mk200_BI_F" ,8 ,"200Rnd_65x39_cased_Box"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_ACO_grn";
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

  _unit addHeadgear "H_HelmetO_ocamo";
  _unit addUniform "U_O_CombatUniform_ocamo";
  _unit addVest "V_TacVest_khk";
  _Unit addBackPack "B_FieldPack_cbr_LAT";

  _unit addWeapon "binocular";
 _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_red",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_katiba_F" ,9 ,"30Rnd_65x39_caseless_green"] call BIS_fnc_addWeapon;
  [_unit, "launch_RPG32_F" ,2 ,"RPG32_F"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_ACO_grn";
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

  _unit addHeadgear "H_Bandanna_sgg";
  _unit addUniform "U_OG_Guerilla2_1";
  _Unit addBackPack "B_TacticalPack_blk";
  _Unit addVest "V_PlateCarrierSpec_rgr";
  
  _unit addWeapon "binocular";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["ClaymoreDirectionalMine_Remote_Mag",2];
  (unitBackpack _unit) addMagazineCargo ["SatchelCharge_Remote_Mag",3]; 
  (unitBackpack _unit) addMagazineCargo ["DemoCharge_Remote_Mag",2]; 
  [_unit, "arifle_katiba_F" ,7 ,"30Rnd_65x39_caseless_green"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
   _unit addPrimaryWeaponItem "optic_ACO_grn";
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

  _unit addHeadgear "H_HelmetO_ocamo";
  _unit addUniform "U_O_CombatUniform_ocamo";
  _unit addVest "V_harnessO_brn";
  _Unit addBackPack "B_Fieldpack_cbr";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",2];
  (unitBackpack _unit) addMagazineCargo ["handGrenade",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_red",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "srifle_EBR_F" ,10 ,"20Rnd_762x51_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_MRCO";
  _unit addPrimaryWeaponItem "muzzle_snds_B";
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

  _unit addHeadgear "H_HelmetO_ocamo";
  _unit addUniform "U_O_CombatUniform_ocamo";
  _unit addVest "V_harnessO_brn";
  _Unit addBackPack "B_FieldPack_ocamo_AA";

  _unit addWeapon "binocular";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_red",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_katiba_F" ,9 ,"30Rnd_65x39_caseless_green"] call BIS_fnc_addWeapon;
  [_unit, "launch_B_Titan_F" ,2 ,"Titan_AA"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_ACO_grn";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
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

  _unit addHeadgear "H_HelmetO_ocamo";
  _unit addUniform "U_O_CombatUniform_ocamo";
  _unit addVest "V_TacVest_khk";
  _Unit addBackPack "B_FieldPack_cbr_AT";
  
  _unit addWeapon "binocular";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_red",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "arifle_katiba_F" ,7 ,"30Rnd_65x39_caseless_green"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
  [_unit, "launch_B_Titan_short_F" ,2 ,"Titan_AT"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_ACO_grn";
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

  _unit addHeadgear "H_HelmetO_ocamo";
  _unit addUniform "U_O_CombatUniform_ocamo";
  _unit addVest "V_harnessO_brn";
  _Unit addBackPack "B_Fieldpack_cbr";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_red",5];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "srifle_DMR_01_F" ,7 ,"10Rnd_762x51_mag"] call BIS_fnc_addWeapon;
  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
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

  _unit addHeadgear "H_HelmetO_ocamo";
  _unit addUniform "U_O_GhillieSuit";
  _unit addVest "V_harnessO_brn";
  _Unit addBackPack "B_Fieldpack_cbr";

  _unit addWeapon "rangefinder";
  _unit addWeapon "itemGps";
  (unitBackpack _unit) addMagazineCargo ["smokeshell",1];
  (unitBackpack _unit) addMagazineCargo ["APERSTripMine_Wire_Mag",1];
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Green",5]; 
  (unitBackpack _unit) addMagazineCargo ["Chemlight_Yellow",5]; 
  [_unit, "srifle_GM6_camo_LRPS_F" ,10 ,"5Rnd_127x108_Mag"] call BIS_fnc_addWeapon;

  [_unit, "hgun_pistol_heavy_02_F" ,6 ,"6Rnd_45ACP_Cylinder"] call BIS_fnc_addWeapon;
  _unit addPrimaryWeaponItem "optic_DMS";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  [_unit] call loadChange;
};
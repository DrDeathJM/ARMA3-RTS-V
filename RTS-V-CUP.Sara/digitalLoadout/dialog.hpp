
class digitalLoadout
{
    idd = 3000;
    movingenable = true;
    onLoad = "uiNamespace setVariable ['DLoad', (_this select 0)]";

    class Controls
    {

      class ICE_BG: rscbackgroundGUI
      {
    idc = -1;
    text = "";
    x = 0.25 * safezoneW + safezoneX;
    y = 0.175 * safezoneH + safezoneY;
    w = 0.4 * safezoneW;
    h = 0.4 * safezoneH * 4 / 3;
      };

      class ICE_TopStripe: rscTopStripe
      {
    idc = -1;
    text = "";
        x = 0.25 * safezoneW + safezoneX;
    y = 0.14 * safezoneH + safezoneY;
    w = 0.4 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

     /* ---------------------------------

               Pictures RANKS

      --------------------------------- */
      class ICE_RankHeader: IcePicture
      {
    idc = 100001;
    text = "";
    x = 0.2575 * safezoneW + safezoneX;
    y = 0.1425 * safezoneH + safezoneY;
    w = 0.02 * safezoneW;
    h = 0.02 * safezoneH * 4 / 3;
      };

      class ICE_rank1: IcePicture
      {
    idc = 100002;
        text = "";
    x = 0.35 * safezoneW + safezoneX;
    y = 0.2 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_rank2: IcePicture
      {
    idc = 100003;
        text = "";
    x = 0.35 * safezoneW + safezoneX;
    y = 0.25 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_rank3: IcePicture
      {
    idc = 100004;
        text = "";
    x = 0.35 * safezoneW + safezoneX;
    y = 0.3 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_rank4: IcePicture
      {
    idc = 100005;
        text = "";
    x = 0.35 * safezoneW + safezoneX;
    y = 0.35 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_rank5: IcePicture
      {
    idc = 100006;
        text = "";
    x = 0.35 * safezoneW + safezoneX;
    y = 0.4 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_rank6: IcePicture
      {
    idc = 100007;
        text = "";
    x = 0.35 * safezoneW + safezoneX;
    y = 0.45 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_rank7: IcePicture
      {
    idc = 100008;
        text = "";
    x = 0.35 * safezoneW + safezoneX;
    y = 0.5 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_rank8: IcePicture
      {
    idc = 100009;
        text = "";
    x = 0.35 * safezoneW + safezoneX;
    y = 0.55 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_rank9: IcePicture
      {
    idc = 100010;
        text = "";
    x = 0.35 * safezoneW + safezoneX;
    y = 0.6 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_rank10: IcePicture
      {
    idc = 100011;
        text = "";
    x = 0.35 * safezoneW + safezoneX;
    y = 0.65 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      /* -----------------------------

                  BUTTONS

    -------------------------------*/
    class ICE_button1: IceButton {
        idc = 15000;
        text = "Rifleman";
        action = "[player, str side player + 'rifleman'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.2 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button2: IceButton {
        idc = 15001;
        text = "Grenadier";
        action = "[player, str side player +  'grenadier'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.25 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button3: IceButton {
        idc = 15002;
        text = "Engineer";
        action = "[player, str side player +  'engineer'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.3 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button4: IceButton {
        idc = 15003;
        text = "Auto-rifleman";
        action = "[player, str side player +  'autorifleman'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.35 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button5: IceButton {
        idc = 15004;
        text = "AT (light)";
        action = "[player, str side player +  'AT rifleman'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.4 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button6: IceButton {
        idc = 15005;
        text = "Sapper";
        action = "[player, str side player +  'sapper'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.45 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button7: IceButton {
        idc = 15006;
        text = "AA (Titan)";
        action = "[player, str side player +  'AA spec'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.5 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button8: IceButton {
        idc = 15007;
        text = "Special Forces";
        action = "[player, str side player +  'SOF'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.55 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button9: IceButton {
        idc = 15008;
        text = "AT (Titan)";
        action = "[player, str side player +  'AT spec'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.6 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button10: IceButton {
        idc = 15009;
        text = "Marksman";
        action = "[player, str side player +  'marksman'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.65 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button11: IceButton {
        idc = 15010;
        text = "sniper";
        action = "[player, str side player +  'sniper'] call Zen_GiveLoadoutCustom; [player] call loadChange;";
        x = 0.25 * safezoneW + safezoneX;
        y = 0.70 * safezoneH + safezoneY;
        w = 0.125 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };
    class ICE_button12: IceButton {
        idc = -1;
        text = "X";
        style = ST_CENTER;
        action = "closeDialog 0";
        x = 0.625 * safezoneW + safezoneX;
        y = 0.14 * safezoneH + safezoneY;
        w = 0.025 * safezoneW;
        h = 0.025 * safezoneH * 4 / 3;
    };

      /* ---------------------------------

                **Pictures Weapons

      --------------------------------- */
      class ICE_Prim_Pic: IcePicture
      {
    idc = 71500;
    x = 0.435 * safezoneW + safezoneX;
    y = 0.2 * safezoneH + safezoneY;
    w = 0.1 * safezoneW;
    h = 0.075 * safezoneH * 4 / 3;
      };

      class ICE_Sec_Pic: IcePicture
      {
    idc = 71501;
    x = 0.44 * safezoneW + safezoneX;
    y = 0.33 * safezoneH + safezoneY;
    w = 0.1 * safezoneW;
    h = 0.075 * safezoneH * 4 / 3;
      };

      class ICE_Pistol_Pic: IcePicture
      {
    idc = 71503;
    x = 0.435 * safezoneW + safezoneX;
    y = 0.45 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.075 * safezoneH * 4 / 3;
      };

      class ICE_BP_Pic: IcePicture
      {
    idc = 71502;
    x = 0.45 * safezoneW + safezoneX;
    y = 0.57 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.075 * safezoneH * 4 / 3;
      };



      /* ---------------------------------

                 **Pictures Ammo

      --------------------------------- */
      class ICE_Prim_Ammo_Pic: IcePicture
      {
    idc = 71504;
    x = 0.545 * safezoneW + safezoneX;
    y = 0.275 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Sec_Ammo_Pic: IcePicture
      {
    idc = 71505;
    x = 0.55 * safezoneW + safezoneX;
    y = 0.36 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Pis_Ammo_Pic: IcePicture
      {
    idc = 71506;
    x = 0.505 * safezoneW + safezoneX;
    y = 0.48 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_HE_Ammo_Pic: IcePicture
      {
    idc = 71522;
    x = 0.575 * safezoneW + safezoneX;
    y = 0.275 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      /* ---------------------------------

            **Pictures attatchments

      --------------------------------- */


      class ICE_attch1_Pic: IcePicture
      {
    idc = 80500;
    x = 0.6 * safezoneW + safezoneX;
    y = 0.235 * safezoneH + safezoneY;
    w = 0.02 * safezoneW;
    h = 0.02 * safezoneH * 4 / 3;
      };

      class ICE_attch2_Pic: IcePicture
      {
    idc = 80501;
    x = 0.575 * safezoneW + safezoneX;
    y = 0.235 * safezoneH + safezoneY;
    w = 0.02 * safezoneW;
    h = 0.02 * safezoneH * 4 / 3;
      };

       class ICE_attch3_Pic: IcePicture
      {
    idc = 80502;
    x = 0.55 * safezoneW + safezoneX;
    y = 0.235 * safezoneH + safezoneY;
    w = 0.02 * safezoneW;
    h = 0.02 * safezoneH * 4 / 3;
      };

      /* ---------------------------------

         **Pictures BackPack items Row1

      --------------------------------- */
      class ICE_BPitem1_Pic: IcePicture
      {
    idc = 71510;
    x = 0.5125 * safezoneW + safezoneX;
    y = 0.5625 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_BPitem2_Pic: IcePicture
      {
    idc = 71511;
    x = 0.54 * safezoneW + safezoneX;
    y = 0.5625 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_BPitem3_Pic: IcePicture
      {
    idc = 71512;
    x = 0.5675 * safezoneW + safezoneX;
    y = 0.5625 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_BPitem4_Pic: IcePicture
      {
    idc = 71513;
    x = 0.595 * safezoneW + safezoneX;
    y = 0.5625 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      /* ---------------------------------

         **Pictures BackPack items Row2

      --------------------------------- */
      class ICE_BPitem5_Pic: IcePicture
      {
    idc = 71514;
    x = 0.5125 * safezoneW + safezoneX;
    y = 0.605 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_BPitem6_Pic: IcePicture
      {
    idc = 71515;
    x = 0.54 * safezoneW + safezoneX;
    y = 0.605 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };


      class ICE_BPitem7_Pic: IcePicture
      {
    idc = 71516;
    x = 0.5675 * safezoneW + safezoneX;
    y = 0.605 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_BPitem8_Pic: IcePicture
      {
    idc = 71517;
    x = 0.595 * safezoneW + safezoneX;
    y = 0.605 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      /* ---------------------------------

         **Pictures BackPack items Row3

      --------------------------------- */
      class ICE_BPitem9_Pic: IcePicture
      {
    idc = 71518;
    x = 0.5125 * safezoneW + safezoneX;
    y = 0.6475 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_BPitem10_Pic: IcePicture
      {
    idc = 71519;
    x = 0.54 * safezoneW + safezoneX;
    y = 0.6475 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_BPitem11_Pic: IcePicture
      {
    idc = 71520;
    x = 0.5675 * safezoneW + safezoneX;
    y = 0.6475 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_BPitem12_Pic: IcePicture
      {
    idc = 71521;
    x = 0.595 * safezoneW + safezoneX;
    y = 0.6475 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

       /* ---------------------------------

             **Text backpack items

      --------------------------------- */
      class ICE_Text_bp1: IceText
      {
    idc = 26500;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx = 0.02;
    x = 0.5125 * safezoneW + safezoneX;
    y = 0.5625 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp2: IceText
      {
    idc = 26501;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx = "0.02; /  (getResolution select 5)";
    x = 0.54 * safezoneW + safezoneX;
    y = 0.5625 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp3: IceText
      {
    idc = 26502;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx = "0.02 /  (getResolution select 5)";
    x = 0.5675 * safezoneW + safezoneX;
    y = 0.5625 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp4: IceText
      {
    idc = 26503;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx =" 0.02 /  (getResolution select 5)";
    x = 0.595 * safezoneW + safezoneX;
    y = 0.5625 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp5: IceText
      {
    idc = 26504;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx =" 0.02 /  (getResolution select 5)";
    x = 0.5125 * safezoneW + safezoneX;
    y = 0.605 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp6: IceText
      {
    idc = 26505;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx =" 0.02 /  (getResolution select 5)";
    x = 0.54 * safezoneW + safezoneX;
    y = 0.605 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp7: IceText
      {
    idc = 26506;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx =" 0.02 /  (getResolution select 5)";
    x = 0.5675 * safezoneW + safezoneX;
    y = 0.605 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp8: IceText
      {
    idc = 26507;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx =" 0.02 /  (getResolution select 5)";
    x = 0.595 * safezoneW + safezoneX;
    y = 0.605 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp9: IceText
      {
    idc = 26508;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx =" 0.02 /  (getResolution select 5)";
    x = 0.5125 * safezoneW + safezoneX;
    y = 0.6475 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp10: IceText
      {
    idc = 26509;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx =" 0.02 /  (getResolution select 5)";
    x = 0.54 * safezoneW + safezoneX;
    y = 0.6475 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp11: IceText
      {
    idc = 26510;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx =" 0.02 /  (getResolution select 5)";
    x = 0.5675 * safezoneW + safezoneX;
    y = 0.6475 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp12: IceText
      {
    idc = 26511;
    text = "0";
        action = "";
        colorText[] = {1,1,1,0.4};
        sizeEx =" 0.02 /  (getResolution select 5)";
    x = 0.595 * safezoneW + safezoneX;
    y = 0.6475 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };


      /* ---------------------------------

                      Text

      --------------------------------- */
      class ICE_Text_Name: IceText
      {
    idc = 61500;
        sizeEx =" 0.02 /  (getResolution select 5)";
    x = 0.25 * safezoneW + safezoneX;
    y = 0.14 * safezoneH + safezoneY;
    w = 0.4 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_PrimW: IceText
      {
    idc = -1;
        sizeEx =" 0.02 /  (getResolution select 5)";
        text = "Primary Weapon";
    x = 0.45 * safezoneW + safezoneX;
    y = 0.2 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };


      class ICE_Text_No_PrimW: IceText
      {
    idc = 40500;
        sizeEx =" 0.02 /  (getResolution select 5)";
        text = "N / A";
    x = 0.45 * safezoneW + safezoneX;
    y = 0.235 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_secW: IceText
      {
    idc = -1;
        sizeEx =" 0.02 /  (getResolution select 5)";
        text = "Launcher";
    x = 0.45 * safezoneW + safezoneX;
    y = 0.33 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

       class ICE_Text_No_secW: IceText
      {
    idc = 40501;
        sizeEx =" 0.02 /  (getResolution select 5)";
        text = "N / A";
    x = 0.45 * safezoneW + safezoneX;
    y = 0.365 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_pisW: IceText
      {
    idc = -1;
        sizeEx =" 0.02 /  (getResolution select 5)";
        text = "Pistol";
    x = 0.45 * safezoneW + safezoneX;
    y = 0.44 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

       class ICE_Text_No_pisW: IceText
      {
    idc = 40502;
        sizeEx =" 0.02 /  (getResolution select 5)";
        text = "N / A";
    x = 0.45 * safezoneW + safezoneX;
    y = 0.47 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_bp: IceText
      {
    idc = -1;
        sizeEx =" 0.02 /  (getResolution select 5)";
        text = "BackPack";
    x = 0.45 * safezoneW + safezoneX;
    y = 0.54 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_No_bp: IceText
      {
    idc = 40503;
        sizeEx =" 0.02 /  (getResolution select 5)";
        text = "N / A";
    x = 0.45 * safezoneW + safezoneX;
    y = 0.6 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };
      class ICE_PWAmmo_Text: IceText
      {
    idc = 71507;
    x = 0.545 * safezoneW + safezoneX;
    y = 0.275 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_SWAmmo_Text: IceText
      {
    idc = 71508;
    x = 0.55 * safezoneW + safezoneX;
    y = 0.36 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_PisAmmo_Text: IceText
      {
    idc = 71509;
    x = 0.505 * safezoneW + safezoneX;
    y = 0.48 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };

      class ICE_Text_HE: IceText
      {
    idc = 71523;
    x = 0.575 * safezoneW + safezoneX;
    y = 0.275 * safezoneH + safezoneY;
    w = 0.025 * safezoneW;
    h = 0.025 * safezoneH * 4 / 3;
      };
   };


};

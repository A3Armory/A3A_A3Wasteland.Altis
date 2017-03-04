//Loot initialize
//Author: BangaBob(H8ermaker) edited by Gigatek
//@file Name: lootInit.sqf

if(isServer)then
{
// Set probability of loot spawning 1-100%
_probability= 1;

// Show loot position and type on map (Debugging)
_showLoot= false;

// Set Weapon loot: Primary weapons, secondary weapons, Sidearms.
weaponsLoot= ["arifle_Mk20C_F","arifle_Mk20_F","arifle_Mk20_GL_F","arifle_MX_Black_F","arifle_MX_khk_F","arifle_MX_GL_Black_F","arifle_MX_GL_khk_F","arifle_SPAR_01_khk_F","arifle_SPAR_01_snd_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_GL_snd_F","arifle_CTAR_GL_blk_F","arifle_ARX_hex_F","arifle_ARX_ghex_F","arifle_MXM_Black_F","arifle_MXM_khk_F","srifle_DMR_07_hex_F","srifle_DMR_07_ghex_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","srifle_DMR_06_camo_F","srifle_DMR_03_multicam_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_LRR_camo_F","srifle_LRR_tna_F","srifle_GM6_camo_F","srifle_GM6_ghex_F","srifle_DMR_04_tan_F","arifle_MX_SW_Black_F","arifle_MX_SW_khk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","launch_RPG32_ghex_F","launch_O_Titan_short_F","launch_I_Titan_short_F","launch_B_Titan_short_tna_F","launch_O_Titan_short_ghex_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_tna_F","launch_O_Titan_ghex_F","MMG_02_sand_F","MMG_02_camo_F","MMG_02_black_F","MMG_01_tan_F","MMG_01_hex_F"];
// Set Magazine loot: Primary weapons, secondary weapons, Sidearms.
magazineLoot= ["SmokeShellPurple","SmokeShellYellow","SmokeShellOrange","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","3Rnd_SmokePurple_Grenade_shell","3Rnd_SmokeYellow_Grenade_shell","3Rnd_SmokeOrange_Grenade_shell","UGL_FlareGreen_F","UGL_FlareYellow_F","UGL_FlareRed_F","3Rnd_UGL_FlareGreen_F","3Rnd_UGL_FlareYellow_F","3Rnd_UGL_FlareRed_F","Titan_AT","Titan_AP","30Rnd_9x21_Mag","30Rnd_556x45_Stanag_Tracer_Yellow","10Rnd_762x54_Mag","20Rnd_556x45_UW_mag","11Rnd_45ACP_Mag","9Rnd_45ACP_Mag"];
// Set items: Weapon attachments, first-aid, Binoculars
itemsLoot= ["Laserdesignator_03","Rangefinder","ToolKit","Medikit","FirstAidKit","muzzle_snds_m_khk_F","muzzle_snds_m_snd_F","muzzle_snds_58_wdm_F","muzzle_snds_H_khk_F","muzzle_snds_H_snd_F","muzzle_snds_H_MG_blk_F","muzzle_snds_H_MG_khk_F","muzzle_snds_65_TI_hex_F","muzzle_snds_65_TI_ghex_F","muzzle_snds_B_khk_F","muzzle_snds_B_snd_F","muzzle_snds_338_green","muzzle_snds_338_sand","muzzle_snds_93mmg_tan","bipod_01_F_mtp","bipod_02_F_hex","bipod_03_F_oli","bipod_01_F_snd","bipod_02_F_tan","bipod_01_F_khk","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco_ghex_F","optic_Hamr_khk_F","optic_SOS_khk_F","optic_KHS_hex","optic_KHS_tan","optic_AMS_khk","optic_AMS_snd","optic_LRPS_ghex_F","optic_LRPS_tna_F","NVGoggles_OPFOR","NVGoggles_INDEP","NVGoggles_tna_F","O_NVGoggles_ghex_F","O_NVGoggles_urb_F","Chemlight_yellow"];
// Set Clothing: Hats, Helmets, Uniforms
clothesLoot= ["H_HelmetB_black","H_HelmetB_camo","H_HelmetSpecB_blk","H_HelmetSpecB_snakeskin","H_HelmetB_Enh_tna_F","H_MilCap_blue","H_MilCap_gry","H_MilCap_oucamo","H_MilCap_rucamo","H_MilCap_mcamo","H_MilCap_ocamo","H_MilCap_dgtl","H_Cap_headphones","H_Bandanna_gry","H_Bandanna_blu","H_Bandanna_cbr","H_Bandanna_khk_hs","H_Bandanna_khk","H_Bandanna_mcamo","H_Bandanna_sgg","H_Bandanna_sand","H_Bandanna_surfer","H_Bandanna_surfer_blk","H_Bandanna_surfer_grn","H_Bandanna_camo","H_Watchcap_blk","H_Watchcap_cbr","H_Watchcap_khk","H_Watchcap_sgg","H_Watchcap_camo","H_Beret_blk","H_Beret_Colonel","H_Beret_02","H_Booniehat_dgtl","H_Booniehat_khk_hs","H_Booniehat_khk","H_Booniehat_mcamo","H_Booniehat_oli","H_Booniehat_tan","H_Hat_blue","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_Cap_grn_BI","H_Cap_blk","H_Cap_blu","H_Cap_blk_CMMG","H_Cap_grn","H_Cap_blk_ION","H_Cap_oli","H_Cap_oli_hs","H_Cap_police","H_Cap_press","H_Cap_red","H_Cap_surfer","H_Cap_tan","H_Cap_khaki_specops_UK","H_Cap_usblack","H_Cap_tan_specops_US","H_Cap_blk_Raven","H_Cap_brn_SPECOPS","H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_tan","H_ShemagOpen_khk","H_RacingHelmet_1_blue_F","H_RacingHelmet_1_green_F","H_RacingHelmet_1_yellow_F","H_RacingHelmet_1_orange_F","H_RacingHelmet_1_red_F","H_RacingHelmet_1_white_F","H_RacingHelmet_1_F","H_RacingHelmet_2_F","H_RacingHelmet_3_F","H_RacingHelmet_4_F","G_Balaclava_TI_tna_F","G_Balaclava_TI_G_tna_F","G_Combat_Goggles_tna_F","G_Goggles_VR","G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_lowprofile","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan","G_Aviator","G_Lady_Blue","G_Lady_Red","G_Lady_Mirror","G_Lady_Dark","G_Lowprofile","G_Shades_Black","G_Shades_Blue","G_Shades_Green","G_Shades_Red","G_Spectacles","G_Sport_Red","G_Sport_Blackyellow","G_Sport_BlackWhite","G_Sport_Checkered","G_Sport_Blackred","G_Sport_Greenblack","G_Squares_Tinted","G_Squares","G_Tactical_Clear","G_Tactical_Black","G_Spectacles_Tinted"];
// Set Vests: Any vests
vestsLoot= ["V_PlateCarrier1_blk","V_PlateCarrierL_CTRG","V_PlateCarrier1_tna_F","V_PlateCarrier2_blk","V_PlateCarrierH_CTRG","V_PlateCarrier2_tna_F","V_PlateCarrierGL_blk","V_PlateCarrierGL_mtp","V_PlateCarrierGL_tna_F","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_tna_F","V_PlateCarrierIAGL_oli","V_HarnessO_gry","V_HarnessOGL_gry","V_BandollierB_cbr","V_BandollierB_rgr","V_BandollierB_khk","V_BandollierB_oli","V_Chestrig_rgr","V_Chestrig_oli","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli","V_TacVest_blk_POLICE","V_Press_F"];
// Set Backpacks: Any packpacks
backpacksLoot= ["B_AssaultPack_rgr","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_tna_F","B_FieldPack_cbr","B_FieldPack_khk","B_FieldPack_oucamo","B_FieldPack_ghex_F","B_Kitbag_rgr","B_Kitbag_mcamo","B_Kitbag_sgg","B_ViperLightHarness_hex_F","B_ViperLightHarness_ghex_F","B_ViperLightHarness_khk_F","B_ViperLightHarness_oli_F","B_ViperHarness_hex_F","B_ViperHarness_ghex_F","B_ViperHarness_khk_F","B_ViperHarness_oli_F","B_Carryall_mcamo","B_Carryall_oli","B_Carryall_oucamo","B_Carryall_ghex_F","B_Bergen_hex_F","B_Bergen_mcamo_F","B_Bergen_tna_F"];

// Exclude buildings from loot spawn. Use 'TYPEOF' to find building name
_exclusionList= ["Land_Pier_F","Land_Pier_small_F","Land_NavigLight","Land_LampHarbour_F"];

_houseList= (getMarkerPos "center_mrk") nearObjects ["House",13000];

{
_house= _x;
	if (!(typeOf _house in _exclusionList)) then
	{
		for "_n" from 0 to 50 do
		{
			_buildingPos= _house buildingpos _n;
			if (str _buildingPos == "[0,0,0]") exitwith {};
			if (_probability > random 100) then
			{
				null=[_buildingPos,_showLoot] execVM "addons\Simple_lootspawner\spawnLoot.sqf";
			};
		};
	};
}foreach _houseList;

};
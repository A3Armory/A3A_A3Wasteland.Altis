// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: fn_refillbox.sqf  "fn_refillbox"
//	@file Author: [404] Pulse , [404] Costlyy , [404] Deadbeat, AgentRev
//	@file Created: 22/1/2012 00:00
//	@file Args: [OBJECT (Weapons box that needs filling), STRING (Name of the fill to give to object)]

if (!isServer) exitWith {};

#define RANDOM_BETWEEN(START,END) ((START) + floor random ((END) - (START) + 1))
#define RANDOM_ODDS(ODDS) ([0,1] select (random 1 < (ODDS))) // between 0.0 and 1.0

private ["_box", "_boxType", "_boxItems", "_item", "_qty", "_mag"];
_box = _this select 0;
_boxType = _this select 1;

_box setVariable [call vChecksum, true];

_box allowDamage false; // No more fucking busted crates
_box setVariable ["allowDamage", false, true];
_box setVariable ["A3W_inventoryLockR3F", true, true];

// Clear pre-existing cargo first
clearBackpackCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;

if (_boxType == "mission_USSpecial2") then { _boxType = "mission_USSpecial" };

switch (_boxType) do
{
	case "mission_USLaunchers":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["launch_RPG32_F", "launch_NLAW_F"], RANDOM_BETWEEN(3,5), RANDOM_BETWEEN(1,2)],
			["wep", "launch_Titan_F", RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			["mag", ["APERSTripMine_Wire_Mag", "APERSBoundingMine_Range_Mag", "APERSMine_Range_Mag", "ClaymoreDirectionalMine_Remote_Mag"], RANDOM_BETWEEN(2,5)],
			["mag", ["SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"], RANDOM_BETWEEN(2,5)],
			["mag", "HandGrenade", RANDOM_BETWEEN(5,10)],
			["mag", "1Rnd_HE_Grenade_shell", RANDOM_BETWEEN(5,10)],
			["itm", [["H_HelmetB", "H_HelmetIA"], ["H_HelmetSpecB", "H_HelmetSpecO_ocamo"], "H_HelmetLeaderO_ocamo"], RANDOM_BETWEEN(1,4)],
			["itm", [["V_PlateCarrier1_rgr", "V_PlateCarrier1_blk", "V_PlateCarrierIA1_dgtl"], // Lite
			         ["V_PlateCarrier2_rgr", "V_PlateCarrier2_blk", "V_PlateCarrierIA2_dgtl"], // Rig
			         ["V_PlateCarrierSpec_rgr", "V_PlateCarrierSpec_blk", "V_PlateCarrierSpec_mtp"], // Special
			         ["V_PlateCarrierGL_rgr", "V_PlateCarrierGL_blk", "V_PlateCarrierGL_mtp", "V_PlateCarrierIAGL_dgtl", "V_PlateCarrierIAGL_oli"]] /* GL */, RANDOM_BETWEEN(1,4)]
		];
	};
	case "mission_USSpecial":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["itm", ["optic_MRCO", "optic_Arco", "optic_Hamr", "optic_SOS"], RANDOM_BETWEEN(0,2)],
			["itm", ["muzzle_snds_M", "muzzle_snds_H", "muzzle_snds_H_MG", "muzzle_snds_B", "muzzle_snds_acp"], RANDOM_BETWEEN(0,3)],
			["wep", ["hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_02_F", "hgun_Rook40_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["arifle_MXM_F", "srifle_EBR_F", "srifle_DMR_01_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["LMG_Mk200_F", "LMG_Zafir_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(2,4)],
			["mag", "30Rnd_556x45_Stanag", RANDOM_BETWEEN(4,8)],
			["mag", "30Rnd_65x39_caseless_green", RANDOM_BETWEEN(4,8)],
			["mag", "30Rnd_9x21_Mag", RANDOM_BETWEEN(1,5)]
		];
	};
	case "mission_Main_A3snipers":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["srifle_LRR_F", "srifle_GM6_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(4,6)],
			["wep", ["srifle_EBR_F", "srifle_DMR_01_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", "Rangefinder", RANDOM_BETWEEN(1,3)],
			["wep", "Laserdesignator_02", RANDOM_BETWEEN(0,1)],
			["itm", "optic_DMS", RANDOM_BETWEEN(1,3)]
		];
	};
	case "mission_HVSniper":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["srifle_LRR_camo_F", "srifle_LRR_tna_F", "srifle_EBR_F", "srifle_DMR_01_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(3,6)],
			["wep", ["srifle_GM6_F", "srifle_GM6_camo_F", "srifle_GM6_ghex_F"], RANDOM_BETWEEN(2,3), RANDOM_BETWEEN(4,6)],
			["wep", ["Laserdesignator", "Laserdesignator_03"], RANDOM_BETWEEN(0,1)],
			["wep", "Laserdesignator_02", RANDOM_BETWEEN(0,1)],
			["itm", ["optic_LRPS", "optic_LRPS_ghex_F", "optic_LRPS_tna_F"], RANDOM_BETWEEN(1,2)],
			["itm", "optic_Nightstalker", RANDOM_BETWEEN(0,1)],
			["itm", "optic_tws", RANDOM_BETWEEN(0,1)],
			["mag", "HandGrenade", RANDOM_BETWEEN(0,5)],
			["mag", "5Rnd_127x108_APDS_Mag", RANDOM_BETWEEN(2,4)]
		];
	};
	case "mission_Uniform":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["itm", ["V_RebreatherIA", "V_RebreatherIR", "V_RebreatherB"], RANDOM_BETWEEN(1,3)],
			["bac", ["B_Carryall_mcamo", "B_Kitbag_mcamo"], RANDOM_BETWEEN(1,3)],
			["itm", ["H_HelmetSpecB_paint2","H_HelmetO_oucamo","H_HelmetLeaderO_oucamo","H_HelmetSpecO_blk"], RANDOM_BETWEEN(1,3)],
			["itm", "Medikit", RANDOM_BETWEEN(1,2)],
			["itm", "Toolkit", RANDOM_BETWEEN(1,2)],
			["itm", "B_UavTerminal", 1],
			["itm", "O_UavTerminal", 1],
			["itm", "I_UavTerminal", 1],
			["bac", ["B_UAV_01_backpack_F", "O_UAV_01_backpack_F", "I_UAV_01_backpack_F"], RANDOM_BETWEEN(0,1)]
		];
	};
	case "mission_DLCRifles":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["srifle_DMR_03_multicam_F", "srifle_DMR_02_sniper_F", "srifle_DMR_05_hex_F", "srifle_DMR_04_Tan_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["itm", ["V_PlateCarrier3_rgr", "V_TacVest_camo", "V_PlateCarrierGL_rgr"], RANDOM_BETWEEN(0,2)],
			["bac", ["B_Carryall_mcamo", "B_Kitbag_mcamo"], RANDOM_BETWEEN(1,3)],
			["itm", ["bipod_01_F_blk", "bipod_02_F_hex"], RANDOM_BETWEEN(2,4)],
			["itm", ["optic_DMS", "optic_AMS", "optic_KHS_blk"], RANDOM_BETWEEN(2,3)],
			["itm", ["muzzle_snds_B", "muzzle_snds_338_black", "muzzle_snds_338_sand", "muzzle_snds_93mmg"], RANDOM_BETWEEN(3,5)]
		];
	};
	case "mission_DLCLMGs":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["MMG_02_black_F", "MMG_02_camo_F", "MMG_02_sand_F"], 1, RANDOM_BETWEEN(1,2)],
			["wep", ["MMG_01_hex_F", "MMG_01_tan_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			["wep", ["arifle_SPAR_02_blk_F", "arifle_SPAR_02_khk_F", "arifle_SPAR_02_snd_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			["wep", ["arifle_CTARS_blk_F", "LMG_03_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			["itm", ["bipod_01_F_blk", "bipod_02_F_hex"], RANDOM_BETWEEN(2,4)],
			["itm", ["optic_DMS", "optic_AMS", "optic_KHS_blk"], RANDOM_BETWEEN(2,3)],
			["itm", "optic_tws_mg", RANDOM_BETWEEN(0,1)]
		];
	};
	case "mission_HVLaunchers":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["launch_RPG32_F", "launch_NLAW_F", "launch_I_Titan_short_F"], RANDOM_BETWEEN(3,5), RANDOM_BETWEEN(1,2)],
			["wep", "launch_I_Titan_F", RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			["mag", ["SmokeShellRed", "SmokeShellOrange", "SmokeShellYellow", "SmokeShellGreen", "SmokeShellBlue", "SmokeShellPurple"], RANDOM_BETWEEN(1,2)],
			["mag", ["SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"], RANDOM_BETWEEN(3,5)],
			["mag", "Titan_AP", RANDOM_BETWEEN(1,3)]
		];
	};
	case "mission_ApexRifles":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["arifle_SPAR_01_blk_F", "arifle_SPAR_01_khk_F", "arifle_SPAR_01_snd_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			["wep", ["arifle_SPAR_01_GL_blk_F", "arifle_SPAR_01_GL_khk_F", "arifle_SPAR_01_GL_snd_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			["wep", ["arifle_AKS_F", "arifle_AKM_F", "arifle_AK12_F", "arifle_AK12_GL_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			["wep", ["srifle_DMR_07_blk_F", "srifle_DMR_07_hex_F", "srifle_DMR_07_ghex_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			["wep", ["arifle_SPAR_03_blk_F", "arifle_SPAR_03_khk_F", "arifle_SPAR_03_snd_F"], RANDOM_BETWEEN(0,1), RANDOM_BETWEEN(1,2)],
			["itm", ["bipod_01_F_blk", "bipod_02_F_hex"], RANDOM_BETWEEN(2,4)],
			["itm", ["optic_Arco_ghex_F", "optic_ERCO_snd_F", "optic_SOS_khk_F"], RANDOM_BETWEEN(2,3)]
		];
	};
	case "mission_Supplies":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["mag", "11Rnd_45ACP_Mag", 4],
			["mag", "30Rnd_556x45_Stanag_Tracer_Yellow", 4],
			["mag", "10Rnd_762x54_Mag", 4],
			["mag", "9Rnd_45ACP_Mag", 4],
			["mag", "20Rnd_556x45_UW_mag", 4],
			["itm", "FirstAidKit", 5],
			["itm", "HandGrenade", 5]
		];
	};
};

[_box, _boxItems] call processItems;

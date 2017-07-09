// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: vehicleSpawnClasses.sqf
//	@file Author: AgentRev

A3W_smallVehicles =
[
	"C_Quadbike_01_F",
	["B_Quadbike_01_F", "O_Quadbike_01_F", "I_Quadbike_01_F", "I_G_Quadbike_01_F"]
];

//Civilian Vehicle List - Random Spawns
civilianVehicles =
[
	"C_Hatchback_01_F",
	"C_Hatchback_01_sport_F",
	"C_SUV_01_F",
	"C_Offroad_01_F",
	["C_Van_01_box_F", "C_Van_01_transport_F"]
];

//Light Military Vehicle List - Random Spawns
lightMilitaryVehicles =
[
	["I_G_Offroad_01_F", "I_G_Offroad_01_armed_F"]
];

//Medium Military Vehicle List - Random Spawns
mediumMilitaryVehicles =
[
	"B_MRAP_01_F",
	"O_MRAP_02_F",
	"I_MRAP_03_F"
];

//Water Vehicles - Random Spawns
waterVehicles =
[
	"C_Boat_Civil_01_F",
	"C_Boat_Civil_01_F",
	["C_Boat_Civil_01_police_F", "C_Boat_Civil_01_rescue_F"],
	["B_Boat_Armed_01_minigun_F", "O_Boat_Armed_01_hmg_F", "I_Boat_Armed_01_minigun_F"]
];

//Object List - Random Spawns.
staticWeaponsList =
[
	"B_Mortar_01_F",
	"O_Mortar_01_F",
	"I_Mortar_01_F",
	"I_G_Mortar_01_F"
];

//Object List - Random Helis.
staticHeliList =
[
	"C_Heli_Light_01_civil_F",
	"B_Heli_Light_01_F",
	"O_Heli_Light_02_unarmed_F",
	"I_Heli_light_03_unarmed_F"
	// don't put cargo helicopters here, it doesn't make sense to find them in towns; they spawn in the CivHeli mission
];

//Object List - Random Planes.
staticPlaneList =
[
	"I_Plane_Fighter_03_dynamicLoadout_F",
	"C_Plane_Civil_01_F"
];

//Random Weapon List - Change this to what you want to spawn in cars.
vehicleWeapons =
[
	["hgun_PDW2000_F", "SMG_05_F", "SMG_02_F", "SMG_01_F"],
	["arifle_Mk20C_plain_F", "arifle_TRG20_F", "arifle_Katiba_C_F", "arifle_MXC_F"],
	["arifle_Mk20_GL_plain_F", "arifle_TRG21_GL_F", "arifle_Katiba_GL_F", "arifle_MX_GL_F"],
	["arifle_SPAR_01_blk_F", "arifle_CTAR_blk_F", "arifle_ARX_blk_F", "arifle_AK12_F"],
	["arifle_MXM_F", "srifle_DMR_01_F", "srifle_EBR_F"],
	["launch_RPG7_F", "launch_RPG32_F", "launch_NLAW_F"]
];

vehicleAddition =
[
	["muzzle_snds_acp", "muzzle_snds_M", "muzzle_snds_58_blk_F"],
	["muzzle_snds_H", "muzzle_snds_H_MG", "muzzle_snds_B"],
	["muzzle_snds_65_TI_blk_F", "muzzle_snds_338_black", "muzzle_snds_93mmg"],
	["V_TacVest_blk", "V_TacVestIR_blk", "V_Press_F"],
	["H_HelmetIA", "H_HelmetB"],
	["optic_Arco", "optic_SOS", "optic_LRPS"],
	["optic_Hamr", "optic_DMS", "optic_Aco", "optic_ACO_grn"],
	["optic_aco_smg", "optic_Holosight", "optic_Holosight_smg", "acc_pointer_IR"],
	["Medikit", "FirstAidKit", "ToolKit", "MineDetector"]
];

vehicleAddition2 =
[
	["MiniGrenade", "HandGrenade", "APERSTripMine_Wire_Mag", "DemoCharge_Remote_Mag"],
	"SmokeShell",
	"30Rnd_556x45_Stanag",
	"30Rnd_65x39_caseless_mag",
	"30Rnd_762x39_Mag_F"
];

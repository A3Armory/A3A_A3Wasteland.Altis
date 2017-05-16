//Configuration for Airdrop Assistance
//Author: Apoc

APOC_AA_coolDownTime = 600; //Expressed in sec

APOC_AA_VehOptions =
[//["Menu Text","ItemClassname",Price,"Drop Type"]
["Rescue Boat", "C_Rubberboat", 12500, "vehicle"],
["Quadbike", "C_Quadbike_01_F", 12600, "vehicle"],
["M-900 Civilian", "C_Heli_Light_01_civil_F", 18000, "vehicle"],
["Strider", "I_MRAP_03_F", 19000, "vehicle"],
["Strider HMG", "I_MRAP_03_hmg_F", 27000, "vehicle"],
["Strider GMG", "I_MRAP_03_gmg_F", 29000, "vehicle"],
["CRV-6e Bobcat (Resupply)", "B_APC_Tracked_01_CRV_F", 45000, "vehicle"]
];

APOC_AA_SupOptions =
[//"Menu Text","Crate Type","Cost","Drop Type"]
//["Launchers", "mission_USLaunchers", 35000, "supply"],
//["Assault Rifle", "mission_USSpecial", 35000, "supply"],
["Supplies", "mission_Supplies", 10000, "supply"],
["Food", "Land_Sacks_goods_F", 6500, "picnic"],
["Water", "Land_BarrelWater_F", 6500, "picnic"]
];

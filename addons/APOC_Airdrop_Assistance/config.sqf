//Configuration for Airdrop Assistance
//Author: Apoc

APOC_AA_coolDownTime = 900; //Expressed in sec

APOC_AA_VehOptions =
[//["Menu Text","ItemClassname",Price,"Drop Type"]
["Quadbike", "C_Quadbike_01_F", 8600,  "vehicle"],
["Strider",  "I_MRAP_03_F",     15000, "vehicle"]
];

APOC_AA_SupOptions =
[//["stringItemName", "Crate Type for fn_refillBox ,Price,"drop type"]
//["Launchers", "mission_USLaunchers", 35000, "supply"],
//["Assault Rifle", "mission_USSpecial", 35000, "supply"],

//"Menu Text","Crate Type","Cost","drop type"
//["Base Building","Land_Pod_Heli_Transport_04_box_F",7500,"base"],
["Food",  "Land_Sacks_goods_F",	6500, "picnic"],
["Water", "Land_BarrelWater_F",	6500, "picnic"]
];

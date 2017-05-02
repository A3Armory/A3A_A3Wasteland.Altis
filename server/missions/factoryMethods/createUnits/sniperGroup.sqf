// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: sniperGroup.sqf
//	@file Author: AgentRev, micovery

if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uPos", "_unit"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_radius = param [3, 10, [0]];

_unitTypes =
[
	"C_man_polo_1_F", "C_man_polo_1_F_euro", "C_man_polo_1_F_afro", "C_man_polo_1_F_asia",
	"C_man_polo_2_F", "C_man_polo_2_F_euro", "C_man_polo_2_F_afro", "C_man_polo_2_F_asia",
	"C_man_polo_3_F", "C_man_polo_3_F_euro", "C_man_polo_3_F_afro", "C_man_polo_3_F_asia",
	"C_man_polo_4_F", "C_man_polo_4_F_euro", "C_man_polo_4_F_afro", "C_man_polo_4_F_asia",
	"C_man_polo_5_F", "C_man_polo_5_F_euro", "C_man_polo_5_F_afro", "C_man_polo_5_F_asia",
	"C_man_polo_6_F", "C_man_polo_6_F_euro", "C_man_polo_6_F_afro", "C_man_polo_6_F_asia"
];

grenadier_loadout =  {
  private["_unit"];
  _unit = _this;
  _unit addUniform "U_I_Ghilliesuit";
  _unit addMagazine "1Rnd_HE_Grenade_shell";
  _unit addMagazine "30Rnd_65x39_caseless_mag";
  _unit addWeapon "arifle_MX_GL_Black_F";
  _unit addPrimaryWeaponItem "optic_Arco";
  _unit addVest "V_BandollierB_oli";
  _unit addMagazine "30Rnd_65x39_caseless_mag";
  _unit addMagazine "30Rnd_65x39_caseless_mag";
  _unit addMagazine "1Rnd_HE_Grenade_shell";
  _unit addMagazine "1Rnd_HE_Grenade_shell";
  _unit addItem "NVGoggles";
  _unit assignItem "NVGoggles";
};

spotter_loadout = {
  private["_unit"];
  _unit = _this;
  _unit addUniform "U_I_Ghilliesuit";
  _unit addVest "V_BandollierB_oli";
  _unit addMagazine "20Rnd_762x51_Mag";
  _unit addWeapon "srifle_EBR_F";
  _unit addPrimaryWeaponItem "optic_SOS";
  _unit addMagazine "20Rnd_762x51_Mag";
  _unit addMagazine "20Rnd_762x51_Mag";
  _unit addMagazine "HandGrenade";
  _unit addItem "Rangefinder";
  _unit addItem "NVGoggles";
  _unit assignItem "NVGoggles";
};

sniper_loadout = {
  private["_unit"];
  _unit = _this;
  _unit addUniform "U_I_Ghilliesuit";
  _unit addMagazine "5Rnd_127x108_APDS_Mag";
  _unit addWeapon "srifle_GM6_F";
  _unit addPrimaryWeaponItem "optic_NVS";
  _unit addVest "V_BandollierB_oli";
  _unit addMagazine "5Rnd_127x108_APDS_Mag";
  _unit addMagazine "5Rnd_127x108_APDS_Mag";
  _unit addMagazine "HandGrenade";
  _unit addItem "NVGoggles";
  _unit assignItem "NVGoggles";
};

sniper2_loadout = {
  private["_unit"];
  _unit = _this;
  _unit addUniform "U_I_GhillieSuit";
  _unit addMagazine "30Rnd_65x39_caseless_mag";
  _unit addWeapon "arifle_MXM_Black_F";
  _unit addPrimaryWeaponItem "optic_LRPS";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  _unit addPrimaryWeaponItem "muzzle_snds_H";
  _unit addVest "V_BandollierB_oli";
  _unit addMagazine "30Rnd_65x39_caseless_mag";
  _unit addMagazine "30Rnd_65x39_caseless_mag";
  _unit addMagazine "HandGrenade";
  _unit addItem "NVGoggles";
  _unit assignItem "NVGoggles";
};

aa_loadout = {
  private["_unit"];
  _unit = _this;
  _unit addUniform "U_I_GhillieSuit";
  _unit addMagazine "30Rnd_65x39_caseless_mag_Tracer";
  _unit addWeapon "arifle_MX_F";
  _unit addPrimaryWeaponItem "optic_Aco";
  _unit addVest "V_BandollierB_oli";
  _unit addBackpack "B_Kitbag_sgg";
  _unit addMagazine "30Rnd_65x39_caseless_mag_Tracer";
  _unit addMagazine "30Rnd_65x39_caseless_mag_Tracer";
  _unit addMagazine "Titan_AA";
  _unit addWeapon "launch_Titan_F";
  _unit addMagazine "Titan_AA";
  _unit addItem "NVGoggles";
  _unit assignItem "NVGoggles";
};

at_loadout = {
  private["_unit"];
  _unit = _this;

  _unit addUniform "U_I_GhillieSuit";
  _unit addMagazine "30Rnd_65x39_caseless_mag_Tracer";
  _unit addWeapon "arifle_MX_F";
  _unit addPrimaryWeaponItem "optic_Aco";
  _unit addVest "V_BandollierB_oli";
  _unit addBackpack "B_Kitbag_sgg";
  _unit addMagazine "30Rnd_65x39_caseless_mag_Tracer";
  _unit addMagazine "30Rnd_65x39_caseless_mag_Tracer";
  _unit addItem "NVGoggles";
  _unit assignItem "NVGoggles";

  if (random 1 < 0.50) then
  {
    _unit addMagazine "Titan_AT";
    _unit addWeapon "launch_Titan_short_F";
    _unit selectWeapon "launch_Titan_short_F";
  }
  else
  {
    _unit addMagazine "NLAW_F";
    _unit addWeapon "launch_NLAW_F";
    _unit selectWeapon "launch_NLAW_F";
  };
};

leader_loadout = {
  private["_unit"];
  _unit = _this;

  _unit addUniform "U_I_GhillieSuit";
  _unit addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
  _unit addWeapon "arifle_Katiba_F";
  _unit addPrimaryWeaponItem "optic_Arco";
  _unit addPrimaryWeaponItem "acc_pointer_IR";
  _unit addVest "V_BandollierB_oli";
  _unit addBackpack "B_Kitbag_sgg";
  _unit addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
  _unit addMagazine "30Rnd_65x39_caseless_green_mag_Tracer";
  _unit addMagazine "NLAW_F";
  _unit addWeapon "launch_NLAW_F";
  _unit addItem "NVGoggles";
  _unit assignItem "NVGoggles";
};

rifleman_loadout = {
  private["_unit"];
  _unit = _this;

  _unit addUniform "U_I_GhillieSuit";
  _unit addMagazine "20Rnd_762x51_Mag";
  _unit addWeapon "srifle_EBR_F";
  _unit addPrimaryWeaponItem "optic_Aco";
  _unit addVest "V_BandollierB_oli";
  _unit addMagazine "20Rnd_762x51_Mag";
  _unit addMagazine "20Rnd_762x51_Mag";
  _unit addItem "NVGoggles";
  _unit assignItem "NVGoggles";
};

weighted_list =
[
  [1, sniper_loadout],
  [1.2, sniper2_loadout],
  [0.5, aa_loadout],
  [0.5, at_loadout],
  [0.8, spotter_loadout],
  [0.7, rifleman_loadout],
  [0.6, grenadier_loadout]
];

get_weighted_loadout = {
  private["_items"];
  _items = weighted_list;

  //calculate the total weight
  private["_totalSum", "_weight"];
  _totalSum = 0;
  {
    _weight = _x select 0;
    _totalSum = _weight + _totalSum;
  } forEach _items;

  //pick at random from the distribution
  private["_index", "_i", "_item", "_sum"];
  _index = random _totalSum;
  _sum = 0;
  _i = 0;

  while {_sum < _index} do {
    _item = _items select _i;
    _weight = _item select 0;
    _sum = _sum + _weight;
    _i = _i + 1;
  };

  ((_items select (_i - 1)) select 1)
};

for "_i" from 1 to _nbUnits do
{
  _uPos = _pos vectorAdd ([[random _radius, 0, 0], random 360] call BIS_fnc_rotateVector2D);
  _unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "Form"];
  _unit setPosATL _uPos;

  removeAllWeapons _unit;
  removeAllAssignedItems _unit;
  removeUniform _unit;
  removeVest _unit;
  removeBackpack _unit;
  removeHeadgear _unit;
  removeGoggles _unit;

  if (_unit == leader _group) then {
    _unit call leader_loadout;
    _unit setRank "SERGEANT";
  }
  else {
    private["_loadout"];
    _loadout = call get_weighted_loadout;
    _unit call _loadout;
  };

  _unit addRating 1e11;
  _unit spawn addMilCap;
  _unit spawn refillPrimaryAmmo;
  _unit call setMissionSkill;
  _unit addEventHandler ["Killed", server_playerDied];
  _unit setVariable ["AI_MoneyDrop", true, true];
};

[_pos] call addDefensiveMines;

[_group, _pos] call defendArea;
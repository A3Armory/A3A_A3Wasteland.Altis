// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupGear.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private ["_player", "_uniform", "_vest", "_backpack", "_headgear", "_goggles"];
_player = _this;

// Clothing is now defined in "client\functions\getDefaultClothing.sqf"

_uniform = [_player, "uniform"] call getDefaultClothing;
_vest = [_player, "vest"] call getDefaultClothing;
_backpack = [_player, "backpack"] call getDefaultClothing;
_headgear = [_player, "headgear"] call getDefaultClothing;
_goggles = [_player, "goggles"] call getDefaultClothing;

if (_uniform != "") then { _player addUniform _uniform };
if (_vest != "") then { _player addVest _vest };
if (_backpack != "") then { _player addBackpack _backpack };
if (_headgear != "") then { _player addHeadgear _headgear };
if (_goggles != "") then { _player addGoggles _goggles };

sleep 0.1;

// Remove GPS
_player unlinkItem "ItemGPS";

// Remove radio
//_player unlinkItem "ItemRadio";

// Remove NVG
if (hmd _player != "") then { _player unlinkItem hmd _player };

// Add NVG
_player linkItem "NVGoggles";

switch (true) do
{
	case (["_medic_", typeOf _player] call fn_findString != -1):
	{
		removeAllWeapons _player;
		//Rifle
		_player addMagazine "30Rnd_556x45_Stanag";
		_player addWeapon "arifle_Mk20_plain_F";
		_player addPrimaryWeaponItem "optic_Holosight";
		_player addItemToBackpack "30Rnd_556x45_Stanag";
		_player addItemToBackpack "30Rnd_556x45_Stanag";
		//Handgun
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addWeapon "hgun_ACPC2_F";
		_player addItemToVest "9Rnd_45ACP_Mag";
		_player addItemToVest "9Rnd_45ACP_Mag";
		_player addItemToVest "9Rnd_45ACP_Mag";
		//Items
		_player addItem "Medikit";
		_player addItem "FirstAidKit";
		_player addWeapon "Binocular";
	};
	case (["_engineer_", typeOf _player] call fn_findString != -1):
	{
		removeAllWeapons _player;
		//Rifle
		_player addMagazine "30Rnd_556x45_Stanag";
		_player addWeapon "arifle_Mk20_F";
		_player addPrimaryWeaponItem "optic_aco";
		_player addItemToBackpack "30Rnd_556x45_Stanag";
		_player addItemToBackpack "30Rnd_556x45_Stanag";
		//Handgun
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addWeapon "hgun_ACPC2_F";
		_player addItemToVest "9Rnd_45ACP_Mag";
		_player addItemToVest "9Rnd_45ACP_Mag";
		_player addItemToVest "9Rnd_45ACP_Mag";
		//Items
		_player addItem "FirstAidKit";
		_player addItem "FirstAidKit";
		_player addItem "MineDetector";
		_player addItem "Toolkit";
		_player addItem "SmokeShell";
		_player addWeapon "Binocular";
	};
	case (["_sniper_", typeOf _player] call fn_findString != -1):
	{
		removeAllWeapons _player;
		//Rifle
		_player addMagazine "10Rnd_762x54_Mag";
		_player addWeapon "srifle_DMR_01_F";
		_player addPrimaryWeaponItem "optic_Arco";
		_player addItemToBackpack "10Rnd_762x54_Mag";
		_player addItemToBackpack "10Rnd_762x54_Mag";
		//Handgun
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addWeapon "hgun_ACPC2_F";
		_player addWeaponItem ["hgun_ACPC2_F", "muzzle_snds_acp"];
		_player addItemToVest "9Rnd_45ACP_Mag";
		_player addItemToVest "9Rnd_45ACP_Mag";
		_player addItemToVest "9Rnd_45ACP_Mag";
		//Items
		_player addItem "FirstAidKit";
		_player addItem "FirstAidKit";
		_player addWeapon "Rangefinder";
	};
	case (["_diver_", typeOf _player] call fn_findString != -1):
	{
		removeAllWeapons _player;
		//Rifle
		_player addMagazine "20Rnd_556x45_UW_mag";
		_player addWeapon "arifle_SDAR_F";
		_player addItemToBackpack "20Rnd_556x45_UW_mag";
		_player addItemToBackpack "20Rnd_556x45_UW_mag";
		//Handgun
		_player addMagazine "11Rnd_45ACP_Mag";
		_player addWeapon "hgun_Pistol_heavy_01_F";
		_player addWeaponItem ["hgun_Pistol_heavy_01_F", "muzzle_snds_acp"];
		_player addItemToBackpack "11Rnd_45ACP_Mag";
		_player addItemToBackpack "11Rnd_45ACP_Mag";
		_player addItemToBackpack "11Rnd_45ACP_Mag";
		//Items
		_player addItem "FirstAidKit";
		_player addItem "FirstAidKit";
		_player addItem "HandGrenade";
		_player addWeapon "Binocular";
	};
};

switch (side _player) do
{
	case west:
	{
		_player addItem "Chemlight_blue";
	};
	case east:
	{
		_player addItem "Chemlight_red";
	};
	case resistance:
	{
		_player addItem "Chemlight_green";
	};
};

if (_player == player) then
{
	thirstLevel = 100;
	hungerLevel = 100;
};

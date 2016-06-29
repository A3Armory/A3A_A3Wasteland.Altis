// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupGear.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private ["_player", "_uniform", "_vest", "_headgear", "_goggles"];
_player = _this;

// Clothing is now defined in "client\functions\getDefaultClothing.sqf"

_uniform = [_player, "uniform"] call getDefaultClothing;
_vest = [_player, "vest"] call getDefaultClothing;
_headgear = [_player, "headgear"] call getDefaultClothing;
_goggles = [_player, "goggles"] call getDefaultClothing;

if (_uniform != "") then { _player addUniform _uniform };
if (_vest != "") then { _player addVest _vest };
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

_player addBackpack "B_AssaultPack_rgr";

_player addMagazine "30Rnd_9x21_Mag";
_player addWeapon "SMG_02_F";
_player addPrimaryWeaponItem "acc_flashlight";
_player addMagazine "9Rnd_45ACP_Mag";
_player addWeapon "hgun_ACPC2_F";
_player addWeaponItem ["hgun_ACPC2_F", "muzzle_snds_acp"];
_player addMagazine "30Rnd_9x21_Mag";
_player addItem "FirstAidKit";
_player selectWeapon "SMG_02_F";

switch (true) do
{
	case (["Combat Life Saver", roleDescription _player] call fn_findString != -1):
	{
		_player removeItem "FirstAidKit";
		_player addItem "Medikit";
	};
	case (["Engineer", roleDescription _player] call fn_findString != -1):
	{
		_player addItem "MineDetector";
		_player addItem "Toolkit";
	};
	case (["Sniper", roleDescription _player] call fn_findString != -1):
	{
		_player addWeapon "Rangefinder";
		_player removeItem "Medikit";
	};
	case (["Diver", roleDescription _player] call fn_findString != -1):
	{
		_player addGoggles "G_Diving";
		_player removeItem "Medikit";
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

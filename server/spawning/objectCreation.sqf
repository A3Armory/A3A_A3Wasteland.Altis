// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: objectCreation.sqf
//	@file Author: [404] Deadbeat, [GoT] JoSchaap, AgentRev

if (!isServer) exitWith {};

private ["_objPos", "_objList", "_objClass", "_obj", "_allowDamage", "_adjustZ", "_pos"];
_objPos = _this select 0;
_objList = _this select 1;

_objClass = _objList call BIS_fnc_selectRandom;
_obj = createVehicle [_objClass, _objPos, [], 50, "None"];

_allowDamage = false;

switch (true) do
{
	case (_objClass == "Land_BarrelWater_F"):
	{
		_obj setVariable ["water", 50, true];
	};
	case (_objClass == "Land_Sacks_goods_F"):
	{
		_obj setVariable ["food", 40, true];
	};
	case (_objClass isKindOf "ReammoBox_F"):
	{
		clearMagazineCargoGlobal _obj;
		clearWeaponCargoGlobal _obj;
		clearItemCargoGlobal _obj;

		_obj addMagazineCargoGlobal ["UGL_FlareWhite_F", 4];
		_obj addMagazineCargoGlobal ["11Rnd_45ACP_Mag", 4];
		_obj addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Yellow", 4];
		_obj addMagazineCargoGlobal ["10Rnd_762x54_Mag", 4];
		_obj addMagazineCargoGlobal ["9Rnd_45ACP_Mag", 4];
		_obj addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 4];
		_obj addItemCargoGlobal ["FirstAidKit", 5];
		_obj addItemCargoGlobal ["HandGrenade", 5];
	};
	default
	{
		_allowDamage = true;
	};
};

_obj allowDamage _allowDamage;
_obj setVariable ["allowDamage", _allowDamage, true];

// fix for sunken/rissen objects :)
_adjustZ = switch (true) do
{
	case (_objClass == "Land_Scaffolding_F"):         { -3 };
	case (_objClass == "Land_Canal_WallSmall_10m_F"): { 3 };
	case (_objClass == "Land_Canal_Wall_Stairs_F"):   { 3 };
	default                                           { 0 };
};

_pos = getPosATL _obj;
_pos set [2, (_pos select 2) + _adjustZ];
_obj setPos _pos;

[_obj] call basePartSetup;

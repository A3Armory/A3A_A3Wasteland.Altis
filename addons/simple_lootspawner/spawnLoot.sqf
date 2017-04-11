//Spawn loot
//Author: BangaBob(H8ermaker) edited by Gigatek
//@file Name: spawnLoot.sqf

if(isServer) then
{
	_pos= (_this select 0);
	_pos0= (_pos select 0);
	_pos1= (_pos select 1);
	_pos2= (_pos select 2);
	_showLoot= (_this select 1);

	_BARREL= createVehicle ["Land_BarrelEmpty_F",[_pos0,_pos1,_pos2+0.3], [], 0, "can_Collide"];
	sleep 1;
	_holder= createVehicle ["groundweaponholder",[_pos0,_pos1,(getposATL _BARREL select 2)], [], 0, "can_Collide"];
	deletevehicle _BARREL;
	_type= floor (random 5);
	_holder setVariable ["persistent", true, true];
	_holder enableDynamicSimulation true;

	if (_showLoot) then
	{
		_id=format ["%1",_pos];
		_debug=createMarker [_id,GETPOS _holder];
		_debug setMarkerShape "ICON";
		_debug setMarkerType "hd_dot";
		_debug setMarkerColor "ColorRed";
		_txt=format ["%1",_type];
		_debug setMarkerText _txt;
	};

// Spawn Weapon
	if (_type == 0) then
	{
		_weapon= weaponsLoot call bis_fnc_selectRandom; 
		_magazines= getArray (configFile / "CfgWeapons" / _weapon / "magazines");
		_magazineClass= _magazines call bis_fnc_selectRandom; 
		_holder addWeaponCargoGlobal [_weapon, 1];
		_holder addMagazineCargoGlobal [_magazineClass, 1];
	};

// Spawn Magazines
	if (_type == 1) then
	{
		_mags= magazineLoot call bis_fnc_selectRandom;
		_holder addMagazineCargoGlobal [_mags, 1];
	};

// Spawn Items
	if (_type == 2) then
	{
		_item= itemsLoot call bis_fnc_selectRandom;
		_holder addItemCargoGlobal [_item, 1];
		_clothing= clothesLoot call bis_fnc_selectRandom;
		_holder addItemCargoGlobal [_clothing, 1];
	};

// Spawn Vests
	if (_type == 3) then
	{
		_vest= vestsLoot call bis_fnc_selectRandom;
		_holder addItemCargoGlobal [_vest, 1];
	};

// Spawn Backpacks
	if (_type == 4) then
	{
		_backpack= backpacksLoot call bis_fnc_selectRandom;
		_holder addBackpackCargoGlobal [_backpack, 1];
	};
};
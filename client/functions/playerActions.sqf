// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.2
//	@file Name: playerActions.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:19

{ [player, _x] call fn_addManagedAction } forEach
[
	["Holster Weapon", { player action ["SwitchWeapon", player, player, 100] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player != '' && (stance player != 'CROUCH' || currentWeapon player != handgunWeapon player)"], // A3 v1.58 bug, holstering handgun while crouched causes infinite anim loop
	//["Unholster Primary Weapon", { player action ["SwitchWeapon", player, player, 0] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player == '' && primaryWeapon player != ''"],

	[format ["<img image='client\icons\playerMenu.paa' color='%1'/> <t color='%1'>[</t>Player Menu<t color='%1'>]</t>", "#FF8000"], "client\systems\playerMenu\init.sqf", [], -10, false], //, false, "", ""],

	["<img image='client\icons\money.paa'/> Pickup Money", "client\actions\pickupMoney.sqf", [], 1, false, false, "", "{_x getVariable ['owner', ''] != 'mission'} count (player nearEntities ['Land_Money_F', 5]) > 0"],

	["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> <t color='#FFFFFF'>Cancel Action</t>", { doCancelAction = true }, [], 1, false, false, "", "mutexScriptInProgress"],

	["<img image='client\icons\repair.paa'/> Salvage", "client\actions\salvage.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'AllVehicles' && !(cursorTarget isKindOf 'Man') && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3}"],

	// If you have a custom vehicle licence system, simply remove/comment the following action
	["<img image='client\icons\r3f_unlock.paa'/> Acquire Vehicle Ownership", "client\actions\takeOwnership.sqf", [], 1, false, false, "", "[] call fn_canTakeOwnership isEqualTo ''"],

	["[0]"] call getPushPlaneAction,
	["Push vehicle", "server\functions\pushVehicle.sqf", [2.5, true], 1, false, false, "", "[2.5] call canPushVehicleOnFoot"],
	["Push vehicle forward", "server\functions\pushVehicle.sqf", [2.5], 1, false, false, "", "[2.5] call canPushWatercraft"],
	["Push vehicle backward", "server\functions\pushVehicle.sqf", [-2.5], 1, false, false, "", "[-2.5] call canPushWatercraft"],

	["<img image='client\icons\driver.paa'/> Enable driver assist", fn_enableDriverAssist, [], 0.5, false, true, "", "_veh = objectParent player; alive _veh && !alive driver _veh && {effectiveCommander _veh == player && player in [gunner _veh, commander _veh] && {_veh isKindOf _x} count ['LandVehicle','Ship'] > 0 && !(_veh isKindOf 'StaticWeapon')}"],
	["<img image='client\icons\driver.paa'/> Disable driver assist", fn_disableDriverAssist, [], 0.5, false, true, "", "_driver = driver objectParent player; isAgent teamMember _driver && {(_driver getVariable ['A3W_driverAssistOwner', objNull]) in [player,objNull]}"],

	[format ["<t color='#FF0000'>Emergency eject (Ctrl+%1)</t>", (actionKeysNamesArray "GetOver") param [0,"<'Step over' keybind>"]],  { [[], fn_emergencyEject] execFSM "call.fsm" }, [], -9, false, true, "", "(vehicle player) isKindOf 'Air' && !((vehicle player) isKindOf 'ParachuteBase')"],
	[format ["<t color='#FF00FF'>Open magic parachute (%1)</t>", (actionKeysNamesArray "GetOver") param [0,"<'Step over' keybind>"]], A3W_fnc_openParachute, [], 20, true, true, "", "vehicle player == player && (getPos player) select 2 > 2.5"]
];

if (["A3W_vehicleLocking"] call isConfigOn) then
{
	[player, ["<img image='client\icons\r3f_unlock.paa'/> Pick Lock", "addons\scripts\lockPick.sqf", [cursorTarget], 1, false, false, "", "alive cursorTarget && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3 && {{cursorTarget isKindOf _x} count ['LandVehicle','Ship','Air'] > 0 && {locked cursorTarget == 2 && !(cursorTarget getVariable ['A3W_lockpickDisabled',false]) && cursorTarget getVariable ['ownerUID','0'] != getPlayerUID player && 'ToolKit' in items player}}"]] call fn_addManagedAction;
};

// Karts DLC
if !(288520 in getDLCs 1) then
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'Kart_01_Base_F' && player distance cursorTarget < 3.4 && isNull driver cursorTarget"]] call fn_addManagedAction;
};

// Helicopters DLC
if !(304380 in getDLCs 1) then 
{
	[player, ["<t color='#00FFFF'>Get in as Pilot</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Heli_Transport_03_base_F','Heli_Transport_04_base_F'] > 0 && player distance cursorTarget < 10 && isNull driver cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Copilot</t>", "client\actions\moveInTurret.sqf", [0], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Heli_Transport_03_base_F','Heli_Transport_04_base_F'] > 0 && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [0])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Left door gunner</t>", "client\actions\moveInTurret.sqf", [1], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'Heli_Transport_03_base_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [1])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Right door gunner</t>", "client\actions\moveInTurret.sqf", [2], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'Heli_Transport_03_base_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [2])"]] call fn_addManagedAction;
};

// Apex DLC
if !(395180 in getDLCs 1) then 
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Offroad_02_base_F','LSV_01_base_F','LSV_02_base_F','Scooter_Transport_01_base_F','Boat_Transport_02_base_F'] > 0 && player distance cursorTarget < 6 && isNull driver cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Commander</t>", "client\actions\moveInCommanderTurret.sqf", [0], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['B_T_LSV_01_armed_F','B_T_LSV_01_AT_F'] > 0 && player distance cursorTarget < 6 && isNull (cursorTarget turretUnit [1])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Gunner</t>", "client\actions\moveInGunner.sqf", [1], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['I_C_Offroad_02_LMG_F','I_C_Offroad_02_AT_F','B_T_LSV_01_armed_F','B_T_LSV_01_AT_F','O_T_LSV_02_armed_F','O_T_LSV_02_armed_F'] > 0 && player distance cursorTarget < 6 && isNull gunner cursorTarget"]] call fn_addManagedAction;

	[player, ["<t color='#00FFFF'>Get in as Pilot</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Plane_Civil_01_base_F','VTOL_01_base_F','VTOL_02_base_F'] > 0 && player distance cursorTarget < 10 && isNull driver cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Copilot</t>", "client\actions\moveInTurret.sqf", [0], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Plane_Civil_01_base_F','VTOL_01_base_F'] > 0 && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [0])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Gunner</t>", "client\actions\moveInGunner.sqf", [0], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'VTOL_02_base_F' && player distance cursorTarget < 10 && isNull gunner cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Passenger (Left Seat)</t>", "client\actions\moveInTurret.sqf", [1], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'B_T_VTOL_01_infantry_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [1])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Passenger (Right Seat)</t>", "client\actions\moveInTurret.sqf", [2], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'B_T_VTOL_01_infantry_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [2])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Left door gunner</t>", "client\actions\moveInTurret.sqf", [1], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'B_T_VTOL_01_armed_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [1])"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Right door gunner</t>", "client\actions\moveInTurret.sqf", [2], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'B_T_VTOL_01_armed_F' && player distance cursorTarget < 10 && isNull (cursorTarget turretUnit [2])"]] call fn_addManagedAction;
};

// Lords of War DLC
if !(571710 in getDLCs 1) then 
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && cursorTarget isKindOf 'Van_02_base_F' && player distance cursorTarget < 6 && isNull driver cursorTarget"]] call fn_addManagedAction;
};

// Jets DLC
if !(601670 in getDLCs 1) then 
{
	[player, ["<t color='#00FFFF'>Get in as Pilot</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['Plane_Fighter_04_Base_F','Plane_Fighter_01_Base_F','Plane_Fighter_02_Base_F'] > 0 && player distance cursorTarget < 8 && isNull driver cursorTarget"]] call fn_addManagedAction;
};

// Tanks DLC
if !(798390 in getDLCs 1) then 
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['AFV_Wheeled_01_base_F','LT_01_base_F','MBT_04_base_F'] > 0 && player distance cursorTarget < 7 && isNull driver cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Commander</t>", "client\actions\moveInCommander.sqf", [0], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['AFV_Wheeled_01_base_F','LT_01_base_F','MBT_04_base_F'] > 0 && player distance cursorTarget < 7 && isNull commander cursorTarget"]] call fn_addManagedAction;
	[player, ["<t color='#00FFFF'>Get in as Gunner</t>", "client\actions\moveInGunner.sqf", [1], 6, true, true, "", "locked cursorTarget != 2 && {cursorTarget isKindOf _x} count ['AFV_Wheeled_01_base_F','MBT_04_base_F'] > 0 && player distance cursorTarget < 7 && isNull gunner cursorTarget"]] call fn_addManagedAction;
};

if (["A3W_savingMethod", "profile"] call getPublicVar == "extDB") then
{
	if (["A3W_vehicleSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Force Save Vehicle", { cursorTarget call fn_forceSaveVehicle }, [], -9.5, false, true, "", "call canForceSaveVehicle"]] call fn_addManagedAction;
	};

	if (["A3W_staticWeaponSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Force Save Turret", { cursorTarget call fn_forceSaveObject }, [], -9.5, false, true, "", "call canForceSaveStaticWeapon"]] call fn_addManagedAction;
	};
};

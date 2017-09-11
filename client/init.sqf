// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.1
//@file Name: init.sqf
//@file Author: [404] Deadbeat, [GoT] JoSchaap, AgentRev, [KoS] Bewilderbeest
//@file Created: 20/11/2012 05:19
//@file Description: The client init.

if (isDedicated) exitWith {};

if (!isServer) then
{
	waitUntil {!isNil "A3W_network_compileFuncs"};
};

waitUntil {!isNil "A3W_serverSetupComplete"};

[] execVM "client\functions\bannedNames.sqf";

showPlayerIcons = true;
mutexScriptInProgress = false;
respawnDialogActive = false;
groupManagmentActive = false;
pvar_PlayerTeamKiller = [];
doCancelAction = false;
spawnBeaconDetectorInProgress = false;

//Initialization Variables
playerCompiledScripts = false;
playerSetupComplete = false;

waitUntil {!isNull player && time > 0};

removeAllWeapons player;
player switchMove "";

// initialize actions and inventory
"client\actions" call mf_init;
"client\inventory" call mf_init;
"client\items" call mf_init;

//Call client compile list.
call compile preprocessFileLineNumbers "client\functions\clientCompile.sqf";

//Stop people being civ's.
if !(playerSide in [BLUFOR,OPFOR,INDEPENDENT]) exitWith
{
	endMission "LOSER";
};

// Teambalancer
call compile preprocessFileLineNumbers "client\functions\teamBalance.sqf";

//Setup player events.
if (!isNil "client_initEH") then { player removeEventHandler ["Respawn", client_initEH] };
player addEventHandler ["Respawn", { _this spawn onRespawn }];
player addEventHandler ["Killed", onKilled];

call compile preprocessFileLineNumbers "addons\far_revive\FAR_revive_init.sqf";

A3W_scriptThreads pushBack execVM "client\functions\evalManagedActions.sqf";

pvar_playerRespawn = [player, objNull];
publicVariableServer "pvar_playerRespawn";

//Player setup
player call playerSetupStart;

// Deal with money here
_baseMoney = ["A3W_startingMoney", 100] call getPublicVar;
player setVariable ["cmoney", _baseMoney, true];

// Player saving - load data
if (["A3W_playerSaving"] call isConfigOn) then
{
	call compile preprocessFileLineNumbers "persistence\client\players\setupPlayerDB.sqf";
	call fn_requestPlayerData;

	waitUntil {!isNil "playerData_loaded"};

	A3W_scriptThreads pushBack ([] spawn
	{
		scriptName "savePlayerLoop";

		// Save player every 5m
		while {true} do
		{
			sleep 300;
			call fn_savePlayerData;
		};
	});
};

if (isNil "playerData_alive") then
{
	player call playerSetupGear;
};

player call playerSetupEnd;

diag_log format ["Player starting with $%1", (player getVariable ["cmoney", 0]) call fn_numToStr];

[] execVM "territory\client\hideDisabledTerritories.sqf";

// Territory system enabled?
if (count (["config_territory_markers", []] call getPublicVar) > 0) then
{
	A3W_fnc_territoryActivityHandler = "territory\client\territoryActivityHandler.sqf" call mf_compile;
	[] execVM "territory\client\setupCaptureTriggers.sqf";
};

//Setup player menu scroll action.
//[] execVM "client\clientEvents\onMouseWheel.sqf";

// Load custom keys from profile
call compile preprocessFileLineNumbers "client\clientEvents\customKeys.sqf";

//Setup Key Handler
waitUntil {!isNull findDisplay 46};
(findDisplay 46) displayAddEventHandler ["KeyDown", onKeyPress];
(findDisplay 46) displayAddEventHandler ["KeyUp", onKeyRelease];

_mouseButtonToKey = "params ['_disp','_btn']; ([_disp, _btn + 65536 + ([0,128] select (_btn isEqualTo 1))] + (_this select [4,999])) call "; // actionKeys mouse bitflag + RMB fix

(findDisplay 46) displayAddEventHandler ["MouseButtonDown", _mouseButtonToKey + "onKeyPress"];
(findDisplay 46) displayAddEventHandler ["MouseButtonUp", _mouseButtonToKey + "onKeyRelease"];

call compile preprocessFileLineNumbers "client\functions\setupClientPVars.sqf";

//client Executes
A3W_scriptThreads pushBack execVM "client\systems\hud\playerHud.sqf";
A3W_scriptThreads pushBack execVM "client\systems\killFeed\killFeed.sqf";

if (["A3W_survivalSystem"] call isConfigOn) then
{
	execVM "client\functions\initSurvival.sqf";
};

[] spawn
{
	[] execVM "client\functions\createGunStoreMarkers.sqf";

	if (["A3W_privateParking"] call isConfigOn) then
	{
		waitUntil {!isNil "parking_functions_defined"};
	};

	if (["A3W_privateStorage"] call isConfigOn) then
	{
		waitUntil {!isNil "storage_functions_defined"};
	};

	[] execVM "client\functions\createGeneralStoreMarkers.sqf";
	[] execVM "client\functions\createVehicleStoreMarkers.sqf";
	[] execVM "client\functions\createLegendMarkers.sqf";
};

A3W_clientSetupComplete = compileFinal "true";

[] spawn playerSpawn;

A3W_scriptThreads pushBack execVM "addons\fpsFix\vehicleManager.sqf";
//A3W_scriptThreads pushBack execVM "addons\Lootspawner\LSclientScan.sqf";
[] execVM "client\functions\drawPlayerIcons.sqf";
[] execVM "addons\camera\functions.sqf";
[] execVM "addons\UAV_Control\functions.sqf";

call compile preprocessFileLineNumbers "client\functions\generateAtmArray.sqf";
[] execVM "client\functions\drawPlayerMarkers.sqf";

inGameUISetEventHandler ["Action", "_this call A3W_fnc_inGameUIActionEvent"];

{ [_x] call fn_remotePlayerSetup } forEach allPlayers;

// update player's spawn beaoon
{
	if (_x getVariable ["ownerUID",""] == getPlayerUID player) then
	{
		_x setVariable ["ownerName", name player, true];
		_x setVariable ["side", playerSide, true];
	};
} forEach pvar_spawn_beacons;

// Fast movement log
if (["A3W_fastMovementLog"] call isConfigOn) then
{
	0 spawn
	{
		private ["_distCheck", "_loopTime", "_newPos", "_oldPos", "_spawnPos"];
		_distCheck = ["A3W_fastMovementLogDist", 1200] call getPublicVar;
		_loopTime = ["A3W_fastMovementLoopTime", 1] call getPublicVar;
		_oldPos = nil;
		_spawnPos = getMarkerPos "respawn_guerrila";

		while {true} do
		{
			_newPos = getPosATL player;

			if (!isNil "_oldPos" && {_newPos distance2D _oldPos > _distCheck}) then
			{
				if (_spawnPos distance2D _newPos > 50 && _spawnPos distance2D _oldPos > 50) then
				{
					publicVariableServer format["FML|Name:%1|Vehicle:%2", name player, typeof vehicle player];
					publicVariableServer format["FML|Speed:%1|OldPos:%2", round speed vehicle player, _oldPos];
					publicVariableServer format["FML|NewPos:%1", _newPos];
				};
			};

			_oldPos = _newPos;

			if (player getVariable ["playerSpawning", true]) then {_oldPos = nil};

			uiSleep _loopTime;
		};
	};
};

// Reserved slots
if (hasInterface && {["A3W_reservedSlots"] call isConfigOn}) then
{
	private ["_maxPlayers", "_noReserve", "_playerCount", "_reservedSlots", "_uid"];

	_maxPlayers = ["A3W_maxPlayers", 50] call getPublicVar;
	_reservedSlots = ["A3W_reservedSlots", 1] call getPublicVar;

	waitUntil {!isNull player};
	waitUntil {(vehicle player) == player};
	waitUntil {(getPlayerUID player) != ""};

	_playerCount = count playableUnits;
	_noReserve = _maxPlayers - _reservedSlots;
	_uid = getPlayerUID player;

	if (_uid call isAdmin || {[_uid, topServerDonors] call isDonor}) then
	{
		_noReserve = _noReserve + 1;

		if (_noReserve > _maxPlayers) then
		{
			_noReserve = _maxPlayers;
		};

		cutText ["You are using a reserved slot", "PLAIN DOWN", 1];
	};

	if (_playerCount > _noReserve && !(_uid call isAdmin || {[_uid, topServerDonors] call isDonor})) then
	{
		["ReservedSlots",false,1] call BIS_fnc_endMission;
	};
};
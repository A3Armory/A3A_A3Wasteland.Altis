// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: payload.sqf
//	@file Author: AgentRev, Tonic, AWA (OpenDayZ.net)
//	@file Created: 01/06/2013 21:31

// This file can be moved to "A3Wasteland_settings\antihack" in order to be loaded externally from the server, which removes the need for it to be in the mission PBO

if (isServer || !hasInterface) exitWith {};

private ["_flagChecksum", "_rscParams", "_cheatFlag", "_cfgPatches", "_escCheck", "_patchClass", "_patchName", "_ctrlCfg", "_memAnomaly", "_minRecoil", "_currentRecoil", "_loopCount"];
_flagChecksum = _this select 0;
_rscParams = _this select 1;

waitUntil {!isNull player};

// diag_log "ANTI-HACK starting...";

_cfgPatches = configFile >> "CfgPatches";
_escCheck = true;

for "_i" from 0 to (count _cfgPatches - 1) do
{
	_patchClass = _cfgPatches select _i;

	if (isClass _patchClass) then
	{
		_patchName = toLower configName _patchClass;

		if (_patchName in ["devcon","loki_lost_key"]) exitWith
		{
			_cheatFlag = ["hacking addon", configName _patchClass];
		};

		if (_patchName in
		[
			"rhs_main", // RHS - Game Options
			"mcc_sandbox", // MCC keys
			"agm_core", // AGM Options
			"ace_optionsmenu", // ACE Options
			"alive_ui" // ALiVE
		])
		then { _escCheck = false };
	};
};

if (isNil "_cheatFlag" && _escCheck) then
{
	{
		for "_i" from 0 to (count _x - 1) do
		{
			_ctrlCfg = _x select _i;
			if (getText (_ctrlCfg >> "action") != "" || getText (_ctrlCfg >> "onButtonClick") != "") exitWith
			{
				_cheatFlag = ["hack menu", format ["foreign Esc menu button '%1'", (getText (_ctrlCfg >> "text")) select [0, 64]]];
			};
		};

		if (!isNil "_cheatFlag") exitWith {};
	}
	forEach
	[
		configFile >> "RscDisplayMPInterrupt" >> "controls",
		configFile >> "RscDisplayMPInterrupt" >> "controlsBackground"
	];
};

if (isNil "_cheatFlag") then
{
	// Hack menu validator based on Tonic's SpyGlass
	_flagChecksum spawn
	{
		disableSerialization;
		scopeName "sendFlag";
		private "_cheatFlag";

		_flagChecksum = _this;

		while {true} do
		{
			{
				if (!isNull findDisplay (_x select 0)) then
				{
					_cheatFlag = _x select 1;
					breakTo "sendFlag";
				};
			}
			forEach
			[
				[19, "RscDisplayIPAddress"],
				[30, "RscDisplayTemplateLoad (Gladtwoown)"],
				[32, "RscDisplayIntel"],
				[64, "RscDisplayPassword (ShadowyFaze)"],
				[69, "RscDisplayPort"],
				[71, "RscDisplayFilter (Gladtwoown)"],
				[125, "RscDisplayEditDiaryRecord (Gladtwoown)"],
				[132, "RscDisplayHostSettings"],
				[165, "RscDisplayPublishMission"],
				[166, "RscDisplayPublishMissionSelectTags (Gladtwoown)"],
				[167, "RscDisplayFileSelect (Lystic)"],
				[2727, "RscDisplayLocWeaponInfo"],
				[3030, "RscConfigEditor_Main (ShadowyFaze)"]
			];

			_isAdmin = serverCommandAvailable "#kick";

			if (!isNull (findDisplay 49 displayCtrl 0)) exitWith { _cheatFlag = "RscDisplayInterruptEditorPreview" };
			if (!isNull findDisplay 17 && !isServer && !_isAdmin) exitWith { _cheatFlag = "RscDisplayRemoteMissions (Wookie)" };
			if (!isNull findDisplay 316000 && !_isAdmin) exitWith { _cheatFlag = "Debug console" }; // RscDisplayDebugPublic
			if (!isNull (uiNamespace getVariable ["RscDisplayArsenal", displayNull]) && !_isAdmin) exitWith { _cheatFlag = "Virtual Arsenal" };
			if (!isNull findDisplay 157 && isNull (uiNamespace getVariable ["RscDisplayModLauncher", displayNull])) exitWith { _cheatFlag = "RscDisplayPhysX3Debug" };

			_display = findDisplay 54;
			if (!isNull _display) then
			{
				sleep 0.5;
				{
					if (_x && !isNull _display) then
					{
						_cheatFlag = "RscDisplayInsertMarker (JME)";
						breakTo "sendFlag";
					};
				}
				forEach
				[
					(toLower ctrlText (_display displayCtrl 1001) != toLower localize "STR_A3_RscDisplayInsertMarker_Title"),
					{if !(buttonAction (_display displayCtrl _x) in ["","call A3W_fnc_markerLogInsert"]) exitWith {true}; false} forEach [1,2]
				];
			};

			_display = findDisplay 148;
			if (!isNull _display) then
			{
				sleep 0.5;
				{
					(_display displayCtrl _x) ctrlRemoveAllEventHandlers "LBDblClick";
					(_display displayCtrl _x) ctrlRemoveAllEventHandlers "LBSelChanged";
				} forEach [103, 104];

				{
					if (_x && !isNull _display) then
					{
						_cheatFlag = "RscDisplayConfigureControllers (JME)";
						breakTo "sendFlag";
					};
				}
				forEach
				[
					(toLower ctrlText (_display displayCtrl 1001) != toLower localize "str_opt_customizable_controllers"),
					(toLower ctrlText (_display displayCtrl 1002) != toLower localize "str_opt_controllers_scheme")
				];
			};

			_display = findDisplay 131;
			if (!isNull _display) then
			{
				sleep 0.5;
				(_display displayCtrl 102) ctrlRemoveAllEventHandlers "LBDblClick";
				(_display displayCtrl 102) ctrlRemoveAllEventHandlers "LBSelChanged";

				{
					if (_x && !isNull _display) then
					{
						_cheatFlag = "RscDisplayConfigureAction";
						breakTo "sendFlag";
					};
				}
				forEach
				[
					(toLower ctrlText (_display displayCtrl 1000) != toLower localize "STR_A3_RscDisplayConfigureAction_Title"),
					{if (buttonAction (_display displayCtrl _x) != "") exitWith {true}; false} forEach [1,104,105,106,107,108,109]
				];
			};

			_display = findDisplay 163;
			if (!isNull _display) then
			{
				sleep 0.5;
				(_display displayCtrl 101) ctrlRemoveAllEventHandlers "LBDblClick";
				(_display displayCtrl 101) ctrlRemoveAllEventHandlers "LBSelChanged";

				{
					if (_x && !isNull _display) then
					{
						_cheatFlag = "RscDisplayControlSchemes (JME)";
						breakTo "sendFlag";
					};
				}
				forEach
				[
					(toLower ctrlText (_display displayCtrl 1000) != toLower localize "STR_DISP_OPTIONS_SCHEME"),
					{if (buttonAction (_display displayCtrl _x) != "") exitWith {true}; false} forEach [1,2]
				];
			};

			_display = findDisplay 129;
			if (!isNull _display) then
			{
				sleep 0.5;
				{
					if (_x && !isNull _display) then
					{
						_cheatFlag = "RscDisplayDiary (Molaron)";
						breakTo "sendFlag";
					};
				}
				forEach
				[
					(ctrlText (_display displayCtrl 1111) == "Namespace:"),
					{if (buttonAction (_display displayCtrl _x) != "") exitWith {true}; false} forEach [1600,1601,1602]
				];
			};

			sleep 1;
		};

		[[profileName, getPlayerUID player, "hack menu", _cheatFlag, _flagChecksum], "A3W_fnc_flagHandler", false] call A3W_fnc_MP;

		waitUntil {alive player};

		[getPlayerUID player, _flagChecksum] call A3W_fnc_clientFlagHandler;
	};

	// Fix mag duping glitch
	0 spawn
	{
		waitUntil {!isNil "A3W_clientSetupComplete"};
		waitUntil
		{
			_cfg = configfile >> "CfgWeapons" >> currentWeapon player;

			if (getNumber (_cfg >> "type") == 8^4 && {(vehicle player) currentWeaponTurret ((assignedVehicleRole player) param [1,[-1]]) == "" && ["camera_get_weapon_info", false] call getPublicVar}) then
			{
				_target = configName _cfg;
				_mag = currentMagazine player;
				player removeWeapon _target;
				[player, _mag] call fn_forceAddItem;
				player addWeapon _target;
				player selectWeapon _target;
			};

			false
		};
	};

	// Decode _rscParams
	{
		_x set [1, toString (_x select 1)];
		_x set [2, toString (_x select 2)];
	} forEach _rscParams;
};

// diag_log "ANTI-HACK: Starting loop!";

_loopCount = 12; // _loopCount >= 12 means every minute

while { true } do
{
	waitUntil {time > 0};

	if (_loopCount >= 12) then
	{
		if (isNil "_cheatFlag") then
		{
			{
				if (!isNil _x) exitWith
				{
					// diag_log "ANTI-HACK: Found a hack variable!";

					_cheatFlag = ["hack variable", _x];
				};
				sleep 1;
			} forEach ["testing","testing1","testing2","testing3"];
		};

		if (isNil "_cheatFlag" && isNil "_memAnomaly") then
		{
			// Diplay validator based on Tonic's SpyGlass
			{
				_rscName = _x select 0;
				_onLoadValid = _x select 1;
				_onUnloadValid = _x select 2;

				_onLoad = getText (configFile >> _rscName >> "onLoad");
				_onUnload = getText (configFile >> _rscName >> "onUnload");

				{
					if (_x select 1 != _x select 2) exitWith
					{
						[[[toArray getPlayerUID player, _rscName, _x], _flagChecksum], "A3W_fnc_logMemAnomaly", false, false] call A3W_fnc_MP;
						_memAnomaly = true;
					};
				}
				forEach
				[
					["onLoad", _onLoad, _onLoadValid],
					["onUnload", _onUnload, _onUnloadValid]
				];

				if (!isNil "_memAnomaly") exitWith {};

				sleep 0.01;
			} forEach _rscParams;
		};

		_loopCount = 0;
	};

	if (isNil "_cheatFlag") then
	{
		// diag_log "ANTI-HACK: Recoil hack check started!";

		_currentRecoil = unitRecoilCoefficient player;
		_minRecoil = ((["A3W_antiHackMinRecoil", 1.0] call getPublicVar) max 0.02) - 0.001;

		if (_currentRecoil < _minRecoil && _currentRecoil != -1) then
		{
			// diag_log "ANTI-HACK: Detected recoil hack!";

			_cheatFlag = ["recoil hack", str ceil (_currentRecoil * 100) + "% recoil"];
		};
	};

	if (!isNil "_cheatFlag") exitWith
	{
		//diag_log str [profileName, getPlayerUID player, _cheatFlag select 0, _cheatFlag select 1];

		[profileName, getPlayerUID player, _cheatFlag select 0, _cheatFlag select 1, _flagChecksum] remoteExec ["A3W_fnc_flagHandler", 2];

		waitUntil {alive player};

		[getPlayerUID player, _flagChecksum] call A3W_fnc_clientFlagHandler;
	};

	sleep 5;
	_loopCount = _loopCount + 1;
};

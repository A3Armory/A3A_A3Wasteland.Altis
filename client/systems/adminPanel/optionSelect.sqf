// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: optionSelect.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:19

#define debugMenu_option 50003
#define adminMenu_option 50001
disableSerialization;

private ["_panelType","_displayAdmin","_displayDebug","_adminSelect","_debugSelect","_money"];
_uid = getPlayerUID player;
if (_uid call isAdmin) then
{
	_panelType = _this select 0;

	_displayAdmin = uiNamespace getVariable ["AdminMenu", displayNull];
	_displayDebug = uiNamespace getVariable ["DebugMenu", displayNull];

	switch (true) do
	{
		case (!isNull _displayAdmin): //Admin panel
		{
			_adminSelect = _displayAdmin displayCtrl adminMenu_option;

			switch (lbCurSel _adminSelect) do
			{
				case 0: //Player Menu
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\playerMenu.sqf";
				};
				case 1: //Show server FPS function
				{
					hint format["Server FPS: %1",serverFPS];
				};
				case 2: //Markers log
				{
					closeDialog 0;
					createDialog "MarkerLog";
				};
				case 3: //Debug Menu
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\loadDebugMenu.sqf";
				};
				case 4: //Full Vehicle Management
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\vehicleManagement.sqf";
				};
				case 5: //Access Vehicle Store
				{
					closeDialog 0;
					[] call loadVehicleStore;
				};
				case 6: //Object search menu
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\loadObjectSearch.sqf";
				};
				case 7: //Teleport
				{
					closeDialog 0;
					["A3W_teleport", "onMapSingleClick",
					{
						vehicle player setPos _pos;
						if (!isNil "notifyAdminMenu") then { ["teleport2", _pos] call notifyAdminMenu };
						["A3W_teleport", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
						true
					}] call BIS_fnc_addStackedEventHandler;
					hint "Click on map to teleport";
				};
				case 8: //// toggle God mode
				{
					execVM "client\systems\adminPanel\toggleGodMode2.sqf";
				};
			};
		};
		case (!isNull _displayDebug): //Debug panel
		{
			_debugSelect = _displayDebug displayCtrl debugMenu_option;

			switch (lbCurSel _debugSelect) do
			{
				case 0: //Teleport
				{
					closeDialog 0;
					["A3W_teleport", "onMapSingleClick",
					{
						vehicle player setPos _pos;
						if (!isNil "notifyAdminMenu") then { ["teleport", _pos] spawn notifyAdminMenu };
						["A3W_teleport", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
						true
					}] call BIS_fnc_addStackedEventHandler;
					hint "Click on map to teleport";
				};
				case 1: //Money
				{
					_money = 10000;
					player setVariable ["cmoney", (player getVariable ["cmoney",0]) + _money, true];
					if (!isNil "notifyAdminMenu") then { ["money", _money] call notifyAdminMenu };
				};
				case 2: // toggle God mode
				{
					execVM "client\systems\adminPanel\toggleGodMode.sqf";
				};
				case 3: //Access Gun Store
				{
					closeDialog 0;
					[] call loadGunStore;
					if (!isNil "notifyAdminMenu") then { ["gunstore"] call notifyAdminMenu };
				};
				case 4: //Access General Store
				{
					closeDialog 0;
					[] call loadGeneralStore;
					if (!isNil "notifyAdminMenu") then { ["generalstore"] call notifyAdminMenu };
				};
				case 5: //Access ATM Dialog
				{
					closeDialog 0;
					call mf_items_atm_access;
					if (!isNil "notifyAdminMenu") then { ["atm"] call notifyAdminMenu };
				};
			};
		};
	};
};

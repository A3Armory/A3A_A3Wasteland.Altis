// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: sellVehicle.sqf
//	@file Author: AgentRev
//  @file edited: CRE4MPIE
//  @credits to: Cael817, lodac, Wiking

private ["_timeLeft", "_veh", "_vehName"];

scriptName "sellVehicle";

if (!isNil "vehicleStore_lastSellTime") then
{
	_timeLeft = (["A3W_vehiclePurchaseCooldown", 60] call getPublicVar) - (diag_tickTime - vehicleStore_lastSellTime);
	_veh = objectFromNetId (player getVariable ["lastVehicleRidden", ""]);
	_vehName = getText (configFile >> "CfgVehicles" >> typeOf _veh >> "displayName");

	if (_timeLeft > 0) then
	{
		hint format ["You need to wait %1s before selling %2", ceil _timeLeft, _vehName];
		playSound "FD_CP_Not_Clear_F";
		breakOut "sellVehicle";
	};
};

#include "sellIncludesStart.sqf";

storeSellingHandle = _this spawn
{
	#define CHOPSHOP_PRICE_RELATIONSHIP 2
	#define VEHICLE_MAX_SELLING_DISTANCE 150

	private ["_vehicle", "_type", "_price", "_confirmMsg", "_text"];

	_storeNPC = _this select 0;
	_vehicle = objectFromNetId (player getVariable ["lastVehicleRidden", ""]);
	_type = typeOf _vehicle;
	_price = 1000;
	_objClass = typeOf _vehicle;
	_objName = getText (configFile >> "CfgVehicles" >> _objClass >> "displayName");

	if (isNull _vehicle) exitWith
	{
		playSound "FD_CP_Not_Clear_F";
		["Your previous vehicle does not exist anymore.", "Error"] call  BIS_fnc_guiMessage;
	};

	if (_vehicle distance _storeNPC > VEHICLE_MAX_SELLING_DISTANCE) exitWith
	{
		playSound "FD_CP_Not_Clear_F";
		[format [' The "%1" is further away than %2m from the store.', _objname, VEHICLE_MAX_SELLING_DISTANCE], "Error"] call  BIS_fnc_guiMessage;
	};

	if (_vehicle getVariable ["ownerUID",""] != getPlayerUID player && _vehicle getVariable ["ownerUID",""] != "") exitWith
    {
    	playSound "FD_CP_Not_Clear_F";
    	[format [' The "%1" is not owned by you.', _objname], "Error"] call  BIS_fnc_guiMessage;
    };

	private _variant = _vehicle getVariable ["A3W_vehicleVariant", ""];
	if (_variant != "") then { _variant = "variant_" + _variant };

	{
		if (_type == _x select 1 && (_variant == "" || {_variant in _x})) exitWith
		{
			if !(_vehicle isKindOf "Plane_Fighter_03_dynamicLoadout_base_F" && _variant == "") then
			{
				_price = (ceil (((_x select 2) / CHOPSHOP_PRICE_RELATIONSHIP) / 5)) * 5;
			}
			else
			{
				_price = (ceil (((_x select 2) / 5) / 5)) * 5;
			};
		};
	} forEach (call allVehStoreVehicles);

	if (!isNil "_price") then
	{
		// Add total sell value to confirm message
		_confirmMsg = format ["Selling the %1 will give you $%2<br/>", _objName, [_price] call fn_numbersText];

		// Display confirm message
		if ([parseText _confirmMsg, "Confirm", "Sell", true] call BIS_fnc_guiMessage) then
		{
			sleep 1;

			if (_vehicle distance _storeNPC > VEHICLE_MAX_SELLING_DISTANCE) exitWith
			{
				playSound "FD_CP_Not_Clear_F";
				[format ['The %1 has already been sold!', _objname, VEHICLE_MAX_SELLING_DISTANCE], "Error"] call  BIS_fnc_guiMessage;
			};

			deleteVehicle _vehicle;

			vehicleStore_lastSellTime = diag_tickTime;

			player setVariable ["cmoney", (player getVariable ["cmoney",0]) + _price, true];
			[format ['The %1 has been sold!', _objname, VEHICLE_MAX_SELLING_DISTANCE], "Thank You"] call  BIS_fnc_guiMessage;

			if (["A3W_playerSaving"] call isConfigOn) then
			{
				[] spawn fn_savePlayerData;
			};
		};
	}
	else
	{
		hint parseText "<t color='#FFFF00'>An unknown error occurred.</t><br/>Vehicle sale cancelled.";
		playSound "FD_CP_Not_Clear_F";
	};
};

#include "sellIncludesEnd.sqf";

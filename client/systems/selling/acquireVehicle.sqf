// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//  @file Name: acquireVehicle.sqf
//  @file Author: AgentRev
//  @file edited: CRE4MPIE
//  @credits to: Cael817, lodac, Wiking

#define TITLE_PRICE_RELATIONSHIP 10
#define VEHICLE_MAX_DISTANCE 100

private ["_vehicle", "_type", "_price", "_playerMoney", "_confirmMsg", "_text"];

_storeNPC = _this select 0;
_vehicle = objectFromNetId (player getVariable ["lastVehicleRidden", ""]);
_type = typeOf _vehicle;
_price = 1000;
_playerMoney = player getVariable ["cmoney", 0];
_objClass = typeOf _vehicle;
_objName = getText (configFile >> "CfgVehicles" >> _objClass >> "displayName");

if (isNull _vehicle) exitWith
{
	playSound "FD_CP_Not_Clear_F";
	["Your previous vehicle does not exist anymore.", "Error"] call  BIS_fnc_guiMessage;
};

if (_vehicle distance _storeNPC > VEHICLE_MAX_DISTANCE) exitWith
{
	playSound "FD_CP_Not_Clear_F";
	[format [' The "%1" is further away than %2m from the store.', _objname, VEHICLE_MAX_DISTANCE], "Error"] call  BIS_fnc_guiMessage;
};

if (_vehicle getVariable ["ownerUID",""] != getPlayerUID player && _vehicle getVariable ["ownerUID",""] != "") exitWith
{
	playSound "FD_CP_Not_Clear_F";
	[format [' The "%1" is already owned.', _objname], "Error"] call  BIS_fnc_guiMessage;
};

if (_vehicle getVariable ["ownerUID",""] == getPlayerUID player && _vehicle getVariable ["ownerUID",""] != "") exitWith
{
	playSound "FD_CP_Not_Clear_F";
	[format [' The "%1" is already owned by you.', _objname], "Error"] call  BIS_fnc_guiMessage;
};

private _variant = _vehicle getVariable ["A3W_vehicleVariant", ""];
if (_variant != "") then { _variant = "variant_" + _variant };

{
	if (_type == _x select 1 && (_variant == "" || {_variant in _x})) exitWith
	{
		_price = (ceil (((_x select 2) / TITLE_PRICE_RELATIONSHIP) / 5)) * 5;
	};
} forEach (call allVehStoreVehicles);

if (_price > _playerMoney) exitWith
{
	playSound "FD_CP_Not_Clear_F";
	[format [' You need $%1 for the %2 title.', [_price - _playerMoney] call fn_numbersText, _objname], "Error"] call  BIS_fnc_guiMessage;
};

if (!isNil "_price") then
{
	// Add total title value to confirm message
	_confirmMsg = format ["Vehicle title for %1 will cost you $%2<br/>", _objName, [_price] call fn_numbersText];

	// Display confirm message
	if ([parseText _confirmMsg, "Confirm", "Acquire Title", true] call BIS_fnc_guiMessage) then
	{
		sleep 1;

		if (_vehicle getVariable ["ownerUID",""] != getPlayerUID player && _vehicle getVariable ["ownerUID",""] != "") exitWith
		{
			playSound "FD_CP_Not_Clear_F";
			[format ['The %1 title has already been bought!', _objname], "Error"] call  BIS_fnc_guiMessage;
		};

		[_vehicle, player] call A3W_fnc_takeOwnership;

		vehicleStore_lastSellTime = diag_tickTime;

		player setVariable ["cmoney", (player getVariable ["cmoney",0]) - _price, true];
		[format ['The %1 title has been bought!', _objname, VEHICLE_MAX_DISTANCE], "Thank You"] call  BIS_fnc_guiMessage;

		if (["A3W_playerSaving"] call isConfigOn) then
		{
			[] spawn fn_savePlayerData;
		};
	};
}
else
{
	hint parseText "<t color='#FFFF00'>An unknown error occurred.</t><br/>Vehicle title sale cancelled.";
	playSound "FD_CP_Not_Clear_F";
};

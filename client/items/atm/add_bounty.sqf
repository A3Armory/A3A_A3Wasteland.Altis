// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: add_bounty.sqf
//	@file Author: AgentRev (copied and modified by Tyler)
//	@file Function: mf_items_atm_add_bounty

#include "gui_defines.hpp"

#define ERR_NOT_ENOUGH_FUNDS "You don't have enough money in your account."
#define ERR_INVALID_ACCOUNT "The selected account is invalid."
#define ERR_MIN_START_BOUNTY "The minimum starting bounty is $%1.\nYou will need to spend $%2 to start this bounty."
#define ERR_MAX_BOUNTY "The selected account has reached its maximum bounty.\nYou cannot add more than $%1 to this bounty."

#define MSG_CONFIRM_LINE1 "You are about to add a bounty reward of $%1 to %2."
#define MSG_CONFIRM_LINE2 "Cost: $%1"

disableSerialization;
private ["_dialog", "_input", "_accDropdown", "_selAcc", "_selAccName", "_amount", "_reward", "_rewardAmount", "_balance", "_maxBounty", "_destBounty", "_confirmMsg", "_bountyKey", "_deposit", "_withdraw", "_controls"];

_dialog = findDisplay AtmGUI_IDD;

if (isNull _dialog) exitWith {};

_input = _dialog displayCtrl AtmAmountInput_IDC;
_accDropdown = _dialog displayCtrl AtmAccountDropdown_IDC;
_selAcc = call compile (_accDropdown lbData lbCurSel _accDropdown);

if (isNil "_selAcc" || {!isPlayer _selAcc || _selAcc == player}) exitWith
{
	[ERR_INVALID_ACCOUNT, 5] call mf_notify_client;
	playSound "FD_CP_Not_Clear_F";
};

_selAccName = name _selAcc;

_amount = _input call mf_verify_money_input;

if (_amount < 1) exitWith {};

_reward = ["A3W_bountyRewardPerc", 10] call getPublicVar;
_rewardAmount = ceil (_amount * (_reward / 100));
_balance = player getVariable ["bmoney", 0];

if (_balance < _rewardAmount) exitWith
{
	[ERR_NOT_ENOUGH_FUNDS, 5] call mf_notify_client;
	playSound "FD_CP_Not_Clear_F";
};

_maxBounty = ["A3W_bountyMax", 100000] call getPublicVar;
_destBounty = _selAcc getVariable ["bounty", 0];

if (_destBounty + _rewardAmount > _maxBounty) exitWith
{
	[format [ERR_MAX_BOUNTY, [_maxBounty - _destBounty] call fn_numbersText], 5] call mf_notify_client;
	playSound "FD_CP_Not_Clear_F";
};

_minStartBounty = ["A3W_bountyMinStart", 1000] call getPublicVar;
if (_destBounty == 0 && _minStartBounty > 0 && _rewardAmount < _minStartBounty) exitWith
{
	[format [ERR_MIN_START_BOUNTY, _minStartBounty, [_minStartBounty / (_reward / 100)] call fn_numbersText], 5] call mf_notify_client;
	playSound "FD_CP_Not_Clear_F";
};

_confirmMsg = format [MSG_CONFIRM_LINE1 + "<br/>", [_rewardAmount] call fn_numbersText, _selAccName] +
format [MSG_CONFIRM_LINE2, [_amount] call fn_numbersText];

[_confirmMsg, _selAcc, _amount, _rewardAmount] spawn
{
	disableSerialization;
	_confirmMsg = _this select 0;
	_selAcc = _this select 1;
	_amount = _this select 2;
	_rewardAmount = _this select 3;

	if !([_confirmMsg, "Confirm", true, true] call BIS_fnc_guiMessage) exitWith {};

	player setVariable ["bmoney", (player getVariable ["bmoney", 0]) - (_amount), false];
	false call mf_items_atm_refresh;

	_bountyKey = call A3W_fnc_generateKey + "_atmBounty";
	player setVariable [_bountyKey, true, false];

	pvar_bountyProcessing = ["addBounty", player, _selAcc, _amount, _rewardAmount, _bountyKey];
	publicVariableServer "pvar_bountyProcessing";

	_dialog = findDisplay AtmGUI_IDD;
	_input = _dialog displayCtrl AtmAmountInput_IDC;
	_accDropdown = _dialog displayCtrl AtmAccountDropdown_IDC;
	_deposit = _dialog displayCtrl AtmDepositButton_IDC;
	_withdraw = _dialog displayCtrl AtmWithdrawButton_IDC;
	_controls = [_input, _accDropdown, _deposit, _withdraw];

	{ _x ctrlEnable false } forEach _controls;

	waitUntil {uiSleep 0.1; !(player getVariable [_bountyKey, false]) || isNull _dialog};

	if (isNull _dialog) exitWith {};

	{ if (!ctrlEnabled _x) then { _x ctrlEnable true } } forEach _controls;
};

closeDialog 0;

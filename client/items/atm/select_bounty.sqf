// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: select_bounty.sqf
//	@file Author: AgentRev (copied and modified by Tyler)
//	@file Function: mf_items_atm_select_bounty

#include "gui_defines.hpp"
disableSerialization;

private ["_bountyCheckbox", "_bountyChecked", "_dialog", "_deposit", "_withdraw", "_feeLabel", "_totalLabel", "_totalText", "_players", "_oldPlayers", "_strPlayers", "_selData", "_idx", "_data", "_selIdx", "_amount", "_fee"];

_bountyCheckbox = _this select 0;
_bountyChecked = _this select 1;
_dialog = ctrlParent _bountyCheckbox;

_deposit = _dialog displayCtrl AtmDepositButton_IDC;
_withdraw = _dialog displayCtrl AtmWithdrawButton_IDC;
_feeLabel = _dialog displayCtrl AtmFeeLabel_IDC;
_totalLabel = _dialog displayCtrl AtmTotalLabel_IDC;

if (_bountyChecked == 1) then
{
  _deposit ctrlSetText "Add Bounty";
  _feeLabel ctrlSetText "Reward:";
	_totalLabel ctrlSetText "Cost:";
	_deposit buttonSetAction "call mf_items_atm_add_bounty";
	if (ctrlShown _withdraw) then { _withdraw ctrlShow false };
}
else
{
	_deposit ctrlSetText "Deposit";
  _feeLabel ctrlSetText "Fee:";
  _totalLabel ctrlSetText "Total:";
	_deposit buttonSetAction "call mf_items_atm_deposit";
	if (!ctrlShown _withdraw) then { _withdraw ctrlShow true };
};

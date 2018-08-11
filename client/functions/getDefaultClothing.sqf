// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: getDefaultClothing.sqf
//	@file Author: AgentRev
//	@file Created: 22/12/2013 22:04

private ["_unit", "_item", "_side", "_isSniper", "_isDiver", "_defaultVest", "_result"];

_unit = _this select 0;
_item = _this select 1;

if (typeName _unit == "OBJECT") then
{
	_side = if (_unit == player) then { playerSide } else { side _unit };
	_unit = typeOf _unit;
}
else
{
	_side = _this select 2;
};

_isSniper = (["_sniper_", _unit] call fn_findString != -1);
_isDiver = (["_diver_", _unit] call fn_findString != -1);

_defaultVest = "V_Rangemaster_Belt";

_result = "";

switch (_side) do
{
	case BLUFOR:
	{
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_B_GhillieSuit" };
				if (_item == "vest") then { _result = "V_PlateCarrier1_rgr" };
				if (_item == "backpack") then { _result = "B_Kitbag_mcamo" };
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result = "U_B_Wetsuit" };
				if (_item == "vest") then { _result = "V_RebreatherB" };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "backpack") then { _result = "B_Bergen_blk" };
			};
			default
			{
				if (_item == "uniform") then { _result = "U_B_CombatUniform_mcam" };
				if (_item == "vest") then { _result = "V_PlateCarrier1_rgr" };
				if (_item == "backpack") then { _result = "B_Kitbag_mcamo" };
				if (_item == "headgear") then { _result = "H_MilCap_mcamo" };				
			};
		};
	};
	case OPFOR:
	{
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_O_GhillieSuit" };
				if (_item == "vest") then { _result = "V_TacVest_khk" };
				if (_item == "backpack") then { _result = "B_Kitbag_mcamo" };
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result = "U_O_Wetsuit" };
				if (_item == "vest") then { _result = "V_RebreatherIR" };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "backpack") then { _result = "B_Bergen_blk" };
			};
			default
			{
				if (_item == "uniform") then { _result = "U_O_CombatUniform_ocamo" };
				if (_item == "vest") then { _result = "V_TacVest_khk" };
				if (_item == "backpack") then { _result = "B_Kitbag_mcamo" };
				if (_item == "headgear") then { _result = "H_MilCap_ocamo" };				
			};
		};
	};
	default
	{
		switch (true) do
		{
			case (_isSniper):
			{
				if (_item == "uniform") then { _result = "U_I_GhillieSuit" };
				if (_item == "vest") then { _result = "V_PlateCarrierIA1_dgtl" };
				if (_item == "backpack") then { _result = "B_Kitbag_rgr" };
			};
			case (_isDiver):
			{
				if (_item == "uniform") then { _result = "U_I_Wetsuit" };
				if (_item == "vest") then { _result = "V_RebreatherIA" };
				if (_item == "goggles") then { _result = "G_Diving" };
				if (_item == "backpack") then { _result = "B_Bergen_rgr" };
			};
			default
			{
				if (_item == "uniform") then { _result = "U_I_CombatUniform" };
				if (_item == "vest") then { _result = "V_PlateCarrierIA1_dgtl" };
				if (_item == "backpack") then { _result = "B_Kitbag_rgr" };
				if (_item == "headgear") then { _result = "H_MilCap_dgtl" };				
			};
		};
	};
};

_result
